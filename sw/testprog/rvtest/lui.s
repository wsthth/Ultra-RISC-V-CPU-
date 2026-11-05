  test_2:      li  x3, 2
      lui x1, 0x00000
      li  x7, 0
      bne x1, x7, fail
  test_3:      li  x3, 3
      lui x1, 0xfffff
sra x1,x1,1
      li  x7, 4294965248
      bne x1, x7, fail
  test_4:      li  x3, 4
      lui x1, 0x7ffff
sra x1,x1,20
      li  x7, 2047
      bne x1, x7, fail
  test_5:      li  x3, 5
      lui x1, 0x80000
sra x1,x1,20
      li  x7, 4294965248
      bne x1, x7, fail
  test_6:      li  x3, 6
      lui x0, 0x80000
      li  x7, 0
      bne x0, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end