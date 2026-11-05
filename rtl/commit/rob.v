//==============================================================================
// rob.v - Reorder Buffer 重排序缓冲
// 按程序顺序提交指令，保证精确异常
//
// 结构：环形队列，head指向下一条要提交的指令，tail指向下一条要写入的指令
// 每条ROB项记录：
//   - valid: 该项是否有效
//   - done: 指令是否执行完成
//   - arch_rd: 目的架构寄存器号
//   - phys_rd: 目的物理寄存器号
//   - is_store: 是否是store指令
//==============================================================================
`timescale 1ns/1ps

module rob #(
    parameter ROB_DEPTH = 32,      // ROB项数
    parameter ARCH_REGS = 32,
    parameter PHYS_REGS = 64
)(
    input  wire                  clk,
    input  wire                  rst_n,

    // ---- 发射阶段：写入ROB ----
    input  wire                  push_en_i,       // 发射一条指令，写入ROB
    input  wire [4:0]            push_arch_rd_i,  // 目的架构寄存器
    input  wire [6:0]            push_phys_rd_i,  // 目的物理寄存器
    input  wire                  push_rd_we_i,    // 是否写寄存器
    input  wire                  push_is_store_i, // 是否是store指令
    output wire [4:0]            push_ptr_o,     // 这条指令在ROB中的索引（供保留站记录）
    output wire                  rob_full_o,      // ROB是否满了

    // ---- 执行完成：标记ROB项为done ----
    input  wire                  commit_wr_en_i,   // 执行完成写回
    input  wire [4:0]            commit_ptr_i,     // 完成的ROB索引
    input  wire [31:0]           commit_result_i, // 执行结果
    input  wire                  commit_rob_we_i,  // 写结果使能

    // ---- 提交阶段：从ROB头部提交 ----
    output wire                  commit_valid_o,   // 有指令可以提交
    output wire [4:0]            commit_arch_rd_o,
    output wire [6:0]            commit_phys_rd_o,
    output wire [31:0]           commit_result_o,
    output wire                  commit_rd_we_o,
    input  wire                  commit_pop_i     // 弹出这条指令
);

    // ROB存储
    reg                 rob_valid  [0:ROB_DEPTH-1];
    reg                 rob_done   [0:ROB_DEPTH-1];
    reg [4:0]           rob_ard    [0:ROB_DEPTH-1];
    reg [6:0]           rob_prd    [0:ROB_DEPTH-1];
    reg [31:0]          rob_result  [0:ROB_DEPTH-1];
    reg                 rob_rd_we  [0:ROB_DEPTH-1];

    // 读写指针
    reg [4:0] head;   // 指向最老的未提交指令
    reg [4:0] tail;   // 指向下一个可写位置
    reg [5:0] count;  // 当前ROB中的指令数

    integer i;

    // 输出：push的位置就是tail
    assign push_ptr_o = tail;
    assign rob_full_o = (count >= ROB_DEPTH);

    // 输出：提交的就是head指向的项
    assign commit_valid_o  = rob_valid[head] && rob_done[head];
    assign commit_arch_rd_o = rob_ard[head];
    assign commit_phys_rd_o = rob_prd[head];
    assign commit_result_o  = rob_result[head];
    assign commit_rd_we_o   = rob_rd_we[head];

    // 时序逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < ROB_DEPTH; i = i + 1) begin
                rob_valid[i]  <= 1'b0;
                rob_done[i]   <= 1'b0;
                rob_ard[i]    <= 5'd0;
                rob_prd[i]    <= 7'd0;
                rob_result[i] <= 32'd0;
                rob_rd_we[i]  <= 1'b0;
            end
            head  <= 5'd0;
            tail  <= 5'd0;
            count <= 6'd0;
        end else begin
            // 1. 写入新指令（发射）
            if (push_en_i && !rob_full_o) begin
                rob_valid[tail]  <= 1'b1;
                rob_done[tail]   <= 1'b0;
                rob_ard[tail]    <= push_arch_rd_i;
                rob_prd[tail]    <= push_phys_rd_i;
                rob_rd_we[tail]  <= push_rd_we_i;
                rob_result[tail] <= 32'd0;
                tail  <= tail + 1;
                count <= count + 1;
            end

            // 2. 执行完成，标记done
            if (commit_wr_en_i && commit_rob_we_i) begin
                rob_done[commit_ptr_i]   <= 1'b1;
                rob_result[commit_ptr_i] <= commit_result_i;
            end

            // 3. 提交：从head弹出
            if (commit_pop_i && commit_valid_o) begin
                rob_valid[head] <= 1'b0;
                head  <= head + 1;
                count <= count - 1;
            end
        end
    end

endmodule
