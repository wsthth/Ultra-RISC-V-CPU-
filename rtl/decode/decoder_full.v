//==============================================================================
// decoder_full.v - 完整RV32I指令译码器
// 支持全部RV32I指令：OP-IMM/OP/LOAD/STORE/BRANCH/LUI/AUIPC/JAL/JALR/SYSTEM
//==============================================================================
`timescale 1ns/1ps

module decoder_full (
    input  wire [31:0] inst_i,

    output wire [4:0]  rs1_o,
    output wire [4:0]  rs2_o,
    output wire [4:0]  rd_o,
    output wire [31:0] imm_o,

    output wire [3:0]  alu_op_o,
    output wire        alu_src_o,

    output wire        mem_read_o,
    output wire        mem_write_o,
    output wire [2:0]  mem_size_o,
    output wire        mem_unsigned_o,

    output wire        reg_write_o,
    output wire        mem_to_reg_o,

    output wire        is_branch_o,
    output wire        is_jal_o,
    output wire        is_jalr_o,
    output wire [2:0]  branch_type_o,

    output wire        is_system_o,
    output wire [11:0] csr_addr_o
);

    wire [6:0] opcode = inst_i[6:0];
    wire [2:0] funct3 = inst_i[14:12];
    wire [6:0] funct7 = inst_i[31:25];

    assign rs1_o = inst_i[19:15];
    assign rs2_o = inst_i[24:20];
    assign rd_o  = inst_i[11:7];
    assign csr_addr_o = inst_i[31:20];

    // 立即数生成
    reg [31:0] imm;
    always @(*) begin
        case (opcode)
            7'b0010011, 7'b0000011, 7'b1100111:
                imm = {{20{inst_i[31]}}, inst_i[31:20]};
            7'b0100011:
                imm = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
            7'b1100011:
                imm = {{19{inst_i[31]}}, inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
            7'b0110111, 7'b0010111:
                imm = {inst_i[31:12], 12'b0};
            7'b1101111:
                imm = {{11{inst_i[31]}}, inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
            default: imm = 32'd0;
        endcase
    end
    assign imm_o = imm;

    // ALU操作译码
    reg [3:0] alu_op;
    reg       alu_src;
    always @(*) begin
        alu_op  = 4'b0000;
        alu_src = 1'b0;
        case (opcode)
            7'b0110011: begin  // R-type
                alu_src = 1'b0;
                case (funct3)
                    3'b000: alu_op = funct7[5] ? 4'b0001 : 4'b0000;
                    3'b010: alu_op = 4'b1000;
                    3'b011: alu_op = 4'b1001;
                    3'b100: alu_op = 4'b0100;
                    3'b110: alu_op = 4'b0011;
                    3'b111: alu_op = 4'b0010;
                    3'b001: alu_op = 4'b0101;
                    3'b101: alu_op = funct7[5] ? 4'b0111 : 4'b0110;
                endcase
            end
            7'b0010011: begin  // I-type ALU
                alu_src = 1'b1;
                case (funct3)
                    3'b000: alu_op = 4'b0000;
                    3'b010: alu_op = 4'b1000;
                    3'b011: alu_op = 4'b1001;
                    3'b100: alu_op = 4'b0100;
                    3'b110: alu_op = 4'b0011;
                    3'b111: alu_op = 4'b0010;
                    3'b001: alu_op = 4'b0101;
                    3'b101: alu_op = funct7[5] ? 4'b0111 : 4'b0110;
                endcase
            end
            7'b0000011, 7'b0100011: begin  // LOAD/STORE地址计算
                alu_op = 4'b0000;
                alu_src = 1'b1;
            end
            7'b1100011: begin  // BRANCH比较
                alu_op = 4'b0001;
                alu_src = 1'b0;
            end
            7'b0110111: begin  // LUI
                alu_op = 4'b0011;
                alu_src = 1'b1;
            end
            default: begin
                alu_op = 4'b0000;
                alu_src = 1'b1;
            end
        endcase
    end
    assign alu_op_o  = alu_op;
    assign alu_src_o = alu_src;

    // 访存信号
    assign mem_read_o  = (opcode == 7'b0000011);
    assign mem_write_o = (opcode == 7'b0100011);
    assign mem_size_o  = funct3;
    assign mem_unsigned_o = (funct3 == 3'b100) || (funct3 == 3'b110);  // LBU/LHU

    // 写回信号
    assign reg_write_o  = (opcode == 7'b0110011) || (opcode == 7'b0010011) ||
                          (opcode == 7'b0000011) || (opcode == 7'b0110111) ||
                          (opcode == 7'b0010111) || (opcode == 7'b1101111) ||
                          (opcode == 7'b1100111);
    assign mem_to_reg_o = (opcode == 7'b0000011);

    // 跳转信号
    assign is_branch_o = (opcode == 7'b1100011);
    assign is_jal_o    = (opcode == 7'b1101111);
    assign is_jalr_o   = (opcode == 7'b1100111);
    assign branch_type_o = funct3;

    // SYSTEM指令
    assign is_system_o = (opcode == 7'b1110011);

endmodule
