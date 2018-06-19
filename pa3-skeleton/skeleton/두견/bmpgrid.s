.text
    .align 4
.globl bmp_grid
    .type bmp_grid,@function
bmp_grid:
    pushq   %rbx
    subq    $48, %rsp

    leaq    (%rsi,%rsi,2), %rbx #3*width
    andq    $3, %rbx  #3*width & 3
    movq    $0, (%rsp)
    je  .L23
    movq    $4, %rax
    subq    %rbx, %rax
    movq    %rax, (%rsp)


.L23:
    leaq    (%rsi,%rsi,2), %rbx # 3*width
    addq    (%rsp), %rbx # 3*w + pad
    imulq   %rdx, %rbx
    addq    %rdi, %rax
    movq    $0, 16(%rsp)
    movq    $0, %rbx

    jmp .L24
.L28:
    cmpq    16(%rsp), %rbx
    jne .L25
    subq    (%rsp), %rax
    movl    $0, 24(%rsp)
    jmp .L26
.L27:
    movb    $-1, -1(%rax)
    movb    $0, -2(%rax)
    movb    $0, -3(%rax)
    addq    $1, (%rsp)
    leaq    -3(%rax), %rax
.L26:
    cmpq    24(%rsp), %rsi
    jg  .L27

    addq    %rcx, %rbx

    movq    %rbx, 32(%rsp)
    movq    %rcx, %rbx
    subq    $1, %rbx #gap - 1
    movq    %rax, 8(%rsp)
    movq    %rsi, %rax  #width
    imulq   $3, %rax #3*width
    addq    (%rsp), %rax #3*width + padding
    imulq   %rax, %rbx # (3*width + padding) * (gap-1)
    movq    8(%rsp), %rax
    subq    %rbx, %rax
    movq    32(%rsp), %rbx

    # addq    %rcx, %r12
    # leaq    -1(%rcx), %r8
    # movq    %rsi, %r9
    # imulq   %r8, %r9
    # leaq    (%r9,%r9,2), %r9
    # imulq   %rbp, %r8
    # addq    %r9, %r8
    # subq    %r8, %rax

.L25:
    addl    $1, 16(%rsp)
.L24:
    cmpq    16(%rsp), %rdx
    jg  .L28
    addq    $48, %rsp
    popq    %rbx
    ret

#     movl    $0, %r10d
#     movl    $0, %ebx
#     jmp .L29
# .L33:
#     cmpq    %rax, %rbx
#     jne .L30
#     addq    %rcx, %rbx
# .L30:
#     movq    %rdi, %rax
#     movl    $0, %r8d
#     jmp .L31
# .L32:
#     movb    $0, (%rax)
#     movb    $0, 1(%rax)
#     movb    $-1, 2(%rax)
#     leaq    -2(%rcx,%rcx,2), %r9
#     leaq    2(%rax,%r9), %rax
#     addl    %ecx, %r8d
# .L31:
#     movslq  %r8d, %r9
#     cmpq    %r9, %rsi
#     jg  .L32
#     addq    %r11, %rdi
#     addl    $1, %r10d
# .L29:
#     movslq  %r10d, %rax
#     cmpq    %rax, %rdx
#     jg  .L33
#     popq    %rbx
#     ret