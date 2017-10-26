; argc = [rsp]
; argv = [rsp + 8*ARG_NUMBER]
; ./a.out hello there
; [rsp] = 3
; [rsp + 8 * 1] = ./test
; [rsp + 8 * 2] = hello
; [rsp + 8 * 3] = there
 
 
    extern  printf
    extern  exit
    global  main
 
    section .data
formatint   db  "There are %d paramters:", 10, 0
formatstr   db  "%s", 10, 0
 
    section .text
main:
    push    qword[rsp]
    push    formatint
    call    printf
    add rsp, 8 * 2
 
    mov rbx, 1
PrintArgV:
    push    qword [ rsp + 8 * rbx]
    push    formatstr
    call    printf
    add rsp, 8
 
    inc rbx
    cmp rbx, qword [ rsp ]
    jng PrintArgV
   
    call    exit

