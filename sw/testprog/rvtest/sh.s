  test_2:      li  x3, 2
      la  x2, tdat
        li  x1, 0x00000000000000aa
        la  x15, 7f
         sh x1, 0(x2)
        lh x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 170
      bne x14, x7, fail
  test_3:      li  x3, 3
      la  x2, tdat
        li  x1, 0xffffffffffffaa00
        la  x15, 7f
         sh x1, 2(x2)
        lh x14, 2(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294945280
      bne x14, x7, fail
  test_4:      li  x3, 4
      la  x2, tdat
        li  x1, 0xffffffffbeef0aa0
        la  x15, 7f
         sh x1, 4(x2)
        lw x14, 4(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 3203336864
      bne x14, x7, fail
  test_5:      li  x3, 5
      la  x2, tdat
        li  x1, 0xffffffffffffa00a
        la  x15, 7f
         sh x1, 6(x2)
        lh x14, 6(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294942730
      bne x14, x7, fail
  test_6:      li  x3, 6
      la  x2, tdat + 14
        li  x1, 0x00000000000000aa
        la  x15, 7f
         sh x1, -6(x2)
        lh x14, -6(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 170
      bne x14, x7, fail
  test_7:      li  x3, 7
      la  x2, tdat + 14
        li  x1, 0xffffffffffffaa00
        la  x15, 7f
         sh x1, -4(x2)
        lh x14, -4(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294945280
      bne x14, x7, fail
  test_8:      li  x3, 8
      la  x2, tdat + 14
        li  x1, 0x0000000000000aa0
        la  x15, 7f
         sh x1, -2(x2)
        lh x14, -2(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 2720
      bne x14, x7, fail
  test_9:      li  x3, 9
      la  x2, tdat + 14
        li  x1, 0xffffffffffffa00a
        la  x15, 7f
         sh x1, 0(x2)
        lh x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294942730
      bne x14, x7, fail
  test_10:      li  x3, 10
      la  x1, tdat + 16
      li  x2, 0x12345678
      addi x4, x1, -32
      sh x2, 32(x4)
      lh x5, 0(x1)
      li  x7, 22136
      bne x5, x7, fail
  test_11:      li  x3, 11
      la  x1, tdat + 16
      li  x2, 0x00003098
      addi x1, x1, -5
      sh x2, 7(x1)
      la  x4, tdat + 18
      lh x5, 0(x4)
      li  x7, 12440
      bne x5, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:  li  x13, 0xffffffffffffccdd
            la  x12, tdat
            sh x13, 0(x12)
      lh x14, 0(x12)
      li  x7, 0xffffffffffffccdd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_13:      li  x3, 13
      li  x4, 0
  1:  li  x13, 0xffffffffffffbccd
            la  x12, tdat
      nop
       sh x13, 2(x12)
      lh x14, 2(x12)
      li  x7, 0xffffffffffffbccd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_14:      li  x3, 14
      li  x4, 0
  1:  li  x13, 0xffffffffffffbbcc
            la  x12, tdat
      nop
 nop
       sh x13, 4(x12)
      lh x14, 4(x12)
      li  x7, 0xffffffffffffbbcc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_15:      li  x3, 15
      li  x4, 0
  1:  li  x13, 0xffffffffffffabbc
      nop
       la  x12, tdat
            sh x13, 6(x12)
      lh x14, 6(x12)
      li  x7, 0xffffffffffffabbc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_16:      li  x3, 16
      li  x4, 0
  1:  li  x13, 0xffffffffffffaabb
      nop
       la  x12, tdat
      nop
       sh x13, 8(x12)
      lh x14, 8(x12)
      li  x7, 0xffffffffffffaabb
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_17:      li  x3, 17
      li  x4, 0
  1:  li  x13, 0xffffffffffffdaab
      nop
 nop
       la  x12, tdat
            sh x13, 10(x12)
      lh x14, 10(x12)
      li  x7, 0xffffffffffffdaab
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_18:      li  x3, 18
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x2233
            sh x1, 0(x2)
      lh x14, 0(x2)
      li  x7, 0x2233
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_19:      li  x3, 19
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x1223
      nop
       sh x1, 2(x2)
      lh x14, 2(x2)
      li  x7, 0x1223
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_20:      li  x3, 20
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x1122
      nop
 nop
       sh x1, 4(x2)
      lh x14, 4(x2)
      li  x7, 0x1122
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_21:      li  x3, 21
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x0112
            sh x1, 6(x2)
      lh x14, 6(x2)
      li  x7, 0x0112
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_22:      li  x3, 22
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x0011
      nop
       sh x1, 8(x2)
      lh x14, 8(x2)
      li  x7, 0x0011
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_23:      li  x3, 23
      li  x4, 0
  1:  la  x2, tdat
      nop
 nop
       li  x1, 0x3001
            sh x1, 10(x2)
      lh x14, 10(x2)
      li  x7, 0x3001
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  li a0, 0xbeef
  la a1, tdat
  sh a0, 6(a1)
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
tdat:
.word 0xBEEFBEEF
.word 0xBEEFBEEF
.word 0xBEEFBEEF
.word 0xBEEFBEEF
.word 0xBEEFBEEF