	.text
	.file	"sort_inst.cpp"
	.globl	_Z15sort_u64_bitsetPmS_         # -- Begin function _Z15sort_u64_bitsetPmS_
	.p2align	4, 0x90
	.type	_Z15sort_u64_bitsetPmS_,@function
_Z15sort_u64_bitsetPmS_:                # @_Z15sort_u64_bitsetPmS_
	.cfi_startproc
# %bb.0:
	movq	%rsi, %rax
	subq	%rdi, %rax
	sarq	$3, %rax
	bsrq	%rax, %rax
	xorl	$63, %eax
	addl	%eax, %eax
	xorq	$126, %rax
	xorl	%edx, %edx
	cmpq	%rdi, %rsi
	cmovneq	%rax, %rdx
	movl	$1, %ecx
	jmp	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb # TAILCALL
.Lfunc_end0:
	.size	_Z15sort_u64_bitsetPmS_, .Lfunc_end0-_Z15sort_u64_bitsetPmS_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"axG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.weak	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb # -- Begin function _ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.p2align	4, 0x90
	.type	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,@function
_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb: # @_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%ecx, (%rsp)                    # 4-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_2 Depth 2
                                        #       Child Loop BB1_60 Depth 3
                                        #       Child Loop BB1_58 Depth 3
                                        #       Child Loop BB1_64 Depth 3
                                        #       Child Loop BB1_67 Depth 3
                                        #         Child Loop BB1_68 Depth 4
                                        #         Child Loop BB1_69 Depth 4
	movq	%r14, %r12
.LBB1_2:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_60 Depth 3
                                        #       Child Loop BB1_58 Depth 3
                                        #       Child Loop BB1_64 Depth 3
                                        #       Child Loop BB1_67 Depth 3
                                        #         Child Loop BB1_68 Depth 4
                                        #         Child Loop BB1_69 Depth 4
	movq	%r12, %r14
	movq	%rbx, %rsi
	subq	%r12, %rsi
	sarq	$3, %rsi
	cmpq	$5, %rsi
	jbe	.LBB1_76
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=2
	cmpq	$23, %rsi
	jle	.LBB1_87
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=2
	testq	%r15, %r15
	je	.LBB1_98
# %bb.5:                                #   in Loop: Header=BB1_2 Depth=2
	movq	%rsi, %rdx
	shrq	%rdx
	leaq	(%r14,%rdx,8), %rax
	movq	-8(%rbx), %rcx
	cmpq	$129, %rsi
	jb	.LBB1_9
# %bb.6:                                #   in Loop: Header=BB1_2 Depth=2
	movq	(%rax), %rdi
	movq	(%r14), %rsi
	cmpq	%rsi, %rdi
	jae	.LBB1_12
# %bb.7:                                #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %rcx
	jae	.LBB1_18
# %bb.8:                                #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%r14)
	jmp	.LBB1_20
	.p2align	4, 0x90
.LBB1_9:                                #   in Loop: Header=BB1_2 Depth=2
	movq	(%r14), %rsi
	movq	(%rax), %rdx
	cmpq	%rdx, %rsi
	jae	.LBB1_15
# %bb.10:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rsi, %rcx
	jae	.LBB1_27
# %bb.11:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%rax)
	jmp	.LBB1_29
.LBB1_12:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %rcx
	jae	.LBB1_21
# %bb.13:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%rax)
	movq	%rdi, -8(%rbx)
	movq	(%rax), %rcx
	movq	(%r14), %rsi
	cmpq	%rsi, %rcx
	jae	.LBB1_21
# %bb.14:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%r14)
	movq	%rsi, (%rax)
	jmp	.LBB1_21
.LBB1_15:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rsi, %rcx
	jae	.LBB1_30
# %bb.16:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%r14)
	movq	%rsi, -8(%rbx)
	movq	(%r14), %rcx
	movq	(%rax), %rdx
	cmpq	%rdx, %rcx
	jae	.LBB1_30
# %bb.17:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%rax)
	movq	%rdx, (%r14)
	decq	%r15
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB1_52
	jmp	.LBB1_51
.LBB1_18:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, (%r14)
	movq	%rsi, (%rax)
	movq	-8(%rbx), %rcx
	cmpq	%rsi, %rcx
	jae	.LBB1_21
# %bb.19:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rcx, (%rax)
.LBB1_20:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rsi, -8(%rbx)
.LBB1_21:                               #   in Loop: Header=BB1_2 Depth=2
	leaq	(%r14,%rdx,8), %rcx
	addq	$-8, %rcx
	movq	-8(%r14,%rdx,8), %rdi
	movq	8(%r14), %rsi
	movq	-16(%rbx), %r8
	cmpq	%rsi, %rdi
	jae	.LBB1_24
# %bb.22:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB1_31
# %bb.23:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, 8(%r14)
	jmp	.LBB1_33
.LBB1_24:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB1_34
# %bb.25:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, (%rcx)
	movq	%rdi, -16(%rbx)
	movq	(%rcx), %rsi
	movq	8(%r14), %rdi
	cmpq	%rdi, %rsi
	jae	.LBB1_34
# %bb.26:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rsi, 8(%r14)
	movq	%rdi, (%rcx)
	jmp	.LBB1_34
.LBB1_27:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rsi, (%rax)
	movq	%rdx, (%r14)
	movq	-8(%rbx), %rax
	cmpq	%rdx, %rax
	jae	.LBB1_30
# %bb.28:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rax, (%r14)
.LBB1_29:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdx, -8(%rbx)
	.p2align	4, 0x90
.LBB1_30:                               #   in Loop: Header=BB1_2 Depth=2
	decq	%r15
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB1_52
	jmp	.LBB1_51
.LBB1_31:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, 8(%r14)
	movq	%rsi, (%rcx)
	movq	-16(%rbx), %rdi
	cmpq	%rsi, %rdi
	jae	.LBB1_34
# %bb.32:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, (%rcx)
.LBB1_33:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rsi, -16(%rbx)
.LBB1_34:                               #   in Loop: Header=BB1_2 Depth=2
	leaq	(%r14,%rdx,8), %rsi
	addq	$8, %rsi
	movq	8(%r14,%rdx,8), %rdi
	movq	16(%r14), %rdx
	movq	-24(%rbx), %r8
	cmpq	%rdx, %rdi
	jae	.LBB1_37
# %bb.35:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB1_40
# %bb.36:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, 16(%r14)
	jmp	.LBB1_42
.LBB1_37:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB1_43
# %bb.38:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, (%rsi)
	movq	%rdi, -24(%rbx)
	movq	(%rsi), %rdx
	movq	16(%r14), %rdi
	cmpq	%rdi, %rdx
	jae	.LBB1_43
# %bb.39:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdx, 16(%r14)
	movq	%rdi, (%rsi)
	jmp	.LBB1_43
.LBB1_40:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, 16(%r14)
	movq	%rdx, (%rsi)
	movq	-24(%rbx), %rdi
	cmpq	%rdx, %rdi
	jae	.LBB1_43
# %bb.41:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, (%rsi)
.LBB1_42:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdx, -24(%rbx)
.LBB1_43:                               #   in Loop: Header=BB1_2 Depth=2
	movq	(%rax), %rdx
	movq	(%rcx), %rdi
	movq	(%rsi), %r8
	cmpq	%rdi, %rdx
	jae	.LBB1_47
# %bb.44:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdx, %r8
	jb	.LBB1_49
# %bb.45:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdx, (%rcx)
	movq	%rdi, (%rax)
	movq	%rax, %rcx
	movq	%r8, %rdx
	cmpq	%rdi, %r8
	jb	.LBB1_49
# %bb.46:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rdi, %rdx
	jmp	.LBB1_50
.LBB1_47:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rdx, %r8
	jae	.LBB1_50
# %bb.48:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, (%rax)
	movq	%rdx, (%rsi)
	movq	%rax, %rsi
	movq	%rdi, %rdx
	cmpq	%rdi, %r8
	jae	.LBB1_74
.LBB1_49:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, (%rcx)
	movq	%rdi, (%rsi)
.LBB1_50:                               #   in Loop: Header=BB1_2 Depth=2
	movq	(%r14), %rcx
	movq	%rdx, (%r14)
	movq	%rcx, (%rax)
	decq	%r15
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB1_52
.LBB1_51:                               #   in Loop: Header=BB1_2 Depth=2
	movq	(%r14), %rax
	cmpq	%rax, -8(%r14)
	jae	.LBB1_56
.LBB1_52:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	movq	%rax, %r13
	testb	$1, %dl
	je	.LBB1_55
# %bb.53:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	movl	%eax, %ebp
	leaq	8(%r13), %r12
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	testb	%al, %al
	jne	.LBB1_75
# %bb.54:                               #   in Loop: Header=BB1_2 Depth=2
	testb	%bpl, %bpl
	jne	.LBB1_2
.LBB1_55:                               #   in Loop: Header=BB1_2 Depth=2
	xorl	%ecx, %ecx
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	setne	%cl
	movq	%r14, %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	addq	$8, %r13
	movl	$0, (%rsp)                      # 4-byte Folded Spill
	movq	%r13, %r12
	jmp	.LBB1_2
.LBB1_56:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	-8(%rbx), %rax
	jae	.LBB1_59
# %bb.57:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r14, %rcx
	.p2align	4, 0x90
.LBB1_58:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leaq	8(%rcx), %r12
	cmpq	8(%rcx), %rax
	movq	%r12, %rcx
	jae	.LBB1_58
	jmp	.LBB1_62
.LBB1_59:                               #   in Loop: Header=BB1_2 Depth=2
	leaq	8(%r14), %rcx
	.p2align	4, 0x90
.LBB1_60:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, %r12
	cmpq	%rbx, %rcx
	jae	.LBB1_62
# %bb.61:                               #   in Loop: Header=BB1_60 Depth=3
	leaq	8(%r12), %rcx
	cmpq	(%r12), %rax
	jae	.LBB1_60
.LBB1_62:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rbx, %rcx
	cmpq	%rbx, %r12
	jae	.LBB1_65
# %bb.63:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rbx, %rdx
	.p2align	4, 0x90
.LBB1_64:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leaq	-8(%rdx), %rcx
	cmpq	-8(%rdx), %rax
	movq	%rcx, %rdx
	jb	.LBB1_64
.LBB1_65:                               #   in Loop: Header=BB1_2 Depth=2
	cmpq	%rcx, %r12
	jae	.LBB1_71
# %bb.66:                               #   in Loop: Header=BB1_2 Depth=2
	movq	(%r12), %rdx
	movq	(%rcx), %rsi
	.p2align	4, 0x90
.LBB1_67:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_68 Depth 4
                                        #         Child Loop BB1_69 Depth 4
	movq	%rsi, (%r12)
	movq	%rdx, (%rcx)
	.p2align	4, 0x90
.LBB1_68:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        #       Parent Loop BB1_67 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	8(%r12), %rdx
	addq	$8, %r12
	cmpq	%rdx, %rax
	jae	.LBB1_68
	.p2align	4, 0x90
.LBB1_69:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        #       Parent Loop BB1_67 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	-8(%rcx), %rsi
	addq	$-8, %rcx
	cmpq	%rsi, %rax
	jb	.LBB1_69
# %bb.70:                               #   in Loop: Header=BB1_67 Depth=3
	cmpq	%rcx, %r12
	jb	.LBB1_67
.LBB1_71:                               #   in Loop: Header=BB1_2 Depth=2
	leaq	-8(%r12), %rcx
	cmpq	%r14, %rcx
	je	.LBB1_73
# %bb.72:                               #   in Loop: Header=BB1_2 Depth=2
	movq	(%rcx), %rdx
	movq	%rdx, (%r14)
.LBB1_73:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%rax, (%rcx)
	jmp	.LBB1_2
.LBB1_74:                               #   in Loop: Header=BB1_2 Depth=2
	movq	%r8, %rdx
	jmp	.LBB1_50
.LBB1_75:                               #   in Loop: Header=BB1_1 Depth=1
	movq	%r13, %rbx
	testb	%bpl, %bpl
	je	.LBB1_1
	jmp	.LBB1_119
.LBB1_76:
	leaq	.LJTI1_0(%rip), %rax
	movslq	(%rax,%rsi,4), %rcx
	addq	%rax, %rcx
	jmpq	*%rcx
.LBB1_77:
	movq	-8(%rbx), %rax
	movq	(%r14), %rcx
	cmpq	%rcx, %rax
	jae	.LBB1_119
# %bb.78:
	movq	%rax, (%r14)
	movq	%rcx, -8(%rbx)
	jmp	.LBB1_119
.LBB1_79:
	movq	(%r14), %rax
	movq	8(%r14), %rcx
	movq	-8(%rbx), %rdx
	cmpq	%rax, %rcx
	jae	.LBB1_100
# %bb.80:
	cmpq	%rcx, %rdx
	jae	.LBB1_116
# %bb.81:
	movq	%rdx, (%r14)
	jmp	.LBB1_118
.LBB1_82:
	leaq	8(%r14), %rsi
	leaq	16(%r14), %rdx
	leaq	24(%r14), %rcx
	addq	$-8, %rbx
	movq	%r14, %rdi
	movq	%rbx, %r8
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_ # TAILCALL
.LBB1_83:
	.cfi_def_cfa_offset 64
	leaq	8(%r14), %rax
	leaq	16(%r14), %rcx
	movq	(%r14), %rdx
	movq	8(%r14), %rsi
	movq	16(%r14), %rdi
	cmpq	%rdx, %rsi
	jae	.LBB1_102
# %bb.84:
	movq	%r14, %r8
	movq	%rcx, %r9
	movq	%rdx, %r10
	cmpq	%rsi, %rdi
	jb	.LBB1_104
# %bb.85:
	movq	%rsi, (%r14)
	movq	%rdx, 8(%r14)
	movq	%rax, %r8
	movq	%rcx, %r9
	movq	%rdx, %r10
	cmpq	%rdx, %rdi
	jb	.LBB1_104
	jmp	.LBB1_86
.LBB1_87:
	cmpq	%rbx, %r14
	sete	%dl
	leaq	8(%r14), %rcx
	cmpq	%rbx, %rcx
	sete	%al
	orb	%dl, %al
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	je	.LBB1_110
# %bb.88:
	testb	%al, %al
	jne	.LBB1_119
# %bb.89:
	movl	$8, %eax
	movq	%r14, %rdx
	jmp	.LBB1_93
	.p2align	4, 0x90
.LBB1_90:                               #   in Loop: Header=BB1_93 Depth=1
	movq	%r14, %rcx
.LBB1_91:                               #   in Loop: Header=BB1_93 Depth=1
	movq	%rsi, (%rcx)
.LBB1_92:                               #   in Loop: Header=BB1_93 Depth=1
	leaq	8(%rdx), %rcx
	addq	$8, %rax
	cmpq	%rbx, %rcx
	je	.LBB1_119
.LBB1_93:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_95 Depth 2
	movq	(%rdx), %rdi
	movq	8(%rdx), %rsi
	movq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jae	.LBB1_92
# %bb.94:                               #   in Loop: Header=BB1_93 Depth=1
	movq	%rax, %rcx
	.p2align	4, 0x90
.LBB1_95:                               #   Parent Loop BB1_93 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdi, (%r14,%rcx)
	cmpq	$8, %rcx
	je	.LBB1_90
# %bb.96:                               #   in Loop: Header=BB1_95 Depth=2
	movq	-16(%r14,%rcx), %rdi
	addq	$-8, %rcx
	cmpq	%rdi, %rsi
	jb	.LBB1_95
# %bb.97:                               #   in Loop: Header=BB1_93 Depth=1
	addq	%r14, %rcx
	jmp	.LBB1_91
.LBB1_98:
	cmpq	%rbx, %r14
	je	.LBB1_119
# %bb.99:
	leaq	7(%rsp), %rcx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%rbx, %rdx
	callq	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	jmp	.LBB1_119
.LBB1_100:
	cmpq	%rcx, %rdx
	jae	.LBB1_119
# %bb.101:
	movq	%rdx, 8(%r14)
	movq	%rcx, -8(%rbx)
	movq	(%r14), %rax
	movq	8(%r14), %rcx
	jmp	.LBB1_108
.LBB1_102:
	cmpq	%rsi, %rdi
	jae	.LBB1_86
# %bb.103:
	movq	%rdi, (%rax)
	movq	%rsi, (%rcx)
	movq	%r14, %r8
	movq	%rax, %r9
	movq	%rsi, %r10
	cmpq	%rdx, %rdi
	jae	.LBB1_105
.LBB1_104:
	movq	%rdi, (%r8)
	movq	%rdx, (%r9)
	movq	%r10, %rsi
.LBB1_105:
	movq	-8(%rbx), %rdx
	cmpq	%rsi, %rdx
	jae	.LBB1_119
	jmp	.LBB1_106
.LBB1_86:
	movq	%rdi, %rsi
	movq	-8(%rbx), %rdx
	cmpq	%rsi, %rdx
	jae	.LBB1_119
.LBB1_106:
	movq	%rdx, (%rcx)
	movq	%rsi, -8(%rbx)
	movq	(%rcx), %rcx
	movq	(%rax), %rax
	cmpq	%rax, %rcx
	jae	.LBB1_119
# %bb.107:
	movq	%rcx, 8(%r14)
	movq	%rax, 16(%r14)
	movq	(%r14), %rax
.LBB1_108:
	cmpq	%rax, %rcx
	jae	.LBB1_119
# %bb.109:
	movq	%rcx, (%r14)
	movq	%rax, 8(%r14)
	jmp	.LBB1_119
.LBB1_110:
	testb	%al, %al
	je	.LBB1_112
	jmp	.LBB1_119
	.p2align	4, 0x90
.LBB1_111:                              #   in Loop: Header=BB1_112 Depth=1
	leaq	8(%r14), %rcx
	cmpq	%rbx, %rcx
	je	.LBB1_119
.LBB1_112:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_114 Depth 2
	movq	(%r14), %rdx
	movq	8(%r14), %rax
	movq	%rcx, %r14
	cmpq	%rdx, %rax
	jae	.LBB1_111
# %bb.113:                              #   in Loop: Header=BB1_112 Depth=1
	movq	%r14, %rcx
	.p2align	4, 0x90
.LBB1_114:                              #   Parent Loop BB1_112 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdx, (%rcx)
	movq	-16(%rcx), %rdx
	addq	$-8, %rcx
	cmpq	%rdx, %rax
	jb	.LBB1_114
# %bb.115:                              #   in Loop: Header=BB1_112 Depth=1
	movq	%rax, (%rcx)
	jmp	.LBB1_111
.LBB1_116:
	movq	%rcx, (%r14)
	movq	%rax, 8(%r14)
	movq	-8(%rbx), %rcx
	cmpq	%rax, %rcx
	jae	.LBB1_119
# %bb.117:
	movq	%rcx, 8(%r14)
.LBB1_118:
	movq	%rax, -8(%rbx)
.LBB1_119:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb, .Lfunc_end1-_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_endproc
	.section	.rodata._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"aG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.p2align	2, 0x0
.LJTI1_0:
	.long	.LBB1_119-.LJTI1_0
	.long	.LBB1_119-.LJTI1_0
	.long	.LBB1_77-.LJTI1_0
	.long	.LBB1_79-.LJTI1_0
	.long	.LBB1_83-.LJTI1_0
	.long	.LBB1_82-.LJTI1_0
                                        # -- End function
	.text
	.globl	_Z16sort_u64_branchyPmS_        # -- Begin function _Z16sort_u64_branchyPmS_
	.p2align	4, 0x90
	.type	_Z16sort_u64_branchyPmS_,@function
_Z16sort_u64_branchyPmS_:               # @_Z16sort_u64_branchyPmS_
	.cfi_startproc
# %bb.0:
	movq	%rsi, %rax
	subq	%rdi, %rax
	sarq	$3, %rax
	bsrq	%rax, %rax
	xorl	$63, %eax
	addl	%eax, %eax
	xorq	$126, %rax
	xorl	%edx, %edx
	cmpq	%rdi, %rsi
	cmovneq	%rax, %rdx
	movl	$1, %ecx
	jmp	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb # TAILCALL
.Lfunc_end2:
	.size	_Z16sort_u64_branchyPmS_, .Lfunc_end2-_Z16sort_u64_branchyPmS_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"axG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.weak	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb # -- Begin function _ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.p2align	4, 0x90
	.type	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,@function
_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb: # @_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%ecx, (%rsp)                    # 4-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
.LBB3_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_2 Depth 2
                                        #       Child Loop BB3_77 Depth 3
                                        #       Child Loop BB3_68 Depth 3
                                        #       Child Loop BB3_81 Depth 3
                                        #       Child Loop BB3_84 Depth 3
                                        #         Child Loop BB3_85 Depth 4
                                        #         Child Loop BB3_86 Depth 4
                                        #       Child Loop BB3_53 Depth 3
                                        #       Child Loop BB3_55 Depth 3
                                        #       Child Loop BB3_57 Depth 3
                                        #       Child Loop BB3_61 Depth 3
                                        #         Child Loop BB3_62 Depth 4
                                        #         Child Loop BB3_63 Depth 4
	movq	%r14, %r12
.LBB3_2:                                #   Parent Loop BB3_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_77 Depth 3
                                        #       Child Loop BB3_68 Depth 3
                                        #       Child Loop BB3_81 Depth 3
                                        #       Child Loop BB3_84 Depth 3
                                        #         Child Loop BB3_85 Depth 4
                                        #         Child Loop BB3_86 Depth 4
                                        #       Child Loop BB3_53 Depth 3
                                        #       Child Loop BB3_55 Depth 3
                                        #       Child Loop BB3_57 Depth 3
                                        #       Child Loop BB3_61 Depth 3
                                        #         Child Loop BB3_62 Depth 4
                                        #         Child Loop BB3_63 Depth 4
	movq	%r12, %r14
	movq	%rbx, %rsi
	subq	%r12, %rsi
	sarq	$3, %rsi
	cmpq	$5, %rsi
	jbe	.LBB3_93
# %bb.3:                                #   in Loop: Header=BB3_2 Depth=2
	cmpq	$23, %rsi
	jle	.LBB3_104
# %bb.4:                                #   in Loop: Header=BB3_2 Depth=2
	testq	%r15, %r15
	je	.LBB3_115
# %bb.5:                                #   in Loop: Header=BB3_2 Depth=2
	movq	%rsi, %rdx
	shrq	%rdx
	leaq	(%r14,%rdx,8), %rax
	movq	-8(%rbx), %rcx
	cmpq	$129, %rsi
	jb	.LBB3_9
# %bb.6:                                #   in Loop: Header=BB3_2 Depth=2
	movq	(%rax), %rdi
	movq	(%r14), %rsi
	cmpq	%rsi, %rdi
	jae	.LBB3_12
# %bb.7:                                #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %rcx
	jae	.LBB3_18
# %bb.8:                                #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%r14)
	jmp	.LBB3_20
	.p2align	4, 0x90
.LBB3_9:                                #   in Loop: Header=BB3_2 Depth=2
	movq	(%r14), %rsi
	movq	(%rax), %rdx
	cmpq	%rdx, %rsi
	jae	.LBB3_15
# %bb.10:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rsi, %rcx
	jae	.LBB3_27
# %bb.11:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%rax)
	jmp	.LBB3_29
.LBB3_12:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %rcx
	jae	.LBB3_21
# %bb.13:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%rax)
	movq	%rdi, -8(%rbx)
	movq	(%rax), %rcx
	movq	(%r14), %rsi
	cmpq	%rsi, %rcx
	jae	.LBB3_21
# %bb.14:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%r14)
	movq	%rsi, (%rax)
	jmp	.LBB3_21
.LBB3_15:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rsi, %rcx
	jae	.LBB3_30
# %bb.16:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%r14)
	movq	%rsi, -8(%rbx)
	movq	(%r14), %rcx
	movq	(%rax), %rdx
	cmpq	%rdx, %rcx
	jae	.LBB3_30
# %bb.17:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%rax)
	movq	%rdx, (%r14)
	decq	%r15
	movq	(%r14), %rax
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB3_52
	jmp	.LBB3_51
.LBB3_18:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, (%r14)
	movq	%rsi, (%rax)
	movq	-8(%rbx), %rcx
	cmpq	%rsi, %rcx
	jae	.LBB3_21
# %bb.19:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rcx, (%rax)
.LBB3_20:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rsi, -8(%rbx)
.LBB3_21:                               #   in Loop: Header=BB3_2 Depth=2
	leaq	(%r14,%rdx,8), %rcx
	addq	$-8, %rcx
	movq	-8(%r14,%rdx,8), %rdi
	movq	8(%r14), %rsi
	movq	-16(%rbx), %r8
	cmpq	%rsi, %rdi
	jae	.LBB3_24
# %bb.22:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB3_31
# %bb.23:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, 8(%r14)
	jmp	.LBB3_33
.LBB3_24:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB3_34
# %bb.25:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, (%rcx)
	movq	%rdi, -16(%rbx)
	movq	(%rcx), %rsi
	movq	8(%r14), %rdi
	cmpq	%rdi, %rsi
	jae	.LBB3_34
# %bb.26:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rsi, 8(%r14)
	movq	%rdi, (%rcx)
	jmp	.LBB3_34
.LBB3_27:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rsi, (%rax)
	movq	%rdx, (%r14)
	movq	-8(%rbx), %rax
	cmpq	%rdx, %rax
	jae	.LBB3_30
# %bb.28:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rax, (%r14)
.LBB3_29:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdx, -8(%rbx)
	.p2align	4, 0x90
.LBB3_30:                               #   in Loop: Header=BB3_2 Depth=2
	decq	%r15
	movq	(%r14), %rax
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB3_52
	jmp	.LBB3_51
.LBB3_31:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, 8(%r14)
	movq	%rsi, (%rcx)
	movq	-16(%rbx), %rdi
	cmpq	%rsi, %rdi
	jae	.LBB3_34
# %bb.32:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, (%rcx)
.LBB3_33:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rsi, -16(%rbx)
.LBB3_34:                               #   in Loop: Header=BB3_2 Depth=2
	leaq	(%r14,%rdx,8), %rsi
	addq	$8, %rsi
	movq	8(%r14,%rdx,8), %rdi
	movq	16(%r14), %rdx
	movq	-24(%rbx), %r8
	cmpq	%rdx, %rdi
	jae	.LBB3_37
# %bb.35:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB3_40
# %bb.36:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, 16(%r14)
	jmp	.LBB3_42
.LBB3_37:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdi, %r8
	jae	.LBB3_43
# %bb.38:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, (%rsi)
	movq	%rdi, -24(%rbx)
	movq	(%rsi), %rdx
	movq	16(%r14), %rdi
	cmpq	%rdi, %rdx
	jae	.LBB3_43
# %bb.39:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdx, 16(%r14)
	movq	%rdi, (%rsi)
	jmp	.LBB3_43
.LBB3_40:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, 16(%r14)
	movq	%rdx, (%rsi)
	movq	-24(%rbx), %rdi
	cmpq	%rdx, %rdi
	jae	.LBB3_43
# %bb.41:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, (%rsi)
.LBB3_42:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdx, -24(%rbx)
.LBB3_43:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%rax), %rdx
	movq	(%rcx), %rdi
	movq	(%rsi), %r8
	cmpq	%rdi, %rdx
	jae	.LBB3_47
# %bb.44:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdx, %r8
	jb	.LBB3_49
# %bb.45:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdx, (%rcx)
	movq	%rdi, (%rax)
	movq	%rax, %rcx
	movq	%r8, %rdx
	cmpq	%rdi, %r8
	jb	.LBB3_49
# %bb.46:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, %rdx
	jmp	.LBB3_50
.LBB3_47:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rdx, %r8
	jae	.LBB3_50
# %bb.48:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, (%rax)
	movq	%rdx, (%rsi)
	movq	%rax, %rsi
	movq	%rdi, %rdx
	cmpq	%rdi, %r8
	jae	.LBB3_91
.LBB3_49:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, (%rcx)
	movq	%rdi, (%rsi)
.LBB3_50:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%r14), %rcx
	movq	%rdx, (%r14)
	movq	%rcx, (%rax)
	decq	%r15
	movq	(%r14), %rax
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	jne	.LBB3_52
.LBB3_51:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rax, -8(%r14)
	jae	.LBB3_66
.LBB3_52:                               #   in Loop: Header=BB3_2 Depth=2
	movl	$8, %ecx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB3_53:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%r14,%rcx), %rdx
	addq	$-8, %rsi
	addq	$8, %rcx
	cmpq	%rax, %rdx
	jb	.LBB3_53
# %bb.54:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r14, %rcx
	subq	%rsi, %rcx
	movq	%rbx, %rdi
	cmpq	$-8, %rsi
	je	.LBB3_56
	.p2align	4, 0x90
.LBB3_55:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leaq	-8(%rdi), %rsi
	cmpq	%rax, -8(%rdi)
	movq	%rsi, %rdi
	jae	.LBB3_55
	jmp	.LBB3_59
	.p2align	4, 0x90
.LBB3_56:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rbx, %rdi
	.p2align	4, 0x90
.LBB3_57:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpq	%rdi, %rcx
	jae	.LBB3_69
# %bb.58:                               #   in Loop: Header=BB3_57 Depth=3
	leaq	-8(%rdi), %rsi
	cmpq	%rax, -8(%rdi)
	movq	%rsi, %rdi
	jae	.LBB3_57
	.p2align	4, 0x90
.LBB3_59:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rsi, %rcx
	jae	.LBB3_70
.LBB3_60:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%rsi), %r8
	movq	%rcx, %r13
	movq	%rsi, %rdi
	.p2align	4, 0x90
.LBB3_61:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB3_62 Depth 4
                                        #         Child Loop BB3_63 Depth 4
	movq	%r8, (%r13)
	movq	%rdx, (%rdi)
	.p2align	4, 0x90
.LBB3_62:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        #       Parent Loop BB3_61 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	8(%r13), %rdx
	addq	$8, %r13
	cmpq	%rax, %rdx
	jb	.LBB3_62
	.p2align	4, 0x90
.LBB3_63:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        #       Parent Loop BB3_61 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	-8(%rdi), %r8
	addq	$-8, %rdi
	cmpq	%rax, %r8
	jae	.LBB3_63
# %bb.64:                               #   in Loop: Header=BB3_61 Depth=3
	cmpq	%rdi, %r13
	jb	.LBB3_61
# %bb.65:                               #   in Loop: Header=BB3_2 Depth=2
	addq	$-8, %r13
	cmpq	%r14, %r13
	jne	.LBB3_71
	jmp	.LBB3_72
.LBB3_66:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	-8(%rbx), %rax
	jae	.LBB3_76
# %bb.67:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r14, %rcx
	.p2align	4, 0x90
.LBB3_68:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leaq	8(%rcx), %r12
	cmpq	8(%rcx), %rax
	movq	%r12, %rcx
	jae	.LBB3_68
	jmp	.LBB3_79
.LBB3_69:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rdi, %rsi
	cmpq	%rsi, %rcx
	jb	.LBB3_60
	.p2align	4, 0x90
.LBB3_70:                               #   in Loop: Header=BB3_2 Depth=2
	leaq	-8(%rcx), %r13
	cmpq	%r14, %r13
	je	.LBB3_72
.LBB3_71:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%r13), %rdx
	movq	%rdx, (%r14)
.LBB3_72:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rax, (%r13)
	cmpq	%rsi, %rcx
	jb	.LBB3_75
# %bb.73:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r14, %rdi
	movq	%r13, %rsi
	callq	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	movl	%eax, %ebp
	leaq	8(%r13), %r12
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	testb	%al, %al
	jne	.LBB3_92
# %bb.74:                               #   in Loop: Header=BB3_2 Depth=2
	testb	%bpl, %bpl
	jne	.LBB3_2
.LBB3_75:                               #   in Loop: Header=BB3_2 Depth=2
	xorl	%ecx, %ecx
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	setne	%cl
	movq	%r14, %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	addq	$8, %r13
	movl	$0, (%rsp)                      # 4-byte Folded Spill
	movq	%r13, %r12
	jmp	.LBB3_2
.LBB3_76:                               #   in Loop: Header=BB3_2 Depth=2
	leaq	8(%r14), %rcx
	.p2align	4, 0x90
.LBB3_77:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, %r12
	cmpq	%rbx, %rcx
	jae	.LBB3_79
# %bb.78:                               #   in Loop: Header=BB3_77 Depth=3
	leaq	8(%r12), %rcx
	cmpq	(%r12), %rax
	jae	.LBB3_77
.LBB3_79:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rbx, %rcx
	cmpq	%rbx, %r12
	jae	.LBB3_82
# %bb.80:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rbx, %rdx
	.p2align	4, 0x90
.LBB3_81:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leaq	-8(%rdx), %rcx
	cmpq	-8(%rdx), %rax
	movq	%rcx, %rdx
	jb	.LBB3_81
.LBB3_82:                               #   in Loop: Header=BB3_2 Depth=2
	cmpq	%rcx, %r12
	jae	.LBB3_88
# %bb.83:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%r12), %rdx
	movq	(%rcx), %rsi
	.p2align	4, 0x90
.LBB3_84:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB3_85 Depth 4
                                        #         Child Loop BB3_86 Depth 4
	movq	%rsi, (%r12)
	movq	%rdx, (%rcx)
	.p2align	4, 0x90
.LBB3_85:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        #       Parent Loop BB3_84 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	8(%r12), %rdx
	addq	$8, %r12
	cmpq	%rdx, %rax
	jae	.LBB3_85
	.p2align	4, 0x90
.LBB3_86:                               #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        #       Parent Loop BB3_84 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movq	-8(%rcx), %rsi
	addq	$-8, %rcx
	cmpq	%rsi, %rax
	jb	.LBB3_86
# %bb.87:                               #   in Loop: Header=BB3_84 Depth=3
	cmpq	%rcx, %r12
	jb	.LBB3_84
.LBB3_88:                               #   in Loop: Header=BB3_2 Depth=2
	leaq	-8(%r12), %rcx
	cmpq	%r14, %rcx
	je	.LBB3_90
# %bb.89:                               #   in Loop: Header=BB3_2 Depth=2
	movq	(%rcx), %rdx
	movq	%rdx, (%r14)
.LBB3_90:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%rax, (%rcx)
	jmp	.LBB3_2
.LBB3_91:                               #   in Loop: Header=BB3_2 Depth=2
	movq	%r8, %rdx
	jmp	.LBB3_50
.LBB3_92:                               #   in Loop: Header=BB3_1 Depth=1
	movq	%r13, %rbx
	testb	%bpl, %bpl
	je	.LBB3_1
	jmp	.LBB3_136
.LBB3_93:
	leaq	.LJTI3_0(%rip), %rax
	movslq	(%rax,%rsi,4), %rcx
	addq	%rax, %rcx
	jmpq	*%rcx
.LBB3_94:
	movq	-8(%rbx), %rax
	movq	(%r14), %rcx
	cmpq	%rcx, %rax
	jae	.LBB3_136
# %bb.95:
	movq	%rax, (%r14)
	movq	%rcx, -8(%rbx)
	jmp	.LBB3_136
.LBB3_96:
	movq	(%r14), %rax
	movq	8(%r14), %rcx
	movq	-8(%rbx), %rdx
	cmpq	%rax, %rcx
	jae	.LBB3_117
# %bb.97:
	cmpq	%rcx, %rdx
	jae	.LBB3_133
# %bb.98:
	movq	%rdx, (%r14)
	jmp	.LBB3_135
.LBB3_99:
	leaq	8(%r14), %rsi
	leaq	16(%r14), %rdx
	leaq	24(%r14), %rcx
	addq	$-8, %rbx
	movq	%r14, %rdi
	movq	%rbx, %r8
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_ # TAILCALL
.LBB3_100:
	.cfi_def_cfa_offset 64
	leaq	8(%r14), %rax
	leaq	16(%r14), %rcx
	movq	(%r14), %rdx
	movq	8(%r14), %rsi
	movq	16(%r14), %rdi
	cmpq	%rdx, %rsi
	jae	.LBB3_119
# %bb.101:
	movq	%r14, %r8
	movq	%rcx, %r9
	movq	%rdx, %r10
	cmpq	%rsi, %rdi
	jb	.LBB3_121
# %bb.102:
	movq	%rsi, (%r14)
	movq	%rdx, 8(%r14)
	movq	%rax, %r8
	movq	%rcx, %r9
	movq	%rdx, %r10
	cmpq	%rdx, %rdi
	jb	.LBB3_121
	jmp	.LBB3_103
.LBB3_104:
	cmpq	%rbx, %r14
	sete	%dl
	leaq	8(%r14), %rcx
	cmpq	%rbx, %rcx
	sete	%al
	orb	%dl, %al
	cmpb	$0, (%rsp)                      # 1-byte Folded Reload
	je	.LBB3_127
# %bb.105:
	testb	%al, %al
	jne	.LBB3_136
# %bb.106:
	movl	$8, %eax
	movq	%r14, %rdx
	jmp	.LBB3_110
	.p2align	4, 0x90
.LBB3_107:                              #   in Loop: Header=BB3_110 Depth=1
	movq	%r14, %rcx
.LBB3_108:                              #   in Loop: Header=BB3_110 Depth=1
	movq	%rsi, (%rcx)
.LBB3_109:                              #   in Loop: Header=BB3_110 Depth=1
	leaq	8(%rdx), %rcx
	addq	$8, %rax
	cmpq	%rbx, %rcx
	je	.LBB3_136
.LBB3_110:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_112 Depth 2
	movq	(%rdx), %rdi
	movq	8(%rdx), %rsi
	movq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jae	.LBB3_109
# %bb.111:                              #   in Loop: Header=BB3_110 Depth=1
	movq	%rax, %rcx
	.p2align	4, 0x90
.LBB3_112:                              #   Parent Loop BB3_110 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdi, (%r14,%rcx)
	cmpq	$8, %rcx
	je	.LBB3_107
# %bb.113:                              #   in Loop: Header=BB3_112 Depth=2
	movq	-16(%r14,%rcx), %rdi
	addq	$-8, %rcx
	cmpq	%rdi, %rsi
	jb	.LBB3_112
# %bb.114:                              #   in Loop: Header=BB3_110 Depth=1
	addq	%r14, %rcx
	jmp	.LBB3_108
.LBB3_115:
	cmpq	%rbx, %r14
	je	.LBB3_136
# %bb.116:
	leaq	7(%rsp), %rcx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%rbx, %rdx
	callq	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	jmp	.LBB3_136
.LBB3_117:
	cmpq	%rcx, %rdx
	jae	.LBB3_136
# %bb.118:
	movq	%rdx, 8(%r14)
	movq	%rcx, -8(%rbx)
	movq	(%r14), %rax
	movq	8(%r14), %rcx
	jmp	.LBB3_125
.LBB3_119:
	cmpq	%rsi, %rdi
	jae	.LBB3_103
# %bb.120:
	movq	%rdi, (%rax)
	movq	%rsi, (%rcx)
	movq	%r14, %r8
	movq	%rax, %r9
	movq	%rsi, %r10
	cmpq	%rdx, %rdi
	jae	.LBB3_122
.LBB3_121:
	movq	%rdi, (%r8)
	movq	%rdx, (%r9)
	movq	%r10, %rsi
.LBB3_122:
	movq	-8(%rbx), %rdx
	cmpq	%rsi, %rdx
	jae	.LBB3_136
	jmp	.LBB3_123
.LBB3_103:
	movq	%rdi, %rsi
	movq	-8(%rbx), %rdx
	cmpq	%rsi, %rdx
	jae	.LBB3_136
.LBB3_123:
	movq	%rdx, (%rcx)
	movq	%rsi, -8(%rbx)
	movq	(%rcx), %rcx
	movq	(%rax), %rax
	cmpq	%rax, %rcx
	jae	.LBB3_136
# %bb.124:
	movq	%rcx, 8(%r14)
	movq	%rax, 16(%r14)
	movq	(%r14), %rax
.LBB3_125:
	cmpq	%rax, %rcx
	jae	.LBB3_136
# %bb.126:
	movq	%rcx, (%r14)
	movq	%rax, 8(%r14)
	jmp	.LBB3_136
.LBB3_127:
	testb	%al, %al
	je	.LBB3_129
	jmp	.LBB3_136
	.p2align	4, 0x90
.LBB3_128:                              #   in Loop: Header=BB3_129 Depth=1
	leaq	8(%r14), %rcx
	cmpq	%rbx, %rcx
	je	.LBB3_136
.LBB3_129:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_131 Depth 2
	movq	(%r14), %rdx
	movq	8(%r14), %rax
	movq	%rcx, %r14
	cmpq	%rdx, %rax
	jae	.LBB3_128
# %bb.130:                              #   in Loop: Header=BB3_129 Depth=1
	movq	%r14, %rcx
	.p2align	4, 0x90
.LBB3_131:                              #   Parent Loop BB3_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdx, (%rcx)
	movq	-16(%rcx), %rdx
	addq	$-8, %rcx
	cmpq	%rdx, %rax
	jb	.LBB3_131
# %bb.132:                              #   in Loop: Header=BB3_129 Depth=1
	movq	%rax, (%rcx)
	jmp	.LBB3_128
.LBB3_133:
	movq	%rcx, (%r14)
	movq	%rax, 8(%r14)
	movq	-8(%rbx), %rcx
	cmpq	%rax, %rcx
	jae	.LBB3_136
# %bb.134:
	movq	%rcx, 8(%r14)
.LBB3_135:
	movq	%rax, -8(%rbx)
.LBB3_136:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb, .Lfunc_end3-_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_endproc
	.section	.rodata._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"aG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.p2align	2, 0x0
.LJTI3_0:
	.long	.LBB3_136-.LJTI3_0
	.long	.LBB3_136-.LJTI3_0
	.long	.LBB3_94-.LJTI3_0
	.long	.LBB3_96-.LJTI3_0
	.long	.LBB3_100-.LJTI3_0
	.long	.LBB3_99-.LJTI3_0
                                        # -- End function
	.section	.text._ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,"axG",@progbits,_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,comdat
	.hidden	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_ # -- Begin function _ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.weak	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.p2align	4, 0x90
	.type	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,@function
_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_: # @_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	(%rdi), %r8
	cmpq	-8(%rsi), %r8
	jae	.LBB4_1
# %bb.4:
	movq	%rdi, %rax
	.p2align	4, 0x90
.LBB4_5:                                # =>This Inner Loop Header: Depth=1
	leaq	8(%rax), %rdx
	cmpq	8(%rax), %r8
	movq	%rdx, %rax
	jae	.LBB4_5
	jmp	.LBB4_6
.LBB4_1:
	leaq	8(%rdi), %rax
	.p2align	4, 0x90
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	movq	%rax, %rdx
	cmpq	%rsi, %rax
	jae	.LBB4_6
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=1
	leaq	8(%rdx), %rax
	cmpq	(%rdx), %r8
	jae	.LBB4_2
.LBB4_6:
	cmpq	%rsi, %rdx
	jae	.LBB4_7
	.p2align	4, 0x90
.LBB4_8:                                # =>This Inner Loop Header: Depth=1
	leaq	-8(%rsi), %r9
	cmpq	-8(%rsi), %r8
	movq	%r9, %rsi
	jb	.LBB4_8
# %bb.9:
	movq	%rdx, %r10
	cmpq	%r9, %rdx
	jae	.LBB4_11
.LBB4_10:
	movq	(%rdx), %rax
	movq	(%r9), %rcx
	movq	%rcx, (%rdx)
	movq	%rax, (%r9)
	leaq	8(%rdx), %r10
.LBB4_11:
	leaq	-8(%r9), %rsi
	movq	%rsi, %r14
	subq	%r10, %r14
	cmpq	$1009, %r14                     # imm = 0x3F1
	jl	.LBB4_25
# %bb.12:
	xorl	%r11d, %r11d
	xorl	%ebx, %ebx
	jmp	.LBB4_13
	.p2align	4, 0x90
.LBB4_22:                               #   in Loop: Header=BB4_13 Depth=1
	xorl	%eax, %eax
	testq	%rbx, %rbx
	sete	%al
	shll	$9, %eax
	addq	%rax, %r10
	xorl	%eax, %eax
	testq	%r11, %r11
	setne	%al
	shll	$9, %eax
	addq	%rax, %rsi
	addq	$-512, %rsi                     # imm = 0xFE00
	movq	%rsi, %r14
	subq	%r10, %r14
	cmpq	$1008, %r14                     # imm = 0x3F0
	jle	.LBB4_23
.LBB4_13:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_15 Depth 2
                                        #     Child Loop BB4_18 Depth 2
                                        #     Child Loop BB4_20 Depth 2
	testq	%rbx, %rbx
	jne	.LBB4_16
# %bb.14:                               #   in Loop: Header=BB4_13 Depth=1
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_15:                               #   Parent Loop BB4_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%r15d, %r15d
	cmpq	%r8, (%r10,%rax,8)
	setae	%r15b
	movl	%eax, %ecx
	shlq	%cl, %r15
	orq	%rbx, %r15
	xorl	%ebx, %ebx
	cmpq	%r8, 8(%r10,%rax,8)
	setae	%bl
	leal	1(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %rbx
	xorl	%r14d, %r14d
	cmpq	%r8, 16(%r10,%rax,8)
	setae	%r14b
	leal	2(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r14
	orq	%rbx, %r14
	orq	%r15, %r14
	xorl	%ebx, %ebx
	cmpq	%r8, 24(%r10,%rax,8)
	setae	%bl
	leal	3(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %rbx
	orq	%r14, %rbx
	addq	$4, %rax
	cmpq	$64, %rax
	jne	.LBB4_15
.LBB4_16:                               #   in Loop: Header=BB4_13 Depth=1
	testq	%r11, %r11
	jne	.LBB4_19
# %bb.17:                               #   in Loop: Header=BB4_13 Depth=1
	xorl	%r11d, %r11d
	xorl	%eax, %eax
	movq	%rsi, %r12
	.p2align	4, 0x90
.LBB4_18:                               #   Parent Loop BB4_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xorl	%r14d, %r14d
	cmpq	%r8, (%r12)
	setb	%r14b
	movl	%eax, %ecx
	shlq	%cl, %r14
	orq	%r11, %r14
	xorl	%r11d, %r11d
	cmpq	%r8, -8(%r12)
	setb	%r11b
	leal	1(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r11
	xorl	%r15d, %r15d
	cmpq	%r8, -16(%r12)
	setb	%r15b
	leal	2(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r15
	orq	%r11, %r15
	orq	%r14, %r15
	xorl	%r11d, %r11d
	cmpq	%r8, -24(%r12)
	setb	%r11b
	leal	3(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r11
	orq	%r15, %r11
	addq	$4, %rax
	addq	$-32, %r12
	cmpq	$64, %rax
	jne	.LBB4_18
.LBB4_19:                               #   in Loop: Header=BB4_13 Depth=1
	testq	%rbx, %rbx
	je	.LBB4_22
	.p2align	4, 0x90
.LBB4_20:                               #   Parent Loop BB4_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	testq	%r11, %r11
	je	.LBB4_22
# %bb.21:                               #   in Loop: Header=BB4_20 Depth=2
	movq	%rbx, %rax
	movq	%r11, %rcx
	rep		bsfq	%rbx, %rbx
	rep		bsfq	%r11, %r11
	shll	$3, %r11d
	movq	%rsi, %r14
	subq	%r11, %r14
	movq	(%r10,%rbx,8), %r15
	movq	(%r14), %r11
	movq	%r11, (%r10,%rbx,8)
	leaq	-1(%rax), %rbx
	leaq	-1(%rcx), %r11
	andq	%rcx, %r11
	movq	%r15, (%r14)
	andq	%rax, %rbx
	jne	.LBB4_20
	jmp	.LBB4_22
.LBB4_7:
	movq	%rsi, %r9
	movq	%rdx, %r10
	cmpq	%r9, %rdx
	jb	.LBB4_10
	jmp	.LBB4_11
.LBB4_25:
	sarq	$3, %r14
	movb	$1, %cl
	xorl	%r11d, %r11d
	jmp	.LBB4_26
.LBB4_23:
	sarq	$3, %r14
	testq	%r11, %r11
	sete	%cl
	movq	%rbx, %rax
	orq	%r11, %rax
	je	.LBB4_26
# %bb.24:
	addq	$-63, %r14
	movl	$64, %r15d
	movl	$64, %eax
	testq	%rbx, %rbx
	jne	.LBB4_38
# %bb.27:
	testq	%r14, %r14
	jle	.LBB4_28
.LBB4_29:
	movq	%r15, -8(%rsp)                  # 8-byte Spill
	movb	%cl, -24(%rsp)                  # 1-byte Spill
	movl	%r14d, %r15d
	andl	$3, %r15d
	cmpq	$4, %r14
	jae	.LBB4_31
# %bb.30:
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	movq	%r10, %r13
	testq	%r15, %r15
	jne	.LBB4_35
	jmp	.LBB4_37
.LBB4_26:
	leaq	1(%r14), %r15
	movq	%r15, %rax
	shrq	$63, %rax
	addq	%rax, %r14
	incq	%r14
	sarq	%r14
	subq	%r14, %r15
	testq	%r14, %r14
	jg	.LBB4_29
.LBB4_28:
	xorl	%ebx, %ebx
	movq	%r14, %rax
	movq	%r15, %r14
	jmp	.LBB4_38
.LBB4_31:
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movabsq	$9223372036854775804, %rbp      # imm = 0x7FFFFFFFFFFFFFFC
	andq	%r14, %rbp
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	movq	%r10, %r13
	.p2align	4, 0x90
.LBB4_32:                               # =>This Inner Loop Header: Depth=1
	xorl	%edi, %edi
	cmpq	%r8, (%r13)
	setae	%dil
	movl	%eax, %ecx
	shlq	%cl, %rdi
	orq	%rbx, %rdi
	xorl	%ebx, %ebx
	cmpq	%r8, 8(%r13)
	setae	%bl
	leal	1(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %rbx
	xorl	%r12d, %r12d
	cmpq	%r8, 16(%r13)
	setae	%r12b
	leal	2(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r12
	orq	%rbx, %r12
	orq	%rdi, %r12
	xorl	%ebx, %ebx
	cmpq	%r8, 24(%r13)
	setae	%bl
	leal	3(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %rbx
	orq	%r12, %rbx
	addq	$32, %r13
	addq	$4, %rax
	cmpq	%rbp, %rax
	jne	.LBB4_32
# %bb.33:
	movq	-16(%rsp), %rdi                 # 8-byte Reload
	testq	%r15, %r15
	je	.LBB4_37
.LBB4_35:
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB4_36:                               # =>This Inner Loop Header: Depth=1
	leal	(%rax,%rbp), %ecx
	xorl	%r12d, %r12d
	cmpq	%r8, (%r13,%rbp,8)
	setae	%r12b
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r12
	orq	%r12, %rbx
	incq	%rbp
	cmpq	%rbp, %r15
	jne	.LBB4_36
.LBB4_37:
	movq	%r14, %rax
	movq	-8(%rsp), %r14                  # 8-byte Reload
	movzbl	-24(%rsp), %ecx                 # 1-byte Folded Reload
.LBB4_38:
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	testb	%cl, %cl
	je	.LBB4_48
# %bb.39:
	testq	%r14, %r14
	jle	.LBB4_48
# %bb.40:
	movl	%r14d, %r12d
	andl	$3, %r12d
	cmpq	$4, %r14
	jae	.LBB4_42
# %bb.41:
	xorl	%r11d, %r11d
	xorl	%eax, %eax
	movq	%rsi, %r13
	testq	%r12, %r12
	jne	.LBB4_46
	jmp	.LBB4_48
.LBB4_42:
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movq	%r14, %rdi
	andq	$-4, %rdi
	xorl	%r11d, %r11d
	xorl	%eax, %eax
	movq	%rsi, %r13
	.p2align	4, 0x90
.LBB4_43:                               # =>This Inner Loop Header: Depth=1
	xorl	%ebp, %ebp
	cmpq	%r8, (%r13)
	setb	%bpl
	movl	%eax, %ecx
	shlq	%cl, %rbp
	orq	%r11, %rbp
	xorl	%r11d, %r11d
	cmpq	%r8, -8(%r13)
	setb	%r11b
	leal	1(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r11
	xorl	%r15d, %r15d
	cmpq	%r8, -16(%r13)
	setb	%r15b
	leal	2(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r15
	orq	%r11, %r15
	orq	%rbp, %r15
	xorl	%r11d, %r11d
	cmpq	%r8, -24(%r13)
	setb	%r11b
	leal	3(%rax), %ecx
                                        # kill: def $cl killed $cl killed $ecx
	shlq	%cl, %r11
	orq	%r15, %r11
	addq	$-32, %r13
	addq	$4, %rax
	cmpq	%rdi, %rax
	jne	.LBB4_43
# %bb.44:
	movq	-16(%rsp), %rdi                 # 8-byte Reload
	testq	%r12, %r12
	je	.LBB4_48
.LBB4_46:
	negq	%r12
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB4_47:                               # =>This Inner Loop Header: Depth=1
	xorl	%r15d, %r15d
	cmpq	%r8, (%r13,%rbp,8)
	setb	%r15b
	movl	%eax, %ecx
	shlq	%cl, %r15
	orq	%r15, %r11
	incq	%rax
	decq	%rbp
	cmpq	%rbp, %r12
	jne	.LBB4_47
.LBB4_48:
	testq	%rbx, %rbx
	je	.LBB4_51
	.p2align	4, 0x90
.LBB4_49:                               # =>This Inner Loop Header: Depth=1
	testq	%r11, %r11
	je	.LBB4_51
# %bb.50:                               #   in Loop: Header=BB4_49 Depth=1
	movq	%rbx, %rax
	movq	%r11, %rcx
	rep		bsfq	%rbx, %rbx
	rep		bsfq	%r11, %r11
	shll	$3, %r11d
	movq	%rsi, %r15
	subq	%r11, %r15
	movq	(%r10,%rbx,8), %r12
	movq	(%r15), %r11
	movq	%r11, (%r10,%rbx,8)
	leaq	-1(%rax), %rbx
	leaq	-1(%rcx), %r11
	andq	%rcx, %r11
	movq	%r12, (%r15)
	andq	%rax, %rbx
	jne	.LBB4_49
.LBB4_51:
	xorl	%eax, %eax
	testq	%r11, %r11
	cmovneq	%rax, %r14
	shlq	$3, %r14
	subq	%r14, %rsi
	testq	%rbx, %rbx
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	cmovneq	%rax, %rcx
	leaq	(%r10,%rcx,8), %rax
	jne	.LBB4_52
	jmp	.LBB4_59
	.p2align	4, 0x90
.LBB4_54:                               #   in Loop: Header=BB4_52 Depth=1
	notq	%r14
	andq	%r14, %rbx
	addq	$-8, %rsi
	testq	%rbx, %rbx
	je	.LBB4_55
.LBB4_52:                               # =>This Inner Loop Header: Depth=1
	bsrq	%rbx, %rcx
	movq	$-1, %r14
	shlq	%cl, %r14
	movl	%ecx, %ecx
	leaq	(%rax,%rcx,8), %rcx
	cmpq	%rcx, %rsi
	je	.LBB4_54
# %bb.53:                               #   in Loop: Header=BB4_52 Depth=1
	movq	(%rcx), %r10
	movq	(%rsi), %r11
	movq	%r11, (%rcx)
	movq	%r10, (%rsi)
	jmp	.LBB4_54
	.p2align	4, 0x90
.LBB4_62:                               #   in Loop: Header=BB4_59 Depth=1
	notq	%r14
	andq	%r14, %r11
	addq	$8, %rax
.LBB4_59:                               # =>This Inner Loop Header: Depth=1
	testq	%r11, %r11
	je	.LBB4_56
# %bb.60:                               #   in Loop: Header=BB4_59 Depth=1
	bsrq	%r11, %rcx
	movq	$-1, %r14
	shlq	%cl, %r14
	shll	$3, %ecx
	movq	%rsi, %r10
	subq	%rcx, %r10
	cmpq	%r10, %rax
	je	.LBB4_62
# %bb.61:                               #   in Loop: Header=BB4_59 Depth=1
	movq	(%r10), %rcx
	movq	(%rax), %rbx
	movq	%rbx, (%r10)
	movq	%rcx, (%rax)
	jmp	.LBB4_62
.LBB4_55:
	addq	$8, %rsi
	movq	%rsi, %rax
.LBB4_56:
	addq	$-8, %rax
	cmpq	%rdi, %rax
	je	.LBB4_58
# %bb.57:
	movq	(%rax), %rcx
	movq	%rcx, (%rdi)
.LBB4_58:
	cmpq	%r9, %rdx
	setae	%dl
	movq	%r8, (%rax)
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_, .Lfunc_end4-_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,"axG",@progbits,_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,comdat
	.hidden	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_ # -- Begin function _ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.weak	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.p2align	4, 0x90
	.type	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,@function
_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_: # @_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rsi, %r8
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	sarq	$3, %rcx
	movb	$1, %al
	cmpq	$5, %rcx
	ja	.LBB5_10
# %bb.1:
	leaq	.LJTI5_0(%rip), %rdx
	movslq	(%rdx,%rcx,4), %rcx
	addq	%rdx, %rcx
	jmpq	*%rcx
.LBB5_2:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB5_3:
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rcx
	movq	8(%rdi), %rdx
	movq	-8(%r8), %rsi
	cmpq	%rcx, %rdx
	jae	.LBB5_17
# %bb.4:
	cmpq	%rdx, %rsi
	jae	.LBB5_40
# %bb.5:
	movq	%rsi, (%rdi)
	jmp	.LBB5_6
.LBB5_7:
	movq	-8(%r8), %rcx
	movq	(%rdi), %rdx
	cmpq	%rdx, %rcx
	jae	.LBB5_2
# %bb.8:
	movq	%rcx, (%rdi)
	movq	%rdx, -8(%r8)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB5_9:
	.cfi_def_cfa_offset 32
	leaq	8(%rdi), %rsi
	leaq	16(%rdi), %rdx
	leaq	24(%rdi), %rcx
	addq	$-8, %r8
	callq	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	movb	$1, %al
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB5_10:
	.cfi_def_cfa_offset 32
	leaq	16(%rdi), %rsi
	leaq	8(%rdi), %r9
	movq	(%rdi), %rcx
	movq	8(%rdi), %r10
	movq	16(%rdi), %rdx
	cmpq	%rcx, %r10
	jae	.LBB5_19
# %bb.11:
	movq	%rdi, %r11
	movq	%rsi, %rbx
	cmpq	%r10, %rdx
	jb	.LBB5_22
# %bb.12:
	movq	%r10, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%r9, %r11
	movq	%rsi, %rbx
	jmp	.LBB5_21
.LBB5_13:
	leaq	8(%rdi), %rcx
	leaq	16(%rdi), %rdx
	movq	(%rdi), %rsi
	movq	8(%rdi), %r10
	movq	16(%rdi), %r9
	cmpq	%rsi, %r10
	jae	.LBB5_32
# %bb.14:
	movq	%rdi, %r11
	movq	%rdx, %rbx
	movq	%rsi, %r14
	cmpq	%r10, %r9
	jb	.LBB5_34
# %bb.15:
	movq	%r10, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%rcx, %r11
	movq	%rdx, %rbx
	movq	%rsi, %r14
	cmpq	%rsi, %r9
	jb	.LBB5_34
	jmp	.LBB5_42
.LBB5_17:
	cmpq	%rdx, %rsi
	jae	.LBB5_2
# %bb.18:
	movq	%rsi, 8(%rdi)
	movq	%rdx, -8(%r8)
	movq	(%rdi), %rcx
	movq	8(%rdi), %rdx
	jmp	.LBB5_38
.LBB5_19:
	cmpq	%r10, %rdx
	jae	.LBB5_23
# %bb.20:
	movq	%rdx, (%r9)
	movq	%r10, (%rsi)
	movq	%rdi, %r11
	movq	%r9, %rbx
.LBB5_21:
	cmpq	%rcx, %rdx
	jae	.LBB5_23
.LBB5_22:
	movq	%rdx, (%r11)
	movq	%rcx, (%rbx)
.LBB5_23:
	leaq	24(%rdi), %rcx
	cmpq	%r8, %rcx
	je	.LBB5_2
# %bb.24:
	xorl	%edx, %edx
	movl	$24, %r9d
	jmp	.LBB5_26
	.p2align	4, 0x90
.LBB5_25:                               #   in Loop: Header=BB5_26 Depth=1
	movq	%rdi, %rsi
	movq	%r10, (%rsi)
	incl	%edx
	cmpl	$8, %edx
	je	.LBB5_43
.LBB5_31:                               #   in Loop: Header=BB5_26 Depth=1
	movq	%rcx, %rsi
	leaq	8(%rcx), %r10
	addq	$8, %r9
	movq	%r10, %rcx
	cmpq	%r8, %r10
	je	.LBB5_2
.LBB5_26:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_28 Depth 2
	movq	(%rcx), %r10
	movq	(%rsi), %r11
	cmpq	%r11, %r10
	jae	.LBB5_31
# %bb.27:                               #   in Loop: Header=BB5_26 Depth=1
	movq	%r9, %rsi
	.p2align	4, 0x90
.LBB5_28:                               #   Parent Loop BB5_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r11, (%rdi,%rsi)
	cmpq	$8, %rsi
	je	.LBB5_25
# %bb.29:                               #   in Loop: Header=BB5_28 Depth=2
	movq	-16(%rdi,%rsi), %r11
	addq	$-8, %rsi
	cmpq	%r11, %r10
	jb	.LBB5_28
# %bb.30:                               #   in Loop: Header=BB5_26 Depth=1
	addq	%rdi, %rsi
	movq	%r10, (%rsi)
	incl	%edx
	cmpl	$8, %edx
	jne	.LBB5_31
.LBB5_43:
	addq	$8, %rcx
	cmpq	%r8, %rcx
	sete	%al
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB5_32:
	.cfi_def_cfa_offset 32
	cmpq	%r10, %r9
	jae	.LBB5_42
# %bb.33:
	movq	%r9, (%rcx)
	movq	%r10, (%rdx)
	movq	%rdi, %r11
	movq	%rcx, %rbx
	movq	%r10, %r14
	cmpq	%rsi, %r9
	jae	.LBB5_35
.LBB5_34:
	movq	%r9, (%r11)
	movq	%rsi, (%rbx)
	movq	%r14, %r10
.LBB5_35:
	movq	-8(%r8), %rsi
	cmpq	%r10, %rsi
	jae	.LBB5_2
	jmp	.LBB5_36
.LBB5_42:
	movq	%r9, %r10
	movq	-8(%r8), %rsi
	cmpq	%r10, %rsi
	jae	.LBB5_2
.LBB5_36:
	movq	%rsi, (%rdx)
	movq	%r10, -8(%r8)
	movq	(%rdx), %rdx
	movq	(%rcx), %rcx
	cmpq	%rcx, %rdx
	jae	.LBB5_2
# %bb.37:
	movq	%rdx, 8(%rdi)
	movq	%rcx, 16(%rdi)
	movq	(%rdi), %rcx
.LBB5_38:
	cmpq	%rcx, %rdx
	jae	.LBB5_2
# %bb.39:
	movq	%rdx, (%rdi)
	movq	%rcx, 8(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB5_40:
	.cfi_def_cfa_offset 32
	movq	%rdx, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	-8(%r8), %rdx
	cmpq	%rcx, %rdx
	jae	.LBB5_2
# %bb.41:
	movq	%rdx, 8(%rdi)
.LBB5_6:
	movq	%rcx, -8(%r8)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_, .Lfunc_end5-_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.cfi_endproc
	.section	.rodata._ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,"aG",@progbits,_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,comdat
	.p2align	2, 0x0
.LJTI5_0:
	.long	.LBB5_2-.LJTI5_0
	.long	.LBB5_2-.LJTI5_0
	.long	.LBB5_7-.LJTI5_0
	.long	.LBB5_3-.LJTI5_0
	.long	.LBB5_13-.LJTI5_0
	.long	.LBB5_9-.LJTI5_0
                                        # -- End function
	.section	.text._ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,"axG",@progbits,_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,comdat
	.hidden	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_ # -- Begin function _ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.weak	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.p2align	4, 0x90
	.type	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,@function
_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_: # @_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.cfi_startproc
# %bb.0:
	movq	(%rsi), %rax
	movq	(%rdi), %r9
	movq	(%rdx), %r10
	cmpq	%r9, %rax
	jae	.LBB6_1
# %bb.5:
	cmpq	%rax, %r10
	jae	.LBB6_7
# %bb.6:
	movq	%r10, (%rdi)
	jmp	.LBB6_9
.LBB6_1:
	cmpq	%rax, %r10
	jae	.LBB6_2
# %bb.3:
	movq	%r10, (%rsi)
	movq	%rax, (%rdx)
	movq	(%rsi), %r9
	movq	(%rdi), %r10
	cmpq	%r10, %r9
	jae	.LBB6_10
# %bb.4:
	movq	%r9, (%rdi)
	movq	%r10, (%rsi)
	movq	(%rdx), %rax
	movq	(%rcx), %r9
	cmpq	%rax, %r9
	jb	.LBB6_11
	jmp	.LBB6_14
.LBB6_7:
	movq	%rax, (%rdi)
	movq	%r9, (%rsi)
	movq	(%rdx), %rax
	cmpq	%r9, %rax
	jae	.LBB6_10
# %bb.8:
	movq	%rax, (%rsi)
.LBB6_9:
	movq	%r9, (%rdx)
	movq	%r9, %rax
.LBB6_10:
	movq	(%rcx), %r9
	cmpq	%rax, %r9
	jae	.LBB6_14
.LBB6_11:
	movq	%r9, (%rdx)
	movq	%rax, (%rcx)
	movq	(%rdx), %rax
	movq	(%rsi), %r9
	cmpq	%r9, %rax
	jae	.LBB6_14
# %bb.12:
	movq	%rax, (%rsi)
	movq	%r9, (%rdx)
	movq	(%rsi), %rax
	movq	(%rdi), %r9
	cmpq	%r9, %rax
	jae	.LBB6_14
# %bb.13:
	movq	%rax, (%rdi)
	movq	%r9, (%rsi)
	jmp	.LBB6_14
.LBB6_2:
	movq	%r10, %rax
	movq	(%rcx), %r9
	cmpq	%rax, %r9
	jb	.LBB6_11
.LBB6_14:
	movq	(%r8), %rax
	movq	(%rcx), %r9
	cmpq	%r9, %rax
	jae	.LBB6_19
# %bb.15:
	movq	%rax, (%rcx)
	movq	%r9, (%r8)
	movq	(%rcx), %rax
	movq	(%rdx), %r8
	cmpq	%r8, %rax
	jae	.LBB6_19
# %bb.16:
	movq	%rax, (%rdx)
	movq	%r8, (%rcx)
	movq	(%rdx), %rax
	movq	(%rsi), %rcx
	cmpq	%rcx, %rax
	jae	.LBB6_19
# %bb.17:
	movq	%rax, (%rsi)
	movq	%rcx, (%rdx)
	movq	(%rsi), %rax
	movq	(%rdi), %rcx
	cmpq	%rcx, %rax
	jae	.LBB6_19
# %bb.18:
	movq	%rax, (%rdi)
	movq	%rcx, (%rsi)
.LBB6_19:
	retq
.Lfunc_end6:
	.size	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_, .Lfunc_end6-_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,"axG",@progbits,_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,comdat
	.hidden	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_ # -- Begin function _ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.weak	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.p2align	4, 0x90
	.type	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,@function
_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_: # @_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.cfi_startproc
# %bb.0:
	movq	%rdx, %rax
	cmpq	%rsi, %rdi
	je	.LBB7_52
# %bb.1:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	sarq	$3, %rcx
	cmpq	$2, %rcx
	jl	.LBB7_15
# %bb.2:
	leaq	-2(%rcx), %r8
	shrq	%r8
	movabsq	$4611686018427387902, %rdx      # imm = 0x3FFFFFFFFFFFFFFE
	movq	%r8, %r10
	jmp	.LBB7_3
	.p2align	4, 0x90
.LBB7_13:                               #   in Loop: Header=BB7_3 Depth=1
	movq	%r14, (%r12)
.LBB7_14:                               #   in Loop: Header=BB7_3 Depth=1
	leaq	-1(%r10), %r9
	testq	%r10, %r10
	movq	%r9, %r10
	jle	.LBB7_15
.LBB7_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_8 Depth 2
	cmpq	%r10, %r8
	jl	.LBB7_14
# %bb.4:                                #   in Loop: Header=BB7_3 Depth=1
	leaq	(%r10,%r10), %r14
	andq	%rdx, %r14
	leaq	1(%r14), %r15
	leaq	(%rdi,%r14,8), %r11
	addq	$8, %r11
	addq	$2, %r14
	cmpq	%rcx, %r14
	jge	.LBB7_5
# %bb.6:                                #   in Loop: Header=BB7_3 Depth=1
	leaq	8(%r11), %r12
	movq	(%r11), %r13
	movq	8(%r11), %rbx
	cmpq	%rbx, %r13
	cmovaq	%r13, %rbx
	cmovbq	%r12, %r11
	cmovbq	%r14, %r15
	leaq	(%rdi,%r10,8), %r12
	movq	(%r12), %r14
	cmpq	%r14, %rbx
	jae	.LBB7_8
	jmp	.LBB7_14
	.p2align	4, 0x90
.LBB7_5:                                #   in Loop: Header=BB7_3 Depth=1
	movq	(%r11), %rbx
	leaq	(%rdi,%r10,8), %r12
	movq	(%r12), %r14
	cmpq	%r14, %rbx
	jae	.LBB7_8
	jmp	.LBB7_14
	.p2align	4, 0x90
.LBB7_11:                               #   in Loop: Header=BB7_8 Depth=2
	leaq	8(%r11), %rbp
	movq	(%r11), %r9
	movq	8(%r11), %rbx
	cmpq	%rbx, %r9
	cmovaq	%r9, %rbx
	cmovbq	%rbp, %r11
	cmovbq	%r15, %r13
	movq	%r13, %r15
	cmpq	%r14, %rbx
	jb	.LBB7_13
.LBB7_8:                                #   Parent Loop BB7_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, (%r12)
	movq	%r11, %r12
	cmpq	%r15, %r8
	jl	.LBB7_13
# %bb.9:                                #   in Loop: Header=BB7_8 Depth=2
	leaq	(%r15,%r15), %r11
	leaq	1(,%r15,2), %r13
	leaq	(%rdi,%r11,8), %r11
	addq	$8, %r11
	leaq	2(,%r15,2), %r15
	cmpq	%rcx, %r15
	jl	.LBB7_11
# %bb.10:                               #   in Loop: Header=BB7_8 Depth=2
	movq	(%r11), %rbx
	movq	%r13, %r15
	cmpq	%r14, %rbx
	jae	.LBB7_8
	jmp	.LBB7_13
.LBB7_15:
	movq	%rsi, %r8
	cmpq	%rax, %rsi
	je	.LBB7_36
# %bb.16:
	cmpq	$2, %rcx
	jge	.LBB7_17
# %bb.21:
	movq	(%rdi), %rdx
	movq	%rsi, %r8
	jmp	.LBB7_22
	.p2align	4, 0x90
.LBB7_24:                               #   in Loop: Header=BB7_22 Depth=1
	addq	$8, %r8
	cmpq	%rax, %r8
	je	.LBB7_35
.LBB7_22:                               # =>This Inner Loop Header: Depth=1
	movq	(%r8), %r9
	cmpq	%rdx, %r9
	jae	.LBB7_24
# %bb.23:                               #   in Loop: Header=BB7_22 Depth=1
	movq	%rdx, (%r8)
	movq	%r9, (%rdi)
	movq	%r9, %rdx
	jmp	.LBB7_24
.LBB7_17:
	leaq	-2(%rcx), %r8
	shrq	%r8
	leaq	8(%rdi), %r9
	leaq	16(%rdi), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%rsi, %r11
	jmp	.LBB7_18
	.p2align	4, 0x90
.LBB7_33:                               #   in Loop: Header=BB7_18 Depth=1
	movq	%rbx, (%r12)
.LBB7_34:                               #   in Loop: Header=BB7_18 Depth=1
	addq	$8, %r11
	cmpq	%rax, %r11
	je	.LBB7_35
.LBB7_18:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_28 Depth 2
	movq	(%r11), %rbx
	movq	(%rdi), %r14
	cmpq	%r14, %rbx
	jae	.LBB7_34
# %bb.19:                               #   in Loop: Header=BB7_18 Depth=1
	movq	%r14, (%r11)
	movq	%rbx, (%rdi)
	movq	8(%rdi), %r14
	movl	$1, %r13d
	cmpq	$16, -8(%rsp)                   # 8-byte Folded Reload
	jne	.LBB7_25
# %bb.20:                               #   in Loop: Header=BB7_18 Depth=1
	movq	%r9, %r15
	cmpq	%rbx, %r14
	jb	.LBB7_34
	jmp	.LBB7_27
	.p2align	4, 0x90
.LBB7_25:                               #   in Loop: Header=BB7_18 Depth=1
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	movq	(%rdx), %r15
	cmpq	%r15, %r14
	cmovbeq	%r15, %r14
	movq	%r9, %r15
	cmovbq	%rdx, %r15
	movl	$0, %r13d
	adcq	$1, %r13
	cmpq	%rbx, %r14
	jb	.LBB7_34
.LBB7_27:                               #   in Loop: Header=BB7_18 Depth=1
	movq	%rdi, %r12
	jmp	.LBB7_28
	.p2align	4, 0x90
.LBB7_31:                               #   in Loop: Header=BB7_28 Depth=2
	leaq	8(%r15), %rdx
	movq	(%r15), %r10
	movq	8(%r15), %r14
	cmpq	%r14, %r10
	cmovaq	%r10, %r14
	cmovbq	%rdx, %r15
	cmovbq	%r13, %rbp
	movq	%rbp, %r13
	cmpq	%rbx, %r14
	jb	.LBB7_33
.LBB7_28:                               #   Parent Loop BB7_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, (%r12)
	movq	%r15, %r12
	cmpq	%r13, %r8
	jl	.LBB7_33
# %bb.29:                               #   in Loop: Header=BB7_28 Depth=2
	leaq	(,%r13,2), %r14
	leaq	1(,%r13,2), %rbp
	leaq	(%rdi,%r14,8), %r15
	addq	$8, %r15
	leaq	2(,%r13,2), %r13
	cmpq	%rcx, %r13
	jl	.LBB7_31
# %bb.30:                               #   in Loop: Header=BB7_28 Depth=2
	movq	(%r15), %r14
	movq	%rbp, %r13
	cmpq	%rbx, %r14
	jae	.LBB7_28
	jmp	.LBB7_33
.LBB7_35:
	movq	%rax, %r8
.LBB7_36:
	cmpq	$2, %rcx
	jge	.LBB7_37
.LBB7_51:
	movq	%r8, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %r12
	.cfi_restore %r13
	.cfi_restore %r14
	.cfi_restore %r15
	.cfi_restore %rbp
.LBB7_52:
	retq
	.p2align	4, 0x90
.LBB7_43:                               #   in Loop: Header=BB7_37 Depth=1
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %rbp, -16
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdx, (%rax)
.LBB7_50:                               #   in Loop: Header=BB7_37 Depth=1
	leaq	-1(%rcx), %rax
	cmpq	$2, %rcx
	movq	%rax, %rcx
	jle	.LBB7_51
.LBB7_37:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_38 Depth 2
                                        #     Child Loop BB7_47 Depth 2
	movq	(%rdi), %rdx
	leaq	-2(%rcx), %r9
	shrq	%r9
	movq	%rdi, %r10
	xorl	%ebx, %ebx
	jmp	.LBB7_38
	.p2align	4, 0x90
.LBB7_40:                               #   in Loop: Header=BB7_38 Depth=2
	leaq	(%r10,%rbx,8), %rbx
	leaq	16(%rbx), %r15
	movq	8(%rbx), %r12
	movq	16(%rbx), %rbx
	cmpq	%rbx, %r12
	cmovaq	%r12, %rbx
	cmovbq	%r15, %rax
	cmovbq	%r14, %r11
.LBB7_41:                               #   in Loop: Header=BB7_38 Depth=2
	movq	%rbx, (%r10)
	movq	%rax, %r10
	movq	%r11, %rbx
	cmpq	%r9, %r11
	jg	.LBB7_42
.LBB7_38:                               #   Parent Loop BB7_37 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r10,%rbx,8), %rax
	addq	$8, %rax
	leaq	1(,%rbx,2), %r11
	leaq	2(,%rbx,2), %r14
	cmpq	%rcx, %r14
	jl	.LBB7_40
# %bb.39:                               #   in Loop: Header=BB7_38 Depth=2
	movq	(%rax), %rbx
	jmp	.LBB7_41
	.p2align	4, 0x90
.LBB7_42:                               #   in Loop: Header=BB7_37 Depth=1
	addq	$-8, %rsi
	cmpq	%rsi, %rax
	je	.LBB7_43
# %bb.44:                               #   in Loop: Header=BB7_37 Depth=1
	movq	(%rsi), %r9
	movq	%r9, (%rax)
	movq	%rdx, (%rsi)
	movq	%rax, %rdx
	subq	%rdi, %rdx
	addq	$8, %rdx
	sarq	$3, %rdx
	cmpq	$2, %rdx
	jl	.LBB7_50
# %bb.45:                               #   in Loop: Header=BB7_37 Depth=1
	addq	$-2, %rdx
	shrq	%rdx
	movq	(%rdi,%rdx,8), %r10
	movq	(%rax), %r9
	cmpq	%r9, %r10
	jae	.LBB7_50
# %bb.46:                               #   in Loop: Header=BB7_37 Depth=1
	leaq	(%rdi,%rdx,8), %r11
	.p2align	4, 0x90
.LBB7_47:                               #   Parent Loop BB7_37 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r10, (%rax)
	movq	%r11, %rax
	testq	%rdx, %rdx
	je	.LBB7_49
# %bb.48:                               #   in Loop: Header=BB7_47 Depth=2
	decq	%rdx
	shrq	%rdx
	leaq	(%rdi,%rdx,8), %r11
	movq	(%rdi,%rdx,8), %r10
	cmpq	%r9, %r10
	jb	.LBB7_47
.LBB7_49:                               #   in Loop: Header=BB7_37 Depth=1
	movq	%r9, (%rax)
	jmp	.LBB7_50
.Lfunc_end7:
	.size	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_, .Lfunc_end7-_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.cfi_endproc
                                        # -- End function
	.section	".linker-options","e",@llvm_linker_options
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
