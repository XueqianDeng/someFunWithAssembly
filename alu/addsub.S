/* addsub.S */
.section .rodata
sPrompt: .string "Enter an integer value: "
sInputFmt: .string "%u"
sFmt: .string "Result is %u\n"

.section .data
val: .space 4

.section .text
	.globl main
main:
	subq $8, %rsp

	movq $sPrompt, %rdi
	call printf

	movq $sInputFmt, %rdi
	movq $val, %rsi
	call scanf

	addl $10, val
	subl $2, val

	movq $sFmt, %rdi
	movl val, %esi
	call printf

	addq $8, %rsp

	ret
