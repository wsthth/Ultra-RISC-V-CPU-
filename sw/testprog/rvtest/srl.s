  test_2:      li  x3, 2
      li  x11, 2147483648
        li  x12, 0
        srl x14, x11, x12
      li  x7, 2147483648
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x11, 2147483648
        li  x12, 1
        srl x14, x11, x12
      li  x7, 1073741824
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x11, 2147483648
        li  x12, 7
        srl x14, x11, x12
      li  x7, 16777216
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x11, 2147483648
        li  x12, 14
        srl x14, x11, x12
      li  x7, 131072
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x11, 2147483649
        li  x12, 31
        srl x14, x11, x12
      li  x7, 1
      bne x14, x7, fail
  test_7:      li  x3, 7
      li  x11, 4294967295
        li  x12, 0
        srl x14, x11, x12
      li  x7, 4294967295
      bne x14, x7, fail
  test_8:      li  x3, 8
      li  x11, 4294967295
        li  x12, 1
        srl x14, x11, x12
      li  x7, 2147483647
      bne x14, x7, fail
  test_9:      li  x3, 9
      li  x11, 4294967295
        li  x12, 7
        srl x14, x11, x12
      li  x7, 33554431
      bne x14, x7, fail
  test_10:      li  x3, 10
      li  x11, 4294967295
        li  x12, 14
        srl x14, x11, x12
      li  x7, 262143
      bne x14, x7, fail
  test_11:      li  x3, 11
      li  x11, 4294967295
        li  x12, 31
        srl x14, x11, x12
      li  x7, 1
      bne x14, x7, fail
  test_12:      li  x3, 12
      li  x11, 555819297
        li  x12, 0
        srl x14, x11, x12
      li  x7, 555819297
      bne x14, x7, fail
  test_13:      li  x3, 13
      li  x11, 555819297
        li  x12, 1
        srl x14, x11, x12
      li  x7, 277909648
      bne x14, x7, fail
  test_14:      li  x3, 14
      li  x11, 555819297
        li  x12, 7
        srl x14, x11, x12
      li  x7, 4342338
      bne x14, x7, fail
  test_15:      li  x3, 15
      li  x11, 555819297
        li  x12, 14
        srl x14, x11, x12
      li  x7, 33924
      bne x14, x7, fail
  test_16:      li  x3, 16
      li  x11, 555819297
        li  x12, 31
        srl x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_22:      li  x3, 22
      li  x11, 2147483648
        li  x12, 7
        srl x11, x11, x12
      li  x7, 16777216
      bne x11, x7, fail
  test_23:      li  x3, 23
      li  x11, 2147483648
        li  x12, 14
        srl x12, x11, x12
      li  x7, 131072
      bne x12, x7, fail
  test_24:      li  x3, 24
      li  x11, 7
        srl x11, x11, x11
      li  x7, 0
      bne x11, x7, fail
  test_25:      li  x3, 25
      li  x4, 0
  1:    li  x1, 2147483648
        li  x2, 7
        srl x14, x1, x2
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16777216
      bne x6, x7, fail
  test_26:      li  x3, 26
      li  x4, 0
  1:    li  x1, 2147483648
        li  x2, 14
        srl x14, x1, x2
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 131072
      bne x6, x7, fail
  test_27:      li  x3, 27
      li  x4, 0
  1:    li  x1, 2147483648
        li  x2, 31
        srl x14, x1, x2
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x6, x7, fail
  test_28:      li  x3, 28
      li  x4, 0
  1:    li  x1, 2147483648
                li  x2, 7
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16777216
      bne x14, x7, fail
  test_29:      li  x3, 29
      li  x4, 0
  1:    li  x1, 2147483648
                li  x2, 14
        nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 131072
      bne x14, x7, fail
  test_30:      li  x3, 30
      li  x4, 0
  1:    li  x1, 2147483648
                li  x2, 31
        nop
 nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_31:      li  x3, 31
      li  x4, 0
  1:    li  x1, 2147483648
        nop
         li  x2, 7
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16777216
      bne x14, x7, fail
  test_32:      li  x3, 32
      li  x4, 0
  1:    li  x1, 2147483648
        nop
         li  x2, 14
        nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 131072
      bne x14, x7, fail
  test_33:      li  x3, 33
      li  x4, 0
  1:    li  x1, 2147483648
        nop
 nop
         li  x2, 31
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_34:      li  x3, 34
      li  x4, 0
  1:    li  x2, 7
                li  x1, 2147483648
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16777216
      bne x14, x7, fail
  test_35:      li  x3, 35
      li  x4, 0
  1:    li  x2, 14
                li  x1, 2147483648
        nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 131072
      bne x14, x7, fail
  test_36:      li  x3, 36
      li  x4, 0
  1:    li  x2, 31
                li  x1, 2147483648
        nop
 nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_37:      li  x3, 37
      li  x4, 0
  1:    li  x2, 7
        nop
         li  x1, 2147483648
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16777216
      bne x14, x7, fail
  test_38:      li  x3, 38
      li  x4, 0
  1:    li  x2, 14
        nop
         li  x1, 2147483648
        nop
         srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 131072
      bne x14, x7, fail
  test_39:      li  x3, 39
      li  x4, 0
  1:    li  x2, 31
        nop
 nop
         li  x1, 2147483648
                srl x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_40:      li  x3, 40
      li x1, 15
        srl x2, x0, x1
      li  x7, 0
      bne x2, x7, fail
  test_41:      li  x3, 41
      li x1, 32
        srl x2, x1, x0
      li  x7, 32
      bne x2, x7, fail
  test_42:      li  x3, 42
      srl x1, x0, x0
      li  x7, 0
      bne x1, x7, fail
  test_43:      li  x3, 43
      li x1, 1024
        li x2, 2048
        srl x0, x1, x2
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end