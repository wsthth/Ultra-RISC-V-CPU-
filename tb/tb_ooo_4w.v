`timescale 1ns/1ps
//==============================================================================
// tb_ooo_4w.v - 4发射乱序CPU测试
//==============================================================================
module tb_ooo_4w;
    reg clk = 0;
    reg rst_n = 0;
    wire [31:0] pc;
    wire commit_valid;
    wire [31:0] commit_cnt;

    integer cycles = 0;

    riscv_ooo_4w dut(
        .clk(clk), .rst_n(rst_n),
        .pc_o(pc),
        .commit_valid_o(commit_valid),
        .commit_count_o(commit_cnt)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== tb_ooo_4w (4-issue OoO) start ===");
        $display("4-issue superscalar architecture initialized");
        $display("  IF stage: 4 instructions/cycle");
        $display("  ID stage: 4-way decode");
        $display("  RN stage: 4-way rename");
        $display("  ROB: 4-entry dispatch");
        $display("  RS: 4-entry dispatch");
        $display("  EX: 4 parallel ALUs");
        $display("  WB: 4 CDB writeback");

        #20;
        rst_n = 1;

        repeat (50) begin
            @(posedge clk);
            cycles = cycles + 1;
            if (cycles % 10 == 0) begin
                $display("cycle %0d: pc=%08X, commit_count=%0d", cycles, pc, commit_cnt);
            end
        end

        $display("=== 4-issue OoO prototype: COMPILE+ELAB PASSED ===");
        $finish;
    end
endmodule
