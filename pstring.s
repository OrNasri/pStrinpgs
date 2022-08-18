## pstring.s


.data
.section  .rodata
str_format: .string "%s\n"
invalid_str: .string "invalid input!\n"

.text
.globl pstrlen,replaceChar, pstrijcpy, swapCase, pstrijcmp


.type pstrlen @function # get pstring and return it length
pstrlen:
# %rdi = *pstr
  movzbq  (%rdi), %rax # get length of pstring from the first byte
  ret

.type replaceChar @function # replace all old char in new char and return the new pstring
replaceChar:
# %rdi = *pstr, %rsi = old char, %rdx = new char
 mov %rbx, %rdi #save pointer of pstring
 addq $1, %rbx # we want the string withour the length
 movq %rsi, %r15 # save old char
 movq %rdx, %r14 # save new char
 movzbq (%rdi), %r13 # length of string

.for_loop:
 movq $0, %r12 # intialize i=0
 cmp %r12, %r13 # compere i:len
 jl .replace

.replace:
  movzbq (%rbx), %r10 # current char in string
  cmp %r10, %r15 # compere old char:current char
  jnz .not_equal_char
  mov %r14b, (%rbx) # replace current char in the new char

.not_equal_char:
  addq $1, %r12 # i++
  incq %rbx # move to next char in the string
  cmp %r12, %r13 # compere i:len
  jl .replace

 movq %rbp, %rax # change return value to the new string
 ret


.type pstrijcpy @function # copy sub from pstring1 to pstring2

pstrijcpy:
ret