/* leaq_example.S */
.section .rodata
sFmt: .string "Result is: %lu\n"

.section .text
	.globl main
main:
	subq $8, %rsp
	movl $0, %eax
	movq $sFmt, %rdi
	movq $1000, %r10
	movq $3, %r11
	leaq 15(%r10,%r11,8), %rsi
	call printf
	addq $8, %rsp
	ret
