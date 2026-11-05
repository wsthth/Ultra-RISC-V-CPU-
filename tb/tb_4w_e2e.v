`timescale 1ns/1ps
module tb_4w_e2e;
    reg clk = 0;
    reg rst_n = 0;
    wire [31:0] pc;
    wire commit_valid;
    wire [31:0] commit_result;
    wire [31:0] commit_cnt;

    integer cycles = 0;

    riscv_4w_e2e dut(
        .clk(clk), .rst_n(rst_n),
        .pc_o(pc),
        .commit_valid_o(commit_valid),
        .commit_result_o(commit_result),
        .commit_count_o(commit_cnt)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== 4w End-to-End Test ===");
        #20; rst_n = 1;
        repeat (50) begin
            @(posedge clk);
            cycles = cycles + 1;
            if (commit_valid) begin
                $display("cycle %0d: COMMIT result=%0d (expect 5 then 10)", cycles, commit_result);
            end
        end
        $display("Total commits: %0d", commit_cnt);
        $display("=== E2E Test Complete ===");
        $finish;
    end
endmodule
