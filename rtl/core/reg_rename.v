//==============================================================================
// reg_rename.v - 寄存器重命名模块
// 将架构寄存器映射到物理寄存器，消除WAR和WAW冒险
// 
// 基本原理：
// - RAT (Register Alias Table): 架构寄存器号 -> 物理寄存器号
// - Free List: 空闲物理寄存器队列
// - 每条写寄存器的指令：从Free List取一个新PRF，更新RAT
// - 提交时：旧的物理寄存器放回Free List
//==============================================================================
`timescale 1ns/1ps

module reg_rename #(
    parameter ARCH_REGS = 32,    // 架构寄存器数
    parameter PHYS_REGS = 64      // 物理寄存器数（>ARCH_REGS）
)(
    input  wire                  clk,
    input  wire                  rst_n,

    // ---- 译码/发射阶段 ----
    input  wire                  rename_en_i,      // 重命名使能（发射一条指令）
    input  wire [4:0]            arch_rs1_i,       // 源寄存器1（架构号）
    input  wire [4:0]            arch_rs2_i,       // 源寄存器2（架构号）
    input  wire [4:0]            arch_rd_i,        // 目的寄存器（架构号）
    input  wire                  rd_we_i,          // 是否写目的寄存器

    output wire [6:0]            ps1_o,            // 源操作数1物理寄存器号
    output wire [6:0]            ps2_o,            // 源操作数2物理寄存器号
    output wire [6:0]            pd_o,             // 新分配的目的物理寄存器号
    output wire                  rename_ready_o,   // 重命名资源是否可用（Free List非空）

    // ---- 提交阶段 ----
    input  wire                  commit_en_i,      // 提交一条指令
    input  wire [4:0]            commit_arch_rd_i,// 提交的目的架构寄存器
    input  wire [6:0]            commit_pd_i,     // 提交的目的物理寄存器
    input  wire                  commit_rd_we_i   // 该指令是否写寄存器
);

    // RAT: 架构寄存器 -> 物理寄存器
    reg [6:0] rat [0:ARCH_REGS-1];

    // Free List: 空闲物理寄存器栈
    reg [6:0] free_list [0:PHYS_REGS-1];
    reg [6:0] free_count;

    integer i;

    // 读RAT：查源操作数
    assign ps1_o = rat[arch_rs1_i];
    assign ps2_o = rat[arch_rs2_i];

    // 新分配的物理寄存器 = Free List栈顶
    assign pd_o = free_list[free_count - 1];
    assign rename_ready_o = (free_count > 1);  // 至少留一个空闲

    // 时序逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 复位：RAT初始化为 x0->0, x1->1, ..., x31->31
            for (i = 0; i < ARCH_REGS; i = i + 1) begin
                rat[i] <= i[6:0];
            end
            // Free List: 32~63都是空闲的
            for (i = 0; i < PHYS_REGS; i = i + 1) begin
                free_list[i] <= 7'd0;
            end
            for (i = 32; i < PHYS_REGS; i = i + 1) begin
                free_list[i-32] <= i[6:0];
            end
            free_count <= 7'd32;  // 32个空闲物理寄存器
        end else begin
            // 1. 发射：重命名
            if (rename_en_i && rd_we_i && (arch_rd_i != 5'd0) && rename_ready_o) begin
                // 更新RAT：架构rd指向新分配的物理寄存器
                rat[arch_rd_i] <= pd_o;
                // Free List栈顶减一
                free_count <= free_count - 1;
            end

            // 2. 提交：旧的物理寄存器回收
            if (commit_en_i && commit_rd_we_i && (commit_arch_rd_i != 5'd0)) begin
                // 把旧的物理寄存器放回Free List
                free_list[free_count] <= commit_pd_i;
                free_count <= free_count + 1;
            end
        end
    end

endmodule
