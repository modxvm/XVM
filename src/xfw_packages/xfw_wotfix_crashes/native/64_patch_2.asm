PUBLIC patch_2_replaceaddr
PUBLIC patch_2_returnaddr

.data

patch_2_replaceaddr QWORD 1
patch_2_returnaddr QWORD 1


.code

patch_2_asmfunc PROC
    ;before
    ;mov     [rsp+28h+arg_8], rbp
    ;add     r8, r8          ; Add
    ;mov     [rsp+28h+arg_10], rdi

    ;
    ; inject
    ;

    ;restore rax
    pop     rax

    ;start
    mov     rcx, rsi
    mov     rdx, [rax+rdx*8+8]
    mov     rax, rsi
    shr     rax, 14h        ; Shift Logical Right
    shr     rcx, 1Ch        ; Shift Logical Right
    and     ecx, 0FFFh      ; Logical AND

    ;crashfix, RDX=0x0
    test    rdx, rdx
    jz      crashfix

    mov     rdx, [rdx+r8*8] ; CRASH, RDX=0x0

    add     rcx, rcx        ; Add
    movzx   r8d, al         ; Move with Zero-Extend
    mov     rax, rsi
    shr     rax, 0Ch        ; Shift Logical Right
    add     r8, r8          ; Add
    mov     rdx, [rdx+rcx*8]
    movzx   ecx, al         ; Move with Zero-Extend
    mov     rax, [rdx+r8*8]
    mov     rbp, [rax+rcx*8]

    jmp patch_2_returnaddr

    ;content on which we are returned
    ;mov     rdi, [rbp+28h]
    ;cmp     byte ptr [rdi+0C8h], 0 ; Compare Two Operands
    ;jz      short loc_14110FD8A    ; Jump if Zero (ZF=1)
    ;lea     rcx, [rdi+98h]         ; Load Effective Address

    crashfix:
    add rsp, 28h ; fix SP
    ret

patch_2_asmfunc ENDP

END