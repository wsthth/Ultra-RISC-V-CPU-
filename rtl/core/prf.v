//==============================================================================
// prf.v - Physical Register File 物理寄存器堆
// 多读口多写口，支持乱序写回
//==============================================================================
`timescale 1ns/1ps

module prf #(
    parameter PHYS_REGS = 64,
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,

    // 读口1
    input  wire [6:0]            raddr1_i,
    output wire [DATA_WIDTH-1:0] rdata1_o,

    // 读口2
    input  wire [6:0]            raddr2_i,
    output wire [DATA_WIDTH-1:0] rdata2_o,

    // 写口（CDB写回）
    input  wire                  we_i,
    input  wire [6:0]            waddr_i,
    input  wire [DATA_WIDTH-1:0] wdata_i
);

    reg [DATA_WIDTH-1:0] rf [0:PHYS_REGS-1];
    integer i;

    // 组合读
    assign rdata1_o = (raddr1_i == 7'd0) ? 32'd0 : rf[raddr1_i];
    assign rdata2_o = (raddr2_i == 7'd0) ? 32'd0 : rf[raddr2_i];

    // 同步写
    always @(posedge clk) begin
        if (we_i && (waddr_i != 7'd0)) begin
            rf[waddr_i] <= wdata_i;
        end
    end

    // 仿真初始化
    initial begin
        for (i = 0; i < PHYS_REGS; i = i + 1) begin
            rf[i] = 32'd0;
        end
    end

endmodule
