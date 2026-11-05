`timescale 1ns/1ps
//==============================================================================
// tb_ooo_simple.v - 单发射乱序CPU简单测试
//==============================================================================
module tb_ooo_simple;
    reg clk = 0;
    reg rst_n = 0;
    wire [31:0] pc;
    wire        commit_valid;
    wire [31:0] commit_result;

    integer cycles = 0;

    // 写一个简单的测试程序hex
    initial begin
        $display("=== OoO Simple Test ===");
        $display("Testing single-issue out-of-order pipeline");
    end

    riscv_ooo dut(
        .clk(clk), .rst_n(rst_n),
        .pc_o(pc),
        .commit_valid_o(commit_valid),
        .commit_rd_o(commit_result)
    );

    always #5 clk = ~clk;

    initial begin
        #20;
        rst_n = 1;
        $display("Reset released, starting...");

        repeat (100) begin
            @(posedge clk);
            cycles = cycles + 1;
            if (cycles < 20 || cycles % 10 == 0) begin
                $display("cycle %0d: pc=%08X commit_valid=%b commit_result=%08X",
                         cycles, pc, commit_valid, commit_result);
            end
        end

        $display("Total cycles: %0d", cycles);
        $display("=== OoO Simple Test Complete ===");
        $finish;
    end
endmodule
