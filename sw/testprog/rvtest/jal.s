test_2:
  li  x3, 2
  li  ra, 0
  jal x4, target_2
linkaddr_2:
  nop
  nop
  j fail
target_2:
  la  x2, linkaddr_2
  bne x2, x4, fail
  test_3:      li  x3, 3
      li  ra, 1
      jal x0, 1f
      addi ra, ra, 1
      addi ra, ra, 1
      addi ra, ra, 1
      addi ra, ra, 1
  1:  addi ra, ra, 1
      addi ra, ra, 1
      li  x7, 3
      bne ra, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end