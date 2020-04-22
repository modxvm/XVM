PUBLIC patch_1_replaceaddr
PUBLIC patch_1_returnaddr

.data

patch_1_replaceaddr QWORD 1
patch_1_returnaddr QWORD 1


.code

patch_1_asmfunc PROC
   
   mov     rax, [r14+4CE0h]
   mov     rcx, [rax+rdi*8]

   ;CRASHFIX, RCX could be 0
   test    rcx, rcx
   jz      short aftercall

   ;function calling
   mov     rax, [rcx] ;CRASH, RCX = 0
   call    qword ptr [rax+20h]

   aftercall:
   inc     rdi
   cmp     rdi, rsi
   jb      patch_1_asmfunc

   jmp     patch_1_returnaddr

patch_1_asmfunc ENDP

END