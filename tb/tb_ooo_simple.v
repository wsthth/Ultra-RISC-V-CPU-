`timescale 1ns/1ps
//==============================================================================
// tb_ooo_simple.v - 乱序CPU顶层简单测试
//==============================================================================
module tb_ooo_simple;
    reg clk = 0;
    reg rst_n = 0;
    wire [31:0] pc;
    wire commit_valid;
    wire [31:0] commit_rd;

    integer cycles = 0;

    riscv_ooo dut(
        .clk(clk), .rst_n(rst_n),
        .pc_o(pc),
        .commit_valid_o(commit_valid),
        .commit_rd_o(commit_rd)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== tb_ooo_simple start ===");
        #20;
        rst_n = 1;

        repeat (100) begin
            @(posedge clk);
            cycles = cycles + 1;
            if (commit_valid) begin
                $display("cycle %0d: commit rd=%08X", cycles, commit_rd);
            end
        end

        $display("=== TEST PASSED (compile check) ===");
        $finish;
    end
endmodule
