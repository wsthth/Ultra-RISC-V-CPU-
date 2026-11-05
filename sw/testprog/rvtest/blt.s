  test_2:      li  x3, 2
      li  x1, 0
      li  x2, 1
      blt x1, x2, 2f
      bne x0, x3, fail
  1:  bne x0, x3, 3f
  2:  blt x1, x2, 1b
      bne x0, x3, fail
  3:
  test_3:      li  x3, 3
      li  x1, -1
      li  x2, 1
      blt x1, x2, 2f
      bne x0, x3, fail
  1:  bne x0, x3, 3f
  2:  blt x1, x2, 1b
      bne x0, x3, fail
  3:
  test_4:      li  x3, 4
      li  x1, -2
      li  x2, -1
      blt x1, x2, 2f
      bne x0, x3, fail
  1:  bne x0, x3, 3f
  2:  blt x1, x2, 1b
      bne x0, x3, fail
  3:
  test_5:      li  x3, 5
      li  x1, 1
      li  x2, 0
      blt x1, x2, 1f
      bne x0, x3, 2f
  1:  bne x0, x3, fail
  2:  blt x1, x2, 1b
  3:
  test_6:      li  x3, 6
      li  x1, 1
      li  x2, -1
      blt x1, x2, 1f
      bne x0, x3, 2f
  1:  bne x0, x3, fail
  2:  blt x1, x2, 1b
  3:
  test_7:      li  x3, 7
      li  x1, -1
      li  x2, -2
      blt x1, x2, 1f
      bne x0, x3, 2f
  1:  bne x0, x3, fail
  2:  blt x1, x2, 1b
  3:
  test_8:      li  x3, 8
      li  x1, 1
      li  x2, -2
      blt x1, x2, 1f
      bne x0, x3, 2f
  1:  bne x0, x3, fail
  2:  blt x1, x2, 1b
  3:
  test_9:      li  x3, 9
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_10:      li  x3, 10
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
      nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_11:      li  x3, 11
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
      nop
 nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_12:      li  x3, 12
      li  x4, 0
  1:  li  x1, 0
      nop
       li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_13:      li  x3, 13
      li  x4, 0
  1:  li  x1, 0
      nop
       li  x2, -1
      nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_14:      li  x3, 14
      li  x4, 0
  1:  li  x1, 0
      nop
 nop
       li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_15:      li  x3, 15
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_16:      li  x3, 16
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
      nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_17:      li  x3, 17
      li  x4, 0
  1:  li  x1, 0
            li  x2, -1
      nop
 nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_18:      li  x3, 18
      li  x4, 0
  1:  li  x1, 0
      nop
       li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_19:      li  x3, 19
      li  x4, 0
  1:  li  x1, 0
      nop
       li  x2, -1
      nop
       blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_20:      li  x3, 20
      li  x4, 0
  1:  li  x1, 0
      nop
 nop
       li  x2, -1
            blt x1, x2, fail
      addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_21:      li  x3, 21
      li  x1, 1
      blt x0, x1, 1f
      addi x1, x1, 1
      addi x1, x1, 1
      addi x1, x1, 1
      addi x1, x1, 1
  1:  addi x1, x1, 1
      addi x1, x1, 1
      li  x7, 3
      bne x1, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end