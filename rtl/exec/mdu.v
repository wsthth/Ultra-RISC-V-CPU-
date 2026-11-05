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

    reg [3:0]  state;
    reg [63:0] mul_result;
    reg [31:0] div_result;
    reg [31:0] rem_result;
    reg [31:0] a_save, b_save;
    reg [3:0]  op_save;

    localparam IDLE   = 4'd0;
    localparam CALC   = 4'd1;
    localparam FINISH = 4'd2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            done_o <= 1'b0;
            busy_o <= 1'b0;
            result_o <= 32'd0;
        end else begin
            case (state)
                IDLE: begin
                    done_o <= 1'b0;
                    busy_o <= 1'b0;
                    if (en_i) begin
                        a_save <= a_i;
                        b_save <= b_i;
                        op_save <= op_i;
                        state <= CALC;
                        busy_o <= 1'b1;
                    end
                end

                CALC: begin
                    // 乘法：单周期完成（组合逻辑）
                    if (op_save[2] == 1'b0) begin  // MUL系列
                        mul_result = $signed(a_save) * $signed(b_save);
                        state <= FINISH;
                    end else begin  // DIV系列（简化：单周期）
                        if (b_save == 0) begin
                            div_result = 32'hFFFFFFFF;  // 除0
                            rem_result = a_save;
                        end else begin
                            div_result = a_save / b_save;
                            rem_result = a_save % b_save;
                        end
                        state <= FINISH;
                    end
                end

                FINISH: begin
                    case (op_save)
                        MUL:    result_o <= mul_result[31:0];
                        MULH:   result_o <= mul_result[63:32];
                        MULHSU: result_o <= ($signed(a_save) * $signed({{32{b_save[31]}}, b_save})) >>> 32;
                        MULHU:  result_o <= mul_result[63:32];
                        DIV:    result_o <= div_result;
                        DIVU:   result_o <= div_result;
                        REM:    result_o <= rem_result;
                        REMU:   result_o <= rem_result;
                    endcase
                    done_o <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
