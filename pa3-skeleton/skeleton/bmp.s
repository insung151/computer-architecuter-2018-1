	.file	"bmp.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Error: cannot open file %s.\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Error: not enough memory (size = %d).\n"
	.section	.rodata.str1.1
.LC2:
	.string	"Error: file read error."
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"Error: file \"%s\" is not in BMP format.\n"
	.align 8
.LC4:
	.string	"Error: file size mismatch (header=%d, actual=%d).\n"
	.align 8
.LC5:
	.string	"Error: this BMP header type is not supported %d.\n"
	.align 8
.LC6:
	.string	"Error: color palette is not supported."
	.align 8
.LC7:
	.string	"Error: compressed BMP files are not supported."
	.align 8
.LC8:
	.string	"Error: cannot support %d bits/pixel.\n"
	.align 8
.LC9:
	.string	"BMP file: %s (%d x %d pixels, %d bits/pixel)\n"
	.text
	.globl	bmp_in
	.type	bmp_in, @function
bmp_in:
.LFB57:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %r12
	movl	$0, %esi
	movl	$0, %eax
	call	open
	testl	%eax, %eax
	jns	.L2
	movq	%r12, %rdx
	movl	$.LC0, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-1, %eax
	jmp	.L3
.L2:
	movl	%eax, %ebp
	movl	$2, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	lseek
	movl	%eax, b+16(%rip)
	movl	$0, %edx
	movl	$0, %esi
	movl	%ebp, %edi
	call	lseek
	movl	b+16(%rip), %ebx
	movslq	%ebx, %rdi
	call	malloc
	movq	%rax, b(%rip)
	testq	%rax, %rax
	jne	.L13
	movl	%ebx, %edx
	movl	$.LC1, %esi
	movl	$1, %edi
	call	__printf_chk
	movl	$-2, %eax
	jmp	.L3
.L6:
	subl	%ebx, %edx
	movslq	%edx, %rdx
	movslq	%ebx, %rsi
	addq	b(%rip), %rsi
	movl	%ebp, %edi
	call	read
	testl	%eax, %eax
	jns	.L5
	movl	$.LC2, %edi
	call	puts
	movl	$-3, %eax
	jmp	.L3
.L5:
	addl	%eax, %ebx
	jmp	.L4
.L13:
	movl	$0, %ebx
.L4:
	movl	b+16(%rip), %edx
	cmpl	%edx, %ebx
	jl	.L6
	movq	b(%rip), %rbx
	movzwl	12(%rbx), %eax
	sall	$16, %eax
	movzwl	10(%rbx), %ecx
	orl	%ecx, %eax
	movl	%eax, b+20(%rip)
	cmpw	$19778, (%rbx)
	je	.L7
	movq	%r12, %rdx
	movl	$.LC3, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-4, %eax
	jmp	.L3
.L7:
	movzwl	4(%rbx), %eax
	sall	$16, %eax
	movzwl	2(%rbx), %ecx
	orl	%ecx, %eax
	cmpl	%eax, %edx
	je	.L8
	movl	%edx, %ecx
	movl	%eax, %edx
	movl	$.LC4, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-5, %eax
	jmp	.L3
.L8:
	movl	14(%rbx), %edx
	cmpl	$40, %edx
	je	.L9
	movl	$.LC5, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-6, %eax
	jmp	.L3
.L9:
	cmpl	$0, 46(%rbx)
	je	.L10
	movl	$.LC6, %edi
	call	puts
	movl	$-7, %eax
	jmp	.L3
.L10:
	cmpl	$0, 30(%rbx)
	je	.L11
	movl	$.LC7, %edi
	call	puts
	movl	$-8, %eax
	jmp	.L3
.L11:
	movzwl	28(%rbx), %r9d
	cmpw	$24, %r9w
	je	.L12
	movzwl	%r9w, %edx
	movl	$.LC8, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-9, %eax
	jmp	.L3
.L12:
	movl	18(%rbx), %ecx
	movzwl	%r9w, %r9d
	movl	22(%rbx), %r8d
	movq	%r12, %rdx
	movl	$.LC9, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movslq	b+20(%rip), %rax
	addq	b(%rip), %rax
	movq	%rax, b+8(%rip)
	movslq	18(%rbx), %rax
	movq	%rax, b+24(%rip)
	movslq	22(%rbx), %rax
	movq	%rax, b+32(%rip)
	movl	%ebp, %edi
	call	close
	movl	$0, %eax
.L3:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE57:
	.size	bmp_in, .-bmp_in
	.section	.rodata.str1.1
.LC10:
	.string	"Error: cannot create file %s\n"
.LC11:
	.string	"Error: file write error"
	.text
	.globl	bmp_out
	.type	bmp_out, @function
bmp_out:
.LFB58:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movl	$448, %esi
	call	creat
	testl	%eax, %eax
	jns	.L20
	movq	%rbx, %rdx
	movl	$.LC10, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$-10, %eax
	jmp	.L17
.L19:
	subl	%ebx, %edx
	movslq	%edx, %rdx
	movslq	%ebx, %rsi
	addq	b(%rip), %rsi
	movl	%ebp, %edi
	call	write
	testl	%eax, %eax
	jns	.L18
	movl	$.LC11, %edi
	call	puts
	movl	$-11, %eax
	jmp	.L17
.L18:
	addl	%eax, %ebx
	jmp	.L16
.L20:
	movl	%eax, %ebp
	movl	$0, %ebx
.L16:
	movl	b+16(%rip), %edx
	cmpl	%edx, %ebx
	jl	.L19
	movl	%ebp, %edi
	call	close
	movl	$0, %eax
.L17:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE58:
	.size	bmp_out, .-bmp_out
	.globl	bmp_grid
	.type	bmp_grid, @function
bmp_grid:
.LFB59:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rsi, %rax
	imulq	%rdx, %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax

	movq	%rsi, %r10
	andq	$-4, %r10
	movl	$0, %r11d
	movl	$0, %ebx
	jmp	.L23
.L27:
	cmpq	%r8, %rbx
	jne	.L25
	jmp	.L33
.L26:
	movb	$-1, -1(%rax)
	movb	$0, -2(%rax)
	movb	$0, -3(%rax)
	addl	$1, %r8d
	leaq	-3(%rax), %rax
	jmp	.L24
.L33:
	movl	$0, %r8d
.L24:
	movslq	%r8d, %r9
	cmpq	%r9, %r10
	jg	.L26
	addq	%rcx, %rbx
	leaq	-1(%rcx), %r8
	imulq	%rsi, %r8
	leaq	(%r8,%r8,2), %r8
	subq	%r8, %rax
.L25:
	addl	$1, %r11d
.L23:
	movslq	%r11d, %r8
	cmpq	%r8, %rdx
	jg	.L27
	movl	$0, %r11d
	movl	$0, %ebx
	jmp	.L28
.L32:
	cmpq	%rax, %rbx
	jne	.L29
	addq	%rcx, %rbx
.L29:
	movq	%rdi, %rax
	movl	$0, %r8d
	jmp	.L30
.L31:
	movb	$0, (%rax)
	movb	$0, 1(%rax)
	movb	$-1, 2(%rax)
	leaq	-2(%rcx,%rcx,2), %r9
	leaq	2(%rax,%r9), %rax
	addl	%ecx, %r8d
.L30:
	movslq	%r8d, %r9
	cmpq	%r9, %r10
	jg	.L31
	leaq	(%rsi,%rsi,2), %rax
	addq	%rax, %rdi
	addl	$1, %r11d
.L28:
	movslq	%r11d, %rax
	cmpq	%rax, %rdx
	jg	.L32
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret

	.cfi_endproc
.LFE59:
	.size	bmp_grid, .-bmp_grid
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"Usage: %s bmpfile outfile gap\n"
	.section	.rodata.str1.1
.LC13:
	.string	"Invalid gap %lld.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB60:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rsi, %rbx
	cmpl	$4, %edi
	je	.L36
	movq	(%rsi), %rdx
	movl	$.LC12, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$1, %eax
	jmp	.L37
.L36:
	movq	8(%rsi), %rdi
	call	bmp_in
	testl	%eax, %eax
	js	.L39
	movq	24(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol
	movslq	%eax, %rcx
	movq	%rcx, b+40(%rip)
	testq	%rcx, %rcx
	jg	.L38
	movq	%rcx, %rdx
	movl	$.LC13, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk
	movl	$3, %eax
	jmp	.L37
.L38:
	movq	b+32(%rip), %rdx
	movq	b+24(%rip), %rsi
	movq	b+8(%rip), %rdi
	call	bmp_grid
	movq	16(%rbx), %rdi
	call	bmp_out
	testl	%eax, %eax
	jns	.L40
	movl	$3, %eax
	jmp	.L37
.L39:
	movl	$2, %eax
	jmp	.L37
.L40:
	movl	$0, %eax
.L37:
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE60:
	.size	main, .-main
	.comm	b,48,32
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
