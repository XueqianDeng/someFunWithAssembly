/* fib.S */

#define N 9

.section .rodata
sResultMsg: .string "fib(%u) = %u\n"

.section .text
	.globl main
main:
	subq $8, %rsp

	movl $1, %ecx      /* %ecx is the loop counter */
	movl $0, %r10d     /* %r10d stores fib(n-1) */
	movl $1, %r11d     /* %r11d stores fib(n) */

	jmp .LtestCond

.LloopTop:
	movl %r11d, %r9d
	addl %r10d, %r11d
	movl %r9d, %r10d
	inc %ecx

.LtestCond:
	cmpl $N, %ecx
	jl .LloopTop

	movl $0, %eax
	movq $sResultMsg, %rdi
	movl $N, %esi
	movl %r11d, %edx
	call printf

	addq $8, %rsp
	ret

/*
vim:ft=gas:
*/
