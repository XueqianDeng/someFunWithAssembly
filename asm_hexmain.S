/* Hexdump main function, assembly language version */
	.section .rodata
colon_format: .string ": "
space: .string " "
newline: .string "\n"
	.section .text

	.globl main
main:
	pushq %r12 /* counter */
	pushq %r13 /* offset_counter */
	pushq %rbx /* position */
	pushq %rbp 
	subq $40, %rsp /* allocate space for char arrays, and align */
	movq %rsp, %rbp /* keep track of local variable address on stack */
	/* 
	char offset_keeper[16]: 0(%rbp)
	char data_buffer[17]: 17(%rbp)
	char byte_val_keeper[2]: 34(%rbp)
	*/
	movq $0, %r12 /* set counter to 0 */
	movq $0, %r13 /* set offset_counter to 0 */

.Lmain_top:
	leaq 17(%rbp), %r10 /* get addr. of data_buffer */
	movq %r10, %rdi /* set data_buffer as 1st argument */
	call hex_read /* read into data_buffer 17(%rbp) */
	movb %al, %r12b /* update number of chars read */
	cmpb $0, %r12b /* check if read any */
	jz .Lmain_out /* break if didn't read any */
	movq %rbp, %rsi /* set addr. of offset_keeper as 2st arg. to format offset */
	movq %r13, %rdi /* set 1st arg. to value of offset_counter */
	call hex_format_offset
	movq %rbp, %rdi /* set addr. of offset_keeper as 1st arg. to hex write */
	call hex_write_string
	movq $colon_format, %rdi /* print colon and a space */
	call hex_write_string

	movq $0, %rbx /* set position to 0 */
.Lmain_print_byte:
	cmpl %r12d, %ebx /* check if position < counter */
	jge .Lmain_align_output /* jump out if not smaller */
	leaq 17(%rbp), %r10 /* move addr. of data_buffer to r10 */
	xorq %rdi, %rdi /* clear %rdi */
	movb (%r10, %rbx), %dil /* access ascii val at index %rbx and set as arg.*/
	leaq 34(%rbp), %rsi /* set addr. of byte_val_keeper as 2nd arg. to format byte*/
	call hex_format_byte_as_hex
	leaq 34(%rbp), %rdi /* set addr. of byte_val_keeper as arg. to hex write */
	call hex_write_string
	movq $space, %rdi /* set addr. of space as arg to hex write*/
	call hex_write_string
	inc %rbx
	jmp .Lmain_print_byte
.Lmain_align_output:  /* to make up space if there are less than 16 bytes to write */
	cmpl $16, %ebx
	jge .Lmain_align_output_out
	movq $space, %rdi/* set addr. of space as arg to write */
	call hex_write_string
	movq $space, %rdi /* set addr. of space as arg to write */
	call hex_write_string
	movq $space, %rdi /* set addr. of space as arg to write */
	call hex_write_string
	inc %rbx
	jmp .Lmain_align_output
.Lmain_align_output_out:
	movq $space, %rdi /* set addr. of space as arg to write */
	call hex_write_string
	movq $0, %rbx /* use rbx to keep track of next loop's count */
.Lmain_to_printable:
	cmpl %r12d, %ebx
	jge .Lmain_print_char
	leaq 17(%rbp), %r10 /* get addr. of data_buffer */
	xorq %rdi, %rdi /* clear %rdi */
	movb (%r10, %rbx), %dil /* get ascci val and set as arg. */
	call hex_to_printable /* convert to printable */
	leaq 17(%rbp), %r10 /* get addr. of data_buffer */
	movb %al, (%r10, %rbx) /* set corresponding pos to printable val */
	inc %rbx
	jmp .Lmain_to_printable
.Lmain_print_char:
	leaq 17(%rbp, %r12), %r10 /* get addr. of end of data_buffer */
	movb $0, (%r10) /* null terminate */
	leaq 17(%rbp), %rdi /* set addr. of data_buffer as arg to hex write */
	call hex_write_string
	movq $newline, %rdi /* set newline ascii val as arg. */
	call hex_write_string
	addq $16, %r13 /* update offset_counter */
	
	cmpl $16, %r12d /* continue if prev count is 16 */
	je .Lmain_top



.Lmain_out:
	addq $40, %rsp /* deallocate */
	popq %rbp
	popq %rbx
	popq %r13
	popq %r12
	movq $0, %rax /* return 0 */
	ret

/* vim:ft=gas:
 */
