; argc = [rsp]
; argv = [rsp + 8*ARG_NUMBER]
; ./a.out hello there
; [rsp] = 3
; [rsp + 8 * 1] = ./a.out
; [rsp + 8 * 2] = hello
; [rsp + 8 * 3] = there

	global	main
	extern	printf
	
	section	.text
main:
	mov	rcx, rdi	; argc
	mov	rdx, rsi	; argv

_print:
	; callee-save or something
	; printf may destroy these
	push	rcx
	push	rdx

	mov	rdi, frmstr
	; argv is a pointer to a pointer
	mov	rsi, [rdx]
	xor	eax, eax
	call	printf

	pop	rdx
	pop	rcx

	add	rdx, 8
	dec	rcx
	jnz	_print
	
	mov	rax, 60
	mov	rdi, 1
	syscall

	section	.data
frmstr:	db	"%s", 10, 0



