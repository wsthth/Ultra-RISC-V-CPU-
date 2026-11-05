`timescale 1ns/1ps
//==============================================================================
// tb_bpu.v - BPU TAGE预测测试
//==============================================================================
module tb_bpu;
    reg clk = 0;
    reg rst_n = 0;

    reg  [31:0] pc;
    wire [31:0] pred_target;
    wire        pred_taken;

    reg  update_en;
    reg  actual_taken;
    reg  [31:0] actual_pc;
    reg  [31:0] actual_target;
    reg  is_return, is_call;

    integer correct = 0;
    integer total = 0;

    bpu_tage dut(
        .clk(clk), .rst_n(rst_n),
        .pc_i(pc), .pred_target_o(pred_target), .pred_taken_o(pred_taken),
        .update_en_i(update_en), .actual_taken_i(actual_taken),
        .actual_pc_i(actual_pc), .actual_target_i(actual_target),
        .is_return_i(is_return), .is_call_i(is_call)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== BPU Prediction Test ===");
        #20; rst_n = 1; #10;

        // 训练：同一个分支，10次都跳转
        pc = 32'h1000;
        repeat (10) begin
            #10;
            update_en = 1; actual_taken = 1; actual_pc = 32'h1000; actual_target = 32'h2000;
            #10;
            update_en = 0;
            total = total + 1;
            if (pred_taken) correct = correct + 1;
        end
        $display("After 10 taken training: pred_taken=%b (expect 1)", pred_taken);
        $display("Accuracy so far: %0d/%0d = %.1f%%", correct, total, 100.0*correct/total);

        // 再训练10次都不跳转
        pc = 32'h2000;
        repeat (10) begin
            #10;
            update_en = 1; actual_taken = 0; actual_pc = 32'h2000;
            #10;
            update_en = 0;
            total = total + 1;
            if (!pred_taken) correct = correct + 1;
        end
        $display("After 10 not-taken training: pred_taken=%b (expect 0)", pred_taken);
        $display("Total Accuracy: %0d/%0d = %.1f%%", correct, total, 100.0*correct/total);

        #10;
        $display("=== BPU Test Complete ===");
        $finish;
    end
endmodule
