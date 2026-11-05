test_2:
  li  x3, 2
  li  t0, 0
  la  t1, target_2
  jalr t0, t1, 0
linkaddr_2:
  j fail
target_2:
  la  t1, linkaddr_2
  bne t0, t1, fail
test_3:
  li  x3, 3
  la  t0, target_3
  jalr t0, t0, 0
linkaddr_3:
  j fail
target_3:
  la  t1, linkaddr_3
  bne t0, t1, fail
  test_4:      li  x3, 4
      li  x4, 0
  1:  la  x6, 2f
            jalr x13, x6, 0
      bne x0, x3, fail
  2:  addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_5:      li  x3, 5
      li  x4, 0
  1:  la  x6, 2f
      nop
       jalr x13, x6, 0
      bne x0, x3, fail
  2:  addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_6:      li  x3, 6
      li  x4, 0
  1:  la  x6, 2f
      nop
 nop
       jalr x13, x6, 0
      bne x0, x3, fail
  2:  addi  x4, x4, 1
      li  x5, 2
      bne x4, x5, 1b
  test_7:      li  x3, 7
      li  t0, 1
      la  t1, 1f
      jr  t1, -4
      addi t0, t0, 1
      addi t0, t0, 1
      addi t0, t0, 1
      addi t0, t0, 1
  1:  addi t0, t0, 1
      addi t0, t0, 1
      li  x7, 4
      bne t0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end