  test_2:      li  x3, 2
      la  x2, tdat
        li  x1, 0x0000000000aa00aa
        la  x15, 7f
         sw x1, 0(x2)
        lw x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 11141290
      bne x14, x7, fail
  test_3:      li  x3, 3
      la  x2, tdat
        li  x1, 0xffffffffaa00aa00
        la  x15, 7f
         sw x1, 4(x2)
        lw x14, 4(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 2852170240
      bne x14, x7, fail
  test_4:      li  x3, 4
      la  x2, tdat
        li  x1, 0x000000000aa00aa0
        la  x15, 7f
         sw x1, 8(x2)
        lw x14, 8(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 178260640
      bne x14, x7, fail
  test_5:      li  x3, 5
      la  x2, tdat
        li  x1, 0xffffffffa00aa00a
        la  x15, 7f
         sw x1, 12(x2)
        lw x14, 12(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 2685050890
      bne x14, x7, fail
  test_6:      li  x3, 6
      la  x2, tdat8
        li  x1, 0x0000000000aa00aa
        la  x15, 7f
         sw x1, -12(x2)
        lw x14, -12(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 11141290
      bne x14, x7, fail
  test_7:      li  x3, 7
      la  x2, tdat8
        li  x1, 0xffffffffaa00aa00
        la  x15, 7f
         sw x1, -8(x2)
        lw x14, -8(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 2852170240
      bne x14, x7, fail
  test_8:      li  x3, 8
      la  x2, tdat8
        li  x1, 0x000000000aa00aa0
        la  x15, 7f
         sw x1, -4(x2)
        lw x14, -4(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 178260640
      bne x14, x7, fail
  test_9:      li  x3, 9
      la  x2, tdat8
        li  x1, 0xffffffffa00aa00a
        la  x15, 7f
         sw x1, 0(x2)
        lw x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 2685050890
      bne x14, x7, fail
  test_10:      li  x3, 10
      la  x1, tdat9
      li  x2, 0x12345678
      addi x4, x1, -32
      sw x2, 32(x4)
      lw x5, 0(x1)
      li  x7, 305419896
      bne x5, x7, fail
  test_11:      li  x3, 11
      la  x1, tdat9
      li  x2, 0x58213098
      addi x1, x1, -3
      sw x2, 7(x1)
      la  x4, tdat10
      lw x5, 0(x4)
      li  x7, 1478570136
      bne x5, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:  li  x13, 0xffffffffaabbccdd
            la  x12, tdat
            sw x13, 0(x12)
      lw x14, 0(x12)
      li  x7, 0xffffffffaabbccdd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_13:      li  x3, 13
      li  x4, 0
  1:  li  x13, 0xffffffffdaabbccd
            la  x12, tdat
      nop
       sw x13, 4(x12)
      lw x14, 4(x12)
      li  x7, 0xffffffffdaabbccd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_14:      li  x3, 14
      li  x4, 0
  1:  li  x13, 0xffffffffddaabbcc
            la  x12, tdat
      nop
 nop
       sw x13, 8(x12)
      lw x14, 8(x12)
      li  x7, 0xffffffffddaabbcc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_15:      li  x3, 15
      li  x4, 0
  1:  li  x13, 0xffffffffcddaabbc
      nop
       la  x12, tdat
            sw x13, 12(x12)
      lw x14, 12(x12)
      li  x7, 0xffffffffcddaabbc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_16:      li  x3, 16
      li  x4, 0
  1:  li  x13, 0xffffffffccddaabb
      nop
       la  x12, tdat
      nop
       sw x13, 16(x12)
      lw x14, 16(x12)
      li  x7, 0xffffffffccddaabb
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_17:      li  x3, 17
      li  x4, 0
  1:  li  x13, 0xffffffffbccddaab
      nop
 nop
       la  x12, tdat
            sw x13, 20(x12)
      lw x14, 20(x12)
      li  x7, 0xffffffffbccddaab
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_18:      li  x3, 18
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x00112233
            sw x1, 0(x2)
      lw x14, 0(x2)
      li  x7, 0x00112233
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_19:      li  x3, 19
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x30011223
      nop
       sw x1, 4(x2)
      lw x14, 4(x2)
      li  x7, 0x30011223
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_20:      li  x3, 20
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x33001122
      nop
 nop
       sw x1, 8(x2)
      lw x14, 8(x2)
      li  x7, 0x33001122
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_21:      li  x3, 21
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x23300112
            sw x1, 12(x2)
      lw x14, 12(x2)
      li  x7, 0x23300112
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_22:      li  x3, 22
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x22330011
      nop
       sw x1, 16(x2)
      lw x14, 16(x2)
      li  x7, 0x22330011
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_23:      li  x3, 23
      li  x4, 0
  1:  la  x2, tdat
      nop
 nop
       li  x1, 0x12233001
            sw x1, 20(x2)
      lw x14, 20(x2)
      li  x7, 0x12233001
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
tdat:
tdat1:  .word 0xdeadbeef
tdat2:  .word 0xdeadbeef
tdat3:  .word 0xdeadbeef
tdat4:  .word 0xdeadbeef
tdat5:  .word 0xdeadbeef
tdat6:  .word 0xdeadbeef
tdat7:  .word 0xdeadbeef
tdat8:  .word 0xdeadbeef
tdat9:  .word 0xdeadbeef
tdat10: .word 0xdeadbeef