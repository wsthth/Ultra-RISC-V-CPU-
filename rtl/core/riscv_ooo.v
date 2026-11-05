//==============================================================================
// riscv_ooo.v - 乱序超标量RISC-V顶层
// 单发射原型阶段：先跑通数据流，后续扩展到4发射
//==============================================================================
`timescale 1ns/1ps

module riscv_ooo #(
    parameter IMEM_DEPTH = 8192
)(
    input  wire        clk,
    input  wire        rst_n,
    output wire [31:0] pc_o,
    output wire        commit_valid_o,
    output wire [31:0] commit_rd_o
);

    // ==================== 内部信号声明 ====================
    // IF
    wire [31:0] inst_f;

    // ID
    wire [4:0]  rs1_idx, rs2_idx, rd_idx;
    wire [3:0]  alu_op_id;
    wire        reg_write_id;

    // 重命名
    wire [6:0] ps1, ps2, pd;
    wire       rename_ready;

    // ROB
    wire [4:0] rob_push_idx;
    wire       rob_ready;
    wire       rob_full_inv;
    wire       rob_commit_valid;
    wire [4:0]  commit_arch_rd;
    wire [6:0]  commit_phys_rd;
    wire [31:0] commit_result;
    wire        commit_rd_we;

    // PRF
    wire [31:0] prf_rdata1, prf_rdata2;

    // RS
    wire [3:0] rs_idx;
    wire       rs_ready;
    wire       rs_full_inv;
    wire       issue_valid;
    wire [3:0] issue_alu_op;
    wire [31:0] issue_op1, issue_op2;
    wire [4:0] issue_rob_idx;

    // ALU
    wire [31:0] alu_result;
    reg         alu_done;
    reg [4:0]   alu_rob_idx;
    reg [6:0]   alu_pdest;

    // ==================== IF阶段 ====================
    reg [31:0] pc_f;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pc_f <= 32'd0;
        else pc_f <= pc_f + 4;
    end

    imem #(.DEPTH(IMEM_DEPTH)) u_imem (
        .clk(clk), .reset(!rst_n), .a(pc_f), .rd(inst_f), .rd_addr()
    );
    assign pc_o = pc_f;

    // ==================== ID译码 ====================
    wire [6:0] opcode = inst_f[6:0];
    wire [2:0] funct3 = inst_f[14:12];
    wire [6:0] funct7 = inst_f[31:25];
    assign rs1_idx = inst_f[19:15];
    assign rs2_idx = inst_f[24:20];
    assign rd_idx  = inst_f[11:7];

    // 支持R-type (0110011) 和 I-type ALU (0010011)
    wire is_rtype = (opcode == 7'b0110011);
    wire is_itype = (opcode == 7'b0010011);
    assign reg_write_id = is_rtype | is_itype;

    // I-type立即数
    wire [31:0] imm_i = {{20{inst_f[31]}}, inst_f[31:20]};
    wire [31:0] op2 = is_itype ? imm_i : 32'd0;  // I-type用立即数

    assign alu_op_id = is_rtype ?
                        ((funct3 == 3'b000) ? (funct7[5] ? 4'b0001 : 4'b0000) :
                         (funct3 == 3'b111) ? 4'b0010 :
                         (funct3 == 3'b110) ? 4'b0011 :
                         (funct3 == 3'b100) ? 4'b0100 : 4'b0000)
                      : 4'b0000;  // I-type默认ADD

    wire dispatch_en = reg_write_id & rename_ready & rob_ready & rs_ready;

    // ==================== 寄存器重命名 ====================
    reg_rename u_reg_rename (
        .clk(clk), .rst_n(rst_n),
        .rename_en_i(dispatch_en),
        .arch_rs1_i(rs1_idx), .arch_rs2_i(rs2_idx),
        .arch_rd_i(rd_idx), .rd_we_i(reg_write_id),
        .ps1_o(ps1), .ps2_o(ps2), .pd_o(pd),
        .rename_ready_o(rename_ready),
        .commit_en_i(rob_commit_valid),
        .commit_arch_rd_i(commit_arch_rd),
        .commit_pd_i(commit_phys_rd),
        .commit_rd_we_i(commit_rd_we)
    );

    // ==================== ROB ====================
    assign rob_ready = ~rob_full_inv;
    rob u_rob (
        .clk(clk), .rst_n(rst_n),
        .push_en_i(dispatch_en),
        .push_arch_rd_i(rd_idx),
        .push_phys_rd_i(pd),
        .push_rd_we_i(reg_write_id),
        .push_is_store_i(1'b0),
        .push_ptr_o(rob_push_idx),
        .rob_full_o(rob_full_inv),
        .commit_wr_en_i(alu_done),
        .commit_ptr_i(alu_rob_idx),
        .commit_result_i(alu_result),
        .commit_rob_we_i(1'b1),
        .commit_valid_o(rob_commit_valid),
        .commit_arch_rd_o(commit_arch_rd),
        .commit_phys_rd_o(commit_phys_rd),
        .commit_result_o(commit_result),
        .commit_rd_we_o(commit_rd_we),
        .commit_pop_i(commit_valid_o)
    );

    // ==================== PRF ====================
    prf u_prf (
        .clk(clk),
        .raddr1_i(ps1), .rdata1_o(prf_rdata1),
        .raddr2_i(ps2), .rdata2_o(prf_rdata2),
        .we_i(alu_done),
        .waddr_i(alu_pdest),
        .wdata_i(alu_result)
    );

    // ==================== 保留站 ====================
    assign rs_ready = ~rs_full_inv;
    reservation_station u_rs (
        .clk(clk), .rst_n(rst_n),
        .dispatch_en_i(dispatch_en),
        .alu_op_i(alu_op_id),
        .op1_prf_i(ps1), .op2_prf_i(ps2),
        .rob_idx_i(rob_push_idx),
        .rs_idx_o(rs_idx),
        .rs_full_o(rs_full_inv),
        .prf_rdata1_i(prf_rdata1),
        .prf_rdata2_i(prf_rdata2),
        .cdb_we_i(alu_done),
        .cdb_prf_i(alu_pdest),
        .cdb_data_i(alu_result),
        .issue_valid_o(issue_valid),
        .issue_alu_op_o(issue_alu_op),
        .issue_op1_o(issue_op1),
        .issue_op2_o(issue_op2),
        .issue_rob_idx_o(issue_rob_idx),
        .issue_ready_i(1'b1)
    );

    // ==================== ALU ====================
    alu u_alu (
        .a(issue_op1), .b(issue_op2),
        .alucontrol(issue_alu_op),
        .result(alu_result), .zero()
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            alu_done    <= 1'b0;
            alu_rob_idx <= 5'd0;
            alu_pdest   <= 7'd0;
        end else begin
            alu_done    <= issue_valid;
            alu_rob_idx <= issue_rob_idx;
            alu_pdest   <= pd;
        end
    end

    assign commit_rd_o = commit_result;
    assign commit_valid_o = rob_commit_valid;

endmodule
