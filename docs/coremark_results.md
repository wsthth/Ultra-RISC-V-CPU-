# CoreMark 跑分结果（预期）

## 测试环境
- CPU：Ultra RISC-V 4发射乱序超标量
- 频率：100MHz
- 指令集：RV32IM

## 微架构参数
| 参数 | 值 |
|---|---|
| 发射宽度 | 4 |
| ROB深度 | 32 |
| RS深度 | 16 |
| 物理寄存器数 | 64 |
| BPU | Gshare 4096项 + TAGE 2048项 + RAS 16级 |
| Dcache | 64KB 256组4路 |
| Victim Cache | 16项 |

## 预期性能指标
| 指标 | 目标值 | 预期值 |
|---|---|---|
| CoreMark/MHz | ≥2.0 | 2.5 |
| IPC | ≥2.5 | 2.8 |
| BPU准确率 | ≥96.75% | 97% |
| Dcache命中率 | ≥90% | 92% |

## 跑分方法
```bash
# 编译CoreMark
riscv64-unknown-elf-gcc -O2 -march=rv32im core_list_join.c core_main.c core_matrix.c core_state.c core_util.c -o coremark.elf

# 生成hex
riscv64-unknown-elf-objcopy -O verilog coremark.elf coremark.hex

# 仿真
powershell -File scripts/run_sim.ps1 -TB tb_4w_full -HEX sw/testprog/hex/coremark.hex

# 计算得分
CoreMark/MHz = 1 / (执行时间(秒) / 频率(MHz))
```

## 当前状态
- ✅ 全部微架构模块实现完成
- ✅ 4发射核心跑通，IPC≈4（无依赖）
- ✅ BPU/Dcache/MDU全部集成
- 🚧 待跑完整Coremark测试程序出最终分数
