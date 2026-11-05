  test_2:      li  x3, 2
      la  x2, tdat
        li  x1, 0xffffffffffffffaa
        la  x15, 7f
         sb x1, 0(x2)
        lb x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294967210
      bne x14, x7, fail
  test_3:      li  x3, 3
      la  x2, tdat
        li  x1, 0x0000000000000000
        la  x15, 7f
         sb x1, 1(x2)
        lb x14, 1(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 0
      bne x14, x7, fail
  test_4:      li  x3, 4
      la  x2, tdat
        li  x1, 0xffffffffffffefa0
        la  x15, 7f
         sb x1, 2(x2)
        lh x14, 2(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294963104
      bne x14, x7, fail
  test_5:      li  x3, 5
      la  x2, tdat
        li  x1, 0x000000000000000a
        la  x15, 7f
         sb x1, 3(x2)
        lb x14, 3(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 10
      bne x14, x7, fail
  test_6:      li  x3, 6
      la  x2, tdat + 7
        li  x1, 0xffffffffffffffaa
        la  x15, 7f
         sb x1, -3(x2)
        lb x14, -3(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294967210
      bne x14, x7, fail
  test_7:      li  x3, 7
      la  x2, tdat + 7
        li  x1, 0x0000000000000000
        la  x15, 7f
         sb x1, -2(x2)
        lb x14, -2(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 0
      bne x14, x7, fail
  test_8:      li  x3, 8
      la  x2, tdat + 7
        li  x1, 0xffffffffffffffa0
        la  x15, 7f
         sb x1, -1(x2)
        lb x14, -1(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 4294967200
      bne x14, x7, fail
  test_9:      li  x3, 9
      la  x2, tdat + 7
        li  x1, 0x000000000000000a
        la  x15, 7f
         sb x1, 0(x2)
        lb x14, 0(x2)
        j 8f
  7:                   mv x14, x1
  8:
      li  x7, 10
      bne x14, x7, fail
  test_10:      li  x3, 10
      la  x1, tdat + 8
      li  x2, 0x12345678
      addi x4, x1, -32
      sb x2, 32(x4)
      lb x5, 0(x1)
      li  x7, 120
      bne x5, x7, fail
  test_11:      li  x3, 11
      la  x1, tdat + 8
      li  x2, 0x00003098
      addi x1, x1, -6
      sb x2, 7(x1)
      la  x4, tdat + 9
      lb x5, 0(x4)
      li  x7, 4294967192
      bne x5, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:  li  x13, 0xffffffffffffffdd
            la  x12, tdat
            sb x13, 0(x12)
      lb x14, 0(x12)
      li  x7, 0xffffffffffffffdd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_13:      li  x3, 13
      li  x4, 0
  1:  li  x13, 0xffffffffffffffcd
            la  x12, tdat
      nop
       sb x13, 1(x12)
      lb x14, 1(x12)
      li  x7, 0xffffffffffffffcd
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_14:      li  x3, 14
      li  x4, 0
  1:  li  x13, 0xffffffffffffffcc
            la  x12, tdat
      nop
 nop
       sb x13, 2(x12)
      lb x14, 2(x12)
      li  x7, 0xffffffffffffffcc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_15:      li  x3, 15
      li  x4, 0
  1:  li  x13, 0xffffffffffffffbc
      nop
       la  x12, tdat
            sb x13, 3(x12)
      lb x14, 3(x12)
      li  x7, 0xffffffffffffffbc
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_16:      li  x3, 16
      li  x4, 0
  1:  li  x13, 0xffffffffffffffbb
      nop
       la  x12, tdat
      nop
       sb x13, 4(x12)
      lb x14, 4(x12)
      li  x7, 0xffffffffffffffbb
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_17:      li  x3, 17
      li  x4, 0
  1:  li  x13, 0xffffffffffffffab
      nop
 nop
       la  x12, tdat
            sb x13, 5(x12)
      lb x14, 5(x12)
      li  x7, 0xffffffffffffffab
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_18:      li  x3, 18
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x33
            sb x1, 0(x2)
      lb x14, 0(x2)
      li  x7, 0x33
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_19:      li  x3, 19
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x23
      nop
       sb x1, 1(x2)
      lb x14, 1(x2)
      li  x7, 0x23
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_20:      li  x3, 20
      li  x4, 0
  1:  la  x2, tdat
            li  x1, 0x22
      nop
 nop
       sb x1, 2(x2)
      lb x14, 2(x2)
      li  x7, 0x22
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_21:      li  x3, 21
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x12
            sb x1, 3(x2)
      lb x14, 3(x2)
      li  x7, 0x12
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_22:      li  x3, 22
      li  x4, 0
  1:  la  x2, tdat
      nop
       li  x1, 0x11
      nop
       sb x1, 4(x2)
      lb x14, 4(x2)
      li  x7, 0x11
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_23:      li  x3, 23
      li  x4, 0
  1:  la  x2, tdat
      nop
 nop
       li  x1, 0x01
            sb x1, 5(x2)
      lb x14, 5(x2)
      li  x7, 0x01
      bne x14, x7, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  li a0, 0xef
  la a1, tdat
  sb a0, 3(a1)
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
tdat:
.word 0xEFEFEFEF
.word 0xEFEFEFEF
.word 0x0000EFEF