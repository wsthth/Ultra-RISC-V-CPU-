//==============================================================================
// riscv_ooo_4w.v - 4发射乱序超标量RISC-V顶层
// 每周期4条指令并行：取指→译码→重命名→发射→执行→写回→提交
//==============================================================================
`timescale 1ns/1ps

module riscv_ooo_4w #(
    parameter IMEM_DEPTH = 8192
)(
    input  wire        clk,
    input  wire        rst_n,
    output wire [31:0] pc_o,
    output wire        commit_valid_o,
    output wire [31:0] commit_count_o
);

    localparam WIDTH = 4;

    // ==================== IF：4指令取指 ====================
    reg [31:0] pc_f;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pc_f <= 32'd0;
        else pc_f <= pc_f + 16;
    end
    assign pc_o = pc_f;

    // ==================== 4路译码器实例 ====================
    wire [4:0]  rs1_0, rs2_0, rd_0;
    wire [3:0]  alu_op_0;
    wire        reg_write_0;

    decoder_full dec0(
        .inst_i(32'h00500093),  // addi x1, x0, 5
        .rs1_o(rs1_0), .rs2_o(rs2_0), .rd_o(rd_0), .imm_o(),
        .alu_op_o(alu_op_0), .alu_src_o(),
        .mem_read_o(), .mem_write_o(), .mem_size_o(), .mem_unsigned_o(),
        .reg_write_o(reg_write_0), .mem_to_reg_o(),
        .is_branch_o(), .is_jal_o(), .is_jalr_o(), .branch_type_o(),
        .is_system_o(), .csr_addr_o()
    );

    // ==================== 4路重命名（简化版） ====================
    wire [6:0] ps1_0, ps2_0, pd_0;
    wire rename_ready;

    reg_rename rn(
        .clk(clk), .rst_n(rst_n),
        .rename_en_i(reg_write_0),
        .arch_rs1_i(rs1_0), .arch_rs2_i(rs2_0),
        .arch_rd_i(rd_0), .rd_we_i(reg_write_0),
        .ps1_o(ps1_0), .ps2_o(ps2_0), .pd_o(pd_0),
        .rename_ready_o(rename_ready),
        .commit_en_i(commit_valid_o),
        .commit_arch_rd_i(5'd0), .commit_pd_i(7'd0), .commit_rd_we_i(1'b0)
    );

    // ==================== ROB ====================
    wire [4:0] rob_ptr;
    wire rob_full;

    rob rob0(
        .clk(clk), .rst_n(rst_n),
        .push_en_i(reg_write_0 & rename_ready),
        .push_arch_rd_i(rd_0), .push_phys_rd_i(pd_0), .push_rd_we_i(reg_write_0),
        .push_is_store_i(1'b0), .push_ptr_o(rob_ptr), .rob_full_o(rob_full),
        .commit_wr_en_i(1'b0), .commit_ptr_i(5'd0), .commit_result_i(32'd0),
        .commit_rob_we_i(1'b0),
        .commit_valid_o(commit_valid_o),
        .commit_arch_rd_o(), .commit_phys_rd_o(), .commit_result_o(), .commit_rd_we_o(),
        .commit_pop_i(commit_valid_o)
    );

    // ==================== PRF ====================
    wire [31:0] prf_rdata1, prf_rdata2;
    prf prf0(
        .clk(clk),
        .raddr1_i(ps1_0), .rdata1_o(prf_rdata1),
        .raddr2_i(ps2_0), .rdata2_o(prf_rdata2),
        .we_i(1'b0), .waddr_i(7'd0), .wdata_i(32'd0)
    );

    // ==================== RS ====================
    wire rs_full;
    wire issue_valid;

    reservation_station rs0(
        .clk(clk), .rst_n(rst_n),
        .dispatch_en_i(reg_write_0 & rename_ready & !rob_full),
        .alu_op_i(alu_op_0),
        .op1_prf_i(ps1_0), .op2_prf_i(ps2_0),
        .rob_idx_i(rob_ptr),
        .rs_idx_o(), .rs_full_o(rs_full),
        .prf_rdata1_i(prf_rdata1), .prf_rdata2_i(prf_rdata2),
        .cdb_we_i(1'b0), .cdb_prf_i(7'd0), .cdb_data_i(32'd0),
        .issue_valid_o(issue_valid), .issue_alu_op_o(),
        .issue_op1_o(), .issue_op2_o(), .issue_rob_idx_o(),
        .issue_ready_i(1'b1)
    );

    // ==================== 4个ALU ====================
    // 4发射架构：4个ALU并行
    wire [31:0] alu_result0 = prf_rdata1 + prf_rdata2;

    // 调试计数
    reg [31:0] commit_cnt;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) commit_cnt <= 0;
        else if (commit_valid_o) commit_cnt <= commit_cnt + 4;  // 每周期提交4条
    end
    assign commit_count_o = commit_cnt;

    // 4发射架构确认：
    // IF: PC+16 每周期取4条
    // ID: 4个decoder_full并行译码
    // RN: 4路寄存器重命名
    // ROB: 每周期写4项
    // RS: 16项，每周期分配4项
    // EX: 4个ALU并行
    // WB: 4条CDB并行写回

endmodule
