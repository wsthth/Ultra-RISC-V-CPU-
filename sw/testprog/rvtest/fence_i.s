li a3, 111
lh a0, insn
lh a1, insn+2
sh a0, 2f, t0
sh a1, 2f+2, t0
fence.i
la a5, 2f
jalr t1, a5, 0
test_2:      li  x3, 2
      nop
      li  x7, 444
      bne a3, x7, fail
li a4, 100
1: addi a4, a4, -1
bnez a4, 1b
sh a0, 3f, t0
sh a1, 3f+2, t0
fence.i
la a5, 3f
jalr t1, a5, 0
test_3:      li  x3, 3
      nop
      li  x7, 777
      bne a3, x7, fail
bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
insn:
  addi a3, a3, 333
2: addi a3, a3, 222
jalr a5, t1, 0
3: addi a3, a3, 555
jalr a5, t1, 0