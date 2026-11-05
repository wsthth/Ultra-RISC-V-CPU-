`timescale 1ns/1ps
//==============================================================================
// tb_trap.v - 精确中断/异常测试
//==============================================================================
module tb_trap;
    reg clk = 0;
    reg rst_n = 0;

    reg instr_addr_misaligned, instr_access_fault;
    reg illegal_instr, ecall, ebreak;
    reg lsu_addr_misaligned, lsu_access_fault;
    reg ext_int, timer_int;
    reg [31:0] pc;

    wire        trap_take;
    wire [31:0] trap_vector;
    wire [31:0] mepc, mcause;
    reg         mret;
    wire [31:0] epc;

    trap_unit dut(
        .clk(clk), .rst_n(rst_n),
        .instr_addr_misaligned_i(instr_addr_misaligned),
        .instr_access_fault_i(instr_access_fault),
        .illegal_instr_i(illegal_instr),
        .ecall_i(ecall), .ebreak_i(ebreak),
        .lsu_addr_misaligned_i(lsu_addr_misaligned),
        .lsu_access_fault_i(lsu_access_fault),
        .ext_int_i(ext_int), .timer_int_i(timer_int),
        .pc_i(pc),
        .trap_take_o(trap_take),
        .trap_vector_o(trap_vector),
        .mepc_o(mepc), .mcause_o(mcause),
        .mret_i(mret), .epc_o(epc)
    );

    always #5 clk = ~clk;

    initial begin
        $display("=== Trap Unit Test ===");
        #20; rst_n = 1; #10;

        // 测试1: 非法指令异常
        illegal_instr = 1; pc = 32'h1000;
        #1;
        $display("Illegal instr: trap=%b, cause=%0d, mepc=%h", trap_take, mcause, mepc);
        illegal_instr = 0;

        // 测试2: ECALL异常
        #10;
        ecall = 1; pc = 32'h2000;
        #1;
        $display("ECALL: trap=%b, cause=%0d, mepc=%h", trap_take, mcause, mepc);
        ecall = 0;

        // 测试3: 外部中断
        #10;
        ext_int = 1; pc = 32'h3000;
        #1;
        $display("External interrupt: trap=%b, cause[31]=%b (interrupt)", trap_take, mcause[31]);
        ext_int = 0;

        // 测试4: 无异常时不触发
        #10;
        $display("Normal: trap=%b (expect 0)", trap_take);

        #10;
        $display("=== Trap Test Complete ===");
        $finish;
    end
endmodule
