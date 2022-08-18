##func_select.s

.data
#.align	8# we want all data to be save in an address that divise with their size.

.section  .rodata
case_5060_first_str: .string "first pstring length: %d, "
case_5060_second_str: .string "second pstring length: %d\n"

case_52_oldChar: .string "old char: %c, "
case_52_newChar: .string "new char: %c, "
case_52_first_str: .string "first string: %s, "
case_52_second_str: .string "second string: %s\n"

case_53_str_len: .string "length: %d, "
case_53_str: .string "string: %s\n"

case_54_str_len: .string "length: %d, "
case_54_str: .string "string: %s\n"

case_55_comp_res: .string "compare result: %d\n"

wrong_option: .string "invalid option!\n"

int_format: .string "%d"
char_format:  .string "%c\n"
 
.jump_table:
    .quad .L0 # case 50/60
    .quad .invalid # case invalid option
    .quad .L2 # case 52
    .quad .L3 # case 53
    .quad .L4 # case 54
    .quad .L5 # case 55

.text
.globl run_func  
.type run_func, @function 
# %rdi - option number   %rsi -&pstr1   %rdx- &pstr2
run_func: 
    # save arguments 
    movq %rdi, %r12 
    movq %rsi, %r13
    movq %rdx, %r14
    # set up jump table
    sub $50, %r12 # compute xi=x-50  
    
    cmpq $0, %r12 # compere xi:5 - case 50/60
    je .L0  # if =, goto L0
    cmpq $10, %r12 # compere xi:5 - case 50/60
    je .L0  # if =, goto L0
    
    
    cmpq $2, %r12 # compere xi:5 - case 52
    je .L2  # if =, goto L2
    
    cmpq $3, %r12 # compere xi:5 - case 53
    je .L3  # if =, goto L3
    
    cmpq $4, %r12 # compere xi:5 - case 54
    je .L4  # if =, goto L4
    
    cmpq $5, %r12 # compere xi:5 - case 55
    je .L5  # if =, goto L5
    
    cmpq $1, %r12 # compere xi:5 - case 51
    je .invalid  # if =, goto invalid
    
    cmpq $6, %r12 # check if option number is more then 55
    jg .invalid
    
    ret
    
.L0 :# case 50/60: pstrlen
    movq $0, %rsi # clean register
    leaq -513(%rbp), %rdi # go to the pointer of first pstring
    call pstrlen # call function 
    movb %al, %sil # get the length in one bit the way we save it
    movq $case_5060_first_str, %rdi  # print it 
    movq $0, %rax
    call printf
    movq $0, %rsi # clean register
    leaq -257(%rbp), %rdi # go to the pointer of second pstring
    call pstrlen # call function 
    movb %al, %sil # get the length in one bit the way we save it
    movq $case_5060_second_str, %rdi   # print it
    movq $0, %rax
    call printf
    ret

    
.L2: # case 52: replaceChar
    movq $char_format, %rdi # scan option in jump table
    leaq -544(%rbp), %rsi
    movq $0, %rax
    call scanf
    #movq -544(%rbp), %r15 # save option number to r15
    ret
   
   


.L3: # case 53: pstrijcpy
    ret
.L4: # case 54: swapCase
    ret
.L5: # case 55: pstrijcmp
    ret
    
.invalid: # case invalid option
    movq $wrong_option, %rdi
    movq $0, %rax
    call printf



