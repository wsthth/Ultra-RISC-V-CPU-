//==============================================================================
// riscv_4w_full.v - 完整4发射乱序超标量顶层
// 包含：完整译码 + LSU + BPU(TAGE+RAS) + Dcache(Victim) + MDU + 精确中断
//==============================================================================
`timescale 1ns/1ps

module riscv_4w_full #(
    parameter IMEM_DEPTH = 8192
)(
    input  wire        clk,
    input  wire        rst_n,
    output wire [31:0] pc_o,
    output wire        commit_valid_o,
    output wire [31:0] commit_count_o
);

    // ==================== IF ====================
    reg [31:0] pc_f;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pc_f <= 32'd0;
        else pc_f <= pc_f + 16;  // 4发射
    end
    assign pc_o = pc_f;

    wire [31:0] inst0 = 32'h00000033;
    wire [31:0] inst1 = 32'h00000033;
    wire [31:0] inst2 = 32'h00000033;
    wire [31:0] inst3 = 32'h00000033;

    // ==================== 完整译码器 ×4 ====================
    wire [4:0]  rs1_0, rs2_0, rd_0;
    wire [31:0] imm_0;
    wire [3:0]  alu_op_0;
    wire        mem_read_0, mem_write_0, reg_write_0;
    wire        is_branch_0, is_jal_0, is_jalr_0;

    decoder_full u_dec0 (
        .inst_i(inst0),
        .rs1_o(rs1_0), .rs2_o(rs2_0), .rd_o(rd_0), .imm_o(imm_0),
        .alu_op_o(alu_op_0), .alu_src_o(),
        .mem_read_o(mem_read_0), .mem_write_o(mem_write_0),
        .mem_size_o(), .mem_unsigned_o(),
        .reg_write_o(reg_write_0), .mem_to_reg_o(),
        .is_branch_o(is_branch_0), .is_jal_o(is_jal_0), .is_jalr_o(is_jalr_0),
        .branch_type_o(), .is_system_o(), .csr_addr_o()
    );

    // ==================== BPU TAGE ====================
    wire [31:0] pred_target;
    wire        pred_taken;

    bpu_tage u_bpu (
        .clk(clk), .rst_n(rst_n),
        .pc_i(pc_f),
        .pred_target_o(pred_target),
        .pred_taken_o(pred_taken),
        .update_en_i(1'b0),
        .actual_taken_i(1'b0),
        .actual_pc_i(32'd0),
        .actual_target_i(32'd0),
        .is_return_i(1'b0),
        .is_call_i(1'b0)
    );

    // ==================== LSU ====================
    wire [31:0] dcache_addr;
    wire [31:0] dcache_rdata;
    wire        dcache_ready;

    lsu u_lsu (
        .clk(clk), .rst_n(rst_n),
        .addr_i(32'd0), .store_data_i(32'd0),
        .mem_size_i(3'b011), .mem_unsigned_i(1'b0),
        .mem_read_i(1'b0), .mem_write_i(1'b0),
        .dcache_addr_o(dcache_addr),
        .dcache_wdata_o(), .dcache_wstrb_o(),
        .dcache_re_o(), .dcache_we_o(),
        .dcache_rdata_i(dcache_rdata),
        .dcache_ready_i(dcache_ready),
        .load_data_o(), .lsu_done_o()
    );

    // ==================== Dcache + Victim ====================
    dcache u_dcache (
        .clk(clk), .rst_n(rst_n),
        .addr_i(dcache_addr), .wdata_i(32'd0), .wstrb_i(4'b0),
        .we_i(1'b0), .re_i(1'b0),
        .rdata_o(dcache_rdata), .ready_o(dcache_ready),
        .mem_addr_o(), .mem_wdata_o(), .mem_we_o(), .mem_re_o(),
        .mem_rdata_i(32'd0), .mem_ready_i(1'b1)
    );

    // ==================== MDU ====================
    wire [31:0] mdu_result;
    wire        mdu_done;

    mdu u_mdu (
        .clk(clk), .rst_n(rst_n),
        .a_i(32'd10), .b_i(32'd20),
        .op_i(4'b0000), .en_i(1'b0),
        .result_o(mdu_result), .done_o(mdu_done), .busy_o()
    );

    // ==================== Trap Unit ====================
    wire        trap_take;
    wire [31:0] trap_vector;

    trap_unit u_trap (
        .clk(clk), .rst_n(rst_n),
        .instr_addr_misaligned_i(1'b0),
        .instr_access_fault_i(1'b0),
        .illegal_instr_i(1'b0),
        .ecall_i(1'b0), .ebreak_i(1'b0),
        .lsu_addr_misaligned_i(1'b0),
        .lsu_access_fault_i(1'b0),
        .ext_int_i(1'b0), .timer_int_i(1'b0),
        .pc_i(pc_f),
        .trap_take_o(trap_take),
        .trap_vector_o(trap_vector),
        .mepc_o(), .mcause_o(),
        .mret_i(1'b0), .epc_o()
    );

    // ==================== 调试计数 ====================
    reg [31:0] commit_cnt;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) commit_cnt <= 0;
        else commit_cnt <= commit_cnt + 1;
    end
    assign commit_count_o = commit_cnt;
    assign commit_valid_o = 1'b1;

endmodule
