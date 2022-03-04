/* weighted_avg.S */

.section .rodata

sWeightPrompt: .string "Enter weight (0 when done): "
sValuePrompt: .string "Enter value: "
sInputFmt: .string "%ld"
sResultMsg: .string "Weighted average is %ld\n"

.section .bss

	/*
	 * Global variables: because these are in the .bss section,
	 * they are automatically initialized to 0
	 */
valueIn: .space 8
weightIn: .space 8
sum: .space 8
weightSum: .space 8

.section .text

	.globl main
main:
	subq $8, %rsp

.LinputLoop:
	/* read weight */
	movl $0, %eax
	movq $sWeightPrompt, %rdi
	call printf
	movl $0, %eax
	movq $sInputFmt, %rdi
	movq $weightIn, %rsi
	call scanf

	/* if weight is 0, we're done */
	cmpq $0, weightIn
	jz .LdoneWithInput

	/* read value */
	movl $0, %eax
	movq $sValuePrompt, %rdi
	call printf
	movl $0, %eax
	movq $sInputFmt, %rdi
	movq $valueIn, %rsi
	call scanf

	/* multiply value by weight, add to sum */
	movq weightIn, %r10
	movq valueIn, %r11
	imulq %r10, %r11
	addq %r11, sum

	/* add weight to sum of weights */
	movq weightIn, %r10
	addq %r10, weightSum

	jmp .LinputLoop

.LdoneWithInput:
	/* divide sum by sum of weights */
	movq $0, %rdx
	movq sum, %rax
	divq weightSum            /* quotient will be stored in %rax */

	/* print result */
	movq %rax, %rsi
	movl $0, %eax
	movq $sResultMsg, %rdi
	call printf

	addq $8, %rsp
	ret

/*
vim:ft=gas:
*/
