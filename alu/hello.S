/* hello.S */

.section .rodata

sHelloMsg: .string "Hello, world\n"

.section .text

	.globl main
main:
	subq $8, %rsp
	movl $0, %eax
	movq $sHelloMsg, %rdi
	call printf

	addq $8, %rsp
	ret
