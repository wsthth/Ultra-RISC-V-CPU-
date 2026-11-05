//==============================================================================
// decoder.v - RV32I 指令译码器
// 输出：操作数地址、立即数、ALU控制信号、访存信号、写回信号等
//==============================================================================
`timescale 1ns/1ps

module decoder (
    input  wire [31:0] inst_i,       // 32位指令

    // 译码输出
    output wire [4:0]  rs1_o,        // 源寄存器1地址
    output wire [4:0]  rs2_o,        // 源寄存器2地址
    output wire [4:0]  rd_o,         // 目的寄存器地址
    output wire [31:0] imm_o,        // 符号扩展后的立即数

    output wire [3:0]  alu_op_o,     // ALU操作码
    output wire        alu_src_o,    // ALU第二操作数来自立即数

    output wire        mem_read_o,   // 访存读
    output wire        mem_write_o,  // 访存写
    output wire [2:0]  mem_size_o,   // 访存宽度（lb/lh/lw/sb/sh/sw）

    output wire        reg_write_o,  // 写寄存器堆
    output wire        mem_to_reg_o, // 写回数据来自内存

    output wire        is_branch_o,  // 条件分支
    output wire        is_jal_o,     // 无条件跳转 JAL
    output wire        is_jalr_o,    // 无条件跳转 JALR

    output wire [6:0]  opcode_o,     // 原始opcode（调试用）
    output wire [2:0]  funct3_o,
    output wire [6:0]  funct7_o
);

    // 指令字段提取
    wire [6:0] opcode = inst_i[6:0];
    wire [2:0] funct3 = inst_i[14:12];
    wire [6:0] funct7 = inst_i[31:25];

    assign opcode_o = opcode;
    assign funct3_o = funct3;
    assign funct7_o = funct7;

    assign rs1_o = inst_i[19:15];
    assign rs2_o = inst_i[24:20];
    assign rd_o  = inst_i[11:7];

    // 立即数生成
    reg [31:0] imm;
    always @(*) begin
        case (opcode)
            7'b0010011,  // OP-IMM
            7'b0000011,  // LOAD
            7'b1100111:  // JALR
                imm = {{20{inst_i[31]}}, inst_i[31:20]};  // I-type

            7'b0100011:  // STORE
                imm = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};  // S-type

            7'b1100011:  // BRANCH
                imm = {{19{inst_i[31]}}, inst_i[31], inst_i[7],
                        inst_i[30:25], inst_i[11:8], 1'b0};  // B-type

            7'b0110111,  // LUI
            7'b0010111:  // AUIPC
                imm = {inst_i[31:12], 12'b0};  // U-type

            7'b1101111:  // JAL
                imm = {{11{inst_i[31]}}, inst_i[31], inst_i[19:12],
                        inst_i[20], inst_i[30:21], 1'b0};  // J-type

            default:
                imm = 32'd0;
        endcase
    end
    assign imm_o = imm;

    // ALU 操作译码
    reg [3:0] alu_op;
    reg       alu_src;
    always @(*) begin
        alu_op  = 4'b0000;  // 默认 ADD
        alu_src = 1'b0;

        case (opcode)
            7'b0110011: begin  // OP (R-type)
                alu_src = 1'b0;
                case (funct3)
                    3'b000: alu_op = funct7[5] ? 4'b0001 : 4'b0000; // SUB/ADD
                    3'b010: alu_op = 4'b1000; // SLT
                    3'b011: alu_op = 4'b1001; // SLTU
                    3'b100: alu_op = 4'b0100; // XOR
                    3'b110: alu_op = 4'b0011; // OR
                    3'b111: alu_op = 4'b0010; // AND
                    3'b001: alu_op = 4'b0101; // SLL
                    3'b101: alu_op = funct7[5] ? 4'b0111 : 4'b0110; // SRA/SRL
                    default: alu_op = 4'b0000;
                endcase
            end

            7'b0010011: begin  // OP-IMM (I-type)
                alu_src = 1'b1;
                case (funct3)
                    3'b000: alu_op = 4'b0000; // ADDI
                    3'b010: alu_op = 4'b1000; // SLTI
                    3'b011: alu_op = 4'b1001; // SLTIU
                    3'b100: alu_op = 4'b0100; // XORI
                    3'b110: alu_op = 4'b0011; // ORI
                    3'b111: alu_op = 4'b0010; // ANDI
                    3'b001: alu_op = 4'b0101; // SLLI
                    3'b101: alu_op = funct7[5] ? 4'b0111 : 4'b0110; // SRAI/SRLI
                    default: alu_op = 4'b0000;
                endcase
            end

            7'b0000011,  // LOAD
            7'b0100011:  // STORE
                alu_op  = 4'b0000;  // 地址计算用加法
                alu_src = 1'b1;

            7'b1100011: begin  // BRANCH
                alu_op  = 4'b0001;  // 比较用减法
                alu_src = 1'b0;
            end

            7'b0110111:  // LUI
                begin alu_op = 4'b0011; alu_src = 1'b1; end  // OR 立即数

            7'b0010111,  // AUIPC
            7'b1101111,  // JAL
            7'b1100111:  // JALR
                begin alu_op = 4'b0000; alu_src = 1'b1; end  // PC + imm

            default: begin
                alu_op  = 4'b0000;
                alu_src = 1'b0;
            end
        endcase
    end
    assign alu_op_o  = alu_op;
    assign alu_src_o = alu_src;

    // 访存信号
    assign mem_read_o  = (opcode == 7'b0000011);  // LOAD
    assign mem_write_o = (opcode == 7'b0100011);  // STORE
    assign mem_size_o  = funct3;

    // 写回信号
    assign reg_write_o  = (opcode == 7'b0110011) ||  // OP
                          (opcode == 7'b0010011) ||  // OP-IMM
                          (opcode == 7'b0000011) ||  // LOAD
                          (opcode == 7'b0110111) ||  // LUI
                          (opcode == 7'b0010111) ||  // AUIPC
                          (opcode == 7'b1101111) ||  // JAL
                          (opcode == 7'b1100111);    // JALR
    assign mem_to_reg_o = (opcode == 7'b0000011);    // LOAD

    // 跳转信号
    assign is_branch_o = (opcode == 7'b1100011);
    assign is_jal_o    = (opcode == 7'b1101111);
    assign is_jalr_o   = (opcode == 7'b1100111);

endmodule
