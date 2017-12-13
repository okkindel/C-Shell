	.file	"hajduk_shell.c"
	.globl	builted_commands
	.section	.rodata
.LC0:
	.string	"move"
.LC1:
	.string	"wheremi"
.LC2:
	.string	"close"
.LC3:
	.string	"help"
	.data
	.align 32
	.type	builted_commands, @object
	.size	builted_commands, 32
builted_commands:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.globl	builted_method
	.align 32
	.type	builted_method, @object
	.size	builted_method, 32
builted_method:
	.quad	hsh_cd
	.quad	hsh_dir
	.quad	hsh_exit
	.quad	hsh_help
	.text
	.globl	number_commands_builted
	.type	number_commands_builted, @function
number_commands_builted:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$4, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	number_commands_builted, .-number_commands_builted
	.section	.rodata
	.align 8
.LC4:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: GIVE ME DIRECTORY RETARTED ._.\033[0m\n"
.LC5:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m"
	.text
	.globl	hsh_cd
	.type	hsh_cd, @function
hsh_cd:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L4
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$62, %edx
	movl	$1, %esi
	movl	$.LC4, %edi
	call	fwrite
	jmp	.L5
.L4:
	movq	-8(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	chdir
	testl	%eax, %eax
	je	.L5
	movl	$.LC5, %edi
	call	perror
.L5:
	movl	$1, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	hsh_cd, .-hsh_cd
	.section	.rodata
	.align 8
.LC6:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: CURRENT DIRECTORY: %s\033[0m\n"
	.align 8
.LC7:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: ERROR... ._."
	.text
	.globl	hsh_dir
	.type	hsh_dir, @function
hsh_dir:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$288, %rsp
	movq	%rdi, -280(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-272(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	getcwd
	testq	%rax, %rax
	je	.L8
	movq	stdout(%rip), %rax
	leaq	-272(%rbp), %rdx
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	jmp	.L9
.L8:
	movl	$.LC7, %edi
	call	perror
.L9:
	nop
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L10
	call	__stack_chk_fail
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	hsh_dir, .-hsh_dir
	.globl	hsh_exit
	.type	hsh_exit, @function
hsh_exit:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	hsh_exit, .-hsh_exit
	.section	.rodata
.LC8:
	.string	"\033[1mMaciej Hajduk's SHELL"
.LC9:
	.string	"Builted commands:\033[0m"
.LC10:
	.string	" %s\n"
	.text
	.globl	hsh_help
	.type	hsh_help, @function
hsh_help:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$.LC8, %edi
	call	puts
	movl	$.LC9, %edi
	call	puts
	movl	$0, -4(%rbp)
	jmp	.L14
.L15:
	movl	-4(%rbp), %eax
	cltq
	movq	builted_commands(,%rax,8), %rax
	movq	%rax, %rsi
	movl	$.LC10, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L14:
	movl	$0, %eax
	call	number_commands_builted
	cmpl	-4(%rbp), %eax
	jg	.L15
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	hsh_help, .-hsh_help
	.section	.rodata
.LC11:
	.string	"r"
.LC12:
	.string	"w+"
	.align 8
.LC13:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: PROCESS CREATED WITH PID: \033[1m\033[31m%d\033[0m\n"
	.text
	.globl	hsh_launch
	.type	hsh_launch, @function
hsh_launch:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movl	%edx, -64(%rbp)
	movl	%ecx, -68(%rbp)
	movl	%r8d, -72(%rbp)
	movq	%r9, -80(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	fork
	movl	%eax, -16(%rbp)
	cmpl	$0, -16(%rbp)
	jne	.L17
	cmpl	$0, -64(%rbp)
	je	.L18
	movq	stdin(%rip), %rdx
	movq	-80(%rbp), %rax
	movl	$.LC11, %esi
	movq	%rax, %rdi
	call	freopen
.L18:
	cmpl	$0, -68(%rbp)
	je	.L19
	movq	stdout(%rip), %rdx
	movq	-88(%rbp), %rax
	movl	$.LC12, %esi
	movq	%rax, %rdi
	call	freopen
.L19:
	cmpl	$0, -72(%rbp)
	je	.L20
	movq	stderr(%rip), %rdx
	movq	-88(%rbp), %rax
	movl	$.LC12, %esi
	movq	%rax, %rdi
	call	freopen
.L20:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execvp
	cmpl	$-1, %eax
	jne	.L21
	movl	$.LC5, %edi
	call	perror
.L21:
	movl	$1, %edi
	call	exit
.L17:
	cmpl	$0, -16(%rbp)
	jns	.L22
	movl	$.LC5, %edi
	call	perror
	jmp	.L23
.L22:
	cmpl	$0, -60(%rbp)
	jne	.L24
.L26:
	leaq	-20(%rbp), %rcx
	movl	-16(%rbp), %eax
	movl	$2, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	waitpid
	movl	%eax, -12(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	andl	$127, %eax
	testl	%eax, %eax
	je	.L23
	movl	-20(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	andl	$127, %eax
	addl	$1, %eax
	sarb	%al
	testb	%al, %al
	jle	.L26
	jmp	.L23
.L24:
	movl	-16(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC13, %edi
	movl	$0, %eax
	call	printf
.L23:
	movl	$1, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L28
	call	__stack_chk_fail
.L28:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	hsh_launch, .-hsh_launch
	.globl	hsh_executive
	.type	hsh_executive, @function
hsh_executive:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movl	%r8d, -40(%rbp)
	movq	%r9, -48(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L30
	movl	$1, %eax
	jmp	.L31
.L30:
	movl	$0, -4(%rbp)
	jmp	.L32
.L34:
	movl	-4(%rbp), %eax
	cltq
	movq	builted_commands(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L33
	movl	-4(%rbp), %eax
	cltq
	movq	builted_method(,%rax,8), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
	jmp	.L31
.L33:
	addl	$1, -4(%rbp)
.L32:
	movl	$0, %eax
	call	number_commands_builted
	cmpl	-4(%rbp), %eax
	jg	.L34
	movq	-48(%rbp), %r8
	movl	-40(%rbp), %edi
	movl	-36(%rbp), %ecx
	movl	-32(%rbp), %edx
	movl	-28(%rbp), %esi
	movq	-24(%rbp), %rax
	subq	$8, %rsp
	pushq	16(%rbp)
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	hsh_launch
	addq	$16, %rsp
.L31:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	hsh_executive, .-hsh_executive
	.section	.rodata
.LC14:
	.string	"|"
	.text
	.globl	hsh_pipe_handler
	.type	hsh_pipe_handler, @function
hsh_pipe_handler:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$2144, %rsp
	movq	%rdi, -2136(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -2124(%rbp)
	movl	$0, -2120(%rbp)
	movl	$0, -2116(%rbp)
	movl	$0, -2112(%rbp)
	movl	$0, -2108(%rbp)
	movl	$0, -2104(%rbp)
	jmp	.L36
.L38:
	movl	-2104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L37
	addl	$1, -2124(%rbp)
.L37:
	addl	$1, -2104(%rbp)
.L36:
	movl	-2104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L38
	addl	$1, -2124(%rbp)
	jmp	.L39
.L64:
	movl	$0, -2108(%rbp)
	jmp	.L40
.L43:
	movl	-2112(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-2108(%rbp), %eax
	cltq
	movq	%rdx, -2064(%rbp,%rax,8)
	addl	$1, -2112(%rbp)
	movl	-2112(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L41
	movl	$1, -2120(%rbp)
	addl	$1, -2108(%rbp)
	jmp	.L42
.L41:
	addl	$1, -2108(%rbp)
.L40:
	movl	-2112(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L43
.L42:
	movl	-2108(%rbp), %eax
	cltq
	movq	$0, -2064(%rbp,%rax,8)
	addl	$1, -2112(%rbp)
	movl	-2116(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L44
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	pipe
	jmp	.L45
.L44:
	leaq	-2080(%rbp), %rax
	movq	%rax, %rdi
	call	pipe
.L45:
	call	fork
	movl	%eax, -2100(%rbp)
	cmpl	$-1, -2100(%rbp)
	jne	.L46
	movl	-2124(%rbp), %eax
	subl	$1, %eax
	cmpl	-2116(%rbp), %eax
	je	.L47
	movl	-2116(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L48
	movl	-2092(%rbp), %eax
	movl	%eax, %edi
	call	close
	jmp	.L47
.L48:
	movl	-2076(%rbp), %eax
	movl	%eax, %edi
	call	close
.L47:
	movl	$.LC5, %edi
	call	perror
	jmp	.L35
.L46:
	cmpl	$0, -2100(%rbp)
	jne	.L50
	cmpl	$0, -2116(%rbp)
	jne	.L51
	movl	-2076(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	dup2
	jmp	.L52
.L51:
	movl	-2124(%rbp), %eax
	subl	$1, %eax
	cmpl	-2116(%rbp), %eax
	jne	.L53
	movl	-2124(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L54
	movl	-2096(%rbp), %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	dup2
	jmp	.L52
.L54:
	movl	-2080(%rbp), %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	dup2
	jmp	.L52
.L53:
	movl	-2116(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L56
	movl	-2080(%rbp), %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	dup2
	movl	-2092(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	dup2
	jmp	.L52
.L56:
	movl	-2096(%rbp), %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	dup2
	movl	-2076(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	dup2
.L52:
	movq	-2064(%rbp), %rax
	leaq	-2064(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execvp
	cmpl	$-1, %eax
	jne	.L50
	call	getpid
	movl	$15, %esi
	movl	%eax, %edi
	call	kill
.L50:
	cmpl	$0, -2116(%rbp)
	jne	.L57
	movl	-2076(%rbp), %eax
	movl	%eax, %edi
	call	close
	jmp	.L58
.L57:
	movl	-2124(%rbp), %eax
	subl	$1, %eax
	cmpl	-2116(%rbp), %eax
	jne	.L59
	movl	-2124(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L60
	movl	-2096(%rbp), %eax
	movl	%eax, %edi
	call	close
	jmp	.L58
.L60:
	movl	-2080(%rbp), %eax
	movl	%eax, %edi
	call	close
	jmp	.L58
.L59:
	movl	-2116(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L62
	movl	-2080(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	-2092(%rbp), %eax
	movl	%eax, %edi
	call	close
	jmp	.L58
.L62:
	movl	-2096(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	-2076(%rbp), %eax
	movl	%eax, %edi
	call	close
.L58:
	movl	-2100(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid
	addl	$1, -2116(%rbp)
.L39:
	movl	-2112(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-2136(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L35
	cmpl	$1, -2120(%rbp)
	jne	.L64
.L35:
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L65
	call	__stack_chk_fail
.L65:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	hsh_pipe_handler, .-hsh_pipe_handler
	.section	.rodata
	.align 8
.LC15:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: LEL THERE IS ERROR WITH ALLOCATION\n"
.LC16:
	.string	" \""
	.text
	.globl	hsh_split_args
	.type	hsh_split_args, @function
hsh_split_args:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	$64, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	-24(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L67
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$62, %edx
	movl	$1, %esi
	movl	$.LC15, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L67:
	movq	-40(%rbp), %rax
	movl	$.LC16, %esi
	movq	%rax, %rdi
	call	strtok
	movq	%rax, -8(%rbp)
	jmp	.L68
.L70:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	addl	$1, -20(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L69
	addl	$64, -24(%rbp)
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L69
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$62, %edx
	movl	$1, %esi
	movl	$.LC15, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L69:
	movl	$.LC16, %esi
	movl	$0, %edi
	call	strtok
	movq	%rax, -8(%rbp)
.L68:
	cmpq	$0, -8(%rbp)
	jne	.L70
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	movq	-16(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	hsh_split_args, .-hsh_split_args
	.globl	hsh_read_line
	.type	hsh_read_line, @function
hsh_read_line:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$1024, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	-20(%rbp), %eax
	cltq
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L73
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$62, %edx
	movl	$1, %esi
	movl	$.LC15, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L73:
	call	getchar
	movl	%eax, -12(%rbp)
	cmpl	$-1, -12(%rbp)
	jne	.L74
	movl	$0, %edi
	call	exit
.L74:
	cmpl	$-1, -12(%rbp)
	je	.L75
	cmpl	$10, -12(%rbp)
	jne	.L76
.L75:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-8(%rbp), %rax
	jmp	.L79
.L76:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	-12(%rbp), %edx
	movb	%dl, (%rax)
	addl	$1, -16(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L73
	addl	$1024, -20(%rbp)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L73
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$62, %edx
	movl	$1, %esi
	movl	$.LC15, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L79:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	hsh_read_line, .-hsh_read_line
	.globl	hsh_error_output
	.type	hsh_error_output, @function
hsh_error_output:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L81
.L88:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$94, %al
	jne	.L82
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L83
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L86
.L83:
	movl	$-1, %eax
	jmp	.L85
.L87:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	$2, %rax
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	addl	$1, -4(%rbp)
.L86:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L87
	movl	$1, %eax
	jmp	.L85
.L82:
	addl	$1, -8(%rbp)
.L81:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L88
	movl	$0, %eax
.L85:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	hsh_error_output, .-hsh_error_output
	.globl	hsh_redirect_input
	.type	hsh_redirect_input, @function
hsh_redirect_input:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L90
.L97:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$60, %al
	jne	.L91
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L92
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L95
.L92:
	movl	$-1, %eax
	jmp	.L94
.L96:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	$2, %rax
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	addl	$1, -4(%rbp)
.L95:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L96
	movl	$1, %eax
	jmp	.L94
.L91:
	addl	$1, -8(%rbp)
.L90:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L97
	movl	$0, %eax
.L94:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	hsh_redirect_input, .-hsh_redirect_input
	.globl	hsh_redirect_output
	.type	hsh_redirect_output, @function
hsh_redirect_output:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L99
.L106:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$62, %al
	jne	.L100
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L101
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L104
.L101:
	movl	$-1, %eax
	jmp	.L103
.L105:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	$2, %rax
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	addl	$1, -4(%rbp)
.L104:
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L105
	movl	$1, %eax
	jmp	.L103
.L100:
	addl	$1, -8(%rbp)
.L99:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L106
	movl	$0, %eax
.L103:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	hsh_redirect_output, .-hsh_redirect_output
	.globl	hsh_pipe_input
	.type	hsh_pipe_input, @function
hsh_pipe_input:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L108
.L111:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$124, %al
	jne	.L109
	movl	$1, %eax
	jmp	.L107
.L109:
	addl	$1, -4(%rbp)
.L108:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L111
.L107:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	hsh_pipe_input, .-hsh_pipe_input
	.globl	hsh_ampersand
	.type	hsh_ampersand, @function
hsh_ampersand:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L113
.L114:
	addl	$1, -4(%rbp)
.L113:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L114
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$38, %al
	jne	.L115
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	movl	$1, %eax
	jmp	.L116
.L115:
	movl	$0, %eax
.L116:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	hsh_ampersand, .-hsh_ampersand
	.section	.rodata
	.align 8
.LC17:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: SYNTAX ERROR ._.\033[0m"
	.align 8
.LC18:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: REDIRECTING FROM:\033[0m %s\n"
	.align 8
.LC19:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: REDIRECTING TO:\033[0m %s\n"
	.align 8
.LC20:
	.string	"\033[1m\033[31mHAJDUK_SHELL\033[0m: REDIRECTING ERRORS TO:\033[0m %s\n"
	.text
	.globl	hsh_info
	.type	hsh_info, @function
hsh_info:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movq	%rcx, -24(%rbp)
	movq	%r8, -32(%rbp)
	movl	-4(%rbp), %eax
	testl	%eax, %eax
	je	.L130
	cmpl	$1, %eax
	je	.L120
	cmpl	$-1, %eax
	jne	.L118
	movl	$.LC17, %edi
	call	puts
	jmp	.L118
.L120:
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC18, %edi
	movl	$0, %eax
	call	printf
	jmp	.L118
.L130:
	nop
.L118:
	movl	-8(%rbp), %eax
	testl	%eax, %eax
	je	.L131
	cmpl	$1, %eax
	je	.L124
	cmpl	$-1, %eax
	jne	.L122
	movl	$.LC17, %edi
	call	puts
	jmp	.L122
.L124:
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC19, %edi
	movl	$0, %eax
	call	printf
	jmp	.L122
.L131:
	nop
.L122:
	movl	-12(%rbp), %eax
	testl	%eax, %eax
	je	.L132
	cmpl	$1, %eax
	je	.L128
	cmpl	$-1, %eax
	je	.L129
	jmp	.L133
.L129:
	movl	$.LC17, %edi
	call	puts
	jmp	.L126
.L128:
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC20, %edi
	movl	$0, %eax
	call	printf
	jmp	.L126
.L132:
	nop
.L126:
.L133:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	hsh_info, .-hsh_info
	.section	.rodata
	.align 8
.LC21:
	.string	"\n\033[1m\033[36mOKKINDEL (\033[33m %s \033[36m)\n$\033[0m "
	.text
	.globl	hsh_loop
	.type	hsh_loop, @function
hsh_loop:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$336, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
.L138:
	leaq	-272(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	getcwd
	testq	%rax, %rax
	je	.L135
	movq	stdout(%rip), %rax
	leaq	-272(%rbp), %rdx
	movl	$.LC21, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
.L135:
	call	hsh_read_line
	movq	%rax, -288(%rbp)
	movq	-288(%rbp), %rax
	movq	%rax, %rdi
	call	hsh_split_args
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	hsh_pipe_input
	testl	%eax, %eax
	je	.L136
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	hsh_pipe_handler
	jmp	.L137
.L136:
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	hsh_ampersand
	movl	%eax, -320(%rbp)
	leaq	-296(%rbp), %rdx
	movq	-280(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	hsh_redirect_input
	movl	%eax, -316(%rbp)
	leaq	-304(%rbp), %rdx
	movq	-280(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	hsh_redirect_output
	movl	%eax, -312(%rbp)
	leaq	-304(%rbp), %rdx
	movq	-280(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	hsh_error_output
	movl	%eax, -308(%rbp)
	movq	-304(%rbp), %rdi
	movq	-296(%rbp), %rcx
	movl	-308(%rbp), %edx
	movl	-312(%rbp), %esi
	movl	-316(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	hsh_info
	movq	-304(%rbp), %rdi
	movq	-296(%rbp), %r9
	movl	-308(%rbp), %r8d
	movl	-312(%rbp), %ecx
	movl	-316(%rbp), %edx
	movl	-320(%rbp), %esi
	movq	-280(%rbp), %rax
	subq	$8, %rsp
	pushq	%rdi
	movq	%rax, %rdi
	call	hsh_executive
	addq	$16, %rsp
	movl	%eax, -324(%rbp)
.L137:
	movq	-288(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	free
	cmpl	$0, -324(%rbp)
	jne	.L138
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L139
	call	__stack_chk_fail
.L139:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	hsh_loop, .-hsh_loop
	.section	.rodata
	.align 8
.LC22:
	.string	"\n\033[1m\033[31mHAJDUK_SHELL\033[0m: PULL CTRL-D TO EXIT\033[0m\n "
	.text
	.globl	intHandler
	.type	intHandler, @function
intHandler:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$53, %edx
	movl	$1, %esi
	movl	$.LC22, %edi
	call	fwrite
	call	hsh_loop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	intHandler, .-intHandler
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$intHandler, %esi
	movl	$2, %edi
	call	signal
	call	hsh_loop
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
