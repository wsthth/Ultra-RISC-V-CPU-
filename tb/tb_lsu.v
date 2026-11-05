`timescale 1ns/1ps
//==============================================================================
// tb_lsu.v - LSU加载存储对齐测试
//==============================================================================
module tb_lsu;
    reg clk = 0;
    reg rst_n = 0;

    reg  [31:0] addr;
    reg  [31:0] store_data;
    reg  [2:0]  mem_size;
    reg         mem_unsigned;
    reg         mem_read;
    reg         mem_write;

    wire [31:0] dcache_addr;
    wire [31:0] dcache_wdata;
    wire [3:0]  dcache_wstrb;
    wire        dcache_re;
    wire        dcache_we;
    reg  [31:0] dcache_rdata;
    reg         dcache_ready;

    wire [31:0] load_data;
    wire        lsu_done;

    lsu dut(
        .clk(clk), .rst_n(rst_n),
        .addr_i(addr), .store_data_i(store_data),
        .mem_size_i(mem_size), .mem_unsigned_i(mem_unsigned),
        .mem_read_i(mem_read), .mem_write_i(mem_write),
        .dcache_addr_o(dcache_addr),
        .dcache_wdata_o(dcache_wdata), .dcache_wstrb_o(dcache_wstrb),
        .dcache_re_o(dcache_re), .dcache_we_o(dcache_we),
        .dcache_rdata_i(dcache_rdata),
        .dcache_ready_i(dcache_ready),
        .load_data_o(load_data), .lsu_done_o(lsu_done)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== LSU Alignment Test ===");
        #20; rst_n = 1; #10;
        dcache_ready = 1;

        // 测试1: 字加载，地址0
        addr = 32'h0; mem_size = 3'b011; mem_read = 1;
        dcache_rdata = 32'h89ABCDEF;
        #1;
        $display("LW addr0: data=%h (expect 89ABCDEF)", load_data);

        // 测试2: 字节加载，地址1（无符号）
        addr = 32'h1; mem_size = 3'b000; mem_unsigned = 1;
        #1;
        $display("LBU addr1: data=%h (expect 000000CD)", load_data);

        // 测试3: 字节加载，地址1（有符号）
        mem_unsigned = 0;
        #1;
        $display("LB addr1: data=%h (expect FFFFFFCD, 符号扩展)", load_data);

        // 测试4: 半字加载，地址2
        addr = 32'h2; mem_size = 3'b001; mem_unsigned = 1;
        #1;
        $display("LHU addr2: data=%h (expect 000089AB)", load_data);

        // 测试5: 写字节，地址1
        addr = 32'h1; mem_write = 1; mem_read = 0; store_data = 32'h12;
        #1;
        $display("SB addr1: wstrb=%b (expect 0010)", dcache_wstrb);

        // 测试6: 写字，地址0
        addr = 32'h0; mem_size = 3'b011; store_data = 32'hDEADBEEF;
        #1;
        $display("SW addr0: wstrb=%b (expect 1111)", dcache_wstrb);

        #10;
        $display("=== LSU Test Complete ===");
        $finish;
    end
endmodule
