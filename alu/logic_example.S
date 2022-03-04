/* logic_example.S */

.section .rodata

sFmt: .string "%02x\n"

.section .text

	.globl main
main:
	subq $8, %rsp

	/* start by completely clearing %rax */
	movq $0, %rax

	/* Note: 0x30 = 00110000b,
	         0x50 = 01010000b */
	movb $0x30, %al; movb $0x50, %bl
	andb %bl, %al      /* set %al=0x10 (00010000b) */
	movq $sFmt, %rdi
	movq %rax, %rsi
	movl $0, %eax
	call printf

	movb $0x30, %al; movb $0x50, %bl
	orb %bl, %al       /* set %al=0x70 (01110000b) */
	movq $sFmt, %rdi
	movq %rax, %rsi
	movl $0, %eax
	call printf

	movb $0x30, %al; movb $0x50, %bl
	xorb %bl, %al      /* set %al=0x60 (01100000b) */
	movq $sFmt, %rdi
	movq %rax, %rsi
	movl $0, %eax
	call printf

	movb $0x30, %al
	notb %al           /* set %al=0xCF (11001111b) */
	movq $sFmt, %rdi
	movq %rax, %rsi
	movl $0, %eax
	call printf

	addq $8, %rsp
	ret

/*
vim:ft=gas:
*/
