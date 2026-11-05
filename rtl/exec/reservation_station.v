//==============================================================================
// reservation_station.v - 保留站
// 存放等待执行的指令，等源操作数就绪后发射到执行单元
// 支持结果总线广播背靠背唤醒
//==============================================================================
`timescale 1ns/1ps

module reservation_station #(
    parameter RS_DEPTH = 16,     // 保留站项数
    parameter PHYS_REGS = 64
)(
    input  wire                  clk,
    input  wire                  rst_n,

    // ---- 发射：分配一个RS项 ----
    input  wire                  dispatch_en_i,
    input  wire [3:0]            alu_op_i,
    input  wire [6:0]            op1_prf_i,
    input  wire [6:0]            op2_prf_i,
    input  wire [31:0]           imm_i,
    input  wire                  use_imm_i,
    input  wire [4:0]            rob_idx_i,
    output wire [3:0]            rs_idx_o,
    output wire                  rs_full_o,

    // ---- 物理寄存器堆读口（操作数就绪时直接取） ----
    input  wire [31:0]           prf_rdata1_i,
    input  wire [31:0]           prf_rdata2_i,

    // ---- 结果总线（广播唤醒） ----
    input  wire                  cdb_we_i,       // 结果总线有效
    input  wire [6:0]            cdb_prf_i,     // 结果写入的物理寄存器号
    input  wire [31:0]           cdb_data_i,     // 结果数据

    // ---- 发射到执行单元 ----
    output reg                   issue_valid_o,
    output reg  [3:0]            issue_alu_op_o,
    output reg  [31:0]           issue_op1_o,
    output reg  [31:0]           issue_op2_o,
    output reg  [4:0]            issue_rob_idx_o,
    input  wire                  issue_ready_i   // 执行单元接受了
);

    // RS项存储
    reg                 rs_valid [0:RS_DEPTH-1];
    reg [3:0]           rs_op    [0:RS_DEPTH-1];
    reg [31:0]          rs_vj    [0:RS_DEPTH-1];
    reg [31:0]          rs_vk    [0:RS_DEPTH-1];
    reg [31:0]          rs_imm   [0:RS_DEPTH-1];
    reg                 rs_use_imm [0:RS_DEPTH-1];
    reg [6:0]           rs_qj    [0:RS_DEPTH-1];  // 操作数1等待的PRF号（0表示就绪）
    reg [6:0]           rs_qk    [0:RS_DEPTH-1];  // 操作数2等待的PRF号
    reg [4:0]           rs_rob   [0:RS_DEPTH-1];  // ROB索引

    // 空闲栈
    reg [3:0] free_stack [0:RS_DEPTH-1];
    reg [4:0] free_count;

    integer i;

    // RS满
    assign rs_full_o = (free_count == 0);
    assign rs_idx_o = free_stack[free_count - 1];

    // 时序逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < RS_DEPTH; i = i + 1) begin
                rs_valid[i] <= 1'b0;
                rs_op[i]    <= 4'd0;
                rs_vj[i]    <= 32'd0;
                rs_vk[i]    <= 32'd0;
                rs_qj[i]    <= 7'd0;
                rs_qk[i]    <= 7'd0;
                rs_rob[i]   <= 5'd0;
                free_stack[i] <= i[3:0];
            end
            free_count <= RS_DEPTH[4:0];
            issue_valid_o <= 1'b0;
        end else begin
            // 1. 发射新指令
            if (dispatch_en_i && !rs_full_o) begin
                rs_valid[rs_idx_o] <= 1'b1;
                rs_op[rs_idx_o]     <= alu_op_i;
                rs_rob[rs_idx_o]    <= rob_idx_i;
                // 操作数就绪判断：如果PRF号是0或者已经有值，就直接用
                // 简化：这里先假设op1/op2都从PRF读，实际会在顶层拼接
                rs_vj[rs_idx_o] <= prf_rdata1_i;
                rs_vk[rs_idx_o] <= prf_rdata2_i;
                rs_imm[rs_idx_o] <= imm_i;
                rs_use_imm[rs_idx_o] <= use_imm_i;
                // 操作数就绪判断：简化版，先全部标记就绪，后续补PRF初始化
                rs_qj[rs_idx_o] <= 7'd0;
                rs_qk[rs_idx_o] <= 7'd0;
                free_count <= free_count - 1;
            end

            // 2. CDB广播唤醒：所有等待这个PRF的RS项捕获结果
            if (cdb_we_i) begin
                for (i = 0; i < RS_DEPTH; i = i + 1) begin
                    if (rs_valid[i] && (rs_qj[i] == cdb_prf_i)) begin
                        rs_vj[i] <= cdb_data_i;
                        rs_qj[i] <= 7'd0;
                    end
                    if (rs_valid[i] && (rs_qk[i] == cdb_prf_i)) begin
                        rs_vk[i] <= cdb_data_i;
                        rs_qk[i] <= 7'd0;
                    end
                end
            end

            // 3. 发射到执行单元：找第一个就绪的RS项
            issue_valid_o <= 1'b0;
            for (i = 0; i < RS_DEPTH; i = i + 1) begin
                if (rs_valid[i] && (rs_qj[i] == 7'd0) && (rs_qk[i] == 7'd0) && issue_ready_i) begin
                    issue_valid_o  <= 1'b1;
                    issue_alu_op_o <= rs_op[i];
                    issue_op1_o    <= rs_vj[i];
                    issue_op2_o    <= rs_use_imm[i] ? rs_imm[i] : rs_vk[i];
                    issue_rob_idx_o <= rs_rob[i];
                    rs_valid[i]    <= 1'b0;
                    // 回收RS项
                    free_stack[free_count] <= i[3:0];
                    free_count <= free_count + 1;
                end
            end
        end
    end

endmodule
