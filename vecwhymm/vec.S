bits 64

section .text
global copy16
copy16:
    ; void (dst xmm ptr , src xmm ptr)
    VMOVDQA xmm0,[rsi]
    VMOVDQA [rdi], xmm0
    ret
global rotateR64
rotateR64: