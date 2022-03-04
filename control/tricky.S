	.section .rodata
sResultMsg: .string "Result is %u\n"

	.section .text

	.globl main
main:
	subq $8, %rsp

	movl $0x80000000, %eax
	movl $0x7FFFFFFF, %ebx
	cmpl %ebx, %eax
	jge .L1
	movl $1, %edi
	jmp .L2
.L1:
	movl $2, %edi
.L2:
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
