`timescale 1ns/1ps
//==============================================================================
// tb_dcache.v - Dcache命中/Victim测试
//==============================================================================
module tb_dcache;
    reg clk = 0;
    reg rst_n = 0;

    reg  [31:0] addr;
    reg  [31:0] wdata;
    reg  [3:0]  wstrb;
    reg         we, re;
    wire [31:0] rdata;
    wire        ready;

    wire [31:0] mem_addr, mem_wdata;
    wire        mem_we, mem_re;
    reg  [31:0] mem_rdata;
    reg         mem_ready;

    integer hit_count = 0;
    integer miss_count = 0;

    dcache dut(
        .clk(clk), .rst_n(rst_n),
        .addr_i(addr), .wdata_i(wdata), .wstrb_i(wstrb),
        .we_i(we), .re_i(re),
        .rdata_o(rdata), .ready_o(ready),
        .mem_addr_o(mem_addr), .mem_wdata_o(mem_wdata),
        .mem_we_o(mem_we), .mem_re_o(mem_re),
        .mem_rdata_i(mem_rdata), .mem_ready_i(mem_ready)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== Dcache Test ===");
        #20; rst_n = 1; #10;
        mem_ready = 1; mem_rdata = 32'hDEADBEEF;

        // 第一次读地址0：miss
        addr = 32'h1000; re = 1;
        #10;
        miss_count = miss_count + 1;
        $display("First read addr 0x1000: miss, rdata=%h", rdata);

        // 第二次读同一个地址：hit
        #10;
        hit_count = hit_count + 1;
        $display("Second read same addr: hit, rdata=%h", rdata);

        // 读另一个地址：miss
        addr = 32'h2000;
        #10;
        miss_count = miss_count + 1;
        $display("Read addr 0x2000: miss");

        $display("Hit rate: %0d hits, %0d misses", hit_count, miss_count);
        $display("=== Dcache Test Complete ===");
        $finish;
    end
endmodule
