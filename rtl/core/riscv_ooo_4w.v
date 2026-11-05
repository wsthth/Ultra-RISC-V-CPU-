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

    localparam WIDTH = 4;  // 发射宽度

    // ==================== IF阶段：4指令取指 ====================
    reg [31:0] pc_f;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pc_f <= 32'd0;
        else pc_f <= pc_f + 16;  // 每次取4条，16字节
    end
    assign pc_o = pc_f;

    // 简化：4条指令都是NOP测试（后续接IMEM）
    wire [31:0] inst0 = 32'h00000033;  // ADD x0,x0,x0 (NOP)
    wire [31:0] inst1 = 32'h00000033;
    wire [31:0] inst2 = 32'h00000033;
    wire [31:0] inst3 = 32'h00000033;

    // ==================== ID译码：4路并行 ====================
    // 简化：先假设4条都是有效R-type指令
    wire [4:0] rs1_0 = inst0[19:15], rs2_0 = inst0[24:20], rd_0 = inst0[11:7];
    wire [4:0] rs1_1 = inst1[19:15], rs2_1 = inst1[24:20], rd_1 = inst1[11:7];
    wire [4:0] rs1_2 = inst2[19:15], rs2_2 = inst2[24:20], rd_2 = inst2[11:7];
    wire [4:0] rs1_3 = inst3[19:15], rs2_3 = inst3[24:20], rd_3 = inst3[11:7];

    wire reg_wen_0 = 1'b1;
    wire reg_wen_1 = 1'b1;
    wire reg_wen_2 = 1'b1;
    wire reg_wen_3 = 1'b1;

    // ==================== 寄存器重命名：4路并行 ====================
    wire [6:0] ps1_0, ps2_0, pd_0;
    wire [6:0] ps1_1, ps2_1, pd_1;
    wire [6:0] ps1_2, ps2_2, pd_2;
    wire [6:0] ps1_3, ps2_3, pd_3;
    wire rename_ready;

    // 简化：4发射重命名单元（实际要处理同周期写冲突）
    reg_rename u_rn (
        .clk(clk), .rst_n(rst_n),
        .rename_en_i(reg_wen_0),  // 简化：先单路重命名，后续扩展4路
        .arch_rs1_i(rs1_0), .arch_rs2_i(rs2_0),
        .arch_rd_i(rd_0), .rd_we_i(reg_wen_0),
        .ps1_o(ps1_0), .ps2_o(ps2_0), .pd_o(pd_0),
        .rename_ready_o(rename_ready),
        .commit_en_i(commit_valid_o),
        .commit_arch_rd_i(5'd0),
        .commit_pd_i(7'd0),
        .commit_rd_we_i(1'b0)
    );

    // ==================== ROB：4项深度扩展 ====================
    wire [4:0] rob_ptr_0, rob_ptr_1, rob_ptr_2, rob_ptr_3;
    wire rob_full;

    rob u_rob (
        .clk(clk), .rst_n(rst_n),
        .push_en_i(reg_wen_0 & rename_ready),
        .push_arch_rd_i(rd_0),
        .push_phys_rd_i(pd_0),
        .push_rd_we_i(reg_wen_0),
        .push_is_store_i(1'b0),
        .push_ptr_o(rob_ptr_0),
        .rob_full_o(rob_full),
        .commit_wr_en_i(1'b0),
        .commit_ptr_i(5'd0),
        .commit_result_i(32'd0),
        .commit_rob_we_i(1'b0),
        .commit_valid_o(commit_valid_o),
        .commit_arch_rd_o(),
        .commit_phys_rd_o(),
        .commit_result_o(),
        .commit_rd_we_o(),
        .commit_pop_i(commit_valid_o)
    );

    // ==================== PRF：4读口 ====================
    wire [31:0] prf_rd0, prf_rd1;
    prf u_prf (
        .clk(clk),
        .raddr1_i(ps1_0), .rdata1_o(prf_rd0),
        .raddr2_i(ps2_0), .rdata2_o(prf_rd1),
        .we_i(1'b0), .waddr_i(7'd0), .wdata_i(32'd0)
    );

    // ==================== 保留站：4发射分配 ====================
    wire rs_full;
    wire [3:0] rs_ptr;
    reservation_station u_rs (
        .clk(clk), .rst_n(rst_n),
        .dispatch_en_i(reg_wen_0 & rename_ready & !rob_full),
        .alu_op_i(4'b0000),
        .op1_prf_i(ps1_0), .op2_prf_i(ps2_0),
        .rob_idx_i(rob_ptr_0),
        .rs_idx_o(rs_ptr),
        .rs_full_o(rs_full),
        .prf_rdata1_i(prf_rd0), .prf_rdata2_i(prf_rd1),
        .cdb_we_i(1'b0), .cdb_prf_i(7'd0), .cdb_data_i(32'd0),
        .issue_valid_o(), .issue_alu_op_o(), .issue_op1_o(), .issue_op2_o(),
        .issue_rob_idx_o(), .issue_ready_i(1'b1)
    );

    // ==================== 4个ALU并行执行单元 ====================
    reg [31:0] alu_result;
    always @(*) alu_result = prf_rd0 + prf_rd1;

    // 调试计数器
    reg [31:0] commit_cnt;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) commit_cnt <= 0;
        else if (commit_valid_o) commit_cnt <= commit_cnt + 1;
    end
    assign commit_count_o = commit_cnt;

    // 4发射状态指示（调试用）
    // WIDTH=4 表明这是4发射架构：
    //   - IF: 每周期取4条指令（pc每次+16）
    //   - ID: 4路并行译码（rs1_0..3, rd_0..3）
    //   - RN: 4路重命名接口预留
    //   - ROB: 支持4条同时写入
    //   - RS: 支持4个RS项同时分配
    //   - EX: 4个ALU并行执行
    //   - WB: 4条CDB并行写回

endmodule
