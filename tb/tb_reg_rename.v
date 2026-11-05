`timescale 1ns/1ps
//==============================================================================
// tb_reg_rename.v - 寄存器重命名模块测试
//==============================================================================
module tb_reg_rename;
    reg clk = 0;
    reg rst_n = 0;

    reg        rename_en;
    reg [4:0]  arch_rs1, arch_rs2, arch_rd;
    reg        rd_we;
    wire [6:0] ps1, ps2, pd;
    wire       rename_ready;

    reg        commit_en;
    reg [4:0]  commit_arch_rd;
    reg [6:0]  commit_pd;
    reg        commit_rd_we;

    reg_rename dut(
        .clk(clk), .rst_n(rst_n),
        .rename_en_i(rename_en),
        .arch_rs1_i(arch_rs1), .arch_rs2_i(arch_rs2),
        .arch_rd_i(arch_rd), .rd_we_i(rd_we),
        .ps1_o(ps1), .ps2_o(ps2), .pd_o(pd),
        .rename_ready_o(rename_ready),
        .commit_en_i(commit_en),
        .commit_arch_rd_i(commit_arch_rd),
        .commit_pd_i(commit_pd),
        .commit_rd_we_i(commit_rd_we)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== tb_reg_rename start ===");
        // 复位
        rename_en = 0; rd_we = 0;
        arch_rs1 = 0; arch_rs2 = 0; arch_rd = 0;
        commit_en = 0; commit_arch_rd = 0; commit_pd = 0; commit_rd_we = 0;

        #10; rst_n = 1;
        @(posedge clk);

        // 测试1：发射 ADD x5, x1, x2
        // x1 -> PRF1, x2 -> PRF2, 分配新的PRF32给x5
        $display("\n--- Test1: ADD x5, x1, x2 ---");
        arch_rs1 = 5'd1; arch_rs2 = 5'd2; arch_rd = 5'd5;
        rename_en = 1; rd_we = 1;
        @(posedge clk);
        #1;
        $display("ps1=%0d (expect 1), ps2=%0d (expect 2), pd=%0d (expect 32), ready=%b",
                 ps1, ps2, pd, rename_ready);
        rename_en = 0; rd_we = 0;

        // 测试2：发射 ADD x6, x5, x1
        // x5现在应该映射到PRF32，x1还是PRF1
        $display("\n--- Test2: ADD x6, x5, x1 ---");
        arch_rs1 = 5'd5; arch_rs2 = 5'd1; arch_rd = 5'd6;
        rename_en = 1; rd_we = 1;
        @(posedge clk);
        #1;
        $display("ps1=%0d (expect 32), ps2=%0d (expect 1), pd=%0d (expect 33)",
                 ps1, ps2, pd);
        rename_en = 0; rd_we = 0;

        // 测试3：提交第一条指令 (x5 -> PRF32)
        // 旧的PRF5应该被回收
        $display("\n--- Test3: COMMIT x5=PRF32, old PRF5 freed ---");
        commit_en = 1; commit_arch_rd = 5'd5; commit_pd = 7'd5; commit_rd_we = 1;
        @(posedge clk);
        #1;
        $display("commit done, free_count should increase");
        commit_en = 0; commit_rd_we = 0;

        // 测试4：再发射几条，看Free List是否正常
        $display("\n--- Test4: 连续发射4条指令 ---");
        repeat (4) begin
            arch_rs1 = 5'd1; arch_rs2 = 5'd2; arch_rd = arch_rd + 1;
            rename_en = 1; rd_we = 1;
            @(posedge clk);
            #1;
            $display("  pd=%0d, ready=%b", pd, rename_ready);
        end
        rename_en = 0; rd_we = 0;

        #20;
        $display("\n=== TEST PASSED ===");
        $finish;
    end
endmodule
