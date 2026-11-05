  test_2:      li  x3, 2
      li  x13, 16715520
        xori x14, x13, 4294967055
      li  x7, 4278251535
      bne x14, x7, fail
  test_3:      li  x3, 3
      li  x13, 267390960
        xori x14, x13, 240
      li  x7, 267390720
      bne x14, x7, fail
  test_4:      li  x3, 4
      li  x13, 16713983
        xori x14, x13, 1807
      li  x7, 16715760
      bne x14, x7, fail
  test_5:      li  x3, 5
      li  x13, 4027576335
        xori x14, x13, 240
      li  x7, 4027576575
      bne x14, x7, fail
  test_6:      li  x3, 6
      li  x11, 4278253312
        xori x11, x11, 1807
      li  x7, 4278251535
      bne x11, x7, fail
  test_7:      li  x3, 7
      li  x4, 0
  1:    li  x1, 267390960
        xori x14, x1, 240
                addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 267390720
      bne x6, x7, fail
  test_8:      li  x3, 8
      li  x4, 0
  1:    li  x1, 16713983
        xori x14, x1, 1807
        nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16715760
      bne x6, x7, fail
  test_9:      li  x3, 9
      li  x4, 0
  1:    li  x1, 4027576335
        xori x14, x1, 240
        nop
 nop
         addi  x6, x14, 0
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4027576575
      bne x6, x7, fail
  test_10:      li  x3, 10
      li  x4, 0
  1:    li  x1, 267390960
                xori x14, x1, 240
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 267390720
      bne x14, x7, fail
  test_11:      li  x3, 11
      li  x4, 0
  1:    li  x1, 16715775
        nop
         xori x14, x1, 15
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 16715760
      bne x14, x7, fail
  test_12:      li  x3, 12
      li  x4, 0
  1:    li  x1, 4027576335
        nop
 nop
         xori x14, x1, 240
        addi  x4, x4, 1
        li  x5, 2
        bne x4, x5, 1b
      li  x7, 4027576575
      bne x14, x7, fail
  test_13:      li  x3, 13
      xori x1, x0, 240
      li  x7, 240
      bne x1, x7, fail
  test_14:      li  x3, 14
      li  x1, 16711935
        xori x0, x1, 1807
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end