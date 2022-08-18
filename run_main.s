##run_main.s

.section .rodata
format_size:     .string "%d"
format_print_size: .string "The size is %d\n"
format_string:     .string "%s\n"


.text
.globl run_main
.type run_main, @function
run_main:
    movq %rsp, %rbp # for correct debugging
    pushq %rbp # intilaize stack pointer
    movq %rsp, %rbp
    subq $544, %rsp # allocate memory in stack to input

     # size of first string
    movq $format_size, %rdi # scan size of first string
    leaq -544(%rbp), %rsi # get size of string from input
    movq $0, %rax
    call scanf
    movzbq -544(%rbp), %rbx # save size of string to stack
    movb %bl, -513(%rbp)

#printing
    movb %bl, %sil
    movq $format_print_size, %rdi
    movq $0, %rax
    call printf

    # first string
    movq $format_string, %rdi # scan first string
    leaq -512(%rbp), %rsi #get size of string from input
    movq $0, %rax
    call scanf
#printing
    movq -512(%rbp), %rsi
    movq $format_print_size, %rdi
    movq $0, %rax
    call printf

    #size of second string
    movq $format_size, %rdi # scan size of second string
    leaq -544(%rbp), %rsi # get size of string from input
    movq $0, %rax
    call scanf
    movzbq -544(%rbp), %rbx # save size of string to stack
    movb %bl, -257(%rbp)



    # second string
   movq $format_string, %rdi # scan first string
   leaq -256(%rbp), %rsi #get size of string from input
   movq $0, %rax
   call scanf
    #printing
    movq -256(%rbp), %rsi
    movq $format_string, %rdi
    movq $0, %rax
    call printf


    # get option
    movq $format_size, %rdi # scan option in jump table
    leaq -544(%rbp), %rsi
    movq $0, %rax
    call scanf
    movq -544(%rbp), %r15 # save option number to r15


    movq %r15, %rdi  # save option number to register
    leaq -513(%rbp), %rsi
    leaq -257(%rbp), %rdx
    call run_func




    # finish
    xorq %rax, %rax
    pop %r15
    addq $544, %rsp
    movq %rbp, %rsp
    popq %rbp



    ret

