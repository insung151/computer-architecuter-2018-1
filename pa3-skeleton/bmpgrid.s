#---------------------------------------------------------
#
#  Project #3: Drawing grid lines in an image
#
#  April 30, 2018
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#---------------------------------------------------------


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
    pushq   %rbx
    subq    $48, %rsp

    movq    %rsi, %rax
    imulq   %rdx, %rax
    leaq    (%rax,%rax,2), %rax
    addq    %rdi, %rax

    movq    %rsi, %rbx
    andq    $3, %rbx
    movq    %rsi, 8(%rsp)
    movq    %rbx, (%rsp)
    cmpq    $0, %rbx
    je  .L3
.L2:
    subq    $1, 8(%rsp)
.L3:
    movq    $0, %rbx
    movq    $0, 16(%rsp)

    jmp .L23
.L27:
    cmpq    16(%rsp), %rbx
    jne .L25
    jmp .L33
.L26:
    movb    $-1, -1(%rax)
    movb    $0, -2(%rax)
    movb    $0, -3(%rax)
    addq    $1, 24(%rsp)
    leaq    -3(%rax), %rax
    jmp .L24
.L33:
    movl    $0, 24(%rsp)
.L24:
    movq    %rbx, 32(%rsp)
    movq    8(%rsp), %rbx
    cmpq    24(%rsp), %rbx
    movq    32(%rsp), %rbx
    jg  .L26

    addq    %rcx, %rbx
    subq    (%rsp), %rax
    movq    %rbx ,32(%rsp)
    leaq    -1(%rcx), %rbx
    imulq   %rsi, %rbx
    leaq    (%rbx,%rbx,2), %rbx
    subq    %rbx, %rax

    movq    32(%rsp), %rbx
.L25:
    addl    $1, 16(%rsp)
.L23:
    cmpq    16(%rsp), %rdx
    jg  .L27

    movq    $0, %rbx
    movq    $0, 16(%rsp)
    jmp .L28
.L32:
    cmpq    16(%rsp), %rbx  #i, heigh 비교
    jne .L29
    addq    %rcx, %rbx  # 같으면 h += gap
.L29:
    movq    %rdi, %rax
    movq    $0, 24(%rsp)
    jmp .L30
.L31:
    movb    $0, (%rax)
    movb    $0, 1(%rax)
    movb    $-1, 2(%rax)
    movq    %rbx, 32(%rsp)

    leaq    -2(%rcx,%rcx,2), %rbx
    leaq    2(%rax,%rbx), %rax
    addq    %rcx, 24(%rsp)
.L30:
    movq    %rbx, 32(%rsp)
    movq    8(%rsp), %rbx
    cmpq    24(%rsp), %rbx
    movq    32(%rsp), %rbx
    jg  .L31
    leaq    (%rsi,%rsi,2), %rax
    addq    %rax, %rdi
    addl    $1, 16(%rsp)
.L28:
    cmpq    16(%rsp), %rdx  #i, heigh 비교
    jg  .L32
    addq    $48, %rsp
    popq    %rbx

    ret
