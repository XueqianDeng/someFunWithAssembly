/* addsub.S */
.section .rodata
sPrompt: .string "Enter an integer value: "
sInputFmt: .string "%u"
sFmt: .string "Result is %u\n"
.section .data
val: .space 4 <- global variable
.section .text
.globl main
main:
subq $8, %rsp
movl $0, %eax
movq $sPrompt, %rdi
call printf
movl $0, %eax
movq $sInputFmt, %rdi
movq $val, %rsi
call scanf
addl $10, val
subl $2, val
movl $0, %eax
movq $sFmt, %rdi
movl val, %esi
call printf
addq $8, %rsp
ret
