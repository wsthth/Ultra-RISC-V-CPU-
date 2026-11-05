  test_2:      li  x3, 2
      li  x15, 0x00000000000000ff
         la  x2, tdat
        lbu x14, 0(x2)
      li  x7, 255
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x15, 0x0000000000000000
         la  x2, tdat
        lbu x14, 1(x2)
      li  x7, 0
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x15, 0x00000000000000f0
         la  x2, tdat
        lbu x14, 2(x2)
      li  x7, 240
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x15, 0x000000000000000f
         la  x2, tdat
        lbu x14, 3(x2)
      li  x7, 15
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x15, 0x00000000000000ff
         la  x2, tdat + 3
        lbu x14, -3(x2)
      li  x7, 255
      bne x14, x7, fail
  test_7:      li  x3, 7
      li  x15, 0x0000000000000000
         la  x2, tdat + 3
        lbu x14, -2(x2)
      li  x7, 0
      bne x14, x7, fail
  test_8:      li  x3, 8
      li  x15, 0x00000000000000f0
         la  x2, tdat + 3
        lbu x14, -1(x2)
      li  x7, 240
      bne x14, x7, fail
  test_9:      li  x3, 9
      li  x15, 0x000000000000000f
         la  x2, tdat + 3
        lbu x14, 0(x2)
      li  x7, 15
      bne x14, x7, fail
  test_10:      li  x3, 10
      la  x1, tdat
      addi x1, x1, -32
      lbu x5, 32(x1)
      li  x7, 255
      bne x5, x7, fail
  test_11:      li  x3, 11
      la  x1, tdat
      addi x1, x1, -6
      lbu x5, 7(x1)
      li  x7, 0
      bne x5, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:  la  x13, tdat + 1
      lbu x14, 1(x13)
            addi  x6, x14, 0
      li  x7, 0x00000000000000f0
      bne x6, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_13:      li  x3, 13
      li  x4, 0
  1:  la  x13, tdat + 2
      lbu x14, 1(x13)
      nop
       addi  x6, x14, 0
      li  x7, 0x000000000000000f
      bne x6, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_14:      li  x3, 14
      li  x4, 0
  1:  la  x13, tdat
      lbu x14, 1(x13)
      nop
 nop
       addi  x6, x14, 0
      li  x7, 0x0000000000000000
      bne x6, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_15:      li  x3, 15
      li  x4, 0
  1:  la  x13, tdat + 1
            lbu x14, 1(x13)
      li  x7, 0x00000000000000f0
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_16:      li  x3, 16
      li  x4, 0
  1:  la  x13, tdat + 2
      nop
       lbu x14, 1(x13)
      li  x7, 0x000000000000000f
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_17:      li  x3, 17
      li  x4, 0
  1:  la  x13, tdat
      nop
 nop
       lbu x14, 1(x13)
      li  x7, 0x0000000000000000
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_18:      li  x3, 18
      la  x5, tdat
      lbu  x2, 0(x5)
      li  x2, 2
      li  x7, 2
      bne x2, x7, fail
  test_19:      li  x3, 19
      la  x5, tdat
      lbu  x2, 0(x5)
      nop
      li  x2, 2
      li  x7, 2
      bne x2, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
tdat:
.word 0x0FF000FF