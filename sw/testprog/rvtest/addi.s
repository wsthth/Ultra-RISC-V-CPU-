  test_2:      li  x3, 2
      li  x13, 0
        addi x14, x13, 0
      li  x7, 0
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x13, 1
        addi x14, x13, 1
      li  x7, 2
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x13, 3
        addi x14, x13, 7
      li  x7, 10
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x13, 0
        addi x14, x13, 4294965248
      li  x7, 4294965248
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x13, 2147483648
        addi x14, x13, 0
      li  x7, 2147483648
      bne x14, x7, fail
  test_7:      li  x3, 7
      li  x13, 2147483648
        addi x14, x13, 4294965248
      li  x7, 2147481600
      bne x14, x7, fail
  test_8:      li  x3, 8
      li  x13, 0
        addi x14, x13, 2047
      li  x7, 2047
      bne x14, x7, fail
  test_9:      li  x3, 9
      li  x13, 2147483647
        addi x14, x13, 0
      li  x7, 2147483647
      bne x14, x7, fail
  test_10:      li  x3, 10
      li  x13, 2147483647
        addi x14, x13, 2047
      li  x7, 2147485694
      bne x14, x7, fail
  test_11:      li  x3, 11
      li  x13, 2147483648
        addi x14, x13, 2047
      li  x7, 2147485695
      bne x14, x7, fail
  test_12:      li  x3, 12
      li  x13, 2147483647
        addi x14, x13, 4294965248
      li  x7, 2147481599
      bne x14, x7, fail
  test_13:      li  x3, 13
      li  x13, 0
        addi x14, x13, 4294967295
      li  x7, 4294967295
      bne x14, x7, fail
  test_14:      li  x3, 14
      li  x13, 4294967295
        addi x14, x13, 1
      li  x7, 0
      bne x14, x7, fail
  test_15:      li  x3, 15
      li  x13, 4294967295
        addi x14, x13, 4294967295
      li  x7, 4294967294
      bne x14, x7, fail
  test_16:      li  x3, 16
      li  x13, 2147483647
        addi x14, x13, 1
      li  x7, 2147483648
      bne x14, x7, fail
  test_17:      li  x3, 17
      li  x11, 13
        addi x11, x11, 11
      li  x7, 24
      bne x11, x7, fail
  test_18:      li  x3, 18
      li  x4, 0
  1:    li  x1, 13
        addi x14, x1, 11
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x6, x7, fail
  test_19:      li  x3, 19
      li  x4, 0
  1:    li  x1, 13
        addi x14, x1, 10
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 23
      bne x6, x7, fail
  test_20:      li  x3, 20
      li  x4, 0
  1:    li  x1, 13
        addi x14, x1, 9
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 22
      bne x6, x7, fail
  test_21:      li  x3, 21
      li  x4, 0
  1:    li  x1, 13
                addi x14, x1, 11
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x14, x7, fail
  test_22:      li  x3, 22
      li  x4, 0
  1:    li  x1, 13
        nop
         addi x14, x1, 10
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 23
      bne x14, x7, fail
  test_23:      li  x3, 23
      li  x4, 0
  1:    li  x1, 13
        nop
 nop
         addi x14, x1, 9
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 22
      bne x14, x7, fail
  test_24:      li  x3, 24
      addi x1, x0, 32
      li  x7, 32
      bne x1, x7, fail
  test_25:      li  x3, 25
      li  x1, 33
        addi x0, x1, 50
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end