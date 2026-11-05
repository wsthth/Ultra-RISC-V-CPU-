  test_2:      li  x3, 2
                 la  x2, tdat
                         li  x1, 0xffffffffffffffdd
                       sb x1, 0(x2)
            lb x14, 0(x2)
            li  x7, 0xffffffffffffffdd
                       bne x14, x7, fail
  test_3:      li  x3, 3
                 la  x2, tdat
                         li  x1, 0xffffffffffffffcd
                       sb x1, 1(x2)
            lb x14, 1(x2)
            li  x7, 0xffffffffffffffcd
                       bne x14, x7, fail
  test_4:      li  x3, 4
                 la  x2, tdat
                         li  x1, 0xffffffffffffffcc
                       sb x1, 2(x2)
            lb x14, 2(x2)
            li  x7, 0xffffffffffffffcc
                       bne x14, x7, fail
  test_5:      li  x3, 5
                 la  x2, tdat
                         li  x1, 0xffffffffffffffbc
                       sb x1, 3(x2)
            lb x14, 3(x2)
            li  x7, 0xffffffffffffffbc
                       bne x14, x7, fail
  test_6:      li  x3, 6
                 la  x2, tdat
                         li  x1, 0xffffffffffffffbb
                       sb x1, 4(x2)
            lb x14, 4(x2)
            li  x7, 0xffffffffffffffbb
                       bne x14, x7, fail
  test_7:      li  x3, 7
                 la  x2, tdat
                         li  x1, 0xffffffffffffffab
                       sb x1, 5(x2)
            lb x14, 5(x2)
            li  x7, 0xffffffffffffffab
                       bne x14, x7, fail
  test_8:      li  x3, 8
                 la  x2, tdat
                         li  x1, 0x33
                       sb x1, 0(x2)
            lb x14, 0(x2)
            li  x7, 0x33
                       bne x14, x7, fail
  test_9:      li  x3, 9
                 la  x2, tdat
                         li  x1, 0x23
                       sb x1, 1(x2)
            lb x14, 1(x2)
            li  x7, 0x23
                       bne x14, x7, fail
  test_10:      li  x3, 10
                 la  x2, tdat
                         li  x1, 0x22
                       sb x1, 2(x2)
            lb x14, 2(x2)
            li  x7, 0x22
                       bne x14, x7, fail
  test_11:      li  x3, 11
                 la  x2, tdat
                         li  x1, 0x12
                       sb x1, 3(x2)
            lb x14, 3(x2)
            li  x7, 0x12
                       bne x14, x7, fail
  test_12:      li  x3, 12
                 la  x2, tdat
                         li  x1, 0x11
                       sb x1, 4(x2)
            lb x14, 4(x2)
            li  x7, 0x11
                       bne x14, x7, fail
  test_13:      li  x3, 13
                 la  x2, tdat
                         li  x1, 0x01
                       sb x1, 5(x2)
            lb x14, 5(x2)
            li  x7, 0x01
                       bne x14, x7, fail
  test_14:      li  x3, 14
                 la  x2, tdat
                         li  x1, 0x33
                       sb x1, 0(x2)
            lbu x14, 0(x2)
            li  x7, 0x33
                       bne x14, x7, fail
  test_15:      li  x3, 15
                 la  x2, tdat
                         li  x1, 0x23
                       sb x1, 1(x2)
            lbu x14, 1(x2)
            li  x7, 0x23
                       bne x14, x7, fail
  test_16:      li  x3, 16
                 la  x2, tdat
                         li  x1, 0x22
                       sb x1, 2(x2)
            lbu x14, 2(x2)
            li  x7, 0x22
                       bne x14, x7, fail
  test_17:      li  x3, 17
                 la  x2, tdat
                         li  x1, 0x12
                       sb x1, 3(x2)
            lbu x14, 3(x2)
            li  x7, 0x12
                       bne x14, x7, fail
  test_18:      li  x3, 18
                 la  x2, tdat
                         li  x1, 0x11
                       sb x1, 4(x2)
            lbu x14, 4(x2)
            li  x7, 0x11
                       bne x14, x7, fail
  test_19:      li  x3, 19
                 la  x2, tdat
                         li  x1, 0x01
                       sb x1, 5(x2)
            lbu x14, 5(x2)
            li  x7, 0x01
                       bne x14, x7, fail
  test_20:      li  x3, 20
                 la  x2, tdat
                         li  x1, 0xffffffffaabbccdd
                       sw x1, 0(x2)
            lw x14, 0(x2)
            li  x7, 0xffffffffaabbccdd
                       bne x14, x7, fail
  test_21:      li  x3, 21
                 la  x2, tdat
                         li  x1, 0xffffffffdaabbccd
                       sw x1, 4(x2)
            lw x14, 4(x2)
            li  x7, 0xffffffffdaabbccd
                       bne x14, x7, fail
  test_22:      li  x3, 22
                 la  x2, tdat
                         li  x1, 0xffffffffddaabbcc
                       sw x1, 8(x2)
            lw x14, 8(x2)
            li  x7, 0xffffffffddaabbcc
                       bne x14, x7, fail
  test_23:      li  x3, 23
                 la  x2, tdat
                         li  x1, 0xffffffffcddaabbc
                       sw x1, 12(x2)
            lw x14, 12(x2)
            li  x7, 0xffffffffcddaabbc
                       bne x14, x7, fail
  test_24:      li  x3, 24
                 la  x2, tdat
                         li  x1, 0xffffffffccddaabb
                       sw x1, 16(x2)
            lw x14, 16(x2)
            li  x7, 0xffffffffccddaabb
                       bne x14, x7, fail
  test_25:      li  x3, 25
                 la  x2, tdat
                         li  x1, 0xffffffffbccddaab
                       sw x1, 20(x2)
            lw x14, 20(x2)
            li  x7, 0xffffffffbccddaab
                       bne x14, x7, fail
  test_26:      li  x3, 26
                 la  x2, tdat
                         li  x1, 0x00112233
                       sw x1, 0(x2)
            lw x14, 0(x2)
            li  x7, 0x00112233
                       bne x14, x7, fail
  test_27:      li  x3, 27
                 la  x2, tdat
                         li  x1, 0x30011223
                       sw x1, 4(x2)
            lw x14, 4(x2)
            li  x7, 0x30011223
                       bne x14, x7, fail
  test_28:      li  x3, 28
                 la  x2, tdat
                         li  x1, 0x33001122
                       sw x1, 8(x2)
            lw x14, 8(x2)
            li  x7, 0x33001122
                       bne x14, x7, fail
  test_29:      li  x3, 29
                 la  x2, tdat
                         li  x1, 0x23300112
                       sw x1, 12(x2)
            lw x14, 12(x2)
            li  x7, 0x23300112
                       bne x14, x7, fail
  test_30:      li  x3, 30
                 la  x2, tdat
                         li  x1, 0x22330011
                       sw x1, 16(x2)
            lw x14, 16(x2)
            li  x7, 0x22330011
                       bne x14, x7, fail
  test_31:      li  x3, 31
                 la  x2, tdat
                         li  x1, 0x12233001
                       sw x1, 20(x2)
            lw x14, 20(x2)
            li  x7, 0x12233001
                       bne x14, x7, fail
  test_32:      li  x3, 32
                 la  x2, tdat
                         li  x1, 0xffffffffffffccdd
                       sh x1, 0(x2)
            lh x14, 0(x2)
            li  x7, 0xffffffffffffccdd
                       bne x14, x7, fail
  test_33:      li  x3, 33
                 la  x2, tdat
                         li  x1, 0xffffffffffffbccd
                       sh x1, 2(x2)
            lh x14, 2(x2)
            li  x7, 0xffffffffffffbccd
                       bne x14, x7, fail
  test_34:      li  x3, 34
                 la  x2, tdat
                         li  x1, 0xffffffffffffbbcc
                       sh x1, 4(x2)
            lh x14, 4(x2)
            li  x7, 0xffffffffffffbbcc
                       bne x14, x7, fail
  test_35:      li  x3, 35
                 la  x2, tdat
                         li  x1, 0xffffffffffffabbc
                       sh x1, 6(x2)
            lh x14, 6(x2)
            li  x7, 0xffffffffffffabbc
                       bne x14, x7, fail
  test_36:      li  x3, 36
                 la  x2, tdat
                         li  x1, 0xffffffffffffaabb
                       sh x1, 8(x2)
            lh x14, 8(x2)
            li  x7, 0xffffffffffffaabb
                       bne x14, x7, fail
  test_37:      li  x3, 37
                 la  x2, tdat
                         li  x1, 0xffffffffffffdaab
                       sh x1, 10(x2)
            lh x14, 10(x2)
            li  x7, 0xffffffffffffdaab
                       bne x14, x7, fail
  test_38:      li  x3, 38
                 la  x2, tdat
                         li  x1, 0x2233
                       sh x1, 0(x2)
            lh x14, 0(x2)
            li  x7, 0x2233
                       bne x14, x7, fail
  test_39:      li  x3, 39
                 la  x2, tdat
                         li  x1, 0x1223
                       sh x1, 2(x2)
            lh x14, 2(x2)
            li  x7, 0x1223
                       bne x14, x7, fail
  test_40:      li  x3, 40
                 la  x2, tdat
                         li  x1, 0x1122
                       sh x1, 4(x2)
            lh x14, 4(x2)
            li  x7, 0x1122
                       bne x14, x7, fail
  test_41:      li  x3, 41
                 la  x2, tdat
                         li  x1, 0x0112
                       sh x1, 6(x2)
            lh x14, 6(x2)
            li  x7, 0x0112
                       bne x14, x7, fail
  test_42:      li  x3, 42
                 la  x2, tdat
                         li  x1, 0x0011
                       sh x1, 8(x2)
            lh x14, 8(x2)
            li  x7, 0x0011
                       bne x14, x7, fail
  test_43:      li  x3, 43
                 la  x2, tdat
                         li  x1, 0x3001
                       sh x1, 10(x2)
            lh x14, 10(x2)
            li  x7, 0x3001
                       bne x14, x7, fail
  test_44:      li  x3, 44
                 la  x2, tdat
                         li  x1, 0x2233
                       sh x1, 0(x2)
            lhu x14, 0(x2)
            li  x7, 0x2233
                       bne x14, x7, fail
  test_45:      li  x3, 45
                 la  x2, tdat
                         li  x1, 0x1223
                       sh x1, 2(x2)
            lhu x14, 2(x2)
            li  x7, 0x1223
                       bne x14, x7, fail
  test_46:      li  x3, 46
                 la  x2, tdat
                         li  x1, 0x1122
                       sh x1, 4(x2)
            lhu x14, 4(x2)
            li  x7, 0x1122
                       bne x14, x7, fail
  test_47:      li  x3, 47
                 la  x2, tdat
                         li  x1, 0x0112
                       sh x1, 6(x2)
            lhu x14, 6(x2)
            li  x7, 0x0112
                       bne x14, x7, fail
  test_48:      li  x3, 48
                 la  x2, tdat
                         li  x1, 0x0011
                       sh x1, 8(x2)
            lhu x14, 8(x2)
            li  x7, 0x0011
                       bne x14, x7, fail
  test_49:      li  x3, 49
                 la  x2, tdat
                         li  x1, 0x3001
                       sh x1, 10(x2)
            lhu x14, 10(x2)
            li  x7, 0x3001
                       bne x14, x7, fail
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
tdat:
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef
    .word 0xdeadbeef