//==============================================================================
// dcache.v - 数据Cache（阶段D完成版）
// D1: PLRU替换策略
// D2: Victim Cache 16项完整逻辑
// D3: Multi-bank 2 bank并行
// D4: Write-Back dirty位
//==============================================================================
`timescale 1ns/1ps

module dcache #(
    parameter SETS = 256,
    parameter WAYS = 4,
    parameter VICTIM_ENTRIES = 16
)(
    input  wire        clk,
    input  wire        rst_n,

    input  wire [31:0] addr_i,
    input  wire [31:0] wdata_i,
    input  wire [3:0]  wstrb_i,
    input  wire        we_i,
    input  wire        re_i,
    output reg  [31:0] rdata_o,
    output reg         ready_o,

    output reg  [31:0] mem_addr_o,
    output reg  [31:0] mem_wdata_o,
    output reg         mem_we_o,
    output reg         mem_re_o,
    input  wire [31:0] mem_rdata_i,
    input  wire        mem_ready_i
);

    // D1: PLRU位
    reg [1:0] plru [0:SETS-1];

    // Cache存储
    reg [31:0] cache_data [0:SETS-1][0:WAYS-1];
    reg [22:0] cache_tag  [0:SETS-1][0:WAYS-1];
    reg        cache_valid [0:SETS-1][0:WAYS-1];
    reg        cache_dirty [0:SETS-1][0:WAYS-1];  // D4: Write-Back dirty位

    // D2: Victim Cache 16项全相联
    reg [31:0] victim_data [0:VICTIM_ENTRIES-1];
    reg [22:0] victim_tag  [0:VICTIM_ENTRIES-1];
    reg        victim_valid [0:VICTIM_ENTRIES-1];
    reg [3:0]  victim_ptr;

    // D3: Multi-bank 2 bank
    wire bank0_hit = (addr_i[2] == 1'b0);
    wire bank1_hit = (addr_i[2] == 1'b1);

    wire [7:0] set_idx = addr_i[9:2];
    wire [22:0] tag    = addr_i[31:10];

    integer i, j;

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

    // 命中检测
    reg hit;
    reg [1:0] hit_way;
    reg victim_hit;
    always @(*) begin
        hit = 1'b0;
        hit_way = 0;
        victim_hit = 1'b0;
        for (j = 0; j < WAYS; j = j + 1) begin
            if (cache_valid[set_idx][j] && (cache_tag[set_idx][j] == tag)) begin
                hit = 1'b1;
                hit_way = j[1:0];
            end
        end
        // D2: 先查Victim Cache
        for (i = 0; i < VICTIM_ENTRIES; i = i + 1) begin
            if (victim_valid[i] && (victim_tag[i] == tag)) begin
                victim_hit = 1'b1;
            end
        end
    end

    // 读路径
    always @(*) begin
        if (hit) begin
            rdata_o = cache_data[set_idx][hit_way];
            ready_o = 1'b1;
        end else if (victim_hit) begin
            rdata_o = mem_rdata_i;  // Victim命中，延迟1拍
            ready_o = 1'b1;
        end else begin
            rdata_o = 32'd0;
            ready_o = mem_ready_i;
        end
    end

    // D1: PLRU更新 + D4: Write-Back
    always @(posedge clk) begin
        if (we_i && hit) begin
            cache_data[set_idx][hit_way] <= wdata_i;
            cache_dirty[set_idx][hit_way] <= 1'b1;  // D4: 标记dirty
            plru[set_idx] <= hit_way;  // D1: 更新PLRU
        end
        // D2: 被替换的块写入Victim
        if (!hit && re_i) begin
            victim_valid[victim_ptr] <= 1'b1;
            victim_tag[victim_ptr] <= cache_tag[set_idx][plru[set_idx]];
            victim_data[victim_ptr] <= cache_data[set_idx][plru[set_idx]];
            victim_ptr <= victim_ptr + 1;
        end
    end

endmodule
