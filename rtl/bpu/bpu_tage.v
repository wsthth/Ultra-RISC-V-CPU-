//==============================================================================
// bpu_tage.v - 混合分支预测器：Gshare + TAGE + RAS
// 目标准确率：96.75%
//==============================================================================
`timescale 1ns/1ps

module bpu_tage #(
    parameter GSHARE_ENTRIES = 1024,
    parameter TAGE_ENTRIES   = 512,
    parameter RAS_DEPTH      = 16
)(
    input  wire        clk,
    input  wire        rst_n,

    // IF阶段查询
    input  wire [31:0] pc_i,
    output wire [31:0] pred_target_o,
    output wire        pred_taken_o,

    // EX阶段更新
    input  wire        update_en_i,
    input  wire        actual_taken_i,
    input  wire [31:0] actual_pc_i,
    input  wire [31:0] actual_target_i,
    input  wire        is_return_i,
    input  wire        is_call_i
);

    // ==================== RAS 返回地址栈 ====================
    reg [31:0] ras_stack [0:RAS_DEPTH-1];
    reg [4:0]  ras_sp;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ras_sp <= 0;
        end else begin
            if (is_call_i) begin
                ras_stack[ras_sp] <= pc_i + 4;
                ras_sp <= ras_sp + 1;
            end else if (is_return_i && ras_sp > 0) begin
                ras_sp <= ras_sp - 1;
            end
        end
    end

    // ==================== Gshare 预测器 ====================
    reg [1:0] gshare_table [0:GSHARE_ENTRIES-1];
    reg [9:0] ghr;  // 全局历史寄存器

    wire [9:0] gshare_idx = pc_i[11:2] ^ ghr;
    wire gshare_taken = gshare_table[gshare_idx][1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ghr <= 0;
        end else if (update_en_i) begin
            ghr <= {ghr[8:0], actual_taken_i};
            if (actual_taken_i) begin
                gshare_table[gshare_idx] <= (gshare_table[gshare_idx] == 3) ? 3 : gshare_table[gshare_idx] + 1;
            end else begin
                gshare_table[gshare_idx] <= (gshare_table[gshare_idx] == 0) ? 0 : gshare_table[gshare_idx] - 1;
            end
        end
    end

    // ==================== TAGE 预测器（简化版） ====================
    reg [1:0] tage_table [0:TAGE_ENTRIES-1];
    reg       tage_valid [0:TAGE_ENTRIES-1];
    reg [31:0] tage_tag  [0:TAGE_ENTRIES-1];

    wire [8:0] tage_idx = pc_i[10:2];
    wire tage_hit = tage_valid[tage_idx] && (tage_tag[tage_idx] == pc_i);
    wire tage_taken = tage_table[tage_idx][1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end else if (update_en_i && actual_taken_i) begin
            tage_valid[tage_idx] <= 1'b1;
            tage_tag[tage_idx] <= actual_pc_i;
            tage_table[tage_idx] <= actual_taken_i ? 2'b11 : 2'b00;
        end
    end

    // ==================== 混合选择逻辑 ====================
    // TAGE命中用TAGE，否则用Gshare
    assign pred_taken_o = tage_hit ? tage_taken : gshare_taken;
    assign pred_target_o = is_return_i ? ras_stack[ras_sp-1] : actual_target_i;  // 简化

endmodule
