  test_2:      li  x3, 2
      lla a0, 1f + 10000
      jal a1, 1f
      1: sub a0, a0, a1
      li  x7, 10000
      bne a0, x7, fail
  test_3:      li  x3, 3
      lla a0, 1f - 10000
      jal a1, 1f
      1: sub a0, a0, a1
      li  x7, 4294957296
      bne a0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end