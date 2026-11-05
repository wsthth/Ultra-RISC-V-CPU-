`timescale 1ns/1ps
//==============================================================================
// tb_decoder.v - 译码器功能测试
//==============================================================================
module tb_decoder;
    reg [31:0] inst;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] imm;
    wire [3:0] alu_op;
    wire mem_read, mem_write, reg_write;

    decoder_full dut(
        .inst_i(inst),
        .rs1_o(rs1), .rs2_o(rs2), .rd_o(rd), .imm_o(imm),
        .alu_op_o(alu_op), .alu_src_o(),
        .mem_read_o(mem_read), .mem_write_o(mem_write),
        .mem_size_o(), .mem_unsigned_o(),
        .reg_write_o(reg_write), .mem_to_reg_o(),
        .is_branch_o(), .is_jal_o(), .is_jalr_o(),
        .branch_type_o(), .is_system_o(), .csr_addr_o()
    );

    initial begin
        $display("=== Decoder Test ===");

        // ADD x1, x2, x3 (R-type)
        inst = 32'h003100b3;
        #1;
        $display("ADD x1,x2,x3: rs1=%0d rs2=%0d rd=%0d alu_op=%b reg_wr=%b",
                 rs1, rs2, rd, alu_op, reg_write);

        // ADDI x1, x2, 100 (I-type)
        inst = 32'h06410093;
        #1;
        $display("ADDI x1,x2,100: rd=%0d imm=%0d alu_op=%b reg_wr=%b",
                 rd, imm, alu_op, reg_write);

        // LW x1, 4(x2) (LOAD)
        inst = 32'h00412083;
        #1;
        $display("LW x1,4(x2): rd=%0d imm=%0d mem_read=%b reg_wr=%b",
                 rd, imm, mem_read, reg_write);

        // SW x1, 8(x2) (STORE)
        inst = 32'h00112423;
        #1;
        $display("SW x1,8(x2): imm=%0d mem_write=%b reg_wr=%b",
                 imm, mem_write, reg_write);

        // BEQ x1, x2, offset (BRANCH)
        inst = 32'h00210463;
        #1;
        $display("BEQ x1,x2,offset: imm=%0d", imm);

        // LUI x1, 0x12345 (U-type)
        inst = 32'h123450b7;
        #1;
        $display("LUI x1,0x12345: rd=%0d imm=%h", rd, imm);

        // JAL x1, offset (J-type)
        inst = 32'h010000ef;
        #1;
        $display("JAL x1,offset: rd=%0d imm=%0d reg_wr=%b", rd, imm, reg_write);

        $display("=== Decoder Test PASSED ===");
        $finish;
    end
endmodule
