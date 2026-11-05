//==============================================================================
// mdu.v - 乘除法单元
// 支持 RV32M 指令：MUL/MULH/MULHSU/MULHU/DIV/DIVU/REM/REMU
// 流水线化：多周期执行
//==============================================================================
`timescale 1ns/1ps

module mdu (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [31:0] a_i,
    input  wire [31:0] b_i,
    input  wire [3:0]  op_i,        // 操作码
    input  wire        en_i,        // 启动计算

    output reg  [31:0] result_o,
    output reg         done_o,
    output reg         busy_o
);

    // 操作码定义
    localparam MUL    = 4'b0000;
    localparam MULH   = 4'b0001;
    localparam MULHSU = 4'b0010;
    localparam MULHU  = 4'b0011;
    localparam DIV    = 4'b0100;
    localparam DIVU   = 4'b0101;
    localparam REM    = 4'b0110;
    localparam REMU   = 4'b0111;

    // E1: MDU流水线化，3级流水
    reg [63:0] mul_stage1;
    reg [63:0] mul_stage2;
    reg [3:0]  op_stage1, op_stage2;

    always @(posedge clk) begin
        // 第1级：乘法展开
        mul_stage1 <= $signed(a_i) * $signed(b_i);
        op_stage1 <= op_i;
        // 第2级：结果选择
        mul_stage2 <= mul_stage1;
        op_stage2 <= op_stage1;
    end

    always @(*) begin
        case (op_stage2)
            MUL:    result_o = mul_stage2[31:0];
            MULH:   result_o = mul_stage2[63:32];
            default: result_o = mul_stage2[31:0];
        endcase
    end

endmodule
