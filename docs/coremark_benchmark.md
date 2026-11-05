# CoreMark 跑分说明

## 测试环境
- 仿真器：Vivado 2019.1 xsim
- CPU：Ultra RISC-V 4发射乱序超标量
- 目标频率：100MHz+

## 跑分步骤

1. **编译CoreMark**
   使用RISC-V GCC工具链编译coremark：
   ```bash
   riscv64-unknown-elf-gcc -O2 -march=rv32im -mabi=ilp32 \
       core_list_join.c core_main.c core_matrix.c core_state.c core_util.c \
       -o coremark.elf
   ```

2. **生成hex文件**
   ```bash
   riscv64-unknown-elf-objcopy -O verilog coremark.elf coremark.hex
   ```

3. **加载到仿真**
   ```powershell
   powershell -File scripts\run_sim.ps1 -TB tb_rvtest -HEX sw\testprog\hex\coremark.hex
   ```

4. **计算得分**
   ```
   CoreMark/MHz = 1 / (运行时间(秒) / 频率(MHz))
   ```

## 预期性能目标

| 指标 | 目标值 |
|---|---|
| CoreMark/MHz | 2.0+（4发射乱序） |
| IPC | 2.5+ |
| 预测准确率 | 96.75% |

## 当前状态

- ✅ CoreMark源码已集成在 sw/bench/coremark/
- ✅ 测试hex已生成：sw/testprog/hex/coremark.hex
- 🚧 待全指令仿真验证后即可正式跑分
