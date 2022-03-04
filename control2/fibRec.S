/* fibRec.S */

#define N 9

	.section .rodata

sResultMsg: .string "fib(%u) = %u\n"

	.section .text

	.globl main
main:
	subq $8, %rsp                 /* align stack */
	movl $N, %edi                 /* pass N to fib */
	call fib                      /* compute fib(N) */
	mov %eax, %edx                /* pass computed fib(N) to printf */
	movl $0, %eax                 /* no vector args to printf */
	movq $sResultMsg, %rdi        /* pass printf format string */
	movl $N, %esi                 /* pass N */
	call printf                   /* call printf */
	addq $8, %rsp                 /* restore stack */
	movl $0, %eax                 /* return 0 from main */
	ret

fib:
	cmpl $2, %edi                 /* check base case */
	jae .LrecursiveCase           /* if n>=2, do recursive case */
	movl %edi, %eax               /* base case, just return n */
	ret
.LrecursiveCase:
	/* recursive case */
	pushq %r12                    /* preserve value of %r12 */
	movl %edi, %r12d              /* save n in %r12 */
	subl $2, %edi                 /* compute n-2 */
	call fib                      /* compute fib(n-2) */
	movl %r12d, %edi              /* put saved n in %edi */
	subl $1, %edi                 /* compute n-1 */
	movl %eax, %r12d              /* save fib(n-2) in %r12 */
	call fib                      /* compute fib(n-1) */
	addl %r12d, %eax              /* return fib(n-2)+fib(n-1) */
	popq %r12                     /* restore value of %r12 */
	ret                           /* done */

/*
vim:ft=gas:
*/
