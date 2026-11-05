  la s0, data
  li x3, 1
    li t1, ((-((0x0201) >> ((16)-1)) << (16)) | ((0x0201) & ((1 << (16))-1)))
    lh t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 2
    li t1, 0x0201
    lhu t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 3
    li t1, ((-((0x04030201) >> ((32)-1)) << (32)) | ((0x04030201) & ((1 << (32))-1)))
    lw t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 4
    li t1, ((-((0x05040302) >> ((32)-1)) << (32)) | ((0x05040302) & ((1 << (32))-1)))
    lw t2, 2(s0)
    bne t1, t2, fail
  1:
  li x3, 5
    li t1, ((-((0x06050403) >> ((32)-1)) << (32)) | ((0x06050403) & ((1 << (32))-1)))
    lw t2, 3(s0)
    bne t1, t2, fail
  1:
  li x3, 16
    li t1, ((-((0x201f) >> ((16)-1)) << (16)) | ((0x201f) & ((1 << (16))-1)))
    lh t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 17
    li t1, 0x201f
    lhu t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 18
    li t1, ((-((0x201f1e1d) >> ((32)-1)) << (32)) | ((0x201f1e1d) & ((1 << (32))-1)))
    lw t2, 29(s0)
    bne t1, t2, fail
  1:
  li x3, 19
    li t1, ((-((0x21201f1e) >> ((32)-1)) << (32)) | ((0x21201f1e) & ((1 << (32))-1)))
    lw t2, 30(s0)
    bne t1, t2, fail
  1:
  li x3, 20
    li t1, ((-((0x2221201f) >> ((32)-1)) << (32)) | ((0x2221201f) & ((1 << (32))-1)))
    lw t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 31
    li t1, ((-((0x403f) >> ((16)-1)) << (16)) | ((0x403f) & ((1 << (16))-1)))
    lh t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 32
    li t1, 0x403f
    lhu t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 33
    li t1, ((-((0x403f3e3d) >> ((32)-1)) << (32)) | ((0x403f3e3d) & ((1 << (32))-1)))
    lw t2, 61(s0)
    bne t1, t2, fail
  1:
  li x3, 34
    li t1, ((-((0x41403f3e) >> ((32)-1)) << (32)) | ((0x41403f3e) & ((1 << (32))-1)))
    lw t2, 62(s0)
    bne t1, t2, fail
  1:
  li x3, 35
    li t1, ((-((0x4241403f) >> ((32)-1)) << (32)) | ((0x4241403f) & ((1 << (32))-1)))
    lw t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 46
    li t1, ((-((0x8180) >> ((16)-1)) << (16)) | ((0x8180) & ((1 << (16))-1)))
    sh t1, 1(s0)
    lh t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 47
    li t1, 0x8382
    sh t1, 1(s0)
    lhu t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 48
    li t1, ((-((0x87868584) >> ((32)-1)) << (32)) | ((0x87868584) & ((1 << (32))-1)))
    sw t1, 1(s0)
    lw t2, 1(s0)
    bne t1, t2, fail
  1:
  li x3, 49
    li t1, ((-((0x8b8a8988) >> ((32)-1)) << (32)) | ((0x8b8a8988) & ((1 << (32))-1)))
    sw t1, 2(s0)
    lw t2, 2(s0)
    bne t1, t2, fail
  1:
  li x3, 50
    li t1, ((-((0x8f8e8d8c) >> ((32)-1)) << (32)) | ((0x8f8e8d8c) & ((1 << (32))-1)))
    sw t1, 3(s0)
    lw t2, 3(s0)
    bne t1, t2, fail
  1:
  li x3, 61
    li t1, ((-((0xd5d4) >> ((16)-1)) << (16)) | ((0xd5d4) & ((1 << (16))-1)))
    sh t1, 31(s0)
    lh t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 62
    li t1, 0xd7d6
    sh t1, 31(s0)
    lhu t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 63
    li t1, ((-((0xdbdad9d8) >> ((32)-1)) << (32)) | ((0xdbdad9d8) & ((1 << (32))-1)))
    sw t1, 29(s0)
    lw t2, 29(s0)
    bne t1, t2, fail
  1:
  li x3, 64
    li t1, ((-((0xdfdedddc) >> ((32)-1)) << (32)) | ((0xdfdedddc) & ((1 << (32))-1)))
    sw t1, 30(s0)
    lw t2, 30(s0)
    bne t1, t2, fail
  1:
  li x3, 65
    li t1, ((-((0xe3e2e1e0) >> ((32)-1)) << (32)) | ((0xe3e2e1e0) & ((1 << (32))-1)))
    sw t1, 31(s0)
    lw t2, 31(s0)
    bne t1, t2, fail
  1:
  li x3, 76
    li t1, ((-((0x3534) >> ((16)-1)) << (16)) | ((0x3534) & ((1 << (16))-1)))
    sh t1, 63(s0)
    lh t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 77
    li t1, 0x3736
    sh t1, 63(s0)
    lhu t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 78
    li t1, ((-((0x3b3a3938) >> ((32)-1)) << (32)) | ((0x3b3a3938) & ((1 << (32))-1)))
    sw t1, 61(s0)
    lw t2, 61(s0)
    bne t1, t2, fail
  1:
  li x3, 79
    li t1, ((-((0x3f3e3d3c) >> ((32)-1)) << (32)) | ((0x3f3e3d3c) & ((1 << (32))-1)))
    sw t1, 62(s0)
    lw t2, 62(s0)
    bne t1, t2, fail
  1:
  li x3, 80
    li t1, ((-((0x43424140) >> ((32)-1)) << (32)) | ((0x43424140) & ((1 << (32))-1)))
    sw t1, 63(s0)
    lw t2, 63(s0)
    bne t1, t2, fail
  1:
  li x3, 91
    li t1, 0x9998
    li t2, ((-((0x98) >> ((8)-1)) << (8)) | ((0x98) & ((1 << (8))-1)))
    sh t1, 1(s0)
    lb t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 92
    li t1, 0x9b9a
    li t2, ((-((0x9b) >> ((8)-1)) << (8)) | ((0x9b) & ((1 << (8))-1)))
    sh t1, 1(s0)
    lb t3, 2(s0)
    bne t2, t3, fail
  1:
  li x3, 93
    li t1, 0x9d9c
    li t2, 0x9c
    sh t1, 1(s0)
    lbu t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 94
    li t1, 0x9f9e
    li t2, 0x9f
    sh t1, 1(s0)
    lbu t3, 2(s0)
    bne t2, t3, fail
  1:
  li x3, 95
    li t1, 0xa3a2a1a0
    li t2, ((-((0xa0) >> ((8)-1)) << (8)) | ((0xa0) & ((1 << (8))-1)))
    sw t1, 1(s0)
    lb t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 96
    li t1, 0xa7a6a5a4
    li t2, 0xa5
    sw t1, 2(s0)
    lbu t3, 3(s0)
    bne t2, t3, fail
  1:
  li x3, 97
    li t1, 0xabaaa9a8
    li t2, ((-((0xaaa9) >> ((16)-1)) << (16)) | ((0xaaa9) & ((1 << (16))-1)))
    sw t1, 3(s0)
    lh t3, 4(s0)
    bne t2, t3, fail
  1:
  li x3, 98
    li t1, 0xafaeadac
    li t2, 0xafae
    sw t1, 3(s0)
    lhu t3, 5(s0)
    bne t2, t3, fail
  1:
  li x3, 106
    li t1, 0xe9e8
    li t2, ((-((0xe8) >> ((8)-1)) << (8)) | ((0xe8) & ((1 << (8))-1)))
    sh t1, 31(s0)
    lb t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 107
    li t1, 0xebea
    li t2, ((-((0xeb) >> ((8)-1)) << (8)) | ((0xeb) & ((1 << (8))-1)))
    sh t1, 31(s0)
    lb t3, 32(s0)
    bne t2, t3, fail
  1:
  li x3, 108
    li t1, 0xedec
    li t2, 0xec
    sh t1, 31(s0)
    lbu t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 109
    li t1, 0xefee
    li t2, 0xef
    sh t1, 31(s0)
    lbu t3, 32(s0)
    bne t2, t3, fail
  1:
  li x3, 110
    li t1, 0xf3f2f1f0
    li t2, ((-((0xf0) >> ((8)-1)) << (8)) | ((0xf0) & ((1 << (8))-1)))
    sw t1, 29(s0)
    lb t3, 29(s0)
    bne t2, t3, fail
  1:
  li x3, 111
    li t1, 0xf7f6f5f4
    li t2, 0xf6
    sw t1, 30(s0)
    lbu t3, 32(s0)
    bne t2, t3, fail
  1:
  li x3, 112
    li t1, 0xfbfaf9f8
    li t2, ((-((0xfbfa) >> ((16)-1)) << (16)) | ((0xfbfa) & ((1 << (16))-1)))
    sw t1, 29(s0)
    lh t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 113
    li t1, 0xfffefdfc
    li t2, 0xfdfc
    sw t1, 31(s0)
    lhu t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 121
    li t1, 0x4948
    li t2, ((-((0x48) >> ((8)-1)) << (8)) | ((0x48) & ((1 << (8))-1)))
    sh t1, 63(s0)
    lb t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 122
    li t1, 0x4b4a
    li t2, ((-((0x4b) >> ((8)-1)) << (8)) | ((0x4b) & ((1 << (8))-1)))
    sh t1, 63(s0)
    lb t3, 64(s0)
    bne t2, t3, fail
  1:
  li x3, 123
    li t1, 0x4d4c
    li t2, 0x4c
    sh t1, 63(s0)
    lbu t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 124
    li t1, 0x4f4e
    li t2, 0x4f
    sh t1, 63(s0)
    lbu t3, 64(s0)
    bne t2, t3, fail
  1:
  li x3, 125
    li t1, 0x53525150
    li t2, ((-((0x50) >> ((8)-1)) << (8)) | ((0x50) & ((1 << (8))-1)))
    sw t1, 61(s0)
    lb t3, 61(s0)
    bne t2, t3, fail
  1:
  li x3, 126
    li t1, 0x57565554
    li t2, 0x56
    sw t1, 62(s0)
    lbu t3, 64(s0)
    bne t2, t3, fail
  1:
  li x3, 127
    li t1, 0x5b5a5958
    li t2, ((-((0x5b5a) >> ((16)-1)) << (16)) | ((0x5b5a) & ((1 << (16))-1)))
    sw t1, 61(s0)
    lh t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 128
    li t1, 0x5f5e5d5c
    li t2, 0x5d5c
    sw t1, 63(s0)
    lhu t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 136
    li t1, 0x98
    li t2, ((-((0xb898) >> ((16)-1)) << (16)) | ((0xb898) & ((1 << (16))-1)))
    sb t1, 1(s0)
    lh t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 137
    li t1, 0x99
    li t2, 0x9998
    sb t1, 2(s0)
    lhu t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 138
    li t1, 0x9b9a
    li t2, ((-((0xc8c09b9a) >> ((32)-1)) << (32)) | ((0xc8c09b9a) & ((1 << (32))-1)))
    sh t1, 1(s0)
    lw t3, 1(s0)
    bne t2, t3, fail
  1:
  li x3, 139
    li t1, 0x9d9c
    li t2, ((-((0xd09d9c9b) >> ((32)-1)) << (32)) | ((0xd09d9c9b) & ((1 << (32))-1)))
    sh t1, 3(s0)
    lw t3, 2(s0)
    bne t2, t3, fail
  1:
  li x3, 140
    li t1, 0x9f9e
    li t2, ((-((0x9f9e9d9c) >> ((32)-1)) << (32)) | ((0x9f9e9d9c) & ((1 << (32))-1)))
    sh t1, 5(s0)
    lw t3, 3(s0)
    bne t2, t3, fail
  1:
  li x3, 151
    li t1, 0xba
    li t2, ((-((0x31ba) >> ((16)-1)) << (16)) | ((0x31ba) & ((1 << (16))-1)))
    sb t1, 31(s0)
    lh t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 152
    li t1, 0xbb
    li t2, 0xbbba
    sb t1, 32(s0)
    lhu t3, 31(s0)
    bne t2, t3, fail
  1:
  li x3, 153
    li t1, 0xbdbc
    li t2, ((-((0x32bbbdbc) >> ((32)-1)) << (32)) | ((0x32bbbdbc) & ((1 << (32))-1)))
    sh t1, 30(s0)
    lw t3, 30(s0)
    bne t2, t3, fail
  1:
  li x3, 154
    li t1, 0xbfbe
    li t2, ((-((0x32bfbebc) >> ((32)-1)) << (32)) | ((0x32bfbebc) & ((1 << (32))-1)))
    sh t1, 31(s0)
    lw t3, 30(s0)
    bne t2, t3, fail
  1:
  li x3, 155
    li t1, 0xc1c0
    li t2, ((-((0xc1c0bebc) >> ((32)-1)) << (32)) | ((0xc1c0bebc) & ((1 << (32))-1)))
    sh t1, 32(s0)
    lw t3, 30(s0)
    bne t2, t3, fail
  1:
  li x3, 166
    li t1, 0xdc
    li t2, ((-((0x91dc) >> ((16)-1)) << (16)) | ((0x91dc) & ((1 << (16))-1)))
    sb t1, 63(s0)
    lh t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 167
    li t1, 0xdd
    li t2, 0xdddc
    sb t1, 64(s0)
    lhu t3, 63(s0)
    bne t2, t3, fail
  1:
  li x3, 168
    li t1, 0xdfde
    li t2, ((-((0x92dddfde) >> ((32)-1)) << (32)) | ((0x92dddfde) & ((1 << (32))-1)))
    sh t1, 62(s0)
    lw t3, 62(s0)
    bne t2, t3, fail
  1:
  li x3, 169
    li t1, 0xe1e0
    li t2, ((-((0x92e1e0de) >> ((32)-1)) << (32)) | ((0x92e1e0de) & ((1 << (32))-1)))
    sh t1, 63(s0)
    lw t3, 62(s0)
    bne t2, t3, fail
  1:
  li x3, 170
    li t1, 0xe3e2
    li t2, ((-((0xe3e2e0de) >> ((32)-1)) << (32)) | ((0xe3e2e0de) & ((1 << (32))-1)))
    sh t1, 64(s0)
    lw t3, 62(s0)
    bne t2, t3, fail
  1:
  bne x0, x3, pass
  fail:          li x3, 0
          j test_end
  pass:          li x3, 1
          j test_end
j test_end
          test_end:          j test_end
data:
.word 0x03020100
.word 0x07060504
.word 0x0b0a0908
.word 0x0f0e0d0c
.word 0x13121110
.word 0x17161514
.word 0x1b1a1918
.word 0x1f1e1d1c
.word 0x23222120
.word 0x27262524
.word 0x2b2a2928
.word 0x2f2e2d2c
.word 0x33323130
.word 0x37363534
.word 0x3b3a3938
.word 0x3f3e3d3c
.word 0x43424140
.word 0x47464544
.word 0x4b4a4948
.word 0x4f4e4d4c
.word 0x53525150
.word 0x57565554
.word 0x5b5a5958
.word 0x5f5e5d5c
.word 0x63626160
.word 0x67666564
.word 0x6b6a6968
.word 0x6f6e6d6c
.word 0x73727170
.word 0x77767574
.word 0x7b7a7978
.word 0x7f7e7d7c