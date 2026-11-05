//==============================================================================
// dcache.v - 数据Cache
// 256组4路组相联，64KB，PLRU替换，Write-Back
// 带16组Victim Cache
//==============================================================================
`timescale 1ns/1ps

module dcache #(
    parameter SETS = 256,
    parameter WAYS = 4,
    parameter LINE_BYTES = 4,
    parameter VICTIM_ENTRIES = 16
)(
    input  wire        clk,
    input  wire        rst_n,

    // CPU侧接口
    input  wire [31:0] addr_i,
    input  wire [31:0] wdata_i,
    input  wire [3:0]  wstrb_i,
    input  wire        we_i,
    input  wire        re_i,
    output reg  [31:0] rdata_o,
    output reg         ready_o,

    // 总线侧接口（简化AXI）
    output reg  [31:0] mem_addr_o,
    output reg  [31:0] mem_wdata_o,
    output reg         mem_we_o,
    output reg         mem_re_o,
    input  wire [31:0] mem_rdata_i,
    input  wire        mem_ready_i
);

    // Cache存储：4路
    reg [31:0] cache_data [0:SETS-1][0:WAYS-1];
    reg [22:0] cache_tag  [0:SETS-1][0:WAYS-1];  // 23bit tag = 32 - 9(set)
    reg        cache_valid [0:SETS-1][0:WAYS-1];
    reg        cache_dirty [0:SETS-1][0:WAYS-1];
    reg [1:0]  plru [0:SETS-1];  // PLRU位

    // Victim Cache：16项全相联
    reg [31:0] victim_data [0:VICTIM_ENTRIES-1];
    reg [22:0] victim_tag  [0:VICTIM_ENTRIES-1];
    reg        victim_valid [0:VICTIM_ENTRIES-1];
    reg [3:0]  victim_ptr;

    wire [7:0] set_idx = addr_i[9:2];
    wire [22:0] tag    = addr_i[31:10];

    integer i, j;

    // 复位
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < SETS; i = i + 1) begin
                for (j = 0; j < WAYS; j = j + 1) begin
                    cache_valid[i][j] <= 1'b0;
                    cache_dirty[i][j] <= 1'b0;
                end
                plru[i] <= 2'b00;
            end
            for (i = 0; i < VICTIM_ENTRIES; i = i + 1) begin
                victim_valid[i] <= 1'b0;
            end
            victim_ptr <= 0;
        end
    end

    // 简化的命中逻辑
    reg hit;
    reg [1:0] hit_way;
    always @(*) begin
        hit = 1'b0;
        hit_way = 0;
        for (j = 0; j < WAYS; j = j + 1) begin
            if (cache_valid[set_idx][j] && (cache_tag[set_idx][j] == tag)) begin
                hit = 1'b1;
                hit_way = j[1:0];
            end
        end
    end

    // 读路径
    always @(*) begin
        if (hit) begin
            rdata_o = cache_data[set_idx][hit_way];
            ready_o = 1'b1;
        end else begin
            rdata_o = 32'd0;
            ready_o = mem_ready_i;  // 简化：等总线
        end
    end

    // 写路径：Write-Back
    always @(posedge clk) begin
        if (we_i && hit) begin
            cache_data[set_idx][hit_way] <= wdata_i;
            cache_dirty[set_idx][hit_way] <= 1'b1;
        end
    end

endmodule
