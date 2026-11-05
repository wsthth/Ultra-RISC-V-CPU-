//==============================================================================
// lsu.v - Load/Store Unit 加载存储单元
// 支持字节/半字/字，有符号/无符号加载
//==============================================================================
`timescale 1ns/1ps

module lsu (
    input  wire        clk,
    input  wire        rst_n,

    // 来自执行阶段的地址
    input  wire [31:0] addr_i,
    input  wire [31:0] store_data_i,
    input  wire [2:0]  mem_size_i,    // 000=byte, 001=half, 011=word
    input  wire        mem_unsigned_i,
    input  wire        mem_read_i,
    input  wire        mem_write_i,

    // 到Dcache的接口
    output wire [31:0] dcache_addr_o,
    output wire [31:0] dcache_wdata_o,
    output wire [3:0]  dcache_wstrb_o,
    output wire        dcache_re_o,
    output wire        dcache_we_o,
    input  wire [31:0] dcache_rdata_i,
    input  wire        dcache_ready_i,

    // 到寄存器堆的读数据
    output reg  [31:0] load_data_o,
    output wire        lsu_done_o
);

    assign dcache_addr_o  = addr_i;
    assign dcache_wdata_o = store_data_i;
    assign dcache_re_o    = mem_read_i;
    assign dcache_we_o    = mem_write_i;

    // 写使能：按字节选通
    reg [3:0] wstrb;
    always @(*) begin
        case (mem_size_i)
            3'b000: wstrb = 4'b0001 << addr_i[1:0];  // byte
            3'b001: wstrb = 4'b0011 << addr_i[1:0];  // half
            default: wstrb = 4'b1111;                 // word
        endcase
    end
    assign dcache_wstrb_o = wstrb;

    // 加载数据对齐与符号扩展
    always @(*) begin
        case (mem_size_i)
            3'b000: begin  // byte
                case (addr_i[1:0])
                    2'b00: load_data_o = mem_unsigned_i ? {24'd0, dcache_rdata_i[7:0]}  : {{24{dcache_rdata_i[7]}},  dcache_rdata_i[7:0]};
                    2'b01: load_data_o = mem_unsigned_i ? {24'd0, dcache_rdata_i[15:8]} : {{24{dcache_rdata_i[15]}}, dcache_rdata_i[15:8]};
                    2'b10: load_data_o = mem_unsigned_i ? {24'd0, dcache_rdata_i[23:16]}: {{24{dcache_rdata_i[23]}}, dcache_rdata_i[23:16]};
                    2'b11: load_data_o = mem_unsigned_i ? {24'd0, dcache_rdata_i[31:24]}: {{24{dcache_rdata_i[31]}}, dcache_rdata_i[31:24]};
                endcase
            end
            3'b001: begin  // half
                case (addr_i[1])
                    1'b0: load_data_o = mem_unsigned_i ? {16'd0, dcache_rdata_i[15:0]}  : {{16{dcache_rdata_i[15]}},  dcache_rdata_i[15:0]};
                    1'b1: load_data_o = mem_unsigned_i ? {16'd0, dcache_rdata_i[31:16]} : {{16{dcache_rdata_i[31]}}, dcache_rdata_i[31:16]};
                endcase
            end
            default: load_data_o = dcache_rdata_i;  // word
        endcase
    end

    assign lsu_done_o = dcache_ready_i;

endmodule
