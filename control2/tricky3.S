	.section .rodata
sResultMsg: .string "Result is %u\n"

	.section .text

	.globl main
main:
	subq $8, %rsp
	movl $3, %edi
	call func
	movl %eax, %esi
	movq $sResultMsg, %rdi
	movl $0, %eax
	call printf
	addq $8, %rsp
	movl $0, %eax
	ret

func:
	addl %edi, %edi
	addl %edi, %edi
	movl %edi, %eax
	ret

/*
vim:ft=gas:
*/
