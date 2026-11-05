//==============================================================================
// trap_unit.v - 精确异常/中断处理单元
// 支持：ecall/ebreak/时钟中断/外部中断
// 异常原因编码与mepc/mcause状态
//==============================================================================
`timescale 1ns/1ps

module trap_unit (
    input  wire        clk,
    input  wire        rst_n,

    // 来自执行阶段的异常信号
    input  wire        instr_addr_misaligned_i,
    input  wire        instr_access_fault_i,
    input  wire        illegal_instr_i,
    input  wire        ecall_i,
    input  wire        ebreak_i,
    input  wire        lsu_addr_misaligned_i,
    input  wire        lsu_access_fault_i,

    // 中断输入
    input  wire        ext_int_i,
    input  wire        timer_int_i,

    // 当前PC
    input  wire [31:0] pc_i,

    // 异常输出
    output reg         trap_take_o,
    output reg  [31:0] trap_vector_o,
    output reg  [31:0] mepc_o,
    output reg  [31:0] mcause_o,

    // MRET返回
    input  wire        mret_i,
    output wire [31:0] epc_o
);

    // 异常原因编码
    localparam CAUSE_INST_ADDR_MISALIGNED = 4'd0;
    localparam CAUSE_INST_ACCESS_FAULT    = 4'd1;
    localparam CAUSE_ILLEGAL_INST         = 4'd2;
    localparam CAUSE_BREAKPOINT           = 4'd3;
    localparam CAUSE_LOAD_ADDR_MISALIGNED = 4'd4;
    localparam CAUSE_LOAD_ACCESS_FAULT    = 4'd5;
    localparam CAUSE_ECALL_UMODE          = 4'd8;
    localparam CAUSE_ECALL_MMODE          = 4'd11;
    localparam CAUSE_MEXT_INT             = 4'd11;  // 中断
    localparam CAUSE_MTIMER_INT           = 4'd7;

    always @(*) begin
        trap_take_o = 1'b0;
        trap_vector_o = 32'h80000000;  // 直接跳中断向量基址
        mepc_o = pc_i;
        mcause_o = 32'd0;

        if (ext_int_i) begin
            trap_take_o = 1'b1;
            mcause_o = {1'b1, 27'd0, CAUSE_MEXT_INT};
        end else if (timer_int_i) begin
            trap_take_o = 1'b1;
            mcause_o = {1'b1, 27'd0, CAUSE_MTIMER_INT};
        end else if (illegal_instr_i) begin
            trap_take_o = 1'b1;
            mcause_o = CAUSE_ILLEGAL_INST;
        end else if (ecall_i) begin
            trap_take_o = 1'b1;
            mcause_o = CAUSE_ECALL_MMODE;
        end else if (ebreak_i) begin
            trap_take_o = 1'b1;
            mcause_o = CAUSE_BREAKPOINT;
        end else if (lsu_addr_misaligned_i) begin
            trap_take_o = 1'b1;
            mcause_o = CAUSE_LOAD_ADDR_MISALIGNED;
        end
    end

    assign epc_o = mepc_o;  // MRET返回地址

endmodule
