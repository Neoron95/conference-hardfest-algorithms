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
	je	.LBB0_7
# %bb.1:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	movl	%ecx, %eax
	movl	%edx, %ecx
	andl	$3, %ecx
	cmpq	$4, %rdx
	jae	.LBB0_8
# %bb.2:
	xorl	%r9d, %r9d
	jmp	.LBB0_3
.LBB0_8:
	andq	$-4, %rdx
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_9:                                # =>This Inner Loop Header: Depth=1
	movq	(%rdi,%r9,8), %r10
	shrxq	%rax, %r10, %r11
	movzbl	%r11b, %r11d
	movl	(%r8,%r11,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r11,4)
	movq	%r10, (%rsi,%rbx,8)
	movq	8(%rdi,%r9,8), %r10
	shrxq	%rax, %r10, %r11
	movzbl	%r11b, %r11d
	movl	(%r8,%r11,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r11,4)
	movq	%r10, (%rsi,%rbx,8)
	movq	16(%rdi,%r9,8), %r10
	shrxq	%rax, %r10, %r11
	movzbl	%r11b, %r11d
	movl	(%r8,%r11,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r11,4)
	movq	%r10, (%rsi,%rbx,8)
	movq	24(%rdi,%r9,8), %r10
	shrxq	%rax, %r10, %r11
	movzbl	%r11b, %r11d
	movl	(%r8,%r11,4), %ebx
	leal	1(%rbx), %ebp
	movl	%ebp, (%r8,%r11,4)
	movq	%r10, (%rsi,%rbx,8)
	addq	$4, %r9
	cmpq	%r9, %rdx
	jne	.LBB0_9
.LBB0_3:
	testq	%rcx, %rcx
	je	.LBB0_6
# %bb.4:
	leaq	(%rdi,%r9,8), %rdx
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rdi,8), %r9
	shrxq	%rax, %r9, %r10
	movzbl	%r10b, %r10d
	movl	(%r8,%r10,4), %r11d
	leal	1(%r11), %ebx
	movl	%ebx, (%r8,%r10,4)
	movq	%r9, (%rsi,%r11,8)
	incq	%rdi
	cmpq	%rdi, %rcx
	jne	.LBB0_5
.LBB0_6:
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %rbp
.LBB0_7:
	#APP
	# LLVM-MCA-END scatter
	#NO_APP
	retq
.Lfunc_end0:
	.size	_Z7scatterPKmPmmiPj, .Lfunc_end0-_Z7scatterPKmPmmiPj
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0                          # -- Begin function _Z8populatePKmmRm
.LCPI1_0:
	.quad	16                              # 0x10
	.quad	32                              # 0x20
	.quad	64                              # 0x40
	.quad	128                             # 0x80
.LCPI1_1:
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	4                               # 0x4
	.quad	8                               # 0x8
.LCPI1_2:
	.quad	256                             # 0x100
	.quad	512                             # 0x200
	.quad	1024                            # 0x400
	.quad	2048                            # 0x800
.LCPI1_3:
	.quad	4096                            # 0x1000
	.quad	8192                            # 0x2000
	.quad	16384                           # 0x4000
	.quad	32768                           # 0x8000
.LCPI1_4:
	.quad	65536                           # 0x10000
	.quad	131072                          # 0x20000
	.quad	262144                          # 0x40000
	.quad	524288                          # 0x80000
.LCPI1_5:
	.quad	1048576                         # 0x100000
	.quad	2097152                         # 0x200000
	.quad	4194304                         # 0x400000
	.quad	8388608                         # 0x800000
.LCPI1_6:
	.quad	16777216                        # 0x1000000
	.quad	33554432                        # 0x2000000
	.quad	67108864                        # 0x4000000
	.quad	134217728                       # 0x8000000
.LCPI1_7:
	.quad	268435456                       # 0x10000000
	.quad	536870912                       # 0x20000000
	.quad	1073741824                      # 0x40000000
	.quad	2147483648                      # 0x80000000
.LCPI1_8:
	.quad	4294967296                      # 0x100000000
	.quad	8589934592                      # 0x200000000
	.quad	17179869184                     # 0x400000000
	.quad	34359738368                     # 0x800000000
.LCPI1_9:
	.quad	68719476736                     # 0x1000000000
	.quad	137438953472                    # 0x2000000000
	.quad	274877906944                    # 0x4000000000
	.quad	549755813888                    # 0x8000000000
.LCPI1_10:
	.quad	1099511627776                   # 0x10000000000
	.quad	2199023255552                   # 0x20000000000
	.quad	4398046511104                   # 0x40000000000
	.quad	8796093022208                   # 0x80000000000
.LCPI1_11:
	.quad	17592186044416                  # 0x100000000000
	.quad	35184372088832                  # 0x200000000000
	.quad	70368744177664                  # 0x400000000000
	.quad	140737488355328                 # 0x800000000000
.LCPI1_12:
	.quad	281474976710656                 # 0x1000000000000
	.quad	562949953421312                 # 0x2000000000000
	.quad	1125899906842624                # 0x4000000000000
	.quad	2251799813685248                # 0x8000000000000
.LCPI1_13:
	.quad	4503599627370496                # 0x10000000000000
	.quad	9007199254740992                # 0x20000000000000
	.quad	18014398509481984               # 0x40000000000000
	.quad	36028797018963968               # 0x80000000000000
.LCPI1_14:
	.quad	72057594037927936               # 0x100000000000000
	.quad	144115188075855872              # 0x200000000000000
	.quad	288230376151711744              # 0x400000000000000
	.quad	576460752303423488              # 0x800000000000000
.LCPI1_15:
	.quad	1152921504606846976             # 0x1000000000000000
	.quad	2305843009213693952             # 0x2000000000000000
	.quad	4611686018427387904             # 0x4000000000000000
	.quad	-9223372036854775808            # 0x8000000000000000
	.text
	.globl	_Z8populatePKmmRm
	.p2align	4, 0x90
	.type	_Z8populatePKmmRm,@function
_Z8populatePKmmRm:                      # @_Z8populatePKmmRm
	.cfi_startproc
# %bb.0:
	#APP
	# LLVM-MCA-BEGIN populate
	#NO_APP
	vpbroadcastq	%rsi, %ymm0
	vpcmpleuq	(%rdi), %ymm0, %k1
	vpcmpleuq	32(%rdi), %ymm0, %k2
	vmovdqa64	.LCPI1_0(%rip), %ymm1 {%k2} {z}
	vporq	.LCPI1_1(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	64(%rdi), %ymm0, %k1
	vporq	.LCPI1_2(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	96(%rdi), %ymm0, %k1
	vporq	.LCPI1_3(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	128(%rdi), %ymm0, %k1
	vporq	.LCPI1_4(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	160(%rdi), %ymm0, %k1
	vporq	.LCPI1_5(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	192(%rdi), %ymm0, %k1
	vporq	.LCPI1_6(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	224(%rdi), %ymm0, %k1
	vporq	.LCPI1_7(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	256(%rdi), %ymm0, %k1
	vporq	.LCPI1_8(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	288(%rdi), %ymm0, %k1
	vporq	.LCPI1_9(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	320(%rdi), %ymm0, %k1
	vporq	.LCPI1_10(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	352(%rdi), %ymm0, %k1
	vporq	.LCPI1_11(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	384(%rdi), %ymm0, %k1
	vporq	.LCPI1_12(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	416(%rdi), %ymm0, %k1
	vporq	.LCPI1_13(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	448(%rdi), %ymm0, %k1
	vporq	.LCPI1_14(%rip), %ymm1, %ymm1 {%k1}
	vpcmpleuq	480(%rdi), %ymm0, %k1
	vporq	.LCPI1_15(%rip), %ymm1, %ymm1 {%k1}
	vextracti128	$1, %ymm1, %xmm0
	vpor	%xmm0, %xmm1, %xmm0
	vpshufd	$238, %xmm0, %xmm1              # xmm1 = xmm0[2,3,2,3]
	vpor	%xmm1, %xmm0, %xmm0
	#APP
	# LLVM-MCA-END populate
	#NO_APP
	vmovq	%xmm0, (%rdx)
	vzeroupper
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
	tzcntq	%rdx, %rax
	tzcntq	%rcx, %r8
	shll	$3, %r8d
	movq	%rsi, %r9
	subq	%r8, %r9
	blsrq	%rdx, %rdx
	movq	(%rdi,%rax,8), %r8
	movq	(%r9), %r10
	movq	%r10, (%rdi,%rax,8)
	movq	%r8, (%r9)
	je	.LBB2_4
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	blsrq	%rcx, %rcx
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
