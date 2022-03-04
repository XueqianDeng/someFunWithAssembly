/* Assembly language implementation of hexdump functions */

	.section .rodata
hex_tablet: .string "0123456789abcdef"
	/* TODO: add read-only data such as strings here */

	.section .text
	
	

	
/*
 * Write given nul-terminated string to standard output.
 * Parameters:
 *  s (%rdi) - pointer to the s string to be the stdin output.
 */
	.globl hex_write_string
hex_write_string:
	pushq %rbx
	movq %rdi, %rbx /* move string address to rbx before calling strLen */
	call strLen
	movq %rax, %rdx /* move string length to rdx (3rd argument) */
	movq %rbx, %rsi /* move string address to rsi (2nd argument) */
	movq $1, %rdi /* move 1 (indicating stdout) to rdi (1st argument) */
	call write
	popq %rbx
	ret


/*
 * This function is to read in from the standard in to the data buffer.
 * Parameters:
 *  data_buf (%rdi) - pointer to the data_buf string to keep the stdin input.
 * Returns:
 *  actual bytes that read in. 
 */
	.globl hex_read
hex_read:
	pushq %rbx
	pushq %r12
	pushq %r13

	movq %rdi, %rbx /* move address of data_buf to rbx */
	movq $0, %r12 /* store total number of bytes read */
	movq $0, %r13 /* store number of new bytes read */

.Lread_loop:
	movq $0, %rdi /* indicate stdin as 1st argument*/
	movq %rbx, %rsi /* address of string buffer as 2nd argument */
	addq %r12, %rsi /* make sure new input is read in at right position */
	movq $16, %rdx /* read at most 16 bytes */
	subq %r12, %rdx /* subtract number of byte already read */
	call read 
	movq %rax, %r13 /* keep track of number of new bytes read */
	addq %r13, %r12 /* keep track of total number of bytes read */
	cmpq $0, %r13 /* check if read any new byte at all */
	jz .Lread_out
	cmpq $16, %r12 /* check if read 16 bytes */
	jz .Lread_out
	jmp .Lread_loop
.Lread_out:
	movq %r12, %rax /* set return value */
	popq %r13
	popq %r12
	popq %rbx
	
	ret

/*
 * Format a long value as an offset string consisting of exactly 8
 * hex digits.  The formatted offset is stored in sbuf, which must
 * have enough room for a string of length 8.
 * Parameters:
 *  offset (%rdi) - the number to offset the string.
 *  sbuf (%rsi) - the pointer for keeping the string. 
 */
	.globl hex_format_offset
hex_format_offset:
	pushq %rbx /* push rbx to stack */
	movq %rdi, %rbx /* move offset value to rbx */
	movq $hex_tablet, %r11 /* move hex_tablet to r11 register */
	movl $8, %r10d /* keep track of sbuf index and zero upper bits as well*/
	movb $0, (%rsi, %r10) /* move null terminator to sbuf at index 8 */
	decb %r10b /* decrement to index 7 */
.Lformat_offset_loop:
	cmpb $0, %r10b /* check loop condition */
	jl .Lformat_offset_out /* if formatting is complete, quit loop */
	movq %rbx, %rdi /* move the offset to rdi */
	andb $15, %dil /* and the lower 8 bits of rdi */
	xorq %rdx, %rdx /* clear rdx */
	movb %dil, %dl /* move the result of and to lower 8 bits of rdx */
	movb (%r11, %rdx), %cl /* move the hex char val to cl */
	movb %cl, (%rsi, %r10) /* move hex char val to corresponding position in sbuf */
	shrq $4, %rbx /* discard the rightmost 4 bits by rightshifting */
	decb %r10b /* decrement index */
	jmp .Lformat_offset_loop
.Lformat_offset_out:
	popq %rbx
	ret

/*
 * Format a byte value (in the range 0-255) as string consisting
 * of two hex digits.  The string is stored in sbuf.
 * Parameters:
 *  byteval (%rdi) - the byte value to be translated. 
 *  sbuf (%rsi) - the pointer to the string. 
 */
	.globl hex_format_byte_as_hex
hex_format_byte_as_hex:
	subq $8, %rsp	/* align stack pointer */
	movq %rdi, %r10 /* Move byteval in rdi register to r10 */
	andq $15, %r10  /* Perform bitwise operation &1111 on r10 register */
	/* increment rsi so that it now has the address of second element in array */
	inc %rsi 
	movq $hex_tablet, %r11 /* store the address of hex_tablet into r11 */
	movb (%r11,%r10), %cl /* put the char value at address (%r10 + %r11) into %cl register */
	movb %cl, (%rsi) /* set the second element of the array (rsi reference) to the char value */
	movq %rdi, %r10 /* Move byteval in rdi register to r10 */
	/* we move the rightmost 4 bits out and retain the leftmost 4 bits, by rightshifting by 4 */
	shrq $4, %r10 
	andq $15, %r10 /* Perform bitwise operation &1111 on r10 register */
	subq $1, %rsi /* decrement by 1 so that rsi has the address of the first element in array */
	movb (%r11,%r10), %cl /* put the char value at address (%r10 + %r11) into %cl register */
	movb %cl, (%rsi) /* set the first element of the array (rsi reference) to the char value */
	movb $0, 2(%rsi) /* set null terminator in array at index 2*/
	addq $8, %rsp /* align stack pointer */
	ret

/*
 * Convert a byte value (in the range 0-255) to a printable character
 * value.  If byteval is already a printable character, it is returned
 * unmodified.  If byteval is not a printable character, then the
 * ASCII code for '.' should be returned.
 *  byteval (%rdi) - the byte value to be translated. 
 */
	.globl hex_to_printable
hex_to_printable:
	subq $8, %rsp /* adjust stack pointer */
	/* check if byteval (passed in edi) is smaller than 0x20 (smallest printable ascii val) */
	cmpl $32, %edi 
	movl $46, %r10d /* put the ascii val of dot (46) to r10d */
	cmovl %r10d,  %edi /* conditionally (if byteval < 0x20), store 46 in edi */
	cmpl $126, %edi /* check if byteval is greater than 0x7E (largest printable ascii val)*/
	cmovg %r10d, %edi /* conditionally (if byteval > 0x7E), store 46 in edi */
	/* move the ascii val in edi to eax as return value (if byteval is within printable range, leave unchanged; otherwise, 46) */
	movl %edi, %eax 
	addq $8, %rsp /* adjust stack pointer back*/
	ret
    

/* vim:ft=gas:
 */

	/*
 * Determine the length of specified character string.
 *
 * Parameters:
 *   s - pointer to a NUL-terminated character string
 *
 * Returns:
 *    number of characters in the string
 */
	.globl strLen
strLen:
	subq $8, %rsp                 /* adjust stack pointer */
	movq $0, %r10                 /* initial count is 0 */

.LstrLenLoop:
	cmpb $0, (%rdi)               /* found NUL terminator? */
	jz .LstrLenDone               /* if so, done */
	inc %r10                      /* increment count */
	inc %rdi                      /* advance to next character */
	jmp .LstrLenLoop              /* continue loop */

.LstrLenDone:
	movq %r10, %rax               /* return count */
	addq $8, %rsp                 /* restore stack pointer */
	ret
