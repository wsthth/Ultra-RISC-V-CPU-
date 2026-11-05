  test_2:      li  x3, 2
      li  x11, 0
        li  x12, 0
        add x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x11, 1
        li  x12, 1
        add x14, x11, x12
      li  x7, 2
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x11, 3
        li  x12, 7
        add x14, x11, x12
      li  x7, 10
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x11, 2147483648
        li  x12, 0
        add x14, x11, x12
      li  x7, 2147483648
      bne x14, x7, fail
  test_9:      li  x3, 9
      li  x11, 2147483647
        li  x12, 0
        add x14, x11, x12
      li  x7, 2147483647
      bne x14, x7, fail
  test_14:      li  x3, 14
      li  x11, 4294967295
        li  x12, 1
        add x14, x11, x12
      li  x7, 0
      bne x14, x7, fail
  test_17:      li  x3, 17
      li  x11, 13
        li  x12, 11
        add x11, x11, x12
      li  x7, 24
      bne x11, x7, fail
  test_18:      li  x3, 18
      li  x11, 14
        li  x12, 11
        add x12, x11, x12
      li  x7, 25
      bne x12, x7, fail
  test_19:      li  x3, 19
      li  x11, 13
        add x11, x11, x11
      li  x7, 26
      bne x11, x7, fail
  test_20:      li  x3, 20
      li  x4, 0
  1:    li  x1, 13
        li  x2, 11
        add x14, x1, x2
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x6, x7, fail
  test_21:      li  x3, 21
      li  x4, 0
  1:    li  x1, 14
        li  x2, 11
        add x14, x1, x2
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 25
      bne x6, x7, fail
  test_22:      li  x3, 22
      li  x4, 0
  1:    li  x1, 15
        li  x2, 11
        add x14, x1, x2
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 26
      bne x6, x7, fail
  test_23:      li  x3, 23
      li  x4, 0
  1:    li  x1, 13
                li  x2, 11
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x14, x7, fail
  test_24:      li  x3, 24
      li  x4, 0
  1:    li  x1, 14
                li  x2, 11
        nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 25
      bne x14, x7, fail
  test_25:      li  x3, 25
      li  x4, 0
  1:    li  x1, 15
                li  x2, 11
        nop
 nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 26
      bne x14, x7, fail
  test_26:      li  x3, 26
      li  x4, 0
  1:    li  x1, 13
        nop
         li  x2, 11
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x14, x7, fail
  test_27:      li  x3, 27
      li  x4, 0
  1:    li  x1, 14
        nop
         li  x2, 11
        nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 25
      bne x14, x7, fail
  test_28:      li  x3, 28
      li  x4, 0
  1:    li  x1, 15
        nop
 nop
         li  x2, 11
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 26
      bne x14, x7, fail
  test_29:      li  x3, 29
      li  x4, 0
  1:    li  x2, 11
                li  x1, 13
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x14, x7, fail
  test_30:      li  x3, 30
      li  x4, 0
  1:    li  x2, 11
                li  x1, 14
        nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 25
      bne x14, x7, fail
  test_31:      li  x3, 31
      li  x4, 0
  1:    li  x2, 11
                li  x1, 15
        nop
 nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 26
      bne x14, x7, fail
  test_32:      li  x3, 32
      li  x4, 0
  1:    li  x2, 11
        nop
         li  x1, 13
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 24
      bne x14, x7, fail
  test_33:      li  x3, 33
      li  x4, 0
  1:    li  x2, 11
        nop
         li  x1, 14
        nop
         add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 25
      bne x14, x7, fail
  test_34:      li  x3, 34
      li  x4, 0
  1:    li  x2, 11
        nop
 nop
         li  x1, 15
                add x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 26
      bne x14, x7, fail
  test_35:      li  x3, 35
      li x1, 15
        add x2, x0, x1
      li  x7, 15
      bne x2, x7, fail
  test_36:      li  x3, 36
      li x1, 32
        add x2, x1, x0
      li  x7, 32
      bne x2, x7, fail
  test_37:      li  x3, 37
      add x1, x0, x0
      li  x7, 0
      bne x1, x7, fail
  test_38:      li  x3, 38
      li x1, 16
        li x2, 30
        add x0, x1, x2
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end