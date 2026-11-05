  test_2:      li  x3, 2
      li  x13, 1
        slli x14, x13, 0
      li  x7, 1
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x13, 1
        slli x14, x13, 1
      li  x7, 2
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x13, 1
        slli x14, x13, 7
      li  x7, 128
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x13, 1
        slli x14, x13, 14
      li  x7, 16384
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x13, 1
        slli x14, x13, 31
      li  x7, 2147483648
      bne x14, x7, fail
  test_7:      li  x3, 7
      li  x13, 4294967295
        slli x14, x13, 0
      li  x7, 4294967295
      bne x14, x7, fail
  test_8:      li  x3, 8
      li  x13, 4294967295
        slli x14, x13, 1
      li  x7, 4294967294
      bne x14, x7, fail
  test_9:      li  x3, 9
      li  x13, 4294967295
        slli x14, x13, 7
      li  x7, 4294967168
      bne x14, x7, fail
  test_10:      li  x3, 10
      li  x13, 4294967295
        slli x14, x13, 14
      li  x7, 4294950912
      bne x14, x7, fail
  test_11:      li  x3, 11
      li  x13, 4294967295
        slli x14, x13, 31
      li  x7, 2147483648
      bne x14, x7, fail
  test_12:      li  x3, 12
      li  x13, 555819297
        slli x14, x13, 0
      li  x7, 555819297
      bne x14, x7, fail
  test_13:      li  x3, 13
      li  x13, 555819297
        slli x14, x13, 1
      li  x7, 1111638594
      bne x14, x7, fail
  test_14:      li  x3, 14
      li  x13, 555819297
        slli x14, x13, 7
      li  x7, 2425393280
      bne x14, x7, fail
  test_15:      li  x3, 15
      li  x13, 555819297
        slli x14, x13, 14
      li  x7, 1212694528
      bne x14, x7, fail
  test_16:      li  x3, 16
      li  x13, 555819297
        slli x14, x13, 31
      li  x7, 2147483648
      bne x14, x7, fail
  test_17:      li  x3, 17
      li  x11, 1
        slli x11, x11, 7
      li  x7, 128
      bne x11, x7, fail
  test_18:      li  x3, 18
      li  x4, 0
  1:    li  x1, 1
        slli x14, x1, 7
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 128
      bne x6, x7, fail
  test_19:      li  x3, 19
      li  x4, 0
  1:    li  x1, 1
        slli x14, x1, 14
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16384
      bne x6, x7, fail
  test_20:      li  x3, 20
      li  x4, 0
  1:    li  x1, 1
        slli x14, x1, 31
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 2147483648
      bne x6, x7, fail
  test_21:      li  x3, 21
      li  x4, 0
  1:    li  x1, 1
                slli x14, x1, 7
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 128
      bne x14, x7, fail
  test_22:      li  x3, 22
      li  x4, 0
  1:    li  x1, 1
        nop
         slli x14, x1, 14
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16384
      bne x14, x7, fail
  test_23:      li  x3, 23
      li  x4, 0
  1:    li  x1, 1
        nop
 nop
         slli x14, x1, 31
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 2147483648
      bne x14, x7, fail
  test_24:      li  x3, 24
      slli x1, x0, 31
      li  x7, 0
      bne x1, x7, fail
  test_25:      li  x3, 25
      li  x1, 33
        slli x0, x1, 20
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end