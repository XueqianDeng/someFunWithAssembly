/* vote.S */

.section .rodata
sAgePrompt: .string "What is your age? "
sInputFmt: .string "%d"
sCanVoteMsg: .string "You can vote, yay!\n"
sCannotVoteMsg: .string "You're not old enough to vote yet\n"

.section .bss
age: .space 4

.section .text

	.globl main
main:
	subq $8, %rsp

	movl $0, %eax
	movq $sAgePrompt, %rdi
	call printf

	movl $0, %eax
	movq $sInputFmt, %rdi
	movq $age, %rsi
	call scanf

	cmpl $18, age
	jl .LtooYoungToVote
	movq $sCanVoteMsg, %rdi
	jmp .LprintMsg

.LtooYoungToVote:
	movq $sCannotVoteMsg, %rdi

.LprintMsg:
	movl $0, %eax
	call printf

	addq $8, %rsp
	ret

/*
vim:ft=gas:
*/
