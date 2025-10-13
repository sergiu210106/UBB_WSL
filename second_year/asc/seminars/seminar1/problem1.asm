a db 1
b db 2
c dw 3
d dw 4

; (b + d) - (a + c)

mov AL, [b]
mov AH, 0
add AX, [d] ; AX = b + d

mov CL, [a]
mov CH, 0
add CX, [c]
sub AX, CX