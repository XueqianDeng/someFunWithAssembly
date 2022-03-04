/* addLongs.S */

.section .rodata

sPromptMsg: .string "Enter two integers: "
sInputFmt:  .string "%ld %ld"
sResultMsg: .string "Sum is %ld\n"

.section .text

	.globl main
	.align 16
main:
	pushq %rbp
	subq $16, %rsp
	movq %rsp, %rbp

	movl $0, %eax
	movq $sPromptMsg, %rdi
	call printf
	
	movl $0, %eax
	movq $sInputFmt, %rdi
	leaq 0(%rbp), %rsi
	leaq 8(%rbp), %rdx
	call scanf

	movq 0(%rbp), %rdi
	movq 8(%rbp), %rsi
	call addLongs

	movq $sResultMsg, %rdi
	movq %rax, %rsi
	call printf

	addq $16, %rsp
	popq %rbp
	ret

	.align 16
addLongs:
	movq %rdi, %rax
	addq %rsi, %rax
	ret
