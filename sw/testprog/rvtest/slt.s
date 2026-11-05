  test_2:      li  x3, 2
      li  x11, 0
        li  x12, 0
        slt x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x11, 1
        li  x12, 1
        slt x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x11, 3
        li  x12, 7
        slt x14, x11, x12
      li  x7, 1
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x11, 7
        li  x12, 3
        slt x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_7:      li  x3, 7
      li  x11, 2147483648
        li  x12, 0
        slt x14, x11, x12
      li  x7, 1
      bne x14, x7, fail
  test_10:      li  x3, 10
      li  x11, 2147483647
        li  x12, 0
        slt x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_15:      li  x3, 15
      li  x11, 4294967295
        li  x12, 1
        slt x14, x11, x12
      li  x7, 1
      bne x14, x7, fail
  test_17:      li  x3, 17
      li  x11, 14
        li  x12, 13
        slt x11, x11, x12
      li  x7, 0
      bne x11, x7, fail
  test_18:      li  x3, 18
      li  x11, 11
        li  x12, 13
        slt x12, x11, x12
      li  x7, 1
      bne x12, x7, fail
  test_19:      li  x3, 19
      li  x11, 13
        slt x11, x11, x11
      li  x7, 0
      bne x11, x7, fail
  test_20:      li  x3, 20
      li  x4, 0
  1:    li  x1, 11
        li  x2, 13
        slt x14, x1, x2
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x6, x7, fail
  test_21:      li  x3, 21
      li  x4, 0
  1:    li  x1, 14
        li  x2, 13
        slt x14, x1, x2
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x6, x7, fail
  test_22:      li  x3, 22
      li  x4, 0
  1:    li  x1, 12
        li  x2, 13
        slt x14, x1, x2
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x6, x7, fail
  test_23:      li  x3, 23
      li  x4, 0
  1:    li  x1, 14
                li  x2, 13
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_24:      li  x3, 24
      li  x4, 0
  1:    li  x1, 11
                li  x2, 13
        nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_25:      li  x3, 25
      li  x4, 0
  1:    li  x1, 15
                li  x2, 13
        nop
 nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_26:      li  x3, 26
      li  x4, 0
  1:    li  x1, 10
        nop
         li  x2, 13
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_27:      li  x3, 27
      li  x4, 0
  1:    li  x1, 16
        nop
         li  x2, 13
        nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_28:      li  x3, 28
      li  x4, 0
  1:    li  x1, 9
        nop
 nop
         li  x2, 13
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_29:      li  x3, 29
      li  x4, 0
  1:    li  x2, 13
                li  x1, 17
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_30:      li  x3, 30
      li  x4, 0
  1:    li  x2, 13
                li  x1, 8
        nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_31:      li  x3, 31
      li  x4, 0
  1:    li  x2, 13
                li  x1, 18
        nop
 nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_32:      li  x3, 32
      li  x4, 0
  1:    li  x2, 13
        nop
         li  x1, 7
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_33:      li  x3, 33
      li  x4, 0
  1:    li  x2, 13
        nop
         li  x1, 19
        nop
         slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 0
      bne x14, x7, fail
  test_34:      li  x3, 34
      li  x4, 0
  1:    li  x2, 13
        nop
 nop
         li  x1, 6
                slt x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 1
      bne x14, x7, fail
  test_35:      li  x3, 35
      li x1, 4294967295
        slt x2, x0, x1
      li  x7, 0
      bne x2, x7, fail
  test_36:      li  x3, 36
      li x1, 4294967295
        slt x2, x1, x0
      li  x7, 1
      bne x2, x7, fail
  test_37:      li  x3, 37
      slt x1, x0, x0
      li  x7, 0
      bne x1, x7, fail
  test_38:      li  x3, 38
      li x1, 16
        li x2, 30
        slt x0, x1, x2
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end