# Ultra RISC-V CPU

基于RISC-V RV32IM指令集的**四发射乱序超标量处理器**实现。

本项目参考第九届全国大学生集成电路创新创业大赛获奖作品「Ultra RISC-V」（南京大学集成电路学院 二二幺九团队）的微架构设计，从零开始在Verilog上完整复现并扩展实现。

---

## 🎯 目标微架构

| 特性 | 目标规格 |
|---|---|
| 指令集 | RV32IM（整数 + 乘除法） |
| 发射宽度 | 4发射（Quad-issue） |
| 执行模型 | 乱序执行（Out-of-Order） |
| 调度算法 | 改进式 Tomasulo |
| 流水线深度 | 12级多级缓冲流水线 |
| 分支预测 | Gshare + TAGE 两级混合预测器 + BTB + RAS |
| 预测准确率目标 | ≥ 96.75% |
| Dcache | 64KB，256组4路组相联，PLRU替换，Write-Back |
| Victim Cache | 16组 |
| 存储并行 | 访存读写并行，Multi-bank |
| 精确中断 | 支持 |
| 验证栈 | Verilator + DIFFTEST + CoreMark + RT-Thread |

---

## 📂 目录结构

```
Ultra RISC-V/
├── rtl/                # 设计源代码
│   ├── core/           # 顶层与流水线控制
│   ├── decode/         # 取指与译码
│   ├── bpu/            # 分支预测单元
│   ├── exec/           # ALU/MDU/旁路网络
│   ├── lsu/            # 加载存储单元
│   ├── cache/          # Dcache + Victim Cache
│   └── commit/         # 提交与异常处理
├── tb/                 # Testbench
├── sim/                # 仿真工作目录与波形
├── sw/                 # 测试程序（汇编/C）
├── docs/               # 设计文档
├── scripts/            # 仿真/综合脚本
└── README.md
```

---

## 🚀 当前实现状态

> 状态标记：✅ 已完成 | 🚧 开发中 | ⬜ 计划中

- [ ] **阶段1：基础流水线** ⬜
  - [x] 项目骨架搭建
  - [ ] RV32I 译码器
  - [ ] 通用寄存器堆（32×32bit）
  - [ ] 整数ALU（ADD/SUB/逻辑/移位/比较）
  - [ ] 基础5级流水线原型
  - [ ] 指令测试通过

- [ ] **阶段2：分支预测器** ⬜
  - [ ] BTB（分支目标缓冲）
  - [ ] RAS（返回地址栈）
  - [ ] Gshare 预测器
  - [ ] TAGE 预测器
  - [ ] 混合选择逻辑

- [ ] **阶段3：Tomasulo 乱序核心** ⬜
  - [ ] 寄存器重命名（RAT + FL + PRF）
  - [ ] 保留站（Reservation Station）
  - [ ] ROB（重排序缓冲）
  - [ ] 旁路网络（Forwarding Network）
  - [ ] 背靠背唤醒（Back-to-back Wakeup）
  - [ ] 4发射调度

- [ ] **阶段4：存储子系统** ⬜
  - [ ] Dcache（256×4路，64KB）
  - [ ] PLRU 替换策略
  - [ ] Victim Cache（16组）
  - [ ] Multi-bank 并行
  - [ ] AXI4 总线接口
  - [ ] LSU 乱序加载/存储

- [ ] **阶段5：高级特性** ⬜
  - [ ] 流水线乘除法 MDU
  - [ ] 精确异常/中断
  - [ ] DIFFTEST 对接
  - [ ] CoreMark 跑分
  - [ ] RT-Thread 移植

---

## 🔧 仿真环境

- **EDA工具：** Xilinx Vivado 2019.1
- **仿真器：** Vivado Simulator (xsim) / 后续接入 Verilator
- **目标板：** Zynq-7020 / 通用 xc7k325t（时序收敛目标 100MHz+）

运行仿真：
```powershell
cd "D:\my_project\Ultra RISC-V"
# 具体脚本待阶段1完成后提供
```

---

## 📝 开发记录

详细开发日志见：[`工作记录.md`](./工作记录.md)

---

## 📜 许可证

本项目仅供学习研究使用。
