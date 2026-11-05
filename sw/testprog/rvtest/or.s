  test_8:      li  x3, 8
      li  x11, 4278255360
        or x11, x11, x11
      li  x7, 4278255360
      bne x11, x7, fail
  test_9:      li  x3, 9
      li  x4, 0
  1:    li  x1, 4278255360
        li  x2, 252645135
        or x14, x1, x2
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4279238415
      bne x6, x7, fail
  test_10:      li  x3, 10
      li  x4, 0
  1:    li  x1, 267390960
        li  x2, 4042322160
        or x14, x1, x2
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4293984240
      bne x6, x7, fail
  test_11:      li  x3, 11
      li  x4, 0
  1:    li  x1, 16711935
        li  x2, 252645135
        or x14, x1, x2
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 268374015
      bne x6, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:    li  x1, 4278255360
                li  x2, 252645135
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4279238415
      bne x14, x7, fail
  test_13:      li  x3, 13
      li  x4, 0
  1:    li  x1, 267390960
                li  x2, 4042322160
        nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4293984240
      bne x14, x7, fail
  test_14:      li  x3, 14
      li  x4, 0
  1:    li  x1, 16711935
                li  x2, 252645135
        nop
 nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 268374015
      bne x14, x7, fail
  test_15:      li  x3, 15
      li  x4, 0
  1:    li  x1, 4278255360
        nop
         li  x2, 252645135
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4279238415
      bne x14, x7, fail
  test_16:      li  x3, 16
      li  x4, 0
  1:    li  x1, 267390960
        nop
         li  x2, 4042322160
        nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4293984240
      bne x14, x7, fail
  test_17:      li  x3, 17
      li  x4, 0
  1:    li  x1, 16711935
        nop
 nop
         li  x2, 252645135
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 268374015
      bne x14, x7, fail
  test_18:      li  x3, 18
      li  x4, 0
  1:    li  x2, 252645135
                li  x1, 4278255360
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4279238415
      bne x14, x7, fail
  test_19:      li  x3, 19
      li  x4, 0
  1:    li  x2, 4042322160
                li  x1, 267390960
        nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4293984240
      bne x14, x7, fail
  test_20:      li  x3, 20
      li  x4, 0
  1:    li  x2, 252645135
                li  x1, 16711935
        nop
 nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 268374015
      bne x14, x7, fail
  test_21:      li  x3, 21
      li  x4, 0
  1:    li  x2, 252645135
        nop
         li  x1, 4278255360
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4279238415
      bne x14, x7, fail
  test_22:      li  x3, 22
      li  x4, 0
  1:    li  x2, 4042322160
        nop
         li  x1, 267390960
        nop
         or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4293984240
      bne x14, x7, fail
  test_23:      li  x3, 23
      li  x4, 0
  1:    li  x2, 252645135
        nop
 nop
         li  x1, 16711935
                or x14, x1, x2
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 268374015
      bne x14, x7, fail
  test_24:      li  x3, 24
      li x1, 4278255360
        or x2, x0, x1
      li  x7, 4278255360
      bne x2, x7, fail
  test_25:      li  x3, 25
      li x1, 16711935
        or x2, x1, x0
      li  x7, 16711935
      bne x2, x7, fail
  test_26:      li  x3, 26
      or x1, x0, x0
      li  x7, 0
      bne x1, x7, fail
  test_27:      li  x3, 27
      li x1, 286331153
        li x2, 572662306
        or x0, x1, x2
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end