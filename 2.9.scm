; Interval 1: (a, b), width: (b - a) / 2
; Interval 2: (c, d), width: (d - c) / 2

; I1 + I2: (a+c, b+d), width: (b + d - a - c) / 2 (equal to width(I1) + width(I2))
; I1 - I2: (a-d, b-c), width: (b - c - a + d) / 2 (equal to width(I1) + width(I2))
; Multiplication and division is not a function of the widths of the intervals (example (2,4)*(0,3) and (1,3)*(2,5) (the division is also a multiplication))
