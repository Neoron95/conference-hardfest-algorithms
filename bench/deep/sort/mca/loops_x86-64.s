	.text
	.file	"loops.cpp"
	.globl	_Z7scatterPKmPmmiPj             # -- Begin function _Z7scatterPKmPmmiPj
	.p2align	4, 0x90
	.type	_Z7scatterPKmPmmiPj,@function
_Z7scatterPKmPmmiPj:                    # @_Z7scatterPKmPmmiPj
	.cfi_startproc
# %bb.0:
	#APP
	# LLVM-MCA-BEGIN scatter
	#NO_APP
	testq	%rdx, %rdx
	je	.LBB0_5
# %bb.1:
	movl	%ecx, %ecx
	cmpq	$1, %rdx
	jne	.LBB0_6
# %bb.2:
	xorl	%eax, %eax
	testb	$1, %dl
	jne	.LBB0_4
	jmp	.LBB0_5
.LBB0_6:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %r9
	andq	$-2, %r9
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_7:                                # =>This Inner Loop Header: Depth=1
	movq	(%rdi,%rax,8), %r10
	movq	%r10, %r11
	shrq	%cl, %r11
	movzbl	%r11b, %r11d
	movl	(%r8,%r11,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r11,4)
	movq	8(%rdi,%rax,8), %r11
	movq	%r11, %r14
	shrq	%cl, %r14
	movq	%r10, (%rsi,%rbx,8)
	movzbl	%r14b, %r10d
	movl	(%r8,%r10,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r10,4)
	movq	%r11, (%rsi,%rbx,8)
	addq	$2, %rax
	cmpq	%rax, %r9
	jne	.LBB0_7
# %bb.8:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %r14
	.cfi_restore %rbp
	testb	$1, %dl
	je	.LBB0_5
.LBB0_4:
	movq	(%rdi,%rax,8), %rax
	movq	%rax, %rdx
                                        # kill: def $cl killed $cl killed $rcx
	shrq	%cl, %rdx
	movzbl	%dl, %ecx
	movl	(%r8,%rcx,4), %edx
	leal	1(%rdx), %edi
	movl	%edi, (%r8,%rcx,4)
	movq	%rax, (%rsi,%rdx,8)
.LBB0_5:
	#APP
	# LLVM-MCA-END scatter
	#NO_APP
	retq
.Lfunc_end0:
	.size	_Z7scatterPKmPmmiPj, .Lfunc_end0-_Z7scatterPKmPmmiPj
	.cfi_endproc
                                        # -- End function
	.globl	_Z8populatePKmmRm               # -- Begin function _Z8populatePKmmRm
	.p2align	4, 0x90
	.type	_Z8populatePKmmRm,@function
_Z8populatePKmmRm:                      # @_Z8populatePKmmRm
	.cfi_startproc
# %bb.0:
	#APP
	# LLVM-MCA-BEGIN populate
	#NO_APP
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	xorl	%r8d, %r8d
	cmpq	%rsi, (%rdi,%rax,8)
	setae	%r8b
	movl	%eax, %ecx
	shlq	%cl, %r8
	orq	%r9, %r8
	xorl	%r9d, %r9d
	cmpq	%rsi, 8(%rdi,%rax,8)
	setae	%r9b
	leal	1(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r9
	xorl	%r10d, %r10d
	cmpq	%rsi, 16(%rdi,%rax,8)
	setae	%r10b
	leal	2(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r10
	orq	%r9, %r10
	orq	%r8, %r10
	xorl	%r9d, %r9d
	cmpq	%rsi, 24(%rdi,%rax,8)
	setae	%r9b
	leal	3(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r9
	orq	%r10, %r9
	addq	$4, %rax
	cmpq	$64, %rax
	jne	.LBB1_1
# %bb.2:
	#APP
	# LLVM-MCA-END populate
	#NO_APP
	movq	%r9, (%rdx)
	retq
.Lfunc_end1:
	.size	_Z8populatePKmmRm, .Lfunc_end1-_Z8populatePKmmRm
	.cfi_endproc
                                        # -- End function
	.globl	_Z13swap_by_masksPmS_mm         # -- Begin function _Z13swap_by_masksPmS_mm
	.p2align	4, 0x90
	.type	_Z13swap_by_masksPmS_mm,@function
_Z13swap_by_masksPmS_mm:                # @_Z13swap_by_masksPmS_mm
	.cfi_startproc
# %bb.0:
	#APP
	# LLVM-MCA-BEGIN swapmask
	#NO_APP
	testq	%rdx, %rdx
	je	.LBB2_4
# %bb.1:
	testq	%rcx, %rcx
	je	.LBB2_4
	.p2align	4, 0x90
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	movq	%rdx, %rax
	rep		bsfq	%rdx, %rdx
	rep		bsfq	%rcx, %r8
	shll	$3, %r8d
	movq	%rsi, %r9
	subq	%r8, %r9
	movq	(%rdi,%rdx,8), %r8
	movq	(%r9), %r10
	movq	%r10, (%rdi,%rdx,8)
	leaq	-1(%rax), %rdx
	movq	%r8, (%r9)
	andq	%rax, %rdx
	je	.LBB2_4
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	leaq	-1(%rcx), %rax
	andq	%rax, %rcx
	jne	.LBB2_2
.LBB2_4:
	#APP
	# LLVM-MCA-END swapmask
	#NO_APP
	retq
.Lfunc_end2:
	.size	_Z13swap_by_masksPmS_mm, .Lfunc_end2-_Z13swap_by_masksPmS_mm
	.cfi_endproc
                                        # -- End function
	.globl	_Z5hoarePmS_PKm                 # -- Begin function _Z5hoarePmS_PKm
	.p2align	4, 0x90
	.type	_Z5hoarePmS_PKm,@function
_Z5hoarePmS_PKm:                        # @_Z5hoarePmS_PKm
	.cfi_startproc
# %bb.0:
	#APP
	# LLVM-MCA-BEGIN hoare
	#NO_APP
	.p2align	4, 0x90
.LBB3_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_2 Depth 2
                                        #     Child Loop BB3_4 Depth 2
	movq	(%rdx), %r8
	.p2align	4, 0x90
.LBB3_2:                                #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rdi), %rcx
	addq	$8, %rdi
	cmpq	%r8, %rcx
	jb	.LBB3_2
# %bb.3:                                #   in Loop: Header=BB3_1 Depth=1
	leaq	-8(%rdi), %rax
	.p2align	4, 0x90
.LBB3_4:                                #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rsi), %r9
	addq	$-8, %rsi
	cmpq	%r9, %r8
	jb	.LBB3_4
# %bb.5:                                #   in Loop: Header=BB3_1 Depth=1
	cmpq	%rsi, %rax
	jae	.LBB3_7
# %bb.6:                                #   in Loop: Header=BB3_1 Depth=1
	movq	%r9, (%rax)
	movq	%rcx, (%rsi)
	jmp	.LBB3_1
.LBB3_7:
	#APP
	# LLVM-MCA-END hoare
	#NO_APP
	retq
.Lfunc_end3:
	.size	_Z5hoarePmS_PKm, .Lfunc_end3-_Z5hoarePmS_PKm
	.cfi_endproc
                                        # -- End function
	.section	".linker-options","e",@llvm_linker_options
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
