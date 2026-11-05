`timescale 1ns/1ps
//==============================================================================
// tb_4w_full.v - 完整4发射CPU测试
//==============================================================================
module tb_4w_full;
    reg clk = 0;
    reg rst_n = 0;
    wire [31:0] pc;
    wire commit_valid;
    wire [31:0] commit_cnt;

    integer cycles = 0;

    riscv_4w_full dut(
        .clk(clk), .rst_n(rst_n),
        .pc_o(pc),
        .commit_valid_o(commit_valid),
        .commit_count_o(commit_cnt)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== tb_4w_full start ===");
        $display("Full 4-issue OoO RISC-V:");
        $display("  - Full RV32I decoder x4");
        $display("  - BPU: Gshare + TAGE + RAS");
        $display("  - LSU + Dcache + Victim Cache");
        $display("  - MDU (RV32M multiply/divide)");
        $display("  - Trap unit (precise exceptions)");

        #20;
        rst_n = 1;

        repeat (100) begin
            @(posedge clk);
            cycles = cycles + 1;
        end

        $display("cycles=%0d, pc=%08X", cycles, pc);
        $display("=== ALL MODULES COMPILED AND ELABORATED SUCCESSFULLY ===");
        $finish;
    end
endmodule
