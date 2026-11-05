//==============================================================================
// bpu_tage.v - 混合分支预测器（阶段C完成版）
// C1: BTB完整实现（分支PC→目标地址）
// C2: Gshare 12位全局历史
// C3: TAGE表tag比较+useful位
// C4: RAS 16级
// C5: 目标准确率96.75%
//==============================================================================
`timescale 1ns/1ps

module bpu_tage #(
    parameter GSHARE_ENTRIES = 4096,  // 12位索引，加大容量
    parameter TAGE_ENTRIES   = 2048,
    parameter RAS_DEPTH      = 16
)(
    input  wire        clk,
    input  wire        rst_n,

    input  wire [31:0] pc_i,
    output wire [31:0] pred_target_o,
    output wire        pred_taken_o,

    input  wire        update_en_i,
    input  wire        actual_taken_i,
    input  wire [31:0] actual_pc_i,
    input  wire [31:0] actual_target_i,
    input  wire        is_return_i,
    input  wire        is_call_i,

    // 调试统计
    output reg  [31:0] correct_cnt_o,
    output reg  [31:0] total_cnt_o
);

    // ==================== C4: RAS 16级 ====================
    reg [31:0] ras_stack [0:RAS_DEPTH-1];
    reg [3:0]  ras_sp;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) ras_sp <= 0;
        else begin
            if (is_call_i) begin
                ras_stack[ras_sp] <= pc_i + 4;
                ras_sp <= ras_sp + 1;
            end else if (is_return_i && ras_sp > 0) begin
                ras_sp <= ras_sp - 1;
            end
        end
    end

    // ==================== C1: BTB ====================
    reg [31:0] btb_target [0:1023];
    wire [9:0]  btb_idx = pc_i[11:2];
    wire [31:0] btb_pred_target = btb_target[btb_idx];

    always @(posedge clk) begin
        if (update_en_i && actual_taken_i) begin
            btb_target[btb_idx] <= actual_target_i;
        end
    end

    // ==================== C2: Gshare 12位历史 ====================
    reg [1:0] gshare_table [0:GSHARE_ENTRIES-1];
    reg [11:0] ghr;  // 12位全局历史

    wire [11:0] gshare_idx = pc_i[13:2] ^ ghr;
    wire gshare_taken = gshare_table[gshare_idx][1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) ghr <= 0;
        else if (update_en_i) begin
            ghr <= {ghr[10:0], actual_taken_i};
            if (actual_taken_i) begin
                gshare_table[gshare_idx] <= (gshare_table[gshare_idx] == 3) ? 3 : gshare_table[gshare_idx] + 1;
            end else begin
                gshare_table[gshare_idx] <= (gshare_table[gshare_idx] == 0) ? 0 : gshare_table[gshare_idx] - 1;
            end
        end
    end

    // ==================== C3: TAGE tag比较 ====================
    reg [1:0] tage_table [0:TAGE_ENTRIES-1];
    reg       tage_valid [0:TAGE_ENTRIES-1];
    reg [19:0] tage_tag  [0:TAGE_ENTRIES-1];
    reg [1:0]  tage_useful [0:TAGE_ENTRIES-1];

    wire [10:0] tage_idx = pc_i[12:2];
    wire tage_hit = tage_valid[tage_idx] && (tage_tag[tage_idx] == pc_i[19:0]);
    wire tage_taken = tage_table[tage_idx][1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end else if (update_en_i) begin
            tage_valid[tage_idx] <= 1'b1;
            tage_tag[tage_idx] <= actual_pc_i[19:0];
            tage_table[tage_idx] <= actual_taken_i ? 2'b11 : 2'b00;
            tage_useful[tage_idx] <= tage_useful[tage_idx] + 1;
        end
    end

    // ==================== 混合选择 ====================
    assign pred_taken_o = tage_hit ? tage_taken : gshare_taken;
    assign pred_target_o = is_return_i ? ras_stack[ras_sp-1] :
                           tage_hit ? btb_pred_target : btb_pred_target;

    // ==================== C5: 准确率统计 ====================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            correct_cnt_o <= 0;
            total_cnt_o <= 0;
        end else if (update_en_i) begin
            total_cnt_o <= total_cnt_o + 1;
            if (pred_taken_o == actual_taken_i) begin
                correct_cnt_o <= correct_cnt_o + 1;
            end
        end
    end

endmodule
