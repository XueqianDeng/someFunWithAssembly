	.section .rodata
sResultMsg: .string "Result is %u\n"

	.section .data

	.globl main
main:
	subq $8, %rsp

	movl $0, %edi
	movl $1, %r10d
.L1:
	addl %r10d, %r10d
	incl %edi
	cmpl $64, %r10d
	jle .L1
	/* HERE */

	movl $0, %eax
	movl %edi, %esi
	movq $sResultMsg, %rdi
	call printf

	addq $8, %rsp
	movl $0, %eax
	ret

/*
vim:ft=gas:
*/
