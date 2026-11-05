`timescale 1ns/1ps
//==============================================================================
// tb_mdu.v - MDU乘除法功能测试
//==============================================================================
module tb_mdu;
    reg clk = 0;
    reg rst_n = 0;
    reg [31:0] a, b;
    reg [3:0] op;
    reg en;
    wire [31:0] result;
    wire done, busy;

    mdu dut(
        .clk(clk), .rst_n(rst_n),
        .a_i(a), .b_i(b), .op_i(op), .en_i(en),
        .result_o(result), .done_o(done), .busy_o(busy)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== MDU Test ===");
        #20; rst_n = 1; #10;

        // MUL: 10 * 20 = 200
        a = 10; b = 20; op = 4'b0000; en = 1;
        #10; en = 0;
        wait(done); #1;
        $display("MUL 10*20 = %0d (expect 200) %s", result, result==200?"PASS":"FAIL");

        // MUL: -5 * 7 = -35
        a = -5; b = 7; op = 4'b0000; en = 1;
        #10; en = 0;
        wait(done); #1;
        $display("MUL -5*7 = %0d (expect -35) %s", $signed(result), $signed(result)==-35?"PASS":"FAIL");

        // DIV: 100 / 7 = 14
        a = 100; b = 7; op = 4'b0100; en = 1;
        #10; en = 0;
        wait(done); #1;
        $display("DIV 100/7 = %0d (expect 14) %s", result, result==14?"PASS":"FAIL");

        // REM: 100 % 7 = 2
        a = 100; b = 7; op = 4'b0110; en = 1;
        #10; en = 0;
        wait(done); #1;
        $display("REM 100%%7 = %0d (expect 2) %s", result, result==2?"PASS":"FAIL");

        #20;
        $display("=== MDU Test Complete ===");
        $finish;
    end
endmodule
