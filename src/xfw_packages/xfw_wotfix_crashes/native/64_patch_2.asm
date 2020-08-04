PUBLIC patch_2_replaceaddr
PUBLIC patch_2_returnaddr

.data

patch_2_replaceaddr QWORD 1
patch_2_returnaddr QWORD 1


.code

patch_2_asmfunc PROC
    ;restore rax
    pop rax

    ;loc_140A1273E:
    mov     rax, [rbx]          ; L67
    mov     rcx, [rax+rdi*8]

    ;CRASHFIX, RCX could be 0
    test    rcx, rcx
    jz      short aftercall

    mov     rax, [rcx]          ; CRASH, RCX=0x0
    call    qword ptr [rax+20h] ; L68

    aftercall:
    mov     r8, [rsi+4CE8h]     ; L69
    cmp     r8, 1               ; L70

    jmp     patch_2_returnaddr

patch_2_asmfunc ENDP

END