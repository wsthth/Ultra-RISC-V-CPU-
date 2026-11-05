`timescale 1ns/1ps
//==============================================================================
// tb_rename.v - 寄存器重命名功能测试
//==============================================================================
module tb_rename;
    reg clk = 0;
    reg rst_n = 0;

    reg         rename_en;
    reg  [4:0]  arch_rs1, arch_rs2, arch_rd;
    reg         rd_we;
    wire [6:0]  ps1, ps2, pd;
    wire        ready;

    reg         commit_en;
    reg  [4:0]  commit_arch_rd;
    reg  [6:0]  commit_pd;
    reg         commit_rd_we;

    reg pass;

    reg_rename dut(
        .clk(clk), .rst_n(rst_n),
        .rename_en_i(rename_en),
        .arch_rs1_i(arch_rs1), .arch_rs2_i(arch_rs2),
        .arch_rd_i(arch_rd), .rd_we_i(rd_we),
        .ps1_o(ps1), .ps2_o(ps2), .pd_o(pd),
        .rename_ready_o(ready),
        .commit_en_i(commit_en),
        .commit_arch_rd_i(commit_arch_rd),
        .commit_pd_i(commit_pd),
        .commit_rd_we_i(commit_rd_we)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== Register Rename Test ===");
        #20; rst_n = 1; #10;

        // 测试1: 写x1，分配新物理寄存器
        rename_en = 1; rd_we = 1; arch_rd = 5'd1; arch_rs1 = 5'd1; arch_rs2 = 5'd0;
        #10;
        pass = (pd == 7'd33);
        $display("Write x1: pd=%0d (expect 33) pass=%b", pd, pass);

        // 测试2: 再写x1，应该分配新的物理寄存器（消除WAW）
        arch_rd = 5'd1;
        #10;
        pass = (pd == 7'd34);
        $display("Write x1 again: pd=%0d (expect 34) pass=%b", pd, pass);

        // 测试3: 读x1，应该指向最新的pd
        arch_rs1 = 5'd1; rd_we = 0;
        #1;
        pass = (ps1 == 7'd34);
        $display("Read x1: ps1=%0d (expect 34) pass=%b", ps1, pass);

        // 测试4: 提交旧的x1物理寄存器
        commit_en = 1; commit_arch_rd = 5'd1; commit_pd = 7'd33; commit_rd_we = 1;
        #10;
        commit_en = 0;
        $display("Committed x1 old pd=33");

        // 测试5: 提交新的x1物理寄存器
        commit_en = 1; commit_pd = 7'd34;
        #10;
        commit_en = 0;
        $display("Committed x1 new pd=34");

        #10;
        $display("=== Rename Test Complete ===");
        $finish;
    end
endmodule
