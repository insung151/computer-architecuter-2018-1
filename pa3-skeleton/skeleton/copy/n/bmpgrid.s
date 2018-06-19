.text
    .align 4
.globl bmp_grid
    .type bmp_grid,@function

bmp_grid:
    #------------------------------------------------------------
    # Use %rax, %rbx, %rcx, %rdx, %rsi, and %rdi registers only
    #   imgptr is in %rdi
    #   width  is in %rsi
    #   height is in %rdx
    #   gap    is in %rcx
    #------------------------------------------------------------

    # --> FILL HERE <--
    pushq %rbx
    subq $40, %rsp
    movq    %rsi, %rbx
    imulq   $3, %rsi # width * 3
    andq    $3, %rsi # and 3
    movq    $0, %rax
    cmpq    $0, %rsi
    je      .L22
.L20:
    movq    $4, %rax
    subq    %rsi, %rax
.L22:
    movq    $0, 16(%rsp)
    movq    $0, 24(%rsp)
    movq    $0, 32(%rsp)
    movq    %rbx, %rsi
    subq    $1, %rdx
    imulq   $3, %rbx
    addq    %rbx, %rax
    movq    %rax, 8(%rsp)
    imulq   %rdx, %rax
    addq    %rax, %rdi
    movq    %rdi, (%rsp)
    jmp .L24
.L23:
    movq    $0, 24(%rsp)
    movq    (%rsp), %rdi
    movq    8(%rsp), %rax
    addq    %rcx, 16(%rsp)
    imulq   16(%rsp), %rax
    subq    %rax, %rdi
    cmpq    %rdx, 16(%rsp)
    jg  .L21
    jmp  .L24
.L29:
    addq    %rcx, 24(%rsp)
    movq    %rcx, %rbx
    imulq   $3, %rbx
    addq    %rbx, %rdi
    cmpq    %rsi, 24(%rsp)
    jge  .L27
.L24:
    movb    $0, (%rdi)
    movb    $0, 1(%rdi)
    movb    $255, 2(%rdi)
    cmpq    $0, 32(%rsp)
    jl  .L29
.L28:
    addq    $1, 24(%rsp)
    addq    $3, %rdi
    cmpq    %rsi, 24(%rsp)
    jge  .L23
    jmp  .L24
.L21:
    movq    $0, 16(%rsp)
    movq    $0, 24(%rsp)
    movq    $0, 32(%rsp)
    subq    $1, 32(%rsp)
    movq    (%rsp), %rdi
    jmp     .L24
.L27:
    movq    $0, 24(%rsp)
    movq    (%rsp), %rdi
    addq    $1, 16(%rsp)
    movq    8(%rsp), %rax
    imulq   16(%rsp), %rax
    subq    %rax, %rdi
    cmpq    16(%rsp),%rdx
    jge  .L24
    addq    $40, %rsp
    popq    %rbx
    #------------------------------------------------------------
    ret
