/* shift_example.S */

.section .rodata

sFmt: .string "%08x\n"

.section .text

	.globl main
main:
	subq $8, %rsp

	movq $sFmt, %rdi
	movl $0xFFFF0000, %esi
	sall $1, %esi            /* %esi set to 0xFFFE0000 */
	call printf

	movq $sFmt, %rdi
	movl $0xFFFF0000, %esi
	sarl $1, %esi            /* %esi set to 0xFFFF8000 */
	call printf

	movq $sFmt, %rdi
	movl $0xFFFF0000, %esi
	shrl $1, %esi            /* %esi set to 0x7FFF8000 */
	call printf

	addq $8, %rsp
	ret
