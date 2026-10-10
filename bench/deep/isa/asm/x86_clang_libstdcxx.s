	.text
	.file	"isa_bench.cpp"
                                        # Start of file scope inline assembly
	.globl	_ZSt21ios_base_library_initv

                                        # End of file scope inline assembly
	.globl	phase_sort                      # -- Begin function phase_sort
	.p2align	4, 0x90
	.type	phase_sort,@function
phase_sort:                             # @phase_sort
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
	movq	(%rdi), %rbx
	movq	8(%rdi), %r14
	cmpq	%r14, %rbx
	je	.LBB0_5
# %bb.1:
	movq	%r14, %rax
	subq	%rbx, %rax
	sarq	$3, %rax
	je	.LBB0_2
# %bb.3:
	bsrq	%rax, %rax
	xorq	$63, %rax
	jmp	.LBB0_4
.LBB0_5:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB0_2:
	.cfi_def_cfa_offset 32
	movl	$64, %eax
.LBB0_4:
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	movq	%rbx, %rdi
	movq	%r14, %rsi
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_ # TAILCALL
.Lfunc_end0:
	.size	phase_sort, .Lfunc_end0-phase_sort
	.cfi_endproc
                                        # -- End function
	.globl	phase_unique                    # -- Begin function phase_unique
	.p2align	4, 0x90
	.type	phase_unique,@function
phase_unique:                           # @phase_unique
	.cfi_startproc
# %bb.0:
	movq	(%rdi), %rax
	movq	8(%rdi), %rcx
	cmpq	%rcx, %rax
	je	.LBB1_10
# %bb.1:
	addq	$8, %rax
	.p2align	4, 0x90
.LBB1_2:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rcx, %rax
	je	.LBB1_12
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=1
	movq	-8(%rax), %rdx
	leaq	8(%rax), %rsi
	cmpq	(%rax), %rdx
	movq	%rsi, %rax
	jne	.LBB1_2
# %bb.4:
	leaq	-16(%rsi), %rax
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_8:                                #   in Loop: Header=BB1_5 Depth=1
	addq	$8, %rsi
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rcx, %rsi
	je	.LBB1_9
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
	movq	%rdx, %r8
	movq	(%rsi), %rdx
	cmpq	%rdx, %r8
	je	.LBB1_8
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
	movq	%rdx, 8(%rax)
	addq	$8, %rax
	jmp	.LBB1_8
.LBB1_9:
	addq	$8, %rax
.LBB1_10:
	cmpq	%rcx, %rax
	je	.LBB1_12
# %bb.11:
	movq	%rax, 8(%rdi)
.LBB1_12:
	retq
.Lfunc_end1:
	.size	phase_unique, .Lfunc_end1-phase_unique
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function phase_uset_insert
.LCPI2_0:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI2_1:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI2_2:
	.quad	0x43e0000000000000              # double 9.2233720368547758E+18
	.text
	.globl	phase_uset_insert
	.p2align	4, 0x90
	.type	phase_uset_insert,@function
phase_uset_insert:                      # @phase_uset_insert
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r15
	movq	%rdi, %r14
	movl	$56, %edi
	callq	_Znwm@PLT
	movq	%rax, %rbx
	addq	$48, %rax
	movq	%rax, (%rbx)
	movq	$1, 8(%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rbx)
	movl	$1065353216, 32(%rbx)           # imm = 0x3F800000
	movq	%r15, %xmm1
	punpckldq	.LCPI2_0(%rip), %xmm1   # xmm1 = xmm1[0],mem[0],xmm1[1],mem[1]
	movups	%xmm0, 40(%rbx)
	subpd	.LCPI2_1(%rip), %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm0                    # xmm0 = xmm0[1],xmm1[1]
	addsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	subsd	.LCPI2_2(%rip), %xmm0
	cvttsd2si	%xmm0, %rsi
	andq	%rcx, %rsi
	orq	%rax, %rsi
	movq	%rbx, %rdi
	callq	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	movq	(%r14), %r12
	movq	8(%r14), %r13
	cmpq	%r13, %r12
	je	.LBB2_3
# %bb.1:
	movq	%rsp, %r14
	leaq	8(%rsp), %r15
	.p2align	4, 0x90
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	movq	(%r12), %rax
	movq	%rax, (%rsp)
	movq	%rbx, 8(%rsp)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r14, %rdx
	movq	%r15, %rcx
	callq	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	addq	$8, %r12
	cmpq	%r13, %r12
	jne	.LBB2_2
.LBB2_3:
	movq	%rbx, %rax
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	phase_uset_insert, .Lfunc_end2-phase_uset_insert
	.cfi_endproc
                                        # -- End function
	.globl	phase_uset_assign               # -- Begin function phase_uset_assign
	.p2align	4, 0x90
	.type	phase_uset_assign,@function
phase_uset_assign:                      # @phase_uset_assign
	.cfi_startproc
# %bb.0:
	movq	16(%rsi), %rsi
	xorl	%edx, %edx
	jmp	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag # TAILCALL
.Lfunc_end3:
	.size	phase_uset_assign, .Lfunc_end3-phase_uset_assign
	.cfi_endproc
                                        # -- End function
	.globl	phase_uset_dtor                 # -- Begin function phase_uset_dtor
	.p2align	4, 0x90
	.type	phase_uset_dtor,@function
phase_uset_dtor:                        # @phase_uset_dtor
	.cfi_startproc
# %bb.0:
	testq	%rdi, %rdi
	je	.LBB4_6
# %bb.1:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	leaq	16(%rdi), %r14
	movq	16(%rdi), %rdi
	testq	%rdi, %rdi
	je	.LBB4_3
	.p2align	4, 0x90
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	movq	(%rdi), %r15
	callq	_ZdlPv@PLT
	movq	%r15, %rdi
	testq	%r15, %r15
	jne	.LBB4_2
.LBB4_3:
	movq	(%rbx), %rdi
	movq	8(%rbx), %rdx
	shlq	$3, %rdx
	xorl	%esi, %esi
	callq	memset@PLT
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%r14)
	movq	(%rbx), %rdi
	leaq	48(%rbx), %rax
	cmpq	%rdi, %rax
	je	.LBB4_5
# %bb.4:
	callq	_ZdlPv@PLT
.LBB4_5:
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB4_6:
	.cfi_restore %rbx
	.cfi_restore %r14
	.cfi_restore %r15
	retq
.Lfunc_end4:
	.size	phase_uset_dtor, .Lfunc_end4-phase_uset_dtor
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function phase_flat_insert
.LCPI5_0:
	.zero	16,128
	.text
	.globl	phase_flat_insert
	.p2align	4, 0x90
	.type	phase_flat_insert,@function
phase_flat_insert:                      # @phase_flat_insert
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r15
	movq	%rdi, %r14
	movl	$16, %edi
	callq	_Znwm@PLT
	movq	%rax, %rbx
	movq	$1, (%rax)
	cmpq	$2, %r15
	jb	.LBB5_2
# %bb.1:
	leaq	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r15, %rdx
	callq	_ZN4absl12lts_2026081718container_internal24ReserveTableToFitNewSizeERNS1_12CommonFieldsERKNS1_15PolicyFunctionsEm@PLT
.LBB5_2:
	movq	(%r14), %r13
	movq	8(%r14), %rbp
	cmpq	%rbp, %r13
	je	.LBB5_17
# %bb.3:
	movq	%rbx, %r15
	addq	$8, %r15
	leaq	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value(%rip), %r14
	movabsq	$8779197792823184629, %r12      # imm = 0x79D5F9E0DE1E8CF5
	jmp	.LBB5_4
	.p2align	4, 0x90
.LBB5_10:                               #   Parent Loop BB5_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_11 Depth 3
	andq	%r10, %r8
	prefetcht0	(%rax,%r8,8)
	movdqu	(%rdi,%r8), %xmm1
	movdqa	%xmm0, %xmm2
	pcmpeqb	%xmm1, %xmm2
	pmovmskb	%xmm2, %ecx
	#APP
	#NO_APP
	testl	%ecx, %ecx
	je	.LBB5_13
.LBB5_11:                               #   Parent Loop BB5_4 Depth=1
                                        #     Parent Loop BB5_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	rep		bsfl	%ecx, %r11d
	addq	%r8, %r11
	andq	%r10, %r11
	cmpq	%rsi, (%rax,%r11,8)
	je	.LBB5_16
# %bb.12:                               #   in Loop: Header=BB5_11 Depth=3
	leal	-1(%rcx), %r11d
	andl	%ecx, %r11d
	movl	%r11d, %ecx
	jne	.LBB5_11
	.p2align	4, 0x90
.LBB5_13:                               #   in Loop: Header=BB5_10 Depth=2
	pcmpeqb	.LCPI5_0(%rip), %xmm1
	pmovmskb	%xmm1, %ecx
	#APP
	#NO_APP
	testl	%ecx, %ecx
	jne	.LBB5_14
# %bb.18:                               #   in Loop: Header=BB5_10 Depth=2
	addq	%r9, %r8
	addq	$16, %r8
	addq	$16, %r9
	jmp	.LBB5_10
	.p2align	4, 0x90
.LBB5_14:                               #   in Loop: Header=BB5_4 Depth=1
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_ZN4absl12lts_2026081718container_internal18PrepareInsertLargeERNS1_12CommonFieldsERKNS1_15PolicyFunctionsEmNS1_18NonIterableBitMaskIjLi16ELi0EEENS1_8FindInfoE@PLT
	jmp	.LBB5_15
	.p2align	4, 0x90
.LBB5_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_10 Depth 2
                                        #       Child Loop BB5_11 Depth 3
	movq	(%r13), %rsi
	movq	%rsi, (%rsp)
	movq	(%rbx), %rax
	testb	$62, %al
	je	.LBB5_5
# %bb.9:                                #   in Loop: Header=BB5_4 Depth=1
	movq	(%r15), %rdi
	movq	$-1, %r10
	movl	%eax, %ecx
	shlq	%cl, %r10
	andl	$1984, %eax                     # imm = 0x7C0
	xorq	%rsi, %rax
	mulq	%r12
	prefetcht2	(%rdi)
	xorq	%rax, %rdx
	movq	%rdx, %rcx
	shrq	$57, %rcx
	movq	%rdi, %rax
	subq	%r10, %rax
	notq	%r10
	addq	$15, %rax
	movd	%ecx, %xmm0
	punpcklbw	%xmm0, %xmm0            # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0,4,5,6,7]
	pshufd	$0, %xmm0, %xmm0                # xmm0 = xmm0[0,0,0,0]
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	jmp	.LBB5_10
	.p2align	4, 0x90
.LBB5_5:                                #   in Loop: Header=BB5_4 Depth=1
	cmpq	$32767, %rax                    # imm = 0x7FFF
	ja	.LBB5_7
# %bb.6:                                #   in Loop: Header=BB5_4 Depth=1
	orq	$32832, %rax                    # imm = 0x8040
	movq	%rax, (%rbx)
	movq	%r15, %rax
	jmp	.LBB5_15
.LBB5_7:                                #   in Loop: Header=BB5_4 Depth=1
	cmpq	%rsi, (%r15)
	je	.LBB5_16
# %bb.8:                                #   in Loop: Header=BB5_4 Depth=1
	movq	%rbx, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	leaq	8(%rsp), %rdx
	leaq	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE(%rip), %rcx
	xorl	%r8d, %r8d
	callq	_ZN4absl12lts_2026081718container_internal42GrowSooTableToNextCapacityAndPrepareInsertILm8ELb1EEEPvRNS1_12CommonFieldsERKNS1_15PolicyFunctionsENS0_11FunctionRefIFmmEEEb@PLT
	.p2align	4, 0x90
.LBB5_15:                               #   in Loop: Header=BB5_4 Depth=1
	movq	(%rsp), %rcx
	movq	%rcx, (%rax)
.LBB5_16:                               #   in Loop: Header=BB5_4 Depth=1
	addq	$8, %r13
	cmpq	%rbp, %r13
	jne	.LBB5_4
.LBB5_17:
	movq	%rbx, %rax
	addq	$24, %rsp
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
.Lfunc_end5:
	.size	phase_flat_insert, .Lfunc_end5-phase_flat_insert
	.cfi_endproc
                                        # -- End function
	.globl	phase_flat_assign               # -- Begin function phase_flat_assign
	.p2align	4, 0x90
	.type	phase_flat_assign,@function
phase_flat_assign:                      # @phase_flat_assign
	.cfi_startproc
# %bb.0:
	movq	(%rsi), %rcx
	cmpq	$32768, %rcx                    # imm = 0x8000
	jb	.LBB6_1
# %bb.3:
	movq	%rsi, %rdx
	addq	$8, %rdx
	testb	$62, %cl
	je	.LBB6_4
# %bb.5:
	andl	$63, %ecx
	movq	$-1, %rsi
	shlq	%cl, %rsi
	movq	(%rdx), %rax
	movl	$15, %r8d
	subq	%rsi, %r8
	xorl	%edx, %edx
	cmpq	$1, %rcx
	cmovneq	%r8, %rdx
	addq	%rax, %rdx
	cmpb	$-2, (%rax)
	jg	.LBB6_6
	.p2align	4, 0x90
.LBB6_7:                                # =>This Inner Loop Header: Depth=1
	leaq	1(%rax), %rsi
	addq	$8, %rdx
	cmpb	$-1, 1(%rax)
	movq	%rsi, %rax
	jl	.LBB6_7
# %bb.2:
	xorl	%r8d, %r8d
	jmp	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag # TAILCALL
.LBB6_4:
	movq	_ZN4absl12lts_2026081718container_internal11kSooControlE@GOTPCREL(%rip), %rsi
	xorl	%r8d, %r8d
	jmp	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag # TAILCALL
.LBB6_6:
	movq	%rax, %rsi
	xorl	%r8d, %r8d
	jmp	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag # TAILCALL
.LBB6_1:
	xorl	%edx, %edx
                                        # implicit-def: $rsi
	xorl	%r8d, %r8d
	jmp	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag # TAILCALL
.Lfunc_end6:
	.size	phase_flat_assign, .Lfunc_end6-phase_flat_assign
	.cfi_endproc
                                        # -- End function
	.globl	phase_flat_dtor                 # -- Begin function phase_flat_dtor
	.p2align	4, 0x90
	.type	phase_flat_dtor,@function
phase_flat_dtor:                        # @phase_flat_dtor
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception0
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	testq	%rdi, %rdi
	je	.LBB7_4
# %bb.1:
	testb	$62, (%rdi)
	je	.LBB7_3
# %bb.2:
.Ltmp0:
	movq	_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm@GOTPCREL(%rip), %r8
	movl	$8, %esi
	movl	$8, %edx
	movq	%rdi, %rbx
	xorl	%ecx, %ecx
	movq	%rdi, %r9
	callq	_ZN4absl12lts_2026081718container_internal11DestructSooERNS1_12CommonFieldsEmmPFvPvS4_EPFvS4_mPNS1_6ctrl_tEmmbmES4_@PLT
	movq	%rbx, %rdi
.Ltmp1:
.LBB7_3:
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB7_4:
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB7_5:
	.cfi_def_cfa_offset 16
.Ltmp2:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end7:
	.size	phase_flat_dtor, .Lfunc_end7-phase_flat_dtor
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table7:
.Lexception0:
	.byte	255                             # @LPStart Encoding = omit
	.byte	155                             # @TType Encoding = indirect pcrel sdata4
	.uleb128 .Lttbase0-.Lttbaseref0
.Lttbaseref0:
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Ltmp0-.Lfunc_begin0           # >> Call Site 1 <<
	.uleb128 .Ltmp1-.Ltmp0                  #   Call between .Ltmp0 and .Ltmp1
	.uleb128 .Ltmp2-.Lfunc_begin0           #     jumps to .Ltmp2
	.byte	1                               #   On action: 1
.Lcst_end0:
	.byte	1                               # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                               #   No further actions
	.p2align	2, 0x0
                                        # >> Catch TypeInfos <<
	.long	0                               # TypeInfo 1
.Lttbase0:
	.p2align	2, 0x0
                                        # -- End function
	.text
	.globl	phase_radix_count               # -- Begin function phase_radix_count
	.p2align	4, 0x90
	.type	phase_radix_count,@function
phase_radix_count:                      # @phase_radix_count
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movl	$8192, %edx                     # imm = 0x2000
	movq	%rsi, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
	movq	(%r14), %rax
	movq	8(%r14), %rcx
	cmpq	%rcx, %rax
	je	.LBB8_3
	.p2align	4, 0x90
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	movq	(%rax), %rdx
	movzbl	%dl, %esi
	incl	(%rbx,%rsi,4)
	movzbl	%dh, %esi
	incl	1024(%rbx,%rsi,4)
	movl	%edx, %esi
	shrl	$14, %esi
	andl	$1020, %esi                     # imm = 0x3FC
	incl	2048(%rbx,%rsi)
	movl	%edx, %esi
	shrl	$24, %esi
	incl	3072(%rbx,%rsi,4)
	movq	%rdx, %rsi
	shrq	$32, %rsi
	movzbl	%sil, %esi
	incl	4096(%rbx,%rsi,4)
	movq	%rdx, %rsi
	shrq	$40, %rsi
	movzbl	%sil, %esi
	incl	5120(%rbx,%rsi,4)
	movq	%rdx, %rsi
	shrq	$48, %rsi
	movzbl	%sil, %esi
	incl	6144(%rbx,%rsi,4)
	shrq	$56, %rdx
	incl	7168(%rbx,%rdx,4)
	addq	$8, %rax
	cmpq	%rcx, %rax
	jne	.LBB8_1
.LBB8_3:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	phase_radix_count, .Lfunc_end8-phase_radix_count
	.cfi_endproc
                                        # -- End function
	.globl	phase_radix_scatter             # -- Begin function phase_radix_scatter
	.p2align	4, 0x90
	.type	phase_radix_scatter,@function
phase_radix_scatter:                    # @phase_radix_scatter
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$1920, %rsp                     # imm = 0x780
	.cfi_def_cfa_offset 1968
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rax
	movq	%rdi, %rcx
	movq	(%rdi), %rdi
	movq	8(%rcx), %rdx
	movq	%rdx, %rcx
	subq	%rdi, %rcx
	sarq	$3, %rcx
	subq	%rdi, %rdx
	je	.LBB9_7
# %bb.1:
	cmpq	$1, %rcx
	movq	%rcx, %r8
	adcq	$0, %r8
	movq	(%rdi), %rbx
	movzbl	%bl, %r9d
	movl	(%rax,%r9,4), %r9d
	cmpq	%r9, %rcx
	jne	.LBB9_12
# %bb.2:
	movq	%rdi, %r9
	movzbl	%bh, %ebp
	movl	1024(%rax,%rbp,4), %r10d
	cmpq	%r10, %rcx
	je	.LBB9_58
.LBB9_3:
	movl	$3, %r10d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_4:                                # =>This Inner Loop Header: Depth=1
	movq	%r11, -152(%rsp,%r10,8)
	movl	1012(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -144(%rsp,%r10,8)
	movl	1016(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -136(%rsp,%r10,8)
	movl	1020(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -128(%rsp,%r10,8)
	movl	1024(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	addq	$4, %r10
	cmpq	$259, %r10                      # imm = 0x103
	jne	.LBB9_4
# %bb.5:
	cmpq	$2, %rcx
	jae	.LBB9_48
# %bb.6:
	xorl	%r10d, %r10d
	jmp	.LBB9_50
.LBB9_7:
	movq	(%rdi), %rbx
	movzbl	%bl, %r8d
	movl	(%rax,%r8,4), %r8d
	cmpq	%r8, %rcx
	jne	.LBB9_16
# %bb.8:
	movq	%rdi, %r8
	movzbl	%bh, %ebp
	movl	1024(%rax,%rbp,4), %r9d
	cmpq	%r9, %rcx
	je	.LBB9_19
.LBB9_9:
	movl	$3, %r9d
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_10:                               # =>This Inner Loop Header: Depth=1
	movq	%r10, -152(%rsp,%r9,8)
	movl	1012(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -144(%rsp,%r9,8)
	movl	1016(%rax,%r9,4), %r10d
	addq	%r11, %r10
	movq	%r10, -136(%rsp,%r9,8)
	movl	1020(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -128(%rsp,%r9,8)
	movl	1024(%rax,%r9,4), %r10d
	addq	%r11, %r10
	addq	$4, %r9
	cmpq	$259, %r9                       # imm = 0x103
	jne	.LBB9_10
# %bb.11:
	movq	(%rsi), %rbx
	movq	%rsi, %r9
	jmp	.LBB9_20
.LBB9_12:
	movl	$3, %r9d
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_13:                               # =>This Inner Loop Header: Depth=1
	movq	%r10, -152(%rsp,%r9,8)
	movl	-12(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -144(%rsp,%r9,8)
	movl	-8(%rax,%r9,4), %r10d
	addq	%r11, %r10
	movq	%r10, -136(%rsp,%r9,8)
	movl	-4(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -128(%rsp,%r9,8)
	movl	(%rax,%r9,4), %r10d
	addq	%r11, %r10
	addq	$4, %r9
	cmpq	$259, %r9                       # imm = 0x103
	jne	.LBB9_13
# %bb.14:
	cmpq	$2, %rcx
	jae	.LBB9_53
# %bb.15:
	xorl	%r9d, %r9d
	jmp	.LBB9_55
.LBB9_16:
	movl	$3, %r8d
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB9_17:                               # =>This Inner Loop Header: Depth=1
	movq	%r9, -152(%rsp,%r8,8)
	movl	-12(%rax,%r8,4), %r10d
	addq	%r9, %r10
	movq	%r10, -144(%rsp,%r8,8)
	movl	-8(%rax,%r8,4), %r9d
	addq	%r10, %r9
	movq	%r9, -136(%rsp,%r8,8)
	movl	-4(%rax,%r8,4), %r10d
	addq	%r9, %r10
	movq	%r10, -128(%rsp,%r8,8)
	movl	(%rax,%r8,4), %r9d
	addq	%r10, %r9
	addq	$4, %r8
	cmpq	$259, %r8                       # imm = 0x103
	jne	.LBB9_17
# %bb.18:
	movq	(%rsi), %rbx
	movq	%rsi, %r8
	movq	%rdi, %rsi
	movzbl	%bh, %ebp
	movl	1024(%rax,%rbp,4), %r9d
	cmpq	%r9, %rcx
	jne	.LBB9_9
.LBB9_19:
	movq	%r8, %r9
	movq	%rsi, %r8
.LBB9_20:
	movl	%ebx, %esi
	shrl	$14, %esi
	andl	$1020, %esi                     # imm = 0x3FC
	movl	2048(%rax,%rsi), %esi
	cmpq	%rsi, %rcx
	jne	.LBB9_22
# %bb.21:
	movq	%r9, %r10
	movq	%r8, %r9
	jmp	.LBB9_25
.LBB9_22:
	xorl	%esi, %esi
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_23:                               # =>This Inner Loop Header: Depth=1
	movq	%r10, -128(%rsp,%rsi,8)
	movl	2048(%rax,%rsi,4), %r11d
	addq	%r10, %r11
	movq	%r11, -120(%rsp,%rsi,8)
	movl	2052(%rax,%rsi,4), %r10d
	addq	%r11, %r10
	movq	%r10, -112(%rsp,%rsi,8)
	movl	2056(%rax,%rsi,4), %r11d
	addq	%r10, %r11
	movq	%r11, -104(%rsp,%rsi,8)
	movl	2060(%rax,%rsi,4), %r10d
	addq	%r11, %r10
	addq	$4, %rsi
	cmpq	$256, %rsi                      # imm = 0x100
	jne	.LBB9_23
# %bb.24:
	movq	(%r8), %rbx
	movq	%r8, %r10
.LBB9_25:
	movl	%ebx, %esi
	shrl	$24, %esi
	movl	3072(%rax,%rsi,4), %esi
	cmpq	%rsi, %rcx
	jne	.LBB9_27
# %bb.26:
	movq	%r10, %rsi
	movq	%r9, %r10
	jmp	.LBB9_30
.LBB9_27:
	xorl	%esi, %esi
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB9_28:                               # =>This Inner Loop Header: Depth=1
	movq	%r8, -128(%rsp,%rsi,8)
	movl	3072(%rax,%rsi,4), %r11d
	addq	%r8, %r11
	movq	%r11, -120(%rsp,%rsi,8)
	movl	3076(%rax,%rsi,4), %r8d
	addq	%r11, %r8
	movq	%r8, -112(%rsp,%rsi,8)
	movl	3080(%rax,%rsi,4), %r11d
	addq	%r8, %r11
	movq	%r11, -104(%rsp,%rsi,8)
	movl	3084(%rax,%rsi,4), %r8d
	addq	%r11, %r8
	addq	$4, %rsi
	cmpq	$256, %rsi                      # imm = 0x100
	jne	.LBB9_28
# %bb.29:
	movq	(%r9), %rbx
	movq	%r9, %rsi
.LBB9_30:
	movq	%rbx, %r8
	shrq	$32, %r8
	movzbl	%r8b, %r8d
	movl	4096(%rax,%r8,4), %r8d
	cmpq	%r8, %rcx
	jne	.LBB9_32
# %bb.31:
	movq	%rsi, %r8
	movq	%r10, %rsi
	jmp	.LBB9_35
.LBB9_32:
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB9_33:                               # =>This Inner Loop Header: Depth=1
	movq	%r9, -128(%rsp,%r8,8)
	movl	4096(%rax,%r8,4), %r11d
	addq	%r9, %r11
	movq	%r11, -120(%rsp,%r8,8)
	movl	4100(%rax,%r8,4), %r9d
	addq	%r11, %r9
	movq	%r9, -112(%rsp,%r8,8)
	movl	4104(%rax,%r8,4), %r11d
	addq	%r9, %r11
	movq	%r11, -104(%rsp,%r8,8)
	movl	4108(%rax,%r8,4), %r9d
	addq	%r11, %r9
	addq	$4, %r8
	cmpq	$256, %r8                       # imm = 0x100
	jne	.LBB9_33
# %bb.34:
	movq	(%r10), %rbx
	movq	%r10, %r8
.LBB9_35:
	movq	%rbx, %r9
	shrq	$40, %r9
	movzbl	%r9b, %r9d
	movl	5120(%rax,%r9,4), %r9d
	cmpq	%r9, %rcx
	jne	.LBB9_37
# %bb.36:
	movq	%r8, %r9
	movq	%rsi, %r8
	jmp	.LBB9_40
.LBB9_37:
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_38:                               # =>This Inner Loop Header: Depth=1
	movq	%r10, -128(%rsp,%r9,8)
	movl	5120(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -120(%rsp,%r9,8)
	movl	5124(%rax,%r9,4), %r10d
	addq	%r11, %r10
	movq	%r10, -112(%rsp,%r9,8)
	movl	5128(%rax,%r9,4), %r11d
	addq	%r10, %r11
	movq	%r11, -104(%rsp,%r9,8)
	movl	5132(%rax,%r9,4), %r10d
	addq	%r11, %r10
	addq	$4, %r9
	cmpq	$256, %r9                       # imm = 0x100
	jne	.LBB9_38
# %bb.39:
	movq	(%rsi), %rbx
	movq	%rsi, %r9
.LBB9_40:
	movq	%rbx, %rsi
	shrq	$48, %rsi
	movzbl	%sil, %esi
	movl	6144(%rax,%rsi,4), %esi
	cmpq	%rsi, %rcx
	jne	.LBB9_42
# %bb.41:
	movq	%r9, %rsi
	movq	%r8, %r9
	shrq	$56, %rbx
	movl	7168(%rax,%rbx,4), %r8d
	cmpq	%r8, %rcx
	jne	.LBB9_45
	jmp	.LBB9_117
.LBB9_42:
	xorl	%esi, %esi
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_43:                               # =>This Inner Loop Header: Depth=1
	movq	%r10, -128(%rsp,%rsi,8)
	movl	6144(%rax,%rsi,4), %r11d
	addq	%r10, %r11
	movq	%r11, -120(%rsp,%rsi,8)
	movl	6148(%rax,%rsi,4), %r10d
	addq	%r11, %r10
	movq	%r10, -112(%rsp,%rsi,8)
	movl	6152(%rax,%rsi,4), %r11d
	addq	%r10, %r11
	movq	%r11, -104(%rsp,%rsi,8)
	movl	6156(%rax,%rsi,4), %r10d
	addq	%r11, %r10
	addq	$4, %rsi
	cmpq	$256, %rsi                      # imm = 0x100
	jne	.LBB9_43
# %bb.44:
	movq	(%r8), %rbx
	movq	%r8, %rsi
	shrq	$56, %rbx
	movl	7168(%rax,%rbx,4), %r8d
	cmpq	%r8, %rcx
	je	.LBB9_117
.LBB9_45:
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB9_46:                               # =>This Inner Loop Header: Depth=1
	movq	%rsi, -128(%rsp,%rcx,8)
	movl	7168(%rax,%rcx,4), %r8d
	addq	%rsi, %r8
	movq	%r8, -120(%rsp,%rcx,8)
	movl	7172(%rax,%rcx,4), %esi
	addq	%r8, %rsi
	movq	%rsi, -112(%rsp,%rcx,8)
	movl	7176(%rax,%rcx,4), %r8d
	addq	%rsi, %r8
	movq	%r8, -104(%rsp,%rcx,8)
	movl	7180(%rax,%rcx,4), %esi
	addq	%r8, %rsi
	addq	$4, %rcx
	cmpq	$256, %rcx                      # imm = 0x100
	jne	.LBB9_46
	jmp	.LBB9_124
.LBB9_48:
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_49:                               # =>This Inner Loop Header: Depth=1
	movq	(%r9,%r10,8), %rbx
	movzbl	%bh, %ebp
	movq	-128(%rsp,%rbp,8), %r14
	leaq	1(%r14), %r15
	movq	%r15, -128(%rsp,%rbp,8)
	movq	%rbx, (%rsi,%r14,8)
	movq	8(%r9,%r10,8), %rbx
	movzbl	%bh, %ebp
	movq	-128(%rsp,%rbp,8), %r14
	leaq	1(%r14), %r15
	movq	%r15, -128(%rsp,%rbp,8)
	movq	%rbx, (%rsi,%r14,8)
	addq	$2, %r10
	cmpq	%r10, %r11
	jne	.LBB9_49
.LBB9_50:
	testb	$1, %r8b
	je	.LBB9_52
# %bb.51:
	movq	(%r9,%r10,8), %rbx
	movzbl	%bh, %ebp
	movq	-128(%rsp,%rbp,8), %r10
	leaq	1(%r10), %r11
	movq	%r11, -128(%rsp,%rbp,8)
	movq	%rbx, (%rsi,%r10,8)
.LBB9_52:
	movq	(%rsi), %rbx
	movq	%rsi, %r10
	jmp	.LBB9_59
.LBB9_53:
	movq	%r8, %r10
	andq	$-2, %r10
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB9_54:                               # =>This Inner Loop Header: Depth=1
	movq	(%rdi,%r9,8), %r11
	movzbl	%r11b, %ebx
	movq	-128(%rsp,%rbx,8), %r14
	leaq	1(%r14), %r15
	movq	%r15, -128(%rsp,%rbx,8)
	movq	%r11, (%rsi,%r14,8)
	movq	8(%rdi,%r9,8), %r11
	movzbl	%r11b, %ebx
	movq	-128(%rsp,%rbx,8), %r14
	leaq	1(%r14), %r15
	movq	%r15, -128(%rsp,%rbx,8)
	movq	%r11, (%rsi,%r14,8)
	addq	$2, %r9
	cmpq	%r9, %r10
	jne	.LBB9_54
.LBB9_55:
	testb	$1, %r8b
	je	.LBB9_57
# %bb.56:
	movq	(%rdi,%r9,8), %r9
	movzbl	%r9b, %r10d
	movq	-128(%rsp,%r10,8), %r11
	leaq	1(%r11), %rbx
	movq	%rbx, -128(%rsp,%r10,8)
	movq	%r9, (%rsi,%r11,8)
.LBB9_57:
	movq	(%rsi), %rbx
	movq	%rsi, %r9
	movq	%rdi, %rsi
	movzbl	%bh, %ebp
	movl	1024(%rax,%rbp,4), %r10d
	cmpq	%r10, %rcx
	jne	.LBB9_3
.LBB9_58:
	movq	%r9, %r10
	movq	%rsi, %r9
.LBB9_59:
	movl	%ebx, %esi
	shrl	$14, %esi
	andl	$1020, %esi                     # imm = 0x3FC
	movl	2048(%rax,%rsi), %esi
	cmpq	%rsi, %rcx
	jne	.LBB9_61
# %bb.60:
	movq	%r10, %rsi
	movq	%r9, %r10
	jmp	.LBB9_70
.LBB9_61:
	xorl	%esi, %esi
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_62:                               # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%rsi,8)
	movl	2048(%rax,%rsi,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%rsi,8)
	movl	2052(%rax,%rsi,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%rsi,8)
	movl	2056(%rax,%rsi,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%rsi,8)
	movl	2060(%rax,%rsi,4), %r11d
	addq	%rbx, %r11
	addq	$4, %rsi
	cmpq	$256, %rsi                      # imm = 0x100
	jne	.LBB9_62
# %bb.63:
	cmpq	$2, %rcx
	jae	.LBB9_65
# %bb.64:
	xorl	%esi, %esi
	jmp	.LBB9_67
.LBB9_65:
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB9_66:                               # =>This Inner Loop Header: Depth=1
	movq	(%r10,%rsi,8), %rbx
	movl	%ebx, %r14d
	shrl	$13, %r14d
	andl	$2040, %r14d                    # imm = 0x7F8
	movq	-128(%rsp,%r14), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14)
	movq	%rbx, (%r9,%r15,8)
	movq	8(%r10,%rsi,8), %rbx
	movl	%ebx, %r14d
	shrl	$13, %r14d
	andl	$2040, %r14d                    # imm = 0x7F8
	movq	-128(%rsp,%r14), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14)
	movq	%rbx, (%r9,%r15,8)
	addq	$2, %rsi
	cmpq	%rsi, %r11
	jne	.LBB9_66
.LBB9_67:
	testb	$1, %r8b
	je	.LBB9_69
# %bb.68:
	movq	(%r10,%rsi,8), %rsi
	movl	%esi, %r11d
	shrl	$13, %r11d
	andl	$2040, %r11d                    # imm = 0x7F8
	movq	-128(%rsp,%r11), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11)
	movq	%rsi, (%r9,%rbx,8)
.LBB9_69:
	movq	(%r9), %rbx
	movq	%r9, %rsi
.LBB9_70:
	movl	%ebx, %r9d
	shrl	$24, %r9d
	movl	3072(%rax,%r9,4), %r9d
	cmpq	%r9, %rcx
	jne	.LBB9_72
# %bb.71:
	movq	%rsi, %r9
	movq	%r10, %rsi
	jmp	.LBB9_81
.LBB9_72:
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_73:                               # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%r9,8)
	movl	3072(%rax,%r9,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%r9,8)
	movl	3076(%rax,%r9,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%r9,8)
	movl	3080(%rax,%r9,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%r9,8)
	movl	3084(%rax,%r9,4), %r11d
	addq	%rbx, %r11
	addq	$4, %r9
	cmpq	$256, %r9                       # imm = 0x100
	jne	.LBB9_73
# %bb.74:
	cmpq	$2, %rcx
	jae	.LBB9_76
# %bb.75:
	xorl	%r9d, %r9d
	jmp	.LBB9_78
.LBB9_76:
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB9_77:                               # =>This Inner Loop Header: Depth=1
	movq	(%rsi,%r9,8), %rbx
	movl	%ebx, %r14d
	shrl	$24, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r10,%r15,8)
	movq	8(%rsi,%r9,8), %rbx
	movl	%ebx, %r14d
	shrl	$24, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r10,%r15,8)
	addq	$2, %r9
	cmpq	%r9, %r11
	jne	.LBB9_77
.LBB9_78:
	testb	$1, %r8b
	je	.LBB9_80
# %bb.79:
	movq	(%rsi,%r9,8), %r9
	movl	%r9d, %r11d
	shrl	$24, %r11d
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%r9, (%r10,%rbx,8)
.LBB9_80:
	movq	(%r10), %rbx
	movq	%r10, %r9
.LBB9_81:
	movq	%rbx, %r10
	shrq	$32, %r10
	movzbl	%r10b, %r10d
	movl	4096(%rax,%r10,4), %r10d
	cmpq	%r10, %rcx
	jne	.LBB9_83
# %bb.82:
	movq	%r9, %r10
	movq	%rsi, %r9
	jmp	.LBB9_92
.LBB9_83:
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_84:                               # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%r10,8)
	movl	4096(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%r10,8)
	movl	4100(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%r10,8)
	movl	4104(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%r10,8)
	movl	4108(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	addq	$4, %r10
	cmpq	$256, %r10                      # imm = 0x100
	jne	.LBB9_84
# %bb.85:
	cmpq	$2, %rcx
	jae	.LBB9_87
# %bb.86:
	xorl	%r10d, %r10d
	jmp	.LBB9_89
.LBB9_87:
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB9_88:                               # =>This Inner Loop Header: Depth=1
	movq	(%r9,%r10,8), %rbx
	movq	%rbx, %r14
	shrq	$32, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%rsi,%r15,8)
	movq	8(%r9,%r10,8), %rbx
	movq	%rbx, %r14
	shrq	$32, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%rsi,%r15,8)
	addq	$2, %r10
	cmpq	%r10, %r11
	jne	.LBB9_88
.LBB9_89:
	testb	$1, %r8b
	je	.LBB9_91
# %bb.90:
	movq	(%r9,%r10,8), %r10
	movq	%r10, %r11
	shrq	$32, %r11
	movzbl	%r11b, %r11d
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%r10, (%rsi,%rbx,8)
.LBB9_91:
	movq	(%rsi), %rbx
	movq	%rsi, %r10
.LBB9_92:
	movq	%rbx, %rsi
	shrq	$40, %rsi
	movzbl	%sil, %esi
	movl	5120(%rax,%rsi,4), %esi
	cmpq	%rsi, %rcx
	jne	.LBB9_94
# %bb.93:
	movq	%r10, %rsi
	movq	%r9, %r10
	jmp	.LBB9_103
.LBB9_94:
	xorl	%esi, %esi
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_95:                               # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%rsi,8)
	movl	5120(%rax,%rsi,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%rsi,8)
	movl	5124(%rax,%rsi,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%rsi,8)
	movl	5128(%rax,%rsi,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%rsi,8)
	movl	5132(%rax,%rsi,4), %r11d
	addq	%rbx, %r11
	addq	$4, %rsi
	cmpq	$256, %rsi                      # imm = 0x100
	jne	.LBB9_95
# %bb.96:
	cmpq	$2, %rcx
	jae	.LBB9_98
# %bb.97:
	xorl	%esi, %esi
	jmp	.LBB9_100
.LBB9_98:
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB9_99:                               # =>This Inner Loop Header: Depth=1
	movq	(%r10,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$40, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r9,%r15,8)
	movq	8(%r10,%rsi,8), %rbx
	movq	%rbx, %r14
	shrq	$40, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r9,%r15,8)
	addq	$2, %rsi
	cmpq	%rsi, %r11
	jne	.LBB9_99
.LBB9_100:
	testb	$1, %r8b
	je	.LBB9_102
# %bb.101:
	movq	(%r10,%rsi,8), %rsi
	movq	%rsi, %r11
	shrq	$40, %r11
	movzbl	%r11b, %r11d
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%rsi, (%r9,%rbx,8)
.LBB9_102:
	movq	(%r9), %rbx
	movq	%r9, %rsi
.LBB9_103:
	movq	%rbx, %r9
	shrq	$48, %r9
	movzbl	%r9b, %r9d
	movl	6144(%rax,%r9,4), %r9d
	cmpq	%r9, %rcx
	jne	.LBB9_109
# %bb.104:
	movq	%rsi, %r9
	movq	%r10, %rsi
	shrq	$56, %rbx
	movl	7168(%rax,%rbx,4), %r10d
	cmpq	%r10, %rcx
	je	.LBB9_124
.LBB9_105:
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_106:                              # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%r10,8)
	movl	7168(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%r10,8)
	movl	7172(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%r10,8)
	movl	7176(%rax,%r10,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%r10,8)
	movl	7180(%rax,%r10,4), %r11d
	addq	%rbx, %r11
	addq	$4, %r10
	cmpq	$256, %r10                      # imm = 0x100
	jne	.LBB9_106
# %bb.107:
	cmpq	$2, %rcx
	jae	.LBB9_113
# %bb.108:
	xorl	%eax, %eax
	jmp	.LBB9_115
.LBB9_109:
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB9_110:                              # =>This Inner Loop Header: Depth=1
	movq	%r11, -128(%rsp,%r9,8)
	movl	6144(%rax,%r9,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -120(%rsp,%r9,8)
	movl	6148(%rax,%r9,4), %r11d
	addq	%rbx, %r11
	movq	%r11, -112(%rsp,%r9,8)
	movl	6152(%rax,%r9,4), %ebx
	addq	%r11, %rbx
	movq	%rbx, -104(%rsp,%r9,8)
	movl	6156(%rax,%r9,4), %r11d
	addq	%rbx, %r11
	addq	$4, %r9
	cmpq	$256, %r9                       # imm = 0x100
	jne	.LBB9_110
# %bb.111:
	cmpq	$2, %rcx
	jae	.LBB9_119
# %bb.112:
	xorl	%r9d, %r9d
	jmp	.LBB9_121
.LBB9_113:
	movq	%r8, %rcx
	andq	$-2, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB9_114:                              # =>This Inner Loop Header: Depth=1
	movq	(%r9,%rax,8), %r10
	movq	%r10, %r11
	shrq	$56, %r11
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%r10, (%rsi,%rbx,8)
	movq	8(%r9,%rax,8), %r10
	movq	%r10, %r11
	shrq	$56, %r11
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%r10, (%rsi,%rbx,8)
	addq	$2, %rax
	cmpq	%rax, %rcx
	jne	.LBB9_114
.LBB9_115:
	testb	$1, %r8b
	je	.LBB9_117
# %bb.116:
	movq	(%r9,%rax,8), %rax
	movq	%rax, %rcx
	shrq	$56, %rcx
	movq	-128(%rsp,%rcx,8), %r8
	leaq	1(%r8), %r9
	movq	%r9, -128(%rsp,%rcx,8)
	movq	%rax, (%rsi,%r8,8)
.LBB9_117:
	addq	$1920, %rsp                     # imm = 0x780
	cmpq	%rdi, %rsi
	je	.LBB9_125
.LBB9_118:
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	memcpy@PLT                      # TAILCALL
.LBB9_119:
	.cfi_def_cfa_offset 1968
	movq	%r8, %r11
	andq	$-2, %r11
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB9_120:                              # =>This Inner Loop Header: Depth=1
	movq	(%rsi,%r9,8), %rbx
	movq	%rbx, %r14
	shrq	$48, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r10,%r15,8)
	movq	8(%rsi,%r9,8), %rbx
	movq	%rbx, %r14
	shrq	$48, %r14
	movzbl	%r14b, %r14d
	movq	-128(%rsp,%r14,8), %r15
	leaq	1(%r15), %r12
	movq	%r12, -128(%rsp,%r14,8)
	movq	%rbx, (%r10,%r15,8)
	addq	$2, %r9
	cmpq	%r9, %r11
	jne	.LBB9_120
.LBB9_121:
	testb	$1, %r8b
	je	.LBB9_123
# %bb.122:
	movq	(%rsi,%r9,8), %r9
	movq	%r9, %r11
	shrq	$48, %r11
	movzbl	%r11b, %r11d
	movq	-128(%rsp,%r11,8), %rbx
	leaq	1(%rbx), %r14
	movq	%r14, -128(%rsp,%r11,8)
	movq	%r9, (%r10,%rbx,8)
.LBB9_123:
	movq	(%r10), %rbx
	movq	%r10, %r9
	shrq	$56, %rbx
	movl	7168(%rax,%rbx,4), %r10d
	cmpq	%r10, %rcx
	jne	.LBB9_105
.LBB9_124:
	movq	%r9, %rsi
	addq	$1920, %rsp                     # imm = 0x780
	cmpq	%rdi, %rsi
	jne	.LBB9_118
.LBB9_125:
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end9:
	.size	phase_radix_scatter, .Lfunc_end9-phase_radix_scatter
	.cfi_endproc
                                        # -- End function
	.globl	phase_merge_sortdelta           # -- Begin function phase_merge_sortdelta
	.p2align	4, 0x90
	.type	phase_merge_sortdelta,@function
phase_merge_sortdelta:                  # @phase_merge_sortdelta
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %r13
	movq	8(%rdi), %r12
	leaq	(,%rsi,8), %r14
	addq	%r13, %r14
	cmpq	%r12, %r14
	je	.LBB10_16
# %bb.1:
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	%r12, %rax
	subq	%r14, %rax
	sarq	$3, %rax
	je	.LBB10_2
# %bb.3:
	bsrq	%rax, %rax
	xorq	$63, %rax
	jmp	.LBB10_4
.LBB10_2:
	movl	$64, %eax
.LBB10_4:
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	movq	8(%rbx), %rax
	cmpq	%rax, %r14
	je	.LBB10_14
# %bb.5:
	leaq	8(,%r15,8), %rsi
	addq	%r13, %rsi
	.p2align	4, 0x90
.LBB10_6:                               # =>This Inner Loop Header: Depth=1
	cmpq	%rax, %rsi
	je	.LBB10_16
# %bb.7:                                #   in Loop: Header=BB10_6 Depth=1
	movq	-8(%rsi), %rcx
	leaq	8(%rsi), %rdx
	cmpq	(%rsi), %rcx
	movq	%rdx, %rsi
	jne	.LBB10_6
# %bb.8:
	leaq	-16(%rdx), %r14
	jmp	.LBB10_9
	.p2align	4, 0x90
.LBB10_12:                              #   in Loop: Header=BB10_9 Depth=1
	addq	$8, %rdx
.LBB10_9:                               # =>This Inner Loop Header: Depth=1
	cmpq	%rax, %rdx
	je	.LBB10_13
# %bb.10:                               #   in Loop: Header=BB10_9 Depth=1
	movq	%rcx, %rsi
	movq	(%rdx), %rcx
	cmpq	%rcx, %rsi
	je	.LBB10_12
# %bb.11:                               #   in Loop: Header=BB10_9 Depth=1
	movq	%rcx, 8(%r14)
	addq	$8, %r14
	jmp	.LBB10_12
.LBB10_13:
	addq	$8, %r14
.LBB10_14:
	cmpq	%rax, %r14
	je	.LBB10_16
# %bb.15:
	movq	%r14, 8(%rbx)
.LBB10_16:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	phase_merge_sortdelta, .Lfunc_end10-phase_merge_sortdelta
	.cfi_endproc
                                        # -- End function
	.globl	phase_merge_inplace             # -- Begin function phase_merge_inplace
	.p2align	4, 0x90
	.type	phase_merge_inplace,@function
phase_merge_inplace:                    # @phase_merge_inplace
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rdx
	leaq	(%rdi,%rsi,8), %rsi
	callq	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	cmpq	%rcx, %rax
	je	.LBB11_10
# %bb.1:
	addq	$8, %rax
	.p2align	4, 0x90
.LBB11_2:                               # =>This Inner Loop Header: Depth=1
	cmpq	%rcx, %rax
	je	.LBB11_12
# %bb.3:                                #   in Loop: Header=BB11_2 Depth=1
	movq	-8(%rax), %rdx
	leaq	8(%rax), %rsi
	cmpq	(%rax), %rdx
	movq	%rsi, %rax
	jne	.LBB11_2
# %bb.4:
	leaq	-16(%rsi), %rax
	jmp	.LBB11_5
	.p2align	4, 0x90
.LBB11_8:                               #   in Loop: Header=BB11_5 Depth=1
	addq	$8, %rsi
.LBB11_5:                               # =>This Inner Loop Header: Depth=1
	cmpq	%rcx, %rsi
	je	.LBB11_9
# %bb.6:                                #   in Loop: Header=BB11_5 Depth=1
	movq	%rdx, %rdi
	movq	(%rsi), %rdx
	cmpq	%rdx, %rdi
	je	.LBB11_8
# %bb.7:                                #   in Loop: Header=BB11_5 Depth=1
	movq	%rdx, 8(%rax)
	addq	$8, %rax
	jmp	.LBB11_8
.LBB11_9:
	addq	$8, %rax
.LBB11_10:
	cmpq	%rcx, %rax
	je	.LBB11_12
# %bb.11:
	movq	%rax, 8(%rbx)
.LBB11_12:
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	phase_merge_inplace, .Lfunc_end11-phase_merge_inplace
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function main
.LCPI12_0:
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	21                              # 0x15
	.byte	124                             # 0x7c
	.byte	74                              # 0x4a
	.byte	127                             # 0x7f
	.byte	185                             # 0xb9
	.byte	121                             # 0x79
	.byte	55                              # 0x37
	.byte	158                             # 0x9e
.LCPI12_1:
	.quad	-7046029254386353131            # 0x9e3779b97f4a7c15
	.quad	-7046029254386353131            # 0x9e3779b97f4a7c15
.LCPI12_2:
	.quad	-4658895280553007687            # 0xbf58476d1ce4e5b9
	.quad	-4658895280553007687            # 0xbf58476d1ce4e5b9
.LCPI12_3:
	.quad	3210233709                      # 0xbf58476d
	.quad	3210233709                      # 0xbf58476d
.LCPI12_4:
	.quad	-7723592293110705685            # 0x94d049bb133111eb
	.quad	-7723592293110705685            # 0x94d049bb133111eb
.LCPI12_5:
	.quad	2496678331                      # 0x94d049bb
	.quad	2496678331                      # 0x94d049bb
.LCPI12_6:
	.quad	4354685564936845354             # 0x3c6ef372fe94f82a
	.quad	4354685564936845354             # 0x3c6ef372fe94f82a
.LCPI12_7:
	.long	1                               # 0x1
	.long	1                               # 0x1
	.long	1                               # 0x1
	.long	1                               # 0x1
.LCPI12_8:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI12_9:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
.LCPI12_10:
	.zero	16
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception1
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
	subq	$8760, %rsp                     # imm = 0x2238
	.cfi_def_cfa_offset 8816
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, (%rsp)                    # 8-byte Spill
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	leaq	168(%rsp), %rax
	movq	%rax, 152(%rsp)
	movl	$1953656691, 168(%rsp)          # imm = 0x74726F73
	movq	$4, 160(%rsp)
	movb	$0, 172(%rsp)
	movl	%edi, 64(%rsp)                  # 4-byte Spill
	cmpl	$1, %edi
	jle	.LBB12_124
# %bb.1:
	leaq	576(%rsp), %r14
	leaq	32(%rsp), %r13
	movl	$1, %eax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movl	$1, %ebp
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB12_2:                               # =>This Inner Loop Header: Depth=1
	movq	%r13, %rbx
	movslq	%ebp, %r13
	movq	%r14, %r12
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	(%rax,%r13,8), %r14
	movq	%r12, 560(%rsp)
	testq	%r14, %r14
	je	.LBB12_511
# %bb.3:                                #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	jb	.LBB12_8
# %bb.4:                                #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_513
# %bb.5:                                #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_479
# %bb.6:                                #   in Loop: Header=BB12_2 Depth=1
.Ltmp3:
	callq	_Znwm@PLT
.Ltmp4:
# %bb.7:                                #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 560(%rsp)
	movq	%r15, 576(%rsp)
.LBB12_8:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_12
# %bb.9:                                #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_11
# %bb.10:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_12
	.p2align	4, 0x90
.LBB12_11:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_12:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 568(%rsp)
	movb	$0, (%r12,%r15)
	movq	560(%rsp), %r14
	movq	568(%rsp), %rdx
	leaq	-3(%rdx), %rax
	cmpq	$6, %rax
	ja	.LBB12_74
# %bb.13:                               #   in Loop: Header=BB12_2 Depth=1
	leaq	.LJTI12_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB12_14:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.2(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_65
# %bb.15:                               #   in Loop: Header=BB12_2 Depth=1
	movzwl	(%r14), %eax
	xorl	$11565, %eax                    # imm = 0x2D2D
	movzbl	2(%r14), %ecx
	xorl	$117, %ecx
	orw	%ax, %cx
	jne	.LBB12_74
# %bb.16:                               #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	leaq	32(%rsp), %r12
	movq	%r12, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_532
# %bb.17:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	movq	%rbx, %r13
	jb	.LBB12_22
# %bb.18:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_554
# %bb.19:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_493
# %bb.20:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp51:
	callq	_Znwm@PLT
.Ltmp52:
# %bb.21:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_22:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_103
# %bb.23:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_102
# %bb.24:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_103
.LBB12_25:                              #   in Loop: Header=BB12_2 Depth=1
	movl	(%r14), %eax
	movl	$1818307885, %ecx               # imm = 0x6C612D2D
	xorl	%ecx, %eax
	movzbl	4(%r14), %ecx
	xorl	$103, %ecx
	orl	%eax, %ecx
	jne	.LBB12_74
# %bb.26:                               #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	leaq	32(%rsp), %r12
	movq	%r12, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_520
# %bb.27:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	movq	%rbx, %r13
	jb	.LBB12_32
# %bb.28:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_540
# %bb.29:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_487
# %bb.30:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp81:
	callq	_Znwm@PLT
.Ltmp82:
# %bb.31:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_32:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_76
# %bb.33:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_75
# %bb.34:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_76
.LBB12_35:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.4(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_74
# %bb.36:                               #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	leaq	32(%rsp), %r12
	movq	%r12, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_518
# %bb.37:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	movq	%rbx, %r13
	jb	.LBB12_42
# %bb.38:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_538
# %bb.39:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_485
# %bb.40:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp36:
	callq	_Znwm@PLT
.Ltmp37:
# %bb.41:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_42:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_87
# %bb.43:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_86
# %bb.44:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_87
.LBB12_45:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.6(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_74
# %bb.46:                               #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	movq	%rbx, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_524
# %bb.47:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rbx, %r13
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	movq	%rbx, %r12
	cmpq	$16, %rax
	jb	.LBB12_52
# %bb.48:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_542
# %bb.49:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_491
# %bb.50:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp6:
	callq	_Znwm@PLT
.Ltmp7:
# %bb.51:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_52:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_92
# %bb.53:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_91
# %bb.54:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_92
.LBB12_55:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.5(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_74
# %bb.56:                               #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	leaq	32(%rsp), %r12
	movq	%r12, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_522
# %bb.57:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	movq	%rbx, %r13
	jb	.LBB12_62
# %bb.58:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_536
# %bb.59:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_489
# %bb.60:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp21:
	callq	_Znwm@PLT
.Ltmp22:
# %bb.61:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_62:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_98
# %bb.63:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_97
# %bb.64:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_98
.LBB12_65:                              #   in Loop: Header=BB12_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	8(%rax,%r13,8), %r14
	leaq	32(%rsp), %r12
	movq	%r12, 16(%rsp)
	testq	%r14, %r14
	je	.LBB12_550
# %bb.66:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	callq	strlen@PLT
	movq	%rax, %r15
	cmpq	$16, %rax
	movq	%rbx, %r13
	jb	.LBB12_71
# %bb.67:                               #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	js	.LBB12_557
# %bb.68:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, %rdi
	incq	%rdi
	js	.LBB12_495
# %bb.69:                               #   in Loop: Header=BB12_2 Depth=1
.Ltmp66:
	callq	_Znwm@PLT
.Ltmp67:
# %bb.70:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 16(%rsp)
	movq	%r15, 32(%rsp)
.LBB12_71:                              #   in Loop: Header=BB12_2 Depth=1
	testq	%r15, %r15
	je	.LBB12_108
# %bb.72:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %r15
	jne	.LBB12_107
# %bb.73:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	(%r14), %eax
	movb	%al, (%r12)
	jmp	.LBB12_108
.LBB12_74:                              #   in Loop: Header=BB12_2 Depth=1
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	xorl	%r15d, %r15d
	leaq	.L.str.7(%rip), %rsi
	movq	%r14, %rdx
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$2, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	leaq	576(%rsp), %r14
	movq	%rbx, %r13
	movq	560(%rsp), %rdi
	cmpq	%r14, %rdi
	jne	.LBB12_116
	jmp	.LBB12_117
.LBB12_75:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_76:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_80
# %bb.77:                               #   in Loop: Header=BB12_2 Depth=1
	movq	16(%rsp), %rcx
	leaq	32(%rsp), %rbx
	cmpq	%rbx, %rcx
	leaq	576(%rsp), %r14
	je	.LBB12_83
# %bb.78:                               #   in Loop: Header=BB12_2 Depth=1
	movq	168(%rsp), %rax
	movq	%rcx, 152(%rsp)
	movdqu	24(%rsp), %xmm0
	movdqu	%xmm0, 160(%rsp)
	testq	%rdi, %rdi
	je	.LBB12_82
# %bb.79:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rdi, 16(%rsp)
	movq	%rax, 32(%rsp)
	jmp	.LBB12_123
.LBB12_80:                              #   in Loop: Header=BB12_2 Depth=1
	movq	16(%rsp), %rax
	leaq	32(%rsp), %rbx
	cmpq	%rbx, %rax
	leaq	576(%rsp), %r14
	je	.LBB12_83
# %bb.81:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, 152(%rsp)
	movdqu	24(%rsp), %xmm0
	movdqu	%xmm0, 160(%rsp)
.LBB12_82:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%rbx, 16(%rsp)
	movq	%rbx, %rdi
	jmp	.LBB12_123
.LBB12_83:                              #   in Loop: Header=BB12_2 Depth=1
	movq	24(%rsp), %rdx
	testq	%rdx, %rdx
	je	.LBB12_122
# %bb.84:                               #   in Loop: Header=BB12_2 Depth=1
	cmpq	$1, %rdx
	jne	.LBB12_121
# %bb.85:                               #   in Loop: Header=BB12_2 Depth=1
	movzbl	32(%rsp), %eax
	movb	%al, (%rdi)
	jmp	.LBB12_122
.LBB12_86:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_87:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	16(%rsp), %r14
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	(%rax), %r12d
	movl	$0, (%rax)
	movq	%r14, %rdi
	leaq	192(%rsp), %rsi
	movl	$10, %edx
	callq	__isoc23_strtoull@PLT
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	cmpq	%r14, 192(%rsp)
	je	.LBB12_528
# %bb.88:                               #   in Loop: Header=BB12_2 Depth=1
	movl	(%r15), %eax
	testl	%eax, %eax
	leaq	576(%rsp), %r14
	je	.LBB12_112
# %bb.89:                               #   in Loop: Header=BB12_2 Depth=1
	cmpl	$34, %eax
	jne	.LBB12_113
	jmp	.LBB12_90
.LBB12_91:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_92:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	16(%rsp), %r14
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	(%rax), %r12d
	movl	$0, (%rax)
	movq	%r14, %rdi
	leaq	192(%rsp), %rsi
	movl	$10, %edx
	callq	__isoc23_strtoull@PLT
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	cmpq	%r14, 192(%rsp)
	je	.LBB12_526
# %bb.93:                               #   in Loop: Header=BB12_2 Depth=1
	movl	(%r15), %eax
	testl	%eax, %eax
	leaq	576(%rsp), %r14
	je	.LBB12_96
# %bb.94:                               #   in Loop: Header=BB12_2 Depth=1
	cmpl	$34, %eax
	je	.LBB12_544
# %bb.95:                               #   in Loop: Header=BB12_2 Depth=1
	movq	16(%rsp), %rdi
	cmpq	%r13, %rdi
	jne	.LBB12_114
	jmp	.LBB12_115
.LBB12_96:                              #   in Loop: Header=BB12_2 Depth=1
	movl	%r12d, (%r15)
	movq	16(%rsp), %rdi
	cmpq	%r13, %rdi
	jne	.LBB12_114
	jmp	.LBB12_115
.LBB12_97:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_98:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	16(%rsp), %r14
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	(%rax), %r12d
	movl	$0, (%rax)
	movq	%r14, %rdi
	leaq	192(%rsp), %rsi
	movl	$10, %edx
	callq	__isoc23_strtoull@PLT
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	cmpq	%r14, 192(%rsp)
	je	.LBB12_530
# %bb.99:                               #   in Loop: Header=BB12_2 Depth=1
	movl	(%r15), %eax
	testl	%eax, %eax
	leaq	576(%rsp), %r14
	je	.LBB12_112
# %bb.100:                              #   in Loop: Header=BB12_2 Depth=1
	cmpl	$34, %eax
	jne	.LBB12_113
	jmp	.LBB12_101
.LBB12_102:                             #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_103:                             #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	16(%rsp), %r14
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	(%rax), %r12d
	movl	$0, (%rax)
	movq	%r14, %rdi
	leaq	192(%rsp), %rsi
	movl	$10, %edx
	callq	__isoc23_strtoull@PLT
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	cmpq	%r14, 192(%rsp)
	je	.LBB12_534
# %bb.104:                              #   in Loop: Header=BB12_2 Depth=1
	movl	(%r15), %eax
	testl	%eax, %eax
	leaq	576(%rsp), %r14
	je	.LBB12_112
# %bb.105:                              #   in Loop: Header=BB12_2 Depth=1
	cmpl	$34, %eax
	jne	.LBB12_113
	jmp	.LBB12_106
.LBB12_107:                             #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB12_108:                             #   in Loop: Header=BB12_2 Depth=1
	movq	%r15, 24(%rsp)
	movb	$0, (%r12,%r15)
	movq	16(%rsp), %r14
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	(%rax), %r12d
	movl	$0, (%rax)
	movq	%r14, %rdi
	leaq	192(%rsp), %rsi
	movl	$10, %edx
	callq	__isoc23_strtoull@PLT
	cmpq	%r14, 192(%rsp)
	je	.LBB12_552
# %bb.109:                              #   in Loop: Header=BB12_2 Depth=1
	movl	(%r15), %ecx
	testl	%ecx, %ecx
	leaq	576(%rsp), %r14
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	je	.LBB12_112
# %bb.110:                              #   in Loop: Header=BB12_2 Depth=1
	cmpl	$34, %ecx
	jne	.LBB12_113
	jmp	.LBB12_111
	.p2align	4, 0x90
.LBB12_112:                             #   in Loop: Header=BB12_2 Depth=1
	movl	%r12d, (%r15)
.LBB12_113:                             #   in Loop: Header=BB12_2 Depth=1
	movq	16(%rsp), %rdi
	leaq	32(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_115
.LBB12_114:                             #   in Loop: Header=BB12_2 Depth=1
	callq	_ZdlPv@PLT
.LBB12_115:                             #   in Loop: Header=BB12_2 Depth=1
	incl	%ebp
	movb	$1, %r15b
	movq	560(%rsp), %rdi
	cmpq	%r14, %rdi
	je	.LBB12_117
.LBB12_116:                             #   in Loop: Header=BB12_2 Depth=1
	callq	_ZdlPv@PLT
.LBB12_117:                             #   in Loop: Header=BB12_2 Depth=1
	testb	%r15b, %r15b
	je	.LBB12_470
# %bb.118:                              #   in Loop: Header=BB12_2 Depth=1
	incl	%ebp
	cmpl	64(%rsp), %ebp                  # 4-byte Folded Reload
	jl	.LBB12_2
	jmp	.LBB12_119
.LBB12_121:                             #   in Loop: Header=BB12_2 Depth=1
	movq	%rbx, %rsi
	callq	memcpy@PLT
.LBB12_122:                             #   in Loop: Header=BB12_2 Depth=1
	movq	24(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	152(%rsp), %rcx
	movb	$0, (%rcx,%rax)
	movq	16(%rsp), %rdi
.LBB12_123:                             #   in Loop: Header=BB12_2 Depth=1
	movq	$0, 24(%rsp)
	movb	$0, (%rdi)
	movq	16(%rsp), %rdi
	cmpq	%rbx, %rdi
	jne	.LBB12_114
	jmp	.LBB12_115
.LBB12_124:
	xorl	%eax, %eax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movl	$1, %r14d
	movl	$1, %eax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movl	$1048576, %ecx                  # imm = 0x100000
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	jmp	.LBB12_125
.LBB12_119:
	movq	136(%rsp), %rax                 # 8-byte Reload
	testq	%rax, %rax
	movq	80(%rsp), %rcx                  # 8-byte Reload
	cmoveq	%rcx, %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	104(%rsp), %rax                 # 8-byte Reload
	cmpq	$4, %rax
	movl	$4, %ecx
	cmovbq	%rax, %rcx
	movq	%rcx, 248(%rsp)                 # 8-byte Spill
	testq	%rax, %rax
	je	.LBB12_337
# %bb.120:
	movq	96(%rsp), %rcx                  # 8-byte Reload
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	movq	248(%rsp), %r14                 # 8-byte Reload
.LBB12_125:
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	leaq	(,%r14,8), %rax
	leaq	(%rax,%rax,2), %r15
.Ltmp91:
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp92:
# %bb.126:
	movq	%r14, %rcx
	movq	%rax, %r14
	movq	%rax, 336(%rsp)
	movq	%rcx, 248(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rcx,2), %rbx
	leaq	(%rax,%rbx,8), %r12
	movq	%rax, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	memset@PLT
	addq	%r15, %r14
	movq	%r12, 352(%rsp)
	movq	%r14, 344(%rsp)
.Ltmp94:
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp95:
# %bb.127:
	movq	%rax, %r14
	movq	80(%rsp), %rax                  # 8-byte Reload
	movq	%rax, %r12
	movq	88(%rsp), %r13                  # 8-byte Reload
	subq	%r13, %r12
	shrq	%r12
	cmpq	$1, %r12
	adcq	$0, %r12
	xorl	%ecx, %ecx
	subq	%r13, %rax
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	movq	%r14, 304(%rsp)
	leaq	(%r14,%rbx,8), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%r12, %rbx
	movl	$0, %eax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	cmoveq	%rcx, %rbx
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	memset@PLT
	addq	%r15, %r14
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	%rax, 320(%rsp)
	movq	%r14, 312(%rsp)
	movq	80(%rsp), %rdx                  # 8-byte Reload
	leaq	(%rdx,%rdx), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	96(%rsp), %r15                  # 8-byte Reload
	leaq	(,%r15,8), %rax
	movq	%rax, 544(%rsp)                 # 8-byte Spill
	leaq	-8(,%r15,8), %rax
	movq	%rax, 504(%rsp)                 # 8-byte Spill
	leaq	(,%r15,4), %rax
	movq	%rax, 536(%rsp)                 # 8-byte Spill
	leaq	(,%rdx,8), %rax
	movq	%rax, 520(%rsp)                 # 8-byte Spill
	leaq	(,%r13,8), %rax
	movq	%rax, 472(%rsp)                 # 8-byte Spill
	leaq	-8(,%r13,8), %rax
	movq	%rax, 440(%rsp)                 # 8-byte Spill
	movq	%r12, 448(%rsp)                 # 8-byte Spill
	leaq	(,%r12,8), %rax
	movq	%rax, 464(%rsp)                 # 8-byte Spill
	movq	%rbx, 120(%rsp)                 # 8-byte Spill
	shrq	%rbx
	movq	%rbx, 456(%rsp)                 # 8-byte Spill
	movabsq	$4611686018427387900, %rcx      # imm = 0x3FFFFFFFFFFFFFFC
	leaq	3(%rcx), %rax
	addq	%r15, %rcx
	addq	$3, %rcx
	andq	%rax, %rcx
	movq	%rcx, 528(%rsp)                 # 8-byte Spill
	leaq	1(%rcx), %rax
	movq	%rax, 496(%rsp)                 # 8-byte Spill
	movq	%rax, %r12
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	andq	%rax, %r12
	leaq	(,%r12,4), %rax
	movq	%rax, 480(%rsp)                 # 8-byte Spill
	movq	%rdx, %rax
	subq	%r15, %rax
	movq	%rax, 552(%rsp)                 # 8-byte Spill
	movq	%r12, 488(%rsp)                 # 8-byte Spill
	jmp	.LBB12_129
	.p2align	4, 0x90
.LBB12_128:                             #   in Loop: Header=BB12_129 Depth=1
	movq	112(%rsp), %rcx                 # 8-byte Reload
	incq	%rcx
	movq	%rcx, %rax
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	cmpq	248(%rsp), %rcx                 # 8-byte Folded Reload
	movq	96(%rsp), %r15                  # 8-byte Reload
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	je	.LBB12_338
.LBB12_129:                             # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_140 Depth 2
                                        #     Child Loop BB12_142 Depth 2
                                        #     Child Loop BB12_146 Depth 2
                                        #     Child Loop BB12_149 Depth 2
                                        #     Child Loop BB12_152 Depth 2
                                        #     Child Loop BB12_162 Depth 2
                                        #       Child Loop BB12_171 Depth 3
                                        #       Child Loop BB12_173 Depth 3
                                        #       Child Loop BB12_178 Depth 3
                                        #       Child Loop BB12_180 Depth 3
                                        #     Child Loop BB12_190 Depth 2
                                        #     Child Loop BB12_199 Depth 2
                                        #     Child Loop BB12_201 Depth 2
                                        #     Child Loop BB12_207 Depth 2
                                        #     Child Loop BB12_211 Depth 2
                                        #     Child Loop BB12_244 Depth 2
                                        #     Child Loop BB12_227 Depth 2
                                        #     Child Loop BB12_271 Depth 2
                                        #     Child Loop BB12_288 Depth 2
                                        #     Child Loop BB12_324 Depth 2
                                        #     Child Loop BB12_329 Depth 2
	cmpq	$5, 160(%rsp)
	jne	.LBB12_131
# %bb.130:                              #   in Loop: Header=BB12_129 Depth=1
	movq	152(%rsp), %rax
	movl	(%rax), %ecx
	movl	$1735550317, %edx               # imm = 0x6772656D
	xorl	%edx, %ecx
	movzbl	4(%rax), %eax
	xorl	$101, %eax
	orl	%ecx, %eax
	je	.LBB12_191
.LBB12_131:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	%rbp, %r15
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	movabsq	$-7046029254386353131, %rbx     # imm = 0x9E3779B97F4A7C15
	ja	.LBB12_507
# %bb.132:                              #   in Loop: Header=BB12_129 Depth=1
	movq	112(%rsp), %rax                 # 8-byte Reload
	incq	%rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	movabsq	$-7723592293110705685, %rdx     # imm = 0x94D049BB133111EB
	imulq	%rdx, %rax
	movq	%r15, %rcx
	shldq	$33, %rax, %rcx
	xorq	144(%rsp), %rax                 # 8-byte Folded Reload
	movabsq	$18691697679587, %rsi           # imm = 0x110000001CE3
	xorq	%rsi, %rax
	xorq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	imulq	%rdx, %rax
	movq	%rax, %r13
	shrq	$31, %r13
	xorq	%rax, %r13
	testq	%r15, %r15
	je	.LBB12_138
# %bb.133:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp97:
	movq	544(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp98:
# %bb.134:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %r14
	leaq	8(%rax), %rdi
	movq	$0, (%rax)
	cmpq	$1, %r15
	je	.LBB12_136
# %bb.135:                              #   in Loop: Header=BB12_129 Depth=1
	leaq	(%r14,%r15,8), %rbx
	xorl	%esi, %esi
	movq	504(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
	movq	%rbx, %rdi
.LBB12_136:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rdi, %rcx
	subq	%r14, %rcx
	addq	$-8, %rcx
	cmpq	$8, %rcx
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	jae	.LBB12_139
# %bb.137:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%r13, %rbx
	movq	%r14, %rax
	movabsq	$-7046029254386353131, %rsi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	jmp	.LBB12_142
	.p2align	4, 0x90
.LBB12_138:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%eax, %eax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, (%rsp)                    # 8-byte Spill
	jmp	.LBB12_151
	.p2align	4, 0x90
.LBB12_139:                             #   in Loop: Header=BB12_129 Depth=1
	shrq	$3, %rcx
	incq	%rcx
	movabsq	$4611686018427387900, %rax      # imm = 0x3FFFFFFFFFFFFFFC
	leaq	2(%rax), %rdx
	andq	%rcx, %rdx
	movq	%rdx, %rbx
	movabsq	$-7046029254386353131, %rax     # imm = 0x9E3779B97F4A7C15
	imulq	%rax, %rbx
	addq	%r13, %rbx
	leaq	(%r14,%rdx,8), %rax
	movq	%r13, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	paddq	.LCPI12_0(%rip), %xmm0
	xorl	%esi, %esi
	movdqa	.LCPI12_1(%rip), %xmm4          # xmm4 = [11400714819323198485,11400714819323198485]
	movdqa	.LCPI12_2(%rip), %xmm5          # xmm5 = [13787848793156543929,13787848793156543929]
	movdqa	.LCPI12_3(%rip), %xmm6          # xmm6 = [3210233709,3210233709]
	movdqa	.LCPI12_4(%rip), %xmm7          # xmm7 = [10723151780598845931,10723151780598845931]
	movdqa	.LCPI12_5(%rip), %xmm8          # xmm8 = [2496678331,2496678331]
	movdqa	.LCPI12_6(%rip), %xmm9          # xmm9 = [4354685564936845354,4354685564936845354]
	.p2align	4, 0x90
.LBB12_140:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm0, %xmm1
	paddq	%xmm4, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$30, %xmm2
	pxor	%xmm1, %xmm2
	movdqa	%xmm2, %xmm1
	psrlq	$32, %xmm1
	pmuludq	%xmm5, %xmm1
	movdqa	%xmm2, %xmm3
	pmuludq	%xmm6, %xmm3
	paddq	%xmm1, %xmm3
	psllq	$32, %xmm3
	pmuludq	%xmm5, %xmm2
	paddq	%xmm3, %xmm2
	movdqa	%xmm2, %xmm1
	psrlq	$27, %xmm1
	pxor	%xmm2, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$32, %xmm2
	pmuludq	%xmm7, %xmm2
	movdqa	%xmm1, %xmm3
	pmuludq	%xmm8, %xmm3
	paddq	%xmm2, %xmm3
	psllq	$32, %xmm3
	pmuludq	%xmm7, %xmm1
	paddq	%xmm3, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$31, %xmm2
	pxor	%xmm1, %xmm2
	movdqu	%xmm2, (%r14,%rsi,8)
	addq	$2, %rsi
	paddq	%xmm9, %xmm0
	cmpq	%rsi, %rdx
	jne	.LBB12_140
# %bb.141:                              #   in Loop: Header=BB12_129 Depth=1
	cmpq	%rdx, %rcx
	movabsq	$-7046029254386353131, %rsi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	je	.LBB12_143
	.p2align	4, 0x90
.LBB12_142:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	%rsi, %rbx
	movq	%rbx, %rcx
	shrq	$30, %rcx
	xorq	%rbx, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rdx
	shrq	$27, %rdx
	xorq	%rcx, %rdx
	imulq	%r8, %rdx
	movq	%rdx, %rcx
	shrq	$31, %rcx
	xorq	%rdx, %rcx
	movq	%rcx, (%rax)
	addq	$8, %rax
	cmpq	%rdi, %rax
	jne	.LBB12_142
.LBB12_143:                             #   in Loop: Header=BB12_129 Depth=1
.Ltmp99:
	movq	536(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp100:
# %bb.144:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rsi
	cmpq	$7, 528(%rsp)                   # 8-byte Folded Reload
	movq	%rax, (%rsp)                    # 8-byte Spill
	jb	.LBB12_148
# %bb.145:                              #   in Loop: Header=BB12_129 Depth=1
	movq	480(%rsp), %rax                 # 8-byte Reload
	addq	%rsi, %rax
	xorl	%ecx, %ecx
	movq	488(%rsp), %rdx                 # 8-byte Reload
	movdqa	.LCPI12_7(%rip), %xmm0          # xmm0 = [1,1,1,1]
	.p2align	4, 0x90
.LBB12_146:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqu	%xmm0, (%rsi,%rcx,4)
	movdqu	%xmm0, 16(%rsi,%rcx,4)
	addq	$8, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB12_146
# %bb.147:                              #   in Loop: Header=BB12_129 Depth=1
	cmpq	%rdx, 496(%rsp)                 # 8-byte Folded Reload
	je	.LBB12_150
.LBB12_148:                             #   in Loop: Header=BB12_129 Depth=1
	leaq	(%rsi,%r15,4), %rcx
	.p2align	4, 0x90
.LBB12_149:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$1, (%rax)
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.LBB12_149
.LBB12_150:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rbx, %r13
	movabsq	$-7046029254386353131, %rbx     # imm = 0x9E3779B97F4A7C15
.LBB12_151:                             #   in Loop: Header=BB12_129 Depth=1
	movq	552(%rsp), %rcx                 # 8-byte Reload
	cmpq	%r15, 80(%rsp)                  # 8-byte Folded Reload
	movabsq	$-7723592293110705685, %rsi     # imm = 0x94D049BB133111EB
	movq	(%rsp), %rdi                    # 8-byte Reload
	jbe	.LBB12_153
	.p2align	4, 0x90
.LBB12_152:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	%rbx, %r13
	movq	%r13, %rax
	shrq	$30, %rax
	xorq	%r13, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	imulq	%rsi, %rdx
	movq	%rdx, %rax
	shrq	$31, %rax
	xorq	%rdx, %rax
	mulq	%r15
	incl	(%rdi,%rdx,4)
	decq	%rcx
	jne	.LBB12_152
.LBB12_153:                             #   in Loop: Header=BB12_129 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 560(%rsp)
	movq	$0, 576(%rsp)
	movq	80(%rsp), %rax                  # 8-byte Reload
	cmpq	%rbp, %rax
	ja	.LBB12_509
# %bb.154:                              #   in Loop: Header=BB12_129 Depth=1
	testq	%rax, %rax
	movabsq	$-7723592293110705685, %rbp     # imm = 0x94D049BB133111EB
	je	.LBB12_158
# %bb.155:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp102:
	movq	520(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp103:
# %bb.156:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %r9
	movq	%rax, 560(%rsp)
	movq	%rax, 568(%rsp)
	movq	80(%rsp), %rax                  # 8-byte Reload
	leaq	(%r9,%rax,8), %rax
	movq	%rax, 576(%rsp)
	movq	%r9, %r14
	testq	%r15, %r15
	je	.LBB12_157
.LBB12_159:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%ebp, %ebp
	jmp	.LBB12_162
	.p2align	4, 0x90
.LBB12_174:                             #   in Loop: Header=BB12_162 Depth=2
	movq	%rcx, 568(%rsp)
	movq	%rcx, %r14
.LBB12_160:                             #   in Loop: Header=BB12_162 Depth=2
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	incq	%rbp
	cmpq	%r15, %rbp
	je	.LBB12_188
.LBB12_162:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_171 Depth 3
                                        #       Child Loop BB12_173 Depth 3
                                        #       Child Loop BB12_178 Depth 3
                                        #       Child Loop BB12_180 Depth 3
	movq	(%rsp), %rcx                    # 8-byte Reload
	movl	(%rcx,%rbp,4), %r12d
	testq	%r12, %r12
	je	.LBB12_160
# %bb.163:                              #   in Loop: Header=BB12_162 Depth=2
	movq	%rax, %rcx
	subq	%r14, %rcx
	sarq	$3, %rcx
	cmpq	%r12, %rcx
	jae	.LBB12_168
# %bb.164:                              #   in Loop: Header=BB12_162 Depth=2
	subq	%r9, %r14
	movq	%r14, %rax
	sarq	$3, %rax
	movabsq	$1152921504606846975, %rdx      # imm = 0xFFFFFFFFFFFFFFF
	movq	%rdx, %rcx
	subq	%rax, %rcx
	cmpq	%r12, %rcx
	jb	.LBB12_499
# %bb.165:                              #   in Loop: Header=BB12_162 Depth=2
	cmpq	%r12, %rax
	movq	%r12, %rcx
	cmovaq	%rax, %rcx
	leaq	(%rcx,%rax), %rdi
	movabsq	$1152921504606846975, %rsi      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rsi, %rdi
	cmovaeq	%rsi, %rdi
	addq	%rax, %rcx
	cmovbq	%rdx, %rdi
	testq	%rdi, %rdi
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	je	.LBB12_175
# %bb.166:                              #   in Loop: Header=BB12_162 Depth=2
	movq	%r9, %rbx
	leaq	(,%rdi,8), %rdi
.Ltmp105:
	callq	_Znwm@PLT
.Ltmp106:
# %bb.167:                              #   in Loop: Header=BB12_162 Depth=2
	movq	%rax, %r15
	movq	%rbx, %r9
	jmp	.LBB12_176
	.p2align	4, 0x90
.LBB12_168:                             #   in Loop: Header=BB12_162 Depth=2
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movq	(%rcx,%rbp,8), %rdx
	leaq	(%r14,%r12,8), %rcx
	movabsq	$2305843009213693951, %rsi      # imm = 0x1FFFFFFFFFFFFFFF
	addq	%rsi, %r12
	andq	%rsi, %r12
	cmpq	$3, %r12
	jae	.LBB12_170
# %bb.169:                              #   in Loop: Header=BB12_162 Depth=2
	movq	%r14, %rsi
	jmp	.LBB12_173
.LBB12_170:                             #   in Loop: Header=BB12_162 Depth=2
	incq	%r12
	movq	%r12, %rdi
	movabsq	$4611686018427387900, %rsi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rsi, %rdi
	leaq	(%r14,%rdi,8), %rsi
	movq	%rdx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB12_171:                             #   Parent Loop BB12_129 Depth=1
                                        #     Parent Loop BB12_162 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	%xmm0, (%r14,%r8,8)
	movdqu	%xmm0, 16(%r14,%r8,8)
	addq	$4, %r8
	cmpq	%r8, %rdi
	jne	.LBB12_171
# %bb.172:                              #   in Loop: Header=BB12_162 Depth=2
	cmpq	%rdi, %r12
	je	.LBB12_174
	.p2align	4, 0x90
.LBB12_173:                             #   Parent Loop BB12_129 Depth=1
                                        #     Parent Loop BB12_162 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rdx, (%rsi)
	addq	$8, %rsi
	cmpq	%rcx, %rsi
	jne	.LBB12_173
	jmp	.LBB12_174
.LBB12_175:                             #   in Loop: Header=BB12_162 Depth=2
	xorl	%r15d, %r15d
.LBB12_176:                             #   in Loop: Header=BB12_162 Depth=2
	leaq	(%r15,%r14), %rax
	leaq	(%rax,%r12,8), %rbx
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movq	(%rcx,%rbp,8), %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	addq	%rdx, %r12
	andq	%rdx, %r12
	cmpq	$3, %r12
	jb	.LBB12_180
# %bb.177:                              #   in Loop: Header=BB12_162 Depth=2
	incq	%r12
	movq	%r12, %rdx
	movabsq	$4611686018427387900, %rsi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rsi, %rdx
	leaq	(%rax,%rdx,8), %rax
	movq	%rcx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	leaq	(%r15,%r14), %rsi
	addq	$16, %rsi
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB12_178:                             #   Parent Loop BB12_129 Depth=1
                                        #     Parent Loop BB12_162 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	%xmm0, -16(%rsi,%rdi,8)
	movdqu	%xmm0, (%rsi,%rdi,8)
	addq	$4, %rdi
	cmpq	%rdi, %rdx
	jne	.LBB12_178
# %bb.179:                              #   in Loop: Header=BB12_162 Depth=2
	cmpq	%rdx, %r12
	je	.LBB12_181
	.p2align	4, 0x90
.LBB12_180:                             #   Parent Loop BB12_129 Depth=1
                                        #     Parent Loop BB12_162 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, (%rax)
	addq	$8, %rax
	cmpq	%rbx, %rax
	jne	.LBB12_180
.LBB12_181:                             #   in Loop: Header=BB12_162 Depth=2
	cmpq	$9, %r14
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	jl	.LBB12_186
# %bb.182:                              #   in Loop: Header=BB12_162 Depth=2
	movq	%r15, %rdi
	movq	%r9, %rsi
	movq	%r14, %rdx
	movq	%r9, %r14
	callq	memmove@PLT
	movq	%r14, %r9
.LBB12_183:                             #   in Loop: Header=BB12_162 Depth=2
	testq	%r9, %r9
	je	.LBB12_185
.LBB12_184:                             #   in Loop: Header=BB12_162 Depth=2
	movq	%r9, %rdi
	callq	_ZdlPv@PLT
.LBB12_185:                             #   in Loop: Header=BB12_162 Depth=2
	movq	%r15, 560(%rsp)
	movq	%rbx, 568(%rsp)
	movq	8(%rsp), %rax                   # 8-byte Reload
	leaq	(%r15,%rax,8), %rax
	movq	%rax, 576(%rsp)
	movq	%r15, %r9
	movq	%rbx, %r14
	movq	96(%rsp), %r15                  # 8-byte Reload
	movabsq	$-7046029254386353131, %rbx     # imm = 0x9E3779B97F4A7C15
	incq	%rbp
	cmpq	%r15, %rbp
	jne	.LBB12_162
	jmp	.LBB12_188
.LBB12_186:                             #   in Loop: Header=BB12_162 Depth=2
	cmpq	$8, %r14
	jne	.LBB12_183
# %bb.187:                              #   in Loop: Header=BB12_162 Depth=2
	movq	(%r9), %rax
	movq	%rax, (%r15)
	jmp	.LBB12_184
	.p2align	4, 0x90
.LBB12_188:                             #   in Loop: Header=BB12_129 Depth=1
	movq	560(%rsp), %r9
	movabsq	$-7723592293110705685, %rbp     # imm = 0x94D049BB133111EB
	subq	%r9, %r14
	sarq	$3, %r14
	cmpq	$2, %r14
	jb	.LBB12_302
	jmp	.LBB12_189
	.p2align	4, 0x90
.LBB12_158:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	movq	%r9, %r14
	testq	%r15, %r15
	jne	.LBB12_159
	.p2align	4, 0x90
.LBB12_157:                             #   in Loop: Header=BB12_129 Depth=1
	subq	%r9, %r14
	sarq	$3, %r14
	cmpq	$2, %r14
	jb	.LBB12_302
.LBB12_189:                             #   in Loop: Header=BB12_129 Depth=1
	addq	%rbx, %r13
	.p2align	4, 0x90
.LBB12_190:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r13, %rax
	shrq	$30, %rax
	xorq	%r13, %rax
	imulq	%r12, %rax
	movq	%rax, %rcx
	shrq	$27, %rcx
	xorq	%rax, %rcx
	imulq	%rbp, %rcx
	movq	%rcx, %rax
	shrq	$31, %rax
	xorq	%rcx, %rax
	mulq	%r14
	movq	-8(%r9,%r14,8), %rax
	movq	(%r9,%rdx,8), %rcx
	movq	%rcx, -8(%r9,%r14,8)
	leaq	-1(%r14), %rcx
	movq	%rax, (%r9,%rdx,8)
	addq	%rbx, %r13
	movq	%rcx, %r14
	cmpq	$1, %rcx
	ja	.LBB12_190
	jmp	.LBB12_302
.LBB12_191:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	%rbp, 88(%rsp)                  # 8-byte Folded Reload
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	ja	.LBB12_507
# %bb.192:                              #   in Loop: Header=BB12_129 Depth=1
	movq	112(%rsp), %rax                 # 8-byte Reload
	incq	%rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	movabsq	$-7723592293110705685, %rdx     # imm = 0x94D049BB133111EB
	imulq	%rdx, %rax
	movq	144(%rsp), %rcx                 # 8-byte Reload
	xorq	%rax, %rcx
	shrq	$31, %rax
	xorq	%rcx, %rax
	movabsq	$18691697679587, %rcx           # imm = 0x110000001CE3
	xorq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	imulq	%rdx, %rax
	movq	%rax, %r14
	shrq	$31, %r14
	xorq	%rax, %r14
	cmpq	$0, 88(%rsp)                    # 8-byte Folded Reload
	je	.LBB12_515
# %bb.193:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp114:
	movq	%r14, %r13
	movq	472(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp115:
# %bb.194:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %r15
	leaq	8(%rax), %rbx
	movq	$0, (%rax)
	movq	%rbx, %r14
	cmpq	$1, 88(%rsp)                    # 8-byte Folded Reload
	je	.LBB12_196
# %bb.195:                              #   in Loop: Header=BB12_129 Depth=1
	movq	88(%rsp), %rax                  # 8-byte Reload
	leaq	(%r15,%rax,8), %r14
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	440(%rsp), %rdx                 # 8-byte Reload
	callq	memset@PLT
.LBB12_196:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%r14, %r10
	movq	%r14, %rax
	subq	%r15, %rax
	leaq	-8(%rax), %rdx
	cmpq	$8, %rdx
	movq	%r15, %rcx
	movq	%r15, 64(%rsp)                  # 8-byte Spill
	jae	.LBB12_198
# %bb.197:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%r13, %r14
	movq	%r15, %rcx
	movabsq	$-7046029254386353131, %rdi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	movq	%r10, %r9
	jmp	.LBB12_201
.LBB12_515:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%eax, %eax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	xorl	%ebx, %ebx
	xorl	%r13d, %r13d
	cmpq	%rbp, 120(%rsp)                 # 8-byte Folded Reload
	jbe	.LBB12_217
	jmp	.LBB12_516
.LBB12_198:                             #   in Loop: Header=BB12_129 Depth=1
	shrq	$3, %rdx
	incq	%rdx
	movabsq	$4611686018427387900, %rcx      # imm = 0x3FFFFFFFFFFFFFFC
	leaq	2(%rcx), %rsi
	andq	%rdx, %rsi
	movq	%rsi, %r14
	movabsq	$-7046029254386353131, %rcx     # imm = 0x9E3779B97F4A7C15
	imulq	%rcx, %r14
	addq	%r13, %r14
	leaq	(%r15,%rsi,8), %rcx
	movq	%r13, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	paddq	.LCPI12_0(%rip), %xmm0
	xorl	%edi, %edi
	movdqa	.LCPI12_1(%rip), %xmm4          # xmm4 = [11400714819323198485,11400714819323198485]
	movdqa	.LCPI12_2(%rip), %xmm5          # xmm5 = [13787848793156543929,13787848793156543929]
	movdqa	.LCPI12_3(%rip), %xmm6          # xmm6 = [3210233709,3210233709]
	movdqa	.LCPI12_4(%rip), %xmm7          # xmm7 = [10723151780598845931,10723151780598845931]
	movdqa	.LCPI12_5(%rip), %xmm8          # xmm8 = [2496678331,2496678331]
	movdqa	.LCPI12_6(%rip), %xmm9          # xmm9 = [4354685564936845354,4354685564936845354]
	.p2align	4, 0x90
.LBB12_199:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqa	%xmm0, %xmm1
	paddq	%xmm4, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$30, %xmm2
	pxor	%xmm1, %xmm2
	movdqa	%xmm2, %xmm1
	psrlq	$32, %xmm1
	pmuludq	%xmm5, %xmm1
	movdqa	%xmm2, %xmm3
	pmuludq	%xmm6, %xmm3
	paddq	%xmm1, %xmm3
	psllq	$32, %xmm3
	pmuludq	%xmm5, %xmm2
	paddq	%xmm3, %xmm2
	movdqa	%xmm2, %xmm1
	psrlq	$27, %xmm1
	pxor	%xmm2, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$32, %xmm2
	pmuludq	%xmm7, %xmm2
	movdqa	%xmm1, %xmm3
	pmuludq	%xmm8, %xmm3
	paddq	%xmm2, %xmm3
	psllq	$32, %xmm3
	pmuludq	%xmm7, %xmm1
	paddq	%xmm3, %xmm1
	movdqa	%xmm1, %xmm2
	psrlq	$31, %xmm2
	pxor	%xmm1, %xmm2
	movdqu	%xmm2, (%r15,%rdi,8)
	addq	$2, %rdi
	paddq	%xmm9, %xmm0
	cmpq	%rdi, %rsi
	jne	.LBB12_199
# %bb.200:                              #   in Loop: Header=BB12_129 Depth=1
	cmpq	%rsi, %rdx
	movabsq	$-7046029254386353131, %rdi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	movq	%r10, %r9
	je	.LBB12_202
	.p2align	4, 0x90
.LBB12_201:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	%rdi, %r14
	movq	%r14, %rdx
	shrq	$30, %rdx
	xorq	%r14, %rdx
	imulq	%r12, %rdx
	movq	%rdx, %rsi
	shrq	$27, %rsi
	xorq	%rdx, %rsi
	imulq	%r8, %rsi
	movq	%rsi, %rdx
	shrq	$31, %rdx
	xorq	%rsi, %rdx
	movq	%rdx, (%rcx)
	addq	$8, %rcx
	cmpq	%r9, %rcx
	jne	.LBB12_201
.LBB12_202:                             #   in Loop: Header=BB12_129 Depth=1
	sarq	$3, %rax
	je	.LBB12_204
# %bb.203:                              #   in Loop: Header=BB12_129 Depth=1
	bsrq	%rax, %rax
	xorq	$63, %rax
	jmp	.LBB12_205
.LBB12_204:                             #   in Loop: Header=BB12_129 Depth=1
	movl	$64, %eax
.LBB12_205:                             #   in Loop: Header=BB12_129 Depth=1
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
.Ltmp117:
	movq	64(%rsp), %r15                  # 8-byte Reload
	movq	%r15, %rdi
	movq	%r10, %r13
	movq	%r10, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp118:
# %bb.206:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp119:
	movq	%r15, %rdi
	movq	%r13, %rsi
	callq	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp120:
	.p2align	4, 0x90
.LBB12_207:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%r13, %rbx
	je	.LBB12_216
# %bb.208:                              #   in Loop: Header=BB12_207 Depth=2
	movq	-8(%rbx), %rcx
	leaq	8(%rbx), %rdx
	cmpq	(%rbx), %rcx
	movq	%rdx, %rbx
	jne	.LBB12_207
# %bb.209:                              #   in Loop: Header=BB12_129 Depth=1
	leaq	-16(%rdx), %rax
	jmp	.LBB12_211
	.p2align	4, 0x90
.LBB12_210:                             #   in Loop: Header=BB12_211 Depth=2
	addq	$8, %rdx
.LBB12_211:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%r13, %rdx
	je	.LBB12_214
# %bb.212:                              #   in Loop: Header=BB12_211 Depth=2
	movq	%rcx, %rsi
	movq	(%rdx), %rcx
	cmpq	%rcx, %rsi
	je	.LBB12_210
# %bb.213:                              #   in Loop: Header=BB12_211 Depth=2
	movq	%rcx, 8(%rax)
	addq	$8, %rax
	jmp	.LBB12_210
.LBB12_214:                             #   in Loop: Header=BB12_129 Depth=1
	addq	$8, %rax
	cmpq	%r13, %rax
	je	.LBB12_216
# %bb.215:                              #   in Loop: Header=BB12_129 Depth=1
	movq	64(%rsp), %rbx                  # 8-byte Reload
	movq	%rax, %r13
	cmpq	%rbp, 120(%rsp)                 # 8-byte Folded Reload
	jbe	.LBB12_217
	jmp	.LBB12_516
.LBB12_216:                             #   in Loop: Header=BB12_129 Depth=1
	movq	64(%rsp), %rbx                  # 8-byte Reload
	cmpq	%rbp, 120(%rsp)                 # 8-byte Folded Reload
	ja	.LBB12_516
.LBB12_217:                             #   in Loop: Header=BB12_129 Depth=1
	movq	80(%rsp), %rax                  # 8-byte Reload
	cmpq	88(%rsp), %rax                  # 8-byte Folded Reload
	jne	.LBB12_219
# %bb.218:                              #   in Loop: Header=BB12_129 Depth=1
	xorl	%ecx, %ecx
	xorl	%ebp, %ebp
	jmp	.LBB12_221
.LBB12_219:                             #   in Loop: Header=BB12_129 Depth=1
.Ltmp122:
	movq	464(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp123:
# %bb.220:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rcx
	movq	448(%rsp), %rax                 # 8-byte Reload
	leaq	(%rcx,%rax,8), %rbp
.LBB12_221:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%r13, %rax
	subq	%rbx, %rax
	movq	%rax, 408(%rsp)                 # 8-byte Spill
	movq	%rax, %r8
	sarq	$3, %r8
	movabsq	$-7046029254386353131, %rax     # imm = 0x9E3779B97F4A7C15
	addq	%r14, %rax
	movq	%rax, %rdx
	shrq	$30, %rdx
	xorq	%rax, %rdx
	imulq	%r12, %rdx
	movq	%rdx, %rsi
	shrq	$27, %rsi
	xorq	%rdx, %rsi
	movabsq	$-7723592293110705685, %rdi     # imm = 0x94D049BB133111EB
	imulq	%rdi, %rsi
	movq	%rsi, %rax
	shrq	$31, %rax
	xorq	%rsi, %rax
	mulq	%r8
	movq	%r14, %rsi
	movabsq	$4354685564936845354, %rax      # imm = 0x3C6EF372FE94F82A
	movq	%r14, 8(%rsp)                   # 8-byte Spill
	leaq	(%r14,%rax), %rbx
	cmpq	$2, 120(%rsp)                   # 8-byte Folded Reload
	movq	%r13, 512(%rsp)                 # 8-byte Spill
	movq	%r8, 240(%rsp)                  # 8-byte Spill
	jae	.LBB12_241
# %bb.222:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rcx, %rax
	jmp	.LBB12_223
.LBB12_241:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rdx, %r14
	movq	%rbx, %rax
	shrq	$30, %rax
	xorq	%rbx, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	imulq	%rdi, %rdx
	movq	%rdx, %rdi
	shrq	$31, %rdi
	xorq	%rdx, %rdi
	orq	$1, %rdi
	movq	456(%rsp), %r13                 # 8-byte Reload
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	%rdi, 232(%rsp)                 # 8-byte Spill
	jmp	.LBB12_244
	.p2align	4, 0x90
.LBB12_246:                             #   in Loop: Header=BB12_244 Depth=2
	movl	%r14d, %eax
	xorl	%edx, %edx
	divl	%r8d
                                        # kill: def $edx killed $edx def $rdx
	cmpq	%rbp, %rcx
	je	.LBB12_247
.LBB12_242:                             #   in Loop: Header=BB12_244 Depth=2
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	(%rax,%rdx,8), %rax
	movq	%rax, (%rcx)
	movq	(%rsp), %rax                    # 8-byte Reload
	addq	$8, %rcx
	addq	%rdi, %r14
	decq	%r13
	je	.LBB12_223
.LBB12_244:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, %rax
	orq	%r8, %rax
	shrq	$32, %rax
	je	.LBB12_246
# %bb.245:                              #   in Loop: Header=BB12_244 Depth=2
	movq	%r14, %rax
	xorl	%edx, %edx
	divq	%r8
	cmpq	%rbp, %rcx
	jne	.LBB12_242
.LBB12_247:                             #   in Loop: Header=BB12_244 Depth=2
	subq	(%rsp), %rbp                    # 8-byte Folded Reload
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %rbp
	je	.LBB12_501
# %bb.248:                              #   in Loop: Header=BB12_244 Depth=2
	movq	%rbp, %r12
	sarq	$3, %r12
	cmpq	$1, %r12
	movq	%r12, %rax
	adcq	$0, %rax
	leaq	(%rax,%r12), %rcx
	movabsq	$1152921504606846975, %rsi      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rsi, %rcx
	jb	.LBB12_249
# %bb.253:                              #   in Loop: Header=BB12_244 Depth=2
	movabsq	$1152921504606846975, %rcx      # imm = 0xFFFFFFFFFFFFFFF
	addq	%r12, %rax
	jae	.LBB12_254
.LBB12_250:                             #   in Loop: Header=BB12_244 Depth=2
	testq	%rsi, %rsi
	movq	%rsi, 256(%rsp)                 # 8-byte Spill
	je	.LBB12_255
.LBB12_251:                             #   in Loop: Header=BB12_244 Depth=2
	movq	%rdx, %r15
	leaq	(,%rsi,8), %rdi
.Ltmp125:
	callq	_Znwm@PLT
.Ltmp126:
# %bb.252:                              #   in Loop: Header=BB12_244 Depth=2
	movq	%r15, %rdx
	movq	%rax, %rcx
	jmp	.LBB12_256
	.p2align	4, 0x90
.LBB12_249:                             #   in Loop: Header=BB12_244 Depth=2
	addq	%r12, %rax
	jb	.LBB12_250
.LBB12_254:                             #   in Loop: Header=BB12_244 Depth=2
	movq	%rcx, %rsi
	testq	%rsi, %rsi
	movq	%rsi, 256(%rsp)                 # 8-byte Spill
	jne	.LBB12_251
.LBB12_255:                             #   in Loop: Header=BB12_244 Depth=2
	xorl	%ecx, %ecx
.LBB12_256:                             #   in Loop: Header=BB12_244 Depth=2
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	(%rax,%rdx,8), %rax
	movq	%rax, (%rcx,%r12,8)
	testq	%rbp, %rbp
	movq	(%rsp), %r15                    # 8-byte Reload
	movq	%rcx, %rax
	jle	.LBB12_258
# %bb.257:                              #   in Loop: Header=BB12_244 Depth=2
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%rbp, %rdx
	movq	%rax, %r12
	callq	memmove@PLT
	movq	%r12, %rax
.LBB12_258:                             #   in Loop: Header=BB12_244 Depth=2
	testq	%r15, %r15
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	je	.LBB12_260
# %bb.259:                              #   in Loop: Header=BB12_244 Depth=2
	movq	%r15, %rdi
	movq	%rax, %r15
	callq	_ZdlPv@PLT
	movq	%r15, %rax
.LBB12_260:                             #   in Loop: Header=BB12_244 Depth=2
	addq	%rax, %rbp
	movq	%rbp, %rcx
	movq	256(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rax,%rdx,8), %rbp
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	240(%rsp), %r8                  # 8-byte Reload
	movq	232(%rsp), %rdi                 # 8-byte Reload
	addq	$8, %rcx
	addq	%rdi, %r14
	decq	%r13
	jne	.LBB12_244
.LBB12_223:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rcx, %r15
	subq	%rax, %r15
	movq	%r15, %r13
	sarq	$3, %r13
	cmpq	120(%rsp), %r13                 # 8-byte Folded Reload
	jae	.LBB12_261
# %bb.224:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, (%rsp)                    # 8-byte Spill
	movabsq	$-2691343689449507777, %rax     # imm = 0xDAA66D2C7DDF743F
	movq	8(%rsp), %r14                   # 8-byte Reload
	addq	%rax, %r14
	jmp	.LBB12_227
	.p2align	4, 0x90
.LBB12_225:                             #   in Loop: Header=BB12_227 Depth=2
	movq	%r14, (%rcx)
	movq	(%rsp), %rdx                    # 8-byte Reload
	movq	8(%rsp), %r14                   # 8-byte Reload
.LBB12_226:                             #   in Loop: Header=BB12_227 Depth=2
	addq	$8, %rcx
	movq	%rcx, %r15
	subq	%rdx, %r15
	movq	%r15, %r13
	sarq	$3, %r13
	movabsq	$-7046029254386353131, %rax     # imm = 0x9E3779B97F4A7C15
	addq	%rax, %r14
	addq	%rax, %rbx
	cmpq	120(%rsp), %r13                 # 8-byte Folded Reload
	jae	.LBB12_262
.LBB12_227:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, %rax
	shrq	$30, %rax
	movq	%r14, 8(%rsp)                   # 8-byte Spill
	xorq	%r14, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	movabsq	$-7723592293110705685, %rax     # imm = 0x94D049BB133111EB
	imulq	%rax, %rdx
	movq	%rdx, %r14
	shrq	$31, %r14
	xorq	%rdx, %r14
	cmpq	%rbp, %rcx
	jne	.LBB12_225
# %bb.228:                              #   in Loop: Header=BB12_227 Depth=2
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %r15
	movabsq	$1152921504606846975, %r12      # imm = 0xFFFFFFFFFFFFFFF
	je	.LBB12_503
# %bb.229:                              #   in Loop: Header=BB12_227 Depth=2
	cmpq	$1, %r13
	movq	%r13, %rax
	adcq	$0, %rax
	leaq	(%rax,%r13), %rcx
	movabsq	$1152921504606846975, %rdx      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	jb	.LBB12_230
# %bb.238:                              #   in Loop: Header=BB12_227 Depth=2
	movabsq	$1152921504606846975, %rcx      # imm = 0xFFFFFFFFFFFFFFF
	addq	%r13, %rax
	jae	.LBB12_239
.LBB12_231:                             #   in Loop: Header=BB12_227 Depth=2
	testq	%r12, %r12
	je	.LBB12_240
.LBB12_232:                             #   in Loop: Header=BB12_227 Depth=2
	leaq	(,%r12,8), %rdi
.Ltmp131:
	callq	_Znwm@PLT
.Ltmp132:
# %bb.233:                              #   in Loop: Header=BB12_227 Depth=2
	movq	%rax, %rbp
	movq	%r14, (%rbp,%r13,8)
	testq	%r15, %r15
	movq	(%rsp), %rsi                    # 8-byte Reload
	jle	.LBB12_235
.LBB12_234:                             #   in Loop: Header=BB12_227 Depth=2
	movq	%rbp, %rdi
	movq	%r15, %rdx
	callq	memmove@PLT
	movq	(%rsp), %rsi                    # 8-byte Reload
.LBB12_235:                             #   in Loop: Header=BB12_227 Depth=2
	testq	%rsi, %rsi
	movq	8(%rsp), %r14                   # 8-byte Reload
	je	.LBB12_237
# %bb.236:                              #   in Loop: Header=BB12_227 Depth=2
	movq	%rsi, %rdi
	callq	_ZdlPv@PLT
.LBB12_237:                             #   in Loop: Header=BB12_227 Depth=2
	movq	%rbp, %rdx
	addq	%rbp, %r15
	leaq	(%rbp,%r12,8), %rbp
	movq	%r15, %rcx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	jmp	.LBB12_226
	.p2align	4, 0x90
.LBB12_230:                             #   in Loop: Header=BB12_227 Depth=2
	addq	%r13, %rax
	jb	.LBB12_231
.LBB12_239:                             #   in Loop: Header=BB12_227 Depth=2
	movq	%rcx, %r12
	testq	%r12, %r12
	jne	.LBB12_232
.LBB12_240:                             #   in Loop: Header=BB12_227 Depth=2
	xorl	%ebp, %ebp
	movq	%r14, (%rbp,%r13,8)
	testq	%r15, %r15
	movq	(%rsp), %rsi                    # 8-byte Reload
	jg	.LBB12_234
	jmp	.LBB12_235
.LBB12_261:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rdx
.LBB12_262:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rdx, (%rsp)                    # 8-byte Spill
	cmpq	%rdx, %rcx
	je	.LBB12_293
# %bb.263:                              #   in Loop: Header=BB12_129 Depth=1
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %r13
	ja	.LBB12_481
# %bb.264:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp134:
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp135:
# %bb.265:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rbp
	cmpq	$9, %r15
	jl	.LBB12_294
.LBB12_266:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rbp, %rdi
	movq	(%rsp), %rsi                    # 8-byte Reload
	movq	%r15, %rdx
	callq	memmove@PLT
.LBB12_267:                             #   in Loop: Header=BB12_129 Depth=1
	leaq	(%r15,%rbp), %r12
	movq	%r15, %r14
	sarq	$3, %r14
	cmpq	184(%rsp), %r14                 # 8-byte Folded Reload
	jae	.LBB12_286
# %bb.268:                              #   in Loop: Header=BB12_129 Depth=1
	leaq	(,%r13,8), %rcx
	addq	%rbp, %rcx
	movq	%rbp, %rax
	jmp	.LBB12_271
	.p2align	4, 0x90
.LBB12_269:                             #   in Loop: Header=BB12_271 Depth=2
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	(%rax,%r13,8), %rax
	movq	%rax, (%r12)
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, %rbp
.LBB12_270:                             #   in Loop: Header=BB12_271 Depth=2
	addq	$8, %r12
	movq	%r12, %r15
	subq	%rbp, %r15
	movq	%r15, %r14
	sarq	$3, %r14
	cmpq	184(%rsp), %r14                 # 8-byte Folded Reload
	jae	.LBB12_286
.LBB12_271:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movabsq	$-7046029254386353131, %rax     # imm = 0x9E3779B97F4A7C15
	addq	%rax, %rbx
	movq	%rbx, %rax
	shrq	$30, %rax
	xorq	%rbx, %rax
	movabsq	$-4658895280553007687, %rdx     # imm = 0xBF58476D1CE4E5B9
	imulq	%rdx, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	movabsq	$-7723592293110705685, %rax     # imm = 0x94D049BB133111EB
	imulq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$31, %rax
	xorq	%rdx, %rax
	mulq	120(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	cmpq	%rcx, %r12
	jne	.LBB12_269
# %bb.272:                              #   in Loop: Header=BB12_271 Depth=2
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %r15
	je	.LBB12_505
# %bb.273:                              #   in Loop: Header=BB12_271 Depth=2
	cmpq	$1, %r14
	movq	%r14, %rax
	adcq	$0, %rax
	leaq	(%rax,%r14), %rcx
	movabsq	$1152921504606846975, %rdx      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	movabsq	$1152921504606846975, %r12      # imm = 0xFFFFFFFFFFFFFFF
	jb	.LBB12_274
# %bb.278:                              #   in Loop: Header=BB12_271 Depth=2
	movabsq	$1152921504606846975, %rcx      # imm = 0xFFFFFFFFFFFFFFF
	addq	%r14, %rax
	jae	.LBB12_279
.LBB12_275:                             #   in Loop: Header=BB12_271 Depth=2
	testq	%r12, %r12
	je	.LBB12_280
.LBB12_276:                             #   in Loop: Header=BB12_271 Depth=2
	leaq	(,%r12,8), %rdi
.Ltmp140:
	callq	_Znwm@PLT
.Ltmp141:
# %bb.277:                              #   in Loop: Header=BB12_271 Depth=2
	movq	%rax, %rbp
	jmp	.LBB12_281
	.p2align	4, 0x90
.LBB12_274:                             #   in Loop: Header=BB12_271 Depth=2
	addq	%r14, %rax
	jb	.LBB12_275
.LBB12_279:                             #   in Loop: Header=BB12_271 Depth=2
	movq	%rcx, %r12
	testq	%r12, %r12
	jne	.LBB12_276
.LBB12_280:                             #   in Loop: Header=BB12_271 Depth=2
	xorl	%ebp, %ebp
.LBB12_281:                             #   in Loop: Header=BB12_271 Depth=2
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	(%rax,%r13,8), %rax
	movq	%rax, (%rbp,%r14,8)
	testq	%r15, %r15
	movq	8(%rsp), %r14                   # 8-byte Reload
	jle	.LBB12_283
# %bb.282:                              #   in Loop: Header=BB12_271 Depth=2
	movq	%rbp, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memmove@PLT
.LBB12_283:                             #   in Loop: Header=BB12_271 Depth=2
	testq	%r14, %r14
	je	.LBB12_285
# %bb.284:                              #   in Loop: Header=BB12_271 Depth=2
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
.LBB12_285:                             #   in Loop: Header=BB12_271 Depth=2
	addq	%rbp, %r15
	leaq	(,%r12,8), %rcx
	addq	%rbp, %rcx
	movq	%r15, %r12
	movq	%rbp, %rax
	jmp	.LBB12_270
.LBB12_286:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	$2, %r14
	movabsq	$-4658895280553007687, %rsi     # imm = 0xBF58476D1CE4E5B9
	movabsq	$-7046029254386353131, %rdi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	jb	.LBB12_289
# %bb.287:                              #   in Loop: Header=BB12_129 Depth=1
	addq	%rdi, %rbx
	.p2align	4, 0x90
.LBB12_288:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rax
	shrq	$30, %rax
	xorq	%rbx, %rax
	imulq	%rsi, %rax
	movq	%rax, %rcx
	shrq	$27, %rcx
	xorq	%rax, %rcx
	imulq	%r8, %rcx
	movq	%rcx, %rax
	shrq	$31, %rax
	xorq	%rcx, %rax
	mulq	%r14
	movq	-8(%rbp,%r14,8), %rax
	movq	(%rbp,%rdx,8), %rcx
	movq	%rcx, -8(%rbp,%r14,8)
	leaq	-1(%r14), %rcx
	movq	%rax, (%rbp,%rdx,8)
	addq	%rdi, %rbx
	movq	%rcx, %r14
	cmpq	$1, %rcx
	ja	.LBB12_288
.LBB12_289:                             #   in Loop: Header=BB12_129 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 560(%rsp)
	movq	$0, 576(%rsp)
	movq	512(%rsp), %rax                 # 8-byte Reload
	cmpq	64(%rsp), %rax                  # 8-byte Folded Reload
	movq	240(%rsp), %r15                 # 8-byte Reload
	je	.LBB12_296
# %bb.290:                              #   in Loop: Header=BB12_129 Depth=1
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %r15
	movq	408(%rsp), %rbx                 # 8-byte Reload
	ja	.LBB12_483
# %bb.291:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp143:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp144:
# %bb.292:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %r14
	jmp	.LBB12_297
.LBB12_293:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%ebp, %ebp
	cmpq	$9, %r15
	jge	.LBB12_266
.LBB12_294:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	$8, %r15
	jne	.LBB12_267
# %bb.295:                              #   in Loop: Header=BB12_129 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, (%rbp)
	jmp	.LBB12_267
.LBB12_296:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%r14d, %r14d
	movq	408(%rsp), %rbx                 # 8-byte Reload
.LBB12_297:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%r14, 560(%rsp)
	leaq	(%r14,%r15,8), %rax
	movq	%rax, 576(%rsp)
	cmpq	$9, %rbx
	jl	.LBB12_335
# %bb.298:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%r14, %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	movq	%rbx, %rdx
	callq	memcpy@PLT
.LBB12_299:                             #   in Loop: Header=BB12_129 Depth=1
	addq	%rbx, %r14
	movq	%r14, 568(%rsp)
.Ltmp148:
	leaq	560(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	movq	%r12, %rcx
	callq	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
.Ltmp149:
# %bb.300:                              #   in Loop: Header=BB12_129 Depth=1
	testq	%rbp, %rbp
	je	.LBB12_302
# %bb.301:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	.p2align	4, 0x90
.LBB12_302:                             #   in Loop: Header=BB12_129 Depth=1
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_304
# %bb.303:                              #   in Loop: Header=BB12_129 Depth=1
	callq	_ZdlPv@PLT
.LBB12_304:                             #   in Loop: Header=BB12_129 Depth=1
	movq	64(%rsp), %rdi                  # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_306
# %bb.305:                              #   in Loop: Header=BB12_129 Depth=1
	callq	_ZdlPv@PLT
.LBB12_306:                             #   in Loop: Header=BB12_129 Depth=1
	movq	336(%rsp), %rbx
	movq	112(%rsp), %rax                 # 8-byte Reload
	leaq	(%rax,%rax,2), %rbp
	movq	(%rbx,%rbp,8), %rdi
	movdqa	560(%rsp), %xmm0
	movdqu	%xmm0, (%rbx,%rbp,8)
	movq	576(%rsp), %rax
	movq	%rax, 16(%rbx,%rbp,8)
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 560(%rsp)
	movq	$0, 576(%rsp)
	testq	%rdi, %rdi
	je	.LBB12_309
# %bb.307:                              #   in Loop: Header=BB12_129 Depth=1
	callq	_ZdlPv@PLT
	movq	560(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_309
# %bb.308:                              #   in Loop: Header=BB12_129 Depth=1
	callq	_ZdlPv@PLT
.LBB12_309:                             #   in Loop: Header=BB12_129 Depth=1
	leaq	(%rbx,%rbp,8), %rax
	movq	(%rax), %r12
	movq	8(%rax), %r13
	movq	%r13, %r15
	subq	%r12, %r15
	sarq	$3, %r15
	movq	%r13, %r14
	subq	%r12, %r14
	je	.LBB12_317
# %bb.310:                              #   in Loop: Header=BB12_129 Depth=1
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %r15
	ja	.LBB12_473
# %bb.311:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp151:
	movq	%r14, %rdi
	callq	_Znwm@PLT
.Ltmp152:
# %bb.312:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rbx
	cmpq	$9, %r14
	movq	%rbp, (%rsp)                    # 8-byte Spill
	jl	.LBB12_318
.LBB12_313:                             #   in Loop: Header=BB12_129 Depth=1
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
.LBB12_314:                             #   in Loop: Header=BB12_129 Depth=1
	leaq	(%rbx,%r14), %rbp
	cmpq	%r12, %r13
	je	.LBB12_333
# %bb.315:                              #   in Loop: Header=BB12_129 Depth=1
	testq	%r15, %r15
	je	.LBB12_320
# %bb.316:                              #   in Loop: Header=BB12_129 Depth=1
	bsrq	%r15, %rax
	xorq	$63, %rax
	jmp	.LBB12_321
	.p2align	4, 0x90
.LBB12_317:                             #   in Loop: Header=BB12_129 Depth=1
	xorl	%ebx, %ebx
	cmpq	$9, %r14
	movq	%rbp, (%rsp)                    # 8-byte Spill
	jge	.LBB12_313
.LBB12_318:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	$8, %r14
	jne	.LBB12_314
# %bb.319:                              #   in Loop: Header=BB12_129 Depth=1
	movq	(%r12), %rax
	movq	%rax, (%rbx)
	jmp	.LBB12_314
	.p2align	4, 0x90
.LBB12_320:                             #   in Loop: Header=BB12_129 Depth=1
	movl	$64, %eax
.LBB12_321:                             #   in Loop: Header=BB12_129 Depth=1
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
.Ltmp157:
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp158:
# %bb.322:                              #   in Loop: Header=BB12_129 Depth=1
.Ltmp159:
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp160:
# %bb.323:                              #   in Loop: Header=BB12_129 Depth=1
	subq	%r13, %r12
	addq	$8, %r12
	xorl	%eax, %eax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB12_324:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%rdx, %r12
	je	.LBB12_333
# %bb.325:                              #   in Loop: Header=BB12_324 Depth=2
	movq	%rdx, %rsi
	movq	(%rbx,%rax), %rcx
	addq	$-8, %rdx
	leaq	8(%rax), %rdi
	cmpq	8(%rbx,%rax), %rcx
	movq	%rdi, %rax
	jne	.LBB12_324
# %bb.326:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rbx, %rax
	subq	%rdx, %rax
	addq	$-8, %rax
	cmpq	%rdx, %r12
	je	.LBB12_331
# %bb.327:                              #   in Loop: Header=BB12_129 Depth=1
	movl	$16, %edx
	subq	%rsi, %rdx
	jmp	.LBB12_329
	.p2align	4, 0x90
.LBB12_328:                             #   in Loop: Header=BB12_329 Depth=2
	addq	$8, %rdx
	cmpq	%rdx, %r14
	je	.LBB12_331
.LBB12_329:                             #   Parent Loop BB12_129 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, %rsi
	movq	(%rbx,%rdx), %rcx
	cmpq	%rcx, %rsi
	je	.LBB12_328
# %bb.330:                              #   in Loop: Header=BB12_329 Depth=2
	movq	%rcx, 8(%rax)
	addq	$8, %rax
	jmp	.LBB12_328
	.p2align	4, 0x90
.LBB12_331:                             #   in Loop: Header=BB12_129 Depth=1
	addq	$8, %rax
	cmpq	%rbp, %rax
	je	.LBB12_333
# %bb.332:                              #   in Loop: Header=BB12_129 Depth=1
	movq	%rax, %rbp
	.p2align	4, 0x90
.LBB12_333:                             #   in Loop: Header=BB12_129 Depth=1
	leaq	(%rbx,%r15,8), %rax
	movq	304(%rsp), %r14
	movq	(%rsp), %rcx                    # 8-byte Reload
	movq	(%r14,%rcx,8), %rdi
	movq	%rbx, (%r14,%rcx,8)
	movq	%rbp, 8(%r14,%rcx,8)
	movq	%rax, 16(%r14,%rcx,8)
	testq	%rdi, %rdi
	je	.LBB12_128
# %bb.334:                              #   in Loop: Header=BB12_129 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB12_128
.LBB12_335:                             #   in Loop: Header=BB12_129 Depth=1
	cmpq	$8, %rbx
	jne	.LBB12_299
# %bb.336:                              #   in Loop: Header=BB12_129 Depth=1
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, (%r14)
	jmp	.LBB12_299
.LBB12_337:
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 336(%rsp)
	movq	$0, 352(%rsp)
	movdqa	%xmm0, 304(%rsp)
	movq	$0, 320(%rsp)
	xorl	%eax, %eax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	xorl	%r14d, %r14d
	movq	96(%rsp), %r15                  # 8-byte Reload
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
.LBB12_338:
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 384(%rsp)
	movdqa	%xmm0, 368(%rsp)
	movq	160(%rsp), %rdx
	cmpq	$4, %rdx
	movq	%r14, 232(%rsp)                 # 8-byte Spill
	je	.LBB12_343
# %bb.339:
	cmpq	$5, %rdx
	jne	.LBB12_460
# %bb.340:
	movq	152(%rsp), %rbx
	leaq	.L.str.15(%rip), %rsi
	movq	%rbx, %rdi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_347
# %bb.341:
	movl	$1735550317, %eax               # imm = 0x6772656D
	xorl	(%rbx), %eax
	movzbl	4(%rbx), %ecx
	xorl	$101, %ecx
	orl	%eax, %ecx
	jne	.LBB12_460
# %bb.342:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 368(%rsp)
	leaq	.L.str.19(%rip), %rax
	jmp	.LBB12_350
.LBB12_343:
	movq	152(%rsp), %rax
	cmpl	$1953656691, (%rax)             # imm = 0x74726F73
	je	.LBB12_349
# %bb.344:
	cmpl	$1952805749, (%rax)             # imm = 0x74657375
	je	.LBB12_346
# %bb.345:
	cmpl	$1952541798, (%rax)             # imm = 0x74616C66
	jne	.LBB12_460
.LBB12_346:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 368(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 376(%rsp)
	leaq	.L.str.14(%rip), %rax
	jmp	.LBB12_348
.LBB12_347:
	leaq	.L.str.16(%rip), %rax
	movq	%rax, 368(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 376(%rsp)
	leaq	.L.str.9(%rip), %rax
.LBB12_348:
	movq	%rax, 384(%rsp)
	movl	$3, %r12d
	jmp	.LBB12_351
.LBB12_349:
	leaq	.L.str(%rip), %rax
	movq	%rax, 368(%rsp)
	leaq	.L.str.9(%rip), %rax
.LBB12_350:
	movq	%rax, 376(%rsp)
	movl	$2, %r12d
.LBB12_351:
	movq	%r15, 96(%rsp)                  # 8-byte Spill
	leal	(,%r12,8), %eax
	leaq	(%rax,%rax,2), %rbx
.Ltmp174:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp175:
# %bb.352:
	movq	%rax, %r14
	movq	%rax, 416(%rsp)
	leaq	(%r12,%r12,2), %rax
	leaq	(%r14,%rax,8), %r15
	movq	%r14, %rdi
	xorl	%esi, %esi
	movq	%rbx, %rdx
	callq	memset@PLT
	addq	%rbx, %r14
	movq	%r15, 432(%rsp)
	movq	%r14, 424(%rsp)
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 272(%rsp)
	movq	$0, 288(%rsp)
	movq	80(%rsp), %r14                  # 8-byte Reload
	cmpq	%rbp, %r14
	ja	.LBB12_548
# %bb.353:
	testq	%r14, %r14
	je	.LBB12_356
# %bb.354:
	leaq	(,%r14,8), %rbx
.Ltmp177:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp178:
# %bb.355:
	movq	%rax, 272(%rsp)
	movq	%rax, 280(%rsp)
	leaq	(%rax,%r14,8), %rax
	movq	%rax, 288(%rsp)
	jmp	.LBB12_357
.LBB12_356:
	xorl	%ebx, %ebx
.LBB12_357:
.Ltmp179:
	movq	%rbx, %rdi
	callq	_Znam@PLT
	movq	%rax, 144(%rsp)                 # 8-byte Spill
.Ltmp180:
# %bb.358:
	movq	%r14, %xmm0
	punpckldq	.LCPI12_8(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI12_9(%rip), %xmm0
	movapd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm1                    # xmm1 = xmm1[1],xmm0[1]
	addsd	%xmm0, %xmm1
	movapd	%xmm1, 64(%rsp)                 # 16-byte Spill
	xorl	%ebx, %ebx
	leaq	272(%rsp), %r15
	movq	104(%rsp), %r14                 # 8-byte Reload
	movq	%r12, 112(%rsp)                 # 8-byte Spill
	jmp	.LBB12_360
.LBB12_414:                             #   in Loop: Header=BB12_360 Depth=1
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	152(%rsp), %rdx
	xorl	%ebx, %ebx
	leaq	.L.str.21(%rip), %rsi
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$3, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	testq	%r15, %r15
	movq	104(%rsp), %r14                 # 8-byte Reload
	je	.LBB12_359
	.p2align	4, 0x90
.LBB12_408:                             #   in Loop: Header=BB12_360 Depth=1
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
.LBB12_359:                             #   in Loop: Header=BB12_360 Depth=1
	testb	%bl, %bl
	leaq	272(%rsp), %r15
	movq	256(%rsp), %rbx                 # 8-byte Reload
	je	.LBB12_422
.LBB12_360:                             # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_385 Depth 2
	cmpq	%r14, %rbx
	movq	%rbx, 240(%rsp)                 # 8-byte Spill
	je	.LBB12_422
# %bb.361:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%rbx, %rax
	movq	248(%rsp), %rcx                 # 8-byte Reload
	orq	%rcx, %rax
	shrq	$32, %rax
	je	.LBB12_363
# %bb.362:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%rbx, %rax
	xorl	%edx, %edx
	divq	%rcx
	jmp	.LBB12_364
	.p2align	4, 0x90
.LBB12_363:                             #   in Loop: Header=BB12_360 Depth=1
	movl	%ebx, %eax
	xorl	%edx, %edx
	divl	%ecx
                                        # kill: def $edx killed $edx def $rdx
.LBB12_364:                             #   in Loop: Header=BB12_360 Depth=1
	movq	336(%rsp), %rax
	leaq	(%rdx,%rdx,2), %rcx
	movq	(%rax,%rcx,8), %rsi
	movq	%rcx, 184(%rsp)                 # 8-byte Spill
	movq	8(%rax,%rcx,8), %rdx
.Ltmp182:
	movq	%r15, %rdi
	callq	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
.Ltmp183:
# %bb.365:                              #   in Loop: Header=BB12_360 Depth=1
	cmpq	$1, %rbx
	je	.LBB12_375
# %bb.366:                              #   in Loop: Header=BB12_360 Depth=1
	cmpq	$1, %r14
	je	.LBB12_375
# %bb.367:                              #   in Loop: Header=BB12_360 Depth=1
	movq	160(%rsp), %rdx
	cmpq	$5, %rdx
	je	.LBB12_376
.LBB12_368:                             #   in Loop: Header=BB12_360 Depth=1
	cmpq	$4, %rdx
	jne	.LBB12_377
# %bb.369:                              #   in Loop: Header=BB12_360 Depth=1
	movq	152(%rsp), %rax
	cmpl	$1953656691, (%rax)             # imm = 0x74726F73
	je	.LBB12_415
# %bb.370:                              #   in Loop: Header=BB12_360 Depth=1
	cmpl	$1952805749, (%rax)             # imm = 0x74657375
	je	.LBB12_418
# %bb.371:                              #   in Loop: Header=BB12_360 Depth=1
	cmpl	$1952541798, (%rax)             # imm = 0x74616C66
	jne	.LBB12_377
# %bb.372:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, (%rsp)                   # 8-byte Spill
	movsd	%xmm0, 192(%rsp)
.Ltmp185:
	movq	%r15, %rdi
	movq	136(%rsp), %rsi                 # 8-byte Reload
	callq	phase_flat_insert
.Ltmp186:
# %bb.373:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%rax, %r14
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp187:
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	phase_flat_assign
.Ltmp188:
# %bb.374:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r14, %rdi
	callq	phase_flat_dtor
	jmp	.LBB12_421
	.p2align	4, 0x90
.LBB12_375:                             #   in Loop: Header=BB12_360 Depth=1
	movq	$1129578498, 16(%rsp)           # imm = 0x43540002
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	leaq	16(%rsp), %rax
	xorl	%edx, %edx
	#APP
	rolq	$3, %rdi
	rolq	$13, %rdi
	rolq	$61, %rdi
	rolq	$51, %rdi
	xchgq	%rbx, %rbx
	#NO_APP
	movq	%rdx, 264(%rsp)
	movq	264(%rsp), %rax
	movq	160(%rsp), %rdx
	cmpq	$5, %rdx
	jne	.LBB12_368
.LBB12_376:                             #   in Loop: Header=BB12_360 Depth=1
	movq	152(%rsp), %rdi
	leaq	.L.str.15(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_417
.LBB12_377:                             #   in Loop: Header=BB12_360 Depth=1
	movq	%rbx, %r13
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, (%rsp)                   # 8-byte Spill
	movsd	%xmm0, 192(%rsp)
.Ltmp197:
	movq	%r15, %rdi
	movq	88(%rsp), %rbx                  # 8-byte Reload
	movq	%rbx, %rsi
	callq	phase_merge_sortdelta
.Ltmp198:
# %bb.378:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp199:
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	phase_merge_inplace
.Ltmp200:
# %bb.379:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r13, %rbx
.LBB12_380:                             #   in Loop: Header=BB12_360 Depth=1
	leaq	1(%rbx), %rax
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	cmpq	%r14, %rax
	jne	.LBB12_382
# %bb.381:                              #   in Loop: Header=BB12_360 Depth=1
	movq	$1129578498, 16(%rsp)           # imm = 0x43540002
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	leaq	16(%rsp), %rax
	xorl	%edx, %edx
	#APP
	rolq	$3, %rdi
	rolq	$13, %rdi
	rolq	$61, %rdi
	rolq	$51, %rdi
	xchgq	%rbx, %rbx
	#NO_APP
	movq	%rdx, 264(%rsp)
	movq	264(%rsp), %rax
.LBB12_382:                             #   in Loop: Header=BB12_360 Depth=1
	movq	416(%rsp), %r13
	addq	$16, %r13
	xorl	%ebx, %ebx
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
	jmp	.LBB12_385
	.p2align	4, 0x90
.LBB12_383:                             #   in Loop: Header=BB12_385 Depth=2
	movsd	%xmm2, (%r14)
	addq	$8, %r14
	movq	%r14, -8(%r13)
	incq	%rbx
	addq	$24, %r13
	cmpq	%rbx, %r12
	je	.LBB12_395
.LBB12_385:                             #   Parent Loop BB12_360 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movapd	%xmm1, %xmm0
	movsd	200(%rsp,%rbx,8), %xmm1         # xmm1 = mem[0],zero
	movapd	%xmm1, %xmm2
	subsd	%xmm0, %xmm2
	divsd	64(%rsp), %xmm2                 # 16-byte Folded Reload
	movq	-8(%r13), %r14
	cmpq	(%r13), %r14
	jne	.LBB12_383
# %bb.386:                              #   in Loop: Header=BB12_385 Depth=2
	movq	-16(%r13), %rcx
	subq	%rcx, %r14
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %r14
	je	.LBB12_497
# %bb.387:                              #   in Loop: Header=BB12_385 Depth=2
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	%r14, %r15
	sarq	$3, %r15
	cmpq	$1, %r15
	movq	%r15, %rax
	adcq	$0, %rax
	leaq	(%rax,%r15), %r12
	movabsq	$1152921504606846975, %rcx      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rcx, %r12
	cmovaeq	%rcx, %r12
	addq	%r15, %rax
	cmovbq	%rbp, %r12
	testq	%r12, %r12
	movsd	%xmm1, (%rsp)                   # 8-byte Spill
	je	.LBB12_394
# %bb.388:                              #   in Loop: Header=BB12_385 Depth=2
	movsd	%xmm2, 120(%rsp)                # 8-byte Spill
	leaq	(,%r12,8), %rdi
.Ltmp202:
	callq	_Znwm@PLT
.Ltmp203:
# %bb.389:                              #   in Loop: Header=BB12_385 Depth=2
	movq	%rax, %rbp
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
	movsd	120(%rsp), %xmm2                # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movsd	%xmm2, (%rbp,%r15,8)
	testq	%r14, %r14
	movq	8(%rsp), %r15                   # 8-byte Reload
	jle	.LBB12_391
.LBB12_390:                             #   in Loop: Header=BB12_385 Depth=2
	movq	%rbp, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
.LBB12_391:                             #   in Loop: Header=BB12_385 Depth=2
	testq	%r15, %r15
	je	.LBB12_393
# %bb.392:                              #   in Loop: Header=BB12_385 Depth=2
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
.LBB12_393:                             #   in Loop: Header=BB12_385 Depth=2
	leaq	(%r14,%rbp), %rax
	addq	$8, %rax
	movq	%rbp, -16(%r13)
	movq	%rax, -8(%r13)
	leaq	(%rbp,%r12,8), %rax
	movq	%rax, (%r13)
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	movq	112(%rsp), %r12                 # 8-byte Reload
	incq	%rbx
	addq	$24, %r13
	cmpq	%rbx, %r12
	jne	.LBB12_385
	jmp	.LBB12_395
.LBB12_394:                             #   in Loop: Header=BB12_385 Depth=2
	xorl	%ebp, %ebp
	movsd	%xmm2, (%rbp,%r15,8)
	testq	%r14, %r14
	movq	8(%rsp), %r15                   # 8-byte Reload
	jg	.LBB12_390
	jmp	.LBB12_391
	.p2align	4, 0x90
.LBB12_395:                             #   in Loop: Header=BB12_360 Depth=1
	movq	272(%rsp), %rbp
	movq	280(%rsp), %rbx
	movq	%rbx, %r14
	subq	%rbp, %r14
	je	.LBB12_403
# %bb.396:                              #   in Loop: Header=BB12_360 Depth=1
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %r14
	ja	.LBB12_477
# %bb.397:                              #   in Loop: Header=BB12_360 Depth=1
.Ltmp205:
	movq	%r14, %rdi
	callq	_Znwm@PLT
.Ltmp206:
# %bb.398:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%rax, %r15
	cmpq	$9, %r14
	jl	.LBB12_404
.LBB12_399:                             #   in Loop: Header=BB12_360 Depth=1
	movq	%r15, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_400:                             #   in Loop: Header=BB12_360 Depth=1
	cmpq	%rbp, %rbx
	je	.LBB12_406
# %bb.401:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%r14, %rax
	sarq	$3, %rax
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	je	.LBB12_409
# %bb.402:                              #   in Loop: Header=BB12_360 Depth=1
	bsrq	%rax, %rax
	xorq	$63, %rax
	jmp	.LBB12_410
	.p2align	4, 0x90
.LBB12_403:                             #   in Loop: Header=BB12_360 Depth=1
	xorl	%r15d, %r15d
	cmpq	$9, %r14
	jge	.LBB12_399
.LBB12_404:                             #   in Loop: Header=BB12_360 Depth=1
	cmpq	$8, %r14
	jne	.LBB12_400
# %bb.405:                              #   in Loop: Header=BB12_360 Depth=1
	movq	(%rbp), %rax
	movq	%rax, (%r15)
	jmp	.LBB12_400
	.p2align	4, 0x90
.LBB12_406:                             #   in Loop: Header=BB12_360 Depth=1
	movq	232(%rsp), %rcx                 # 8-byte Reload
	movq	184(%rsp), %rdx                 # 8-byte Reload
	movq	8(%rcx,%rdx,8), %rax
	subq	(%rcx,%rdx,8), %rax
	movb	$1, %bl
	cmpq	%rax, %r14
	movabsq	$1152921504606846975, %rbp      # imm = 0xFFFFFFFFFFFFFFF
	je	.LBB12_407
	jmp	.LBB12_414
	.p2align	4, 0x90
.LBB12_409:                             #   in Loop: Header=BB12_360 Depth=1
	movl	$64, %eax
.LBB12_410:                             #   in Loop: Header=BB12_360 Depth=1
	leaq	(%r15,%r14), %r13
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
.Ltmp211:
	movq	%r15, %rdi
	movq	%r13, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp212:
# %bb.411:                              #   in Loop: Header=BB12_360 Depth=1
.Ltmp213:
	movq	%r15, %rdi
	movq	%r13, %rsi
	callq	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp214:
# %bb.412:                              #   in Loop: Header=BB12_360 Depth=1
	movq	304(%rsp), %rax
	movq	184(%rsp), %rcx                 # 8-byte Reload
	movq	(%rax,%rcx,8), %rsi
	movq	%rax, 232(%rsp)                 # 8-byte Spill
	movq	8(%rax,%rcx,8), %rax
	subq	%rsi, %rax
	cmpq	%rax, %r14
	jne	.LBB12_414
# %bb.413:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	bcmp@PLT
	movb	$1, %bl
	testl	%eax, %eax
	jne	.LBB12_414
.LBB12_407:                             #   in Loop: Header=BB12_360 Depth=1
	testq	%r15, %r15
	movq	104(%rsp), %r14                 # 8-byte Reload
	jne	.LBB12_408
	jmp	.LBB12_359
.LBB12_415:                             #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, (%rsp)                   # 8-byte Spill
	movsd	%xmm0, 192(%rsp)
.Ltmp195:
	movq	%r15, %rdi
	callq	phase_sort
.Ltmp196:
# %bb.416:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
	movq	%r15, %rdi
	callq	phase_unique
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	jmp	.LBB12_380
.LBB12_417:                             #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, (%rsp)                   # 8-byte Spill
	movsd	%xmm0, 192(%rsp)
	movq	%r15, %rdi
	movq	%rbx, %r13
	leaq	560(%rsp), %rbx
	movq	%rbx, %rsi
	callq	phase_radix_count
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
	movq	%r15, %rdi
	movq	144(%rsp), %rsi                 # 8-byte Reload
	movq	%rbx, %rdx
	movq	%r13, %rbx
	callq	phase_radix_scatter
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r15, %rdi
	callq	phase_unique
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 216(%rsp)
	jmp	.LBB12_380
.LBB12_418:                             #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, (%rsp)                   # 8-byte Spill
	movsd	%xmm0, 192(%rsp)
.Ltmp190:
	movq	%r15, %rdi
	movq	136(%rsp), %rsi                 # 8-byte Reload
	callq	phase_uset_insert
.Ltmp191:
# %bb.419:                              #   in Loop: Header=BB12_360 Depth=1
	movq	%rax, %r14
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp192:
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	phase_uset_assign
.Ltmp193:
# %bb.420:                              #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r14, %rdi
	callq	phase_uset_dtor
.LBB12_421:                             #   in Loop: Header=BB12_360 Depth=1
	callq	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 216(%rsp)
	movq	104(%rsp), %r14                 # 8-byte Reload
	jmp	.LBB12_380
.LBB12_422:
	cmpq	%r14, 240(%rsp)                 # 8-byte Folded Reload
	jb	.LBB12_446
# %bb.423:
	shll	$3, %r12d
	leaq	(%r12,%r12,2), %r12
	leaq	368(%rsp), %r13
	xorl	%ebp, %ebp
	jmp	.LBB12_425
	.p2align	4, 0x90
.LBB12_424:                             #   in Loop: Header=BB12_425 Depth=1
	movq	152(%rsp), %rsi
	movq	(%r13), %rdx
	andq	$-2, %r14
	movsd	(%r15,%r14,4), %xmm0            # xmm0 = mem[0],zero
	leaq	.L.str.22(%rip), %rdi
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	96(%rsp), %r8                   # 8-byte Reload
	movb	$1, %al
	callq	printf@PLT
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	addq	$8, %r13
	addq	$24, %rbp
	cmpq	%rbp, %r12
	je	.LBB12_445
.LBB12_425:                             # =>This Inner Loop Header: Depth=1
	movq	416(%rsp), %rbx
	movq	8(%rbx,%rbp), %rsi
	movq	%rsi, %rdi
	subq	(%rbx,%rbp), %rdi
	je	.LBB12_435
# %bb.426:                              #   in Loop: Header=BB12_425 Depth=1
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rax, %rdi
	ja	.LBB12_475
# %bb.427:                              #   in Loop: Header=BB12_425 Depth=1
.Ltmp219:
	callq	_Znwm@PLT
.Ltmp220:
# %bb.428:                              #   in Loop: Header=BB12_425 Depth=1
	movq	%rax, %r15
	movq	(%rbx,%rbp), %rsi
	movq	8(%rbx,%rbp), %rbx
	subq	%rsi, %rbx
	cmpq	$8, %rbx
	jle	.LBB12_436
.LBB12_429:                             #   in Loop: Header=BB12_425 Depth=1
	movq	%r15, %rdi
	movq	%rbx, %rdx
	callq	memmove@PLT
	leaq	-8(%rbx), %rdx
	cmpq	$17, %rbx
	jb	.LBB12_441
# %bb.430:                              #   in Loop: Header=BB12_425 Depth=1
	leaq	8(%r15), %rsi
	movq	%r15, %rdi
	callq	memmove@PLT
.LBB12_431:                             #   in Loop: Header=BB12_425 Depth=1
	addq	%r15, %rbx
	addq	$-8, %rbx
.LBB12_432:                             #   in Loop: Header=BB12_425 Depth=1
	movq	%rbx, %r14
	subq	%r15, %r14
	sarq	$3, %r14
	cmpq	%rbx, %r15
	je	.LBB12_424
# %bb.433:                              #   in Loop: Header=BB12_425 Depth=1
	testq	%r14, %r14
	je	.LBB12_438
# %bb.434:                              #   in Loop: Header=BB12_425 Depth=1
	bsrq	%r14, %rax
	xorq	$63, %rax
	jmp	.LBB12_439
	.p2align	4, 0x90
.LBB12_435:                             #   in Loop: Header=BB12_425 Depth=1
	movq	%rsi, %rbx
	xorl	%r15d, %r15d
	subq	%rsi, %rbx
	cmpq	$8, %rbx
	jg	.LBB12_429
.LBB12_436:                             #   in Loop: Header=BB12_425 Depth=1
	jne	.LBB12_443
# %bb.437:                              #   in Loop: Header=BB12_425 Depth=1
	movsd	(%rsi), %xmm0                   # xmm0 = mem[0],zero
	movsd	%xmm0, (%r15)
	jmp	.LBB12_444
	.p2align	4, 0x90
.LBB12_438:                             #   in Loop: Header=BB12_425 Depth=1
	movl	$64, %eax
.LBB12_439:                             #   in Loop: Header=BB12_425 Depth=1
	addq	%rax, %rax
	movl	$126, %edx
	subq	%rax, %rdx
.Ltmp225:
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp226:
# %bb.440:                              #   in Loop: Header=BB12_425 Depth=1
.Ltmp227:
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp228:
	jmp	.LBB12_424
.LBB12_441:                             #   in Loop: Header=BB12_425 Depth=1
	cmpq	$8, %rdx
	jne	.LBB12_431
# %bb.442:                              #   in Loop: Header=BB12_425 Depth=1
	movsd	8(%r15), %xmm0                  # xmm0 = mem[0],zero
	movsd	%xmm0, (%r15)
	jmp	.LBB12_431
.LBB12_443:                             #   in Loop: Header=BB12_425 Depth=1
	ja	.LBB12_431
.LBB12_444:                             #   in Loop: Header=BB12_425 Depth=1
	addq	%r15, %rbx
	jmp	.LBB12_432
.LBB12_445:
	xorl	%eax, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
.LBB12_446:
	movq	144(%rsp), %rdi                 # 8-byte Reload
	callq	_ZdaPv@PLT
	movq	272(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_448
# %bb.447:
	callq	_ZdlPv@PLT
.LBB12_448:
	movq	416(%rsp), %rbx
	movq	424(%rsp), %r14
	cmpq	%r14, %rbx
	je	.LBB12_453
# %bb.449:
	movq	%rbx, %r15
	jmp	.LBB12_451
	.p2align	4, 0x90
.LBB12_450:                             #   in Loop: Header=BB12_451 Depth=1
	addq	$24, %r15
	cmpq	%r14, %r15
	je	.LBB12_453
.LBB12_451:                             # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.LBB12_450
# %bb.452:                              #   in Loop: Header=BB12_451 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB12_450
.LBB12_453:
	testq	%rbx, %rbx
	je	.LBB12_455
# %bb.454:
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB12_455:
	movq	304(%rsp), %r14
	movq	312(%rsp), %rbx
	movq	%r14, %r15
	cmpq	%rbx, %r14
	je	.LBB12_461
.LBB12_456:
	movq	%r15, %r14
	jmp	.LBB12_458
	.p2align	4, 0x90
.LBB12_457:                             #   in Loop: Header=BB12_458 Depth=1
	addq	$24, %r14
	cmpq	%rbx, %r14
	je	.LBB12_461
.LBB12_458:                             # =>This Inner Loop Header: Depth=1
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	.LBB12_457
# %bb.459:                              #   in Loop: Header=BB12_458 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB12_457
.LBB12_460:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	leaq	.L.str.20(%rip), %rdi
	movl	$12, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$2, %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	312(%rsp), %rbx
	movq	%r14, %r15
	cmpq	%rbx, %r14
	jne	.LBB12_456
.LBB12_461:
	testq	%r15, %r15
	je	.LBB12_463
# %bb.462:
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
.LBB12_463:
	movq	336(%rsp), %rbx
	movq	344(%rsp), %r14
	cmpq	%r14, %rbx
	je	.LBB12_468
# %bb.464:
	movq	%rbx, %r15
	jmp	.LBB12_466
	.p2align	4, 0x90
.LBB12_465:                             #   in Loop: Header=BB12_466 Depth=1
	addq	$24, %r15
	cmpq	%r14, %r15
	je	.LBB12_468
.LBB12_466:                             # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rdi
	testq	%rdi, %rdi
	je	.LBB12_465
# %bb.467:                              #   in Loop: Header=BB12_466 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB12_465
.LBB12_468:
	testq	%rbx, %rbx
	je	.LBB12_470
# %bb.469:
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB12_470:
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_472
# %bb.471:
	callq	_ZdlPv@PLT
.LBB12_472:
	movq	128(%rsp), %rax                 # 8-byte Reload
                                        # kill: def $eax killed $eax killed $rax
	addq	$8760, %rsp                     # imm = 0x2238
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
.LBB12_473:
	.cfi_def_cfa_offset 8816
.Ltmp154:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.Ltmp155:
# %bb.474:
.LBB12_475:
.Ltmp222:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.Ltmp223:
# %bb.476:
.LBB12_477:
.Ltmp208:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.Ltmp209:
# %bb.478:
.LBB12_479:
.Ltmp233:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp234:
# %bb.480:
.LBB12_481:
.Ltmp137:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.Ltmp138:
# %bb.482:
.LBB12_483:
.Ltmp146:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.Ltmp147:
# %bb.484:
.LBB12_485:
.Ltmp44:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp45:
# %bb.486:
.LBB12_487:
.Ltmp84:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp85:
# %bb.488:
.LBB12_489:
.Ltmp29:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp30:
# %bb.490:
.LBB12_491:
.Ltmp14:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp15:
# %bb.492:
.LBB12_493:
.Ltmp59:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp60:
# %bb.494:
.LBB12_495:
.Ltmp74:
	callq	_ZSt17__throw_bad_allocv@PLT
.Ltmp75:
# %bb.496:
.LBB12_497:
.Ltmp216:
	leaq	.L.str.29(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp217:
# %bb.498:
.LBB12_499:
.Ltmp108:
	leaq	.L.str.31(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp109:
# %bb.500:
.LBB12_501:
.Ltmp128:
	leaq	.L.str.29(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp129:
# %bb.502:
.LBB12_503:
.Ltmp165:
	leaq	.L.str.29(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp166:
# %bb.504:
.LBB12_505:
.Ltmp162:
	leaq	.L.str.29(%rip), %rdi
	movq	8(%rsp), %rbp                   # 8-byte Reload
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp163:
# %bb.506:
.LBB12_507:
.Ltmp171:
	leaq	.L.str.23(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp172:
# %bb.508:
.LBB12_509:
.Ltmp111:
	leaq	.L.str.32(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp112:
# %bb.510:
.LBB12_511:
.Ltmp237:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp238:
# %bb.512:
.LBB12_513:
.Ltmp235:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp236:
# %bb.514:
.LBB12_516:
.Ltmp168:
	leaq	.L.str.32(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp169:
# %bb.517:
.LBB12_518:
.Ltmp48:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp49:
# %bb.519:
.LBB12_520:
.Ltmp88:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp89:
# %bb.521:
.LBB12_522:
.Ltmp33:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp34:
# %bb.523:
.LBB12_524:
.Ltmp18:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp19:
# %bb.525:
.LBB12_526:
.Ltmp11:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt24__throw_invalid_argumentPKc@PLT
.Ltmp12:
# %bb.527:
.LBB12_528:
.Ltmp41:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt24__throw_invalid_argumentPKc@PLT
.Ltmp42:
# %bb.529:
.LBB12_530:
.Ltmp26:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt24__throw_invalid_argumentPKc@PLT
.Ltmp27:
# %bb.531:
.LBB12_532:
.Ltmp63:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp64:
# %bb.533:
.LBB12_534:
.Ltmp56:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt24__throw_invalid_argumentPKc@PLT
.Ltmp57:
# %bb.535:
.LBB12_536:
.Ltmp31:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp32:
# %bb.537:
.LBB12_538:
.Ltmp46:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp47:
# %bb.539:
.LBB12_540:
.Ltmp86:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp87:
# %bb.541:
.LBB12_542:
.Ltmp16:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp17:
# %bb.543:
.LBB12_544:
.Ltmp9:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt20__throw_out_of_rangePKc@PLT
.Ltmp10:
# %bb.545:
.LBB12_101:
.Ltmp24:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt20__throw_out_of_rangePKc@PLT
.Ltmp25:
# %bb.546:
.LBB12_90:
.Ltmp39:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt20__throw_out_of_rangePKc@PLT
.Ltmp40:
# %bb.547:
.LBB12_548:
.Ltmp230:
	leaq	.L.str.32(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp231:
# %bb.549:
.LBB12_550:
.Ltmp78:
	leaq	.L.str.26(%rip), %rdi
	callq	_ZSt19__throw_logic_errorPKc@PLT
.Ltmp79:
# %bb.551:
.LBB12_552:
.Ltmp71:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt24__throw_invalid_argumentPKc@PLT
.Ltmp72:
# %bb.553:
.LBB12_554:
.Ltmp61:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp62:
# %bb.555:
.LBB12_106:
.Ltmp54:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt20__throw_out_of_rangePKc@PLT
.Ltmp55:
# %bb.556:
.LBB12_557:
.Ltmp76:
	leaq	.L.str.27(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Ltmp77:
# %bb.558:
.LBB12_111:
.Ltmp69:
	leaq	.L.str.28(%rip), %rdi
	callq	_ZSt20__throw_out_of_rangePKc@PLT
.Ltmp70:
# %bb.559:
.LBB12_560:
.Ltmp68:
	jmp	.LBB12_634
.LBB12_561:
.Ltmp53:
	jmp	.LBB12_634
.LBB12_562:
.Ltmp96:
	movq	%rax, %r14
	jmp	.LBB12_656
.LBB12_563:
.Ltmp93:
	jmp	.LBB12_645
.LBB12_564:
.Ltmp181:
	movq	%rax, %r14
	jmp	.LBB12_650
.LBB12_565:
.Ltmp176:
	jmp	.LBB12_654
.LBB12_566:
.Ltmp38:
	jmp	.LBB12_634
.LBB12_567:
.Ltmp23:
	jmp	.LBB12_634
.LBB12_568:
.Ltmp8:
	jmp	.LBB12_634
.LBB12_569:
.Ltmp83:
	jmp	.LBB12_634
.LBB12_570:
.Ltmp73:
	movq	%rax, %r14
	cmpl	$0, (%r15)
	jne	.LBB12_572
	jmp	.LBB12_571
.LBB12_574:
.Ltmp189:
	jmp	.LBB12_648
.LBB12_575:
.Ltmp232:
	movq	%rax, %r14
	jmp	.LBB12_650
.LBB12_576:
.Ltmp58:
	movq	%rax, %r14
	cmpl	$0, (%r15)
	je	.LBB12_571
	jmp	.LBB12_572
.LBB12_578:
.Ltmp194:
	jmp	.LBB12_648
.LBB12_579:
.Ltmp124:
	movq	%rax, %r14
	movq	64(%rsp), %r15                  # 8-byte Reload
	testq	%r15, %r15
	jne	.LBB12_643
	jmp	.LBB12_655
.LBB12_580:
.Ltmp28:
	movq	%rax, %r14
	cmpl	$0, (%r15)
	je	.LBB12_571
	jmp	.LBB12_572
.LBB12_582:
.Ltmp43:
	movq	%rax, %r14
	cmpl	$0, (%r15)
	jne	.LBB12_572
.LBB12_571:
	movl	%r12d, (%r15)
.LBB12_572:
	movq	16(%rsp), %rdi
	leaq	32(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_635
	jmp	.LBB12_573
.LBB12_584:
.Ltmp13:
	movq	%rax, %r14
	cmpl	$0, (%r15)
	jne	.LBB12_586
# %bb.585:
	movl	%r12d, (%r15)
.LBB12_586:
	movq	16(%rsp), %rdi
	cmpq	%rbx, %rdi
	je	.LBB12_635
.LBB12_573:
	callq	_ZdlPv@PLT
	jmp	.LBB12_635
.LBB12_587:
.Ltmp145:
	movq	%rax, %r14
	testq	%rbp, %rbp
	je	.LBB12_591
	jmp	.LBB12_641
.LBB12_588:
.Ltmp136:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_589:
.Ltmp150:
	movq	%rax, %r14
	movq	560(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.LBB12_593
# %bb.590:
	testq	%rbp, %rbp
	jne	.LBB12_641
.LBB12_591:
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	jne	.LBB12_642
.LBB12_592:
	movq	64(%rsp), %r15                  # 8-byte Reload
	testq	%r15, %r15
	jne	.LBB12_643
	jmp	.LBB12_655
.LBB12_593:
	callq	_ZdlPv@PLT
	testq	%rbp, %rbp
	je	.LBB12_591
	jmp	.LBB12_641
.LBB12_594:
.Ltmp170:
	movq	%rax, %r14
	movq	64(%rsp), %r15                  # 8-byte Reload
	testq	%r15, %r15
	jne	.LBB12_643
	jmp	.LBB12_655
.LBB12_595:
.Ltmp5:
	jmp	.LBB12_645
.LBB12_596:
.Ltmp121:
	movq	%rax, %r14
	jmp	.LBB12_643
.LBB12_597:
.Ltmp207:
	jmp	.LBB12_648
.LBB12_598:
.Ltmp221:
	jmp	.LBB12_648
.LBB12_599:
.Ltmp104:
	jmp	.LBB12_613
.LBB12_600:
.Ltmp101:
	movq	%rax, %r14
	movq	64(%rsp), %rdi                  # 8-byte Reload
	callq	_ZdlPv@PLT
	jmp	.LBB12_655
.LBB12_601:
.Ltmp184:
	jmp	.LBB12_648
.LBB12_602:
.Ltmp153:
	jmp	.LBB12_654
.LBB12_603:
.Ltmp116:
	jmp	.LBB12_654
.LBB12_604:
.Ltmp215:
	jmp	.LBB12_606
.LBB12_605:
.Ltmp229:
.LBB12_606:
	movq	%rax, %r14
	testq	%r15, %r15
	je	.LBB12_649
# %bb.607:
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_649
.LBB12_608:
.Ltmp142:
	movq	%rax, %r14
	movq	8(%rsp), %rbp                   # 8-byte Reload
	testq	%rbp, %rbp
	je	.LBB12_591
	jmp	.LBB12_641
.LBB12_609:
.Ltmp127:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_610:
.Ltmp133:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_611:
.Ltmp201:
	jmp	.LBB12_648
.LBB12_612:
.Ltmp113:
.LBB12_613:
	movq	%rax, %r14
	movq	(%rsp), %rbx                    # 8-byte Reload
	testq	%rbx, %rbx
	jne	.LBB12_624
	jmp	.LBB12_625
.LBB12_614:
.Ltmp173:
	jmp	.LBB12_654
.LBB12_615:
.Ltmp167:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_616:
.Ltmp130:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_617:
.Ltmp161:
	movq	%rax, %r14
	testq	%rbx, %rbx
	je	.LBB12_655
# %bb.618:
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_655
.LBB12_619:
.Ltmp107:
	jmp	.LBB12_622
.LBB12_620:
.Ltmp204:
	jmp	.LBB12_648
.LBB12_621:
.Ltmp110:
.LBB12_622:
	movq	%rax, %r14
	movq	(%rsp), %rbx                    # 8-byte Reload
	movq	560(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_624
# %bb.623:
	callq	_ZdlPv@PLT
.LBB12_624:
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB12_625:
	movq	64(%rsp), %rdi                  # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_655
# %bb.626:
	callq	_ZdlPv@PLT
	jmp	.LBB12_655
.LBB12_627:
.Ltmp218:
	jmp	.LBB12_648
.LBB12_628:
.Ltmp80:
	jmp	.LBB12_634
.LBB12_629:
.Ltmp65:
	jmp	.LBB12_634
.LBB12_630:
.Ltmp20:
	jmp	.LBB12_634
.LBB12_631:
.Ltmp35:
	jmp	.LBB12_634
.LBB12_632:
.Ltmp90:
	jmp	.LBB12_634
.LBB12_633:
.Ltmp50:
.LBB12_634:
	movq	%rax, %r14
.LBB12_635:
	movq	560(%rsp), %rdi
	leaq	576(%rsp), %rax
	cmpq	%rax, %rdi
	jne	.LBB12_638
# %bb.636:
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	jne	.LBB12_657
.LBB12_637:
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB12_638:
	callq	_ZdlPv@PLT
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_637
	jmp	.LBB12_657
.LBB12_639:
.Ltmp139:
	movq	%rax, %r14
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
.LBB12_642:
	callq	_ZdlPv@PLT
	movq	64(%rsp), %r15                  # 8-byte Reload
	testq	%r15, %r15
	je	.LBB12_655
.LBB12_643:
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_655
.LBB12_640:
.Ltmp164:
	movq	%rax, %r14
	testq	%rbp, %rbp
	je	.LBB12_591
.LBB12_641:
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	movq	(%rsp), %rdi                    # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB12_592
	jmp	.LBB12_642
.LBB12_644:
.Ltmp239:
.LBB12_645:
	movq	%rax, %r14
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_637
	jmp	.LBB12_657
.LBB12_646:
.Ltmp210:
	jmp	.LBB12_648
.LBB12_647:
.Ltmp224:
.LBB12_648:
	movq	%rax, %r14
.LBB12_649:
	movq	144(%rsp), %rdi                 # 8-byte Reload
	callq	_ZdaPv@PLT
.LBB12_650:
	movq	272(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_652
# %bb.651:
	callq	_ZdlPv@PLT
.LBB12_652:
	leaq	416(%rsp), %rdi
	callq	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	jmp	.LBB12_655
.LBB12_653:
.Ltmp156:
.LBB12_654:
	movq	%rax, %r14
.LBB12_655:
	leaq	304(%rsp), %rdi
	callq	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
.LBB12_656:
	leaq	336(%rsp), %rdi
	callq	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	movq	152(%rsp), %rdi
	leaq	168(%rsp), %rax
	cmpq	%rax, %rdi
	je	.LBB12_637
.LBB12_657:
	callq	_ZdlPv@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end12:
	.size	main, .Lfunc_end12-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI12_0:
	.long	.LBB12_14-.LJTI12_0
	.long	.LBB12_74-.LJTI12_0
	.long	.LBB12_25-.LJTI12_0
	.long	.LBB12_74-.LJTI12_0
	.long	.LBB12_55-.LJTI12_0
	.long	.LBB12_45-.LJTI12_0
	.long	.LBB12_35-.LJTI12_0
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table12:
.Lexception1:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Ltmp3-.Lfunc_begin1           # >> Call Site 1 <<
	.uleb128 .Ltmp4-.Ltmp3                  #   Call between .Ltmp3 and .Ltmp4
	.uleb128 .Ltmp5-.Lfunc_begin1           #     jumps to .Ltmp5
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp4-.Lfunc_begin1           # >> Call Site 2 <<
	.uleb128 .Ltmp51-.Ltmp4                 #   Call between .Ltmp4 and .Ltmp51
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp51-.Lfunc_begin1          # >> Call Site 3 <<
	.uleb128 .Ltmp52-.Ltmp51                #   Call between .Ltmp51 and .Ltmp52
	.uleb128 .Ltmp53-.Lfunc_begin1          #     jumps to .Ltmp53
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp81-.Lfunc_begin1          # >> Call Site 4 <<
	.uleb128 .Ltmp82-.Ltmp81                #   Call between .Ltmp81 and .Ltmp82
	.uleb128 .Ltmp83-.Lfunc_begin1          #     jumps to .Ltmp83
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp36-.Lfunc_begin1          # >> Call Site 5 <<
	.uleb128 .Ltmp37-.Ltmp36                #   Call between .Ltmp36 and .Ltmp37
	.uleb128 .Ltmp38-.Lfunc_begin1          #     jumps to .Ltmp38
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp6-.Lfunc_begin1           # >> Call Site 6 <<
	.uleb128 .Ltmp7-.Ltmp6                  #   Call between .Ltmp6 and .Ltmp7
	.uleb128 .Ltmp8-.Lfunc_begin1           #     jumps to .Ltmp8
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp21-.Lfunc_begin1          # >> Call Site 7 <<
	.uleb128 .Ltmp22-.Ltmp21                #   Call between .Ltmp21 and .Ltmp22
	.uleb128 .Ltmp23-.Lfunc_begin1          #     jumps to .Ltmp23
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp66-.Lfunc_begin1          # >> Call Site 8 <<
	.uleb128 .Ltmp67-.Ltmp66                #   Call between .Ltmp66 and .Ltmp67
	.uleb128 .Ltmp68-.Lfunc_begin1          #     jumps to .Ltmp68
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp67-.Lfunc_begin1          # >> Call Site 9 <<
	.uleb128 .Ltmp91-.Ltmp67                #   Call between .Ltmp67 and .Ltmp91
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp91-.Lfunc_begin1          # >> Call Site 10 <<
	.uleb128 .Ltmp92-.Ltmp91                #   Call between .Ltmp91 and .Ltmp92
	.uleb128 .Ltmp93-.Lfunc_begin1          #     jumps to .Ltmp93
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp92-.Lfunc_begin1          # >> Call Site 11 <<
	.uleb128 .Ltmp94-.Ltmp92                #   Call between .Ltmp92 and .Ltmp94
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp94-.Lfunc_begin1          # >> Call Site 12 <<
	.uleb128 .Ltmp95-.Ltmp94                #   Call between .Ltmp94 and .Ltmp95
	.uleb128 .Ltmp96-.Lfunc_begin1          #     jumps to .Ltmp96
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp95-.Lfunc_begin1          # >> Call Site 13 <<
	.uleb128 .Ltmp97-.Ltmp95                #   Call between .Ltmp95 and .Ltmp97
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp97-.Lfunc_begin1          # >> Call Site 14 <<
	.uleb128 .Ltmp98-.Ltmp97                #   Call between .Ltmp97 and .Ltmp98
	.uleb128 .Ltmp116-.Lfunc_begin1         #     jumps to .Ltmp116
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp98-.Lfunc_begin1          # >> Call Site 15 <<
	.uleb128 .Ltmp99-.Ltmp98                #   Call between .Ltmp98 and .Ltmp99
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp99-.Lfunc_begin1          # >> Call Site 16 <<
	.uleb128 .Ltmp100-.Ltmp99               #   Call between .Ltmp99 and .Ltmp100
	.uleb128 .Ltmp101-.Lfunc_begin1         #     jumps to .Ltmp101
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp102-.Lfunc_begin1         # >> Call Site 17 <<
	.uleb128 .Ltmp103-.Ltmp102              #   Call between .Ltmp102 and .Ltmp103
	.uleb128 .Ltmp104-.Lfunc_begin1         #     jumps to .Ltmp104
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp105-.Lfunc_begin1         # >> Call Site 18 <<
	.uleb128 .Ltmp106-.Ltmp105              #   Call between .Ltmp105 and .Ltmp106
	.uleb128 .Ltmp107-.Lfunc_begin1         #     jumps to .Ltmp107
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp106-.Lfunc_begin1         # >> Call Site 19 <<
	.uleb128 .Ltmp114-.Ltmp106              #   Call between .Ltmp106 and .Ltmp114
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp114-.Lfunc_begin1         # >> Call Site 20 <<
	.uleb128 .Ltmp115-.Ltmp114              #   Call between .Ltmp114 and .Ltmp115
	.uleb128 .Ltmp116-.Lfunc_begin1         #     jumps to .Ltmp116
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp115-.Lfunc_begin1         # >> Call Site 21 <<
	.uleb128 .Ltmp117-.Ltmp115              #   Call between .Ltmp115 and .Ltmp117
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp117-.Lfunc_begin1         # >> Call Site 22 <<
	.uleb128 .Ltmp120-.Ltmp117              #   Call between .Ltmp117 and .Ltmp120
	.uleb128 .Ltmp121-.Lfunc_begin1         #     jumps to .Ltmp121
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp122-.Lfunc_begin1         # >> Call Site 23 <<
	.uleb128 .Ltmp123-.Ltmp122              #   Call between .Ltmp122 and .Ltmp123
	.uleb128 .Ltmp124-.Lfunc_begin1         #     jumps to .Ltmp124
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp125-.Lfunc_begin1         # >> Call Site 24 <<
	.uleb128 .Ltmp126-.Ltmp125              #   Call between .Ltmp125 and .Ltmp126
	.uleb128 .Ltmp127-.Lfunc_begin1         #     jumps to .Ltmp127
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp126-.Lfunc_begin1         # >> Call Site 25 <<
	.uleb128 .Ltmp131-.Ltmp126              #   Call between .Ltmp126 and .Ltmp131
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp131-.Lfunc_begin1         # >> Call Site 26 <<
	.uleb128 .Ltmp132-.Ltmp131              #   Call between .Ltmp131 and .Ltmp132
	.uleb128 .Ltmp133-.Lfunc_begin1         #     jumps to .Ltmp133
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp132-.Lfunc_begin1         # >> Call Site 27 <<
	.uleb128 .Ltmp134-.Ltmp132              #   Call between .Ltmp132 and .Ltmp134
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp134-.Lfunc_begin1         # >> Call Site 28 <<
	.uleb128 .Ltmp135-.Ltmp134              #   Call between .Ltmp134 and .Ltmp135
	.uleb128 .Ltmp136-.Lfunc_begin1         #     jumps to .Ltmp136
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp135-.Lfunc_begin1         # >> Call Site 29 <<
	.uleb128 .Ltmp140-.Ltmp135              #   Call between .Ltmp135 and .Ltmp140
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp140-.Lfunc_begin1         # >> Call Site 30 <<
	.uleb128 .Ltmp141-.Ltmp140              #   Call between .Ltmp140 and .Ltmp141
	.uleb128 .Ltmp142-.Lfunc_begin1         #     jumps to .Ltmp142
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp141-.Lfunc_begin1         # >> Call Site 31 <<
	.uleb128 .Ltmp143-.Ltmp141              #   Call between .Ltmp141 and .Ltmp143
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp143-.Lfunc_begin1         # >> Call Site 32 <<
	.uleb128 .Ltmp144-.Ltmp143              #   Call between .Ltmp143 and .Ltmp144
	.uleb128 .Ltmp145-.Lfunc_begin1         #     jumps to .Ltmp145
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp144-.Lfunc_begin1         # >> Call Site 33 <<
	.uleb128 .Ltmp148-.Ltmp144              #   Call between .Ltmp144 and .Ltmp148
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp148-.Lfunc_begin1         # >> Call Site 34 <<
	.uleb128 .Ltmp149-.Ltmp148              #   Call between .Ltmp148 and .Ltmp149
	.uleb128 .Ltmp150-.Lfunc_begin1         #     jumps to .Ltmp150
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp151-.Lfunc_begin1         # >> Call Site 35 <<
	.uleb128 .Ltmp152-.Ltmp151              #   Call between .Ltmp151 and .Ltmp152
	.uleb128 .Ltmp153-.Lfunc_begin1         #     jumps to .Ltmp153
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp152-.Lfunc_begin1         # >> Call Site 36 <<
	.uleb128 .Ltmp157-.Ltmp152              #   Call between .Ltmp152 and .Ltmp157
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp157-.Lfunc_begin1         # >> Call Site 37 <<
	.uleb128 .Ltmp160-.Ltmp157              #   Call between .Ltmp157 and .Ltmp160
	.uleb128 .Ltmp161-.Lfunc_begin1         #     jumps to .Ltmp161
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp174-.Lfunc_begin1         # >> Call Site 38 <<
	.uleb128 .Ltmp175-.Ltmp174              #   Call between .Ltmp174 and .Ltmp175
	.uleb128 .Ltmp176-.Lfunc_begin1         #     jumps to .Ltmp176
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp175-.Lfunc_begin1         # >> Call Site 39 <<
	.uleb128 .Ltmp177-.Ltmp175              #   Call between .Ltmp175 and .Ltmp177
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp177-.Lfunc_begin1         # >> Call Site 40 <<
	.uleb128 .Ltmp178-.Ltmp177              #   Call between .Ltmp177 and .Ltmp178
	.uleb128 .Ltmp232-.Lfunc_begin1         #     jumps to .Ltmp232
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp179-.Lfunc_begin1         # >> Call Site 41 <<
	.uleb128 .Ltmp180-.Ltmp179              #   Call between .Ltmp179 and .Ltmp180
	.uleb128 .Ltmp181-.Lfunc_begin1         #     jumps to .Ltmp181
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp182-.Lfunc_begin1         # >> Call Site 42 <<
	.uleb128 .Ltmp183-.Ltmp182              #   Call between .Ltmp182 and .Ltmp183
	.uleb128 .Ltmp184-.Lfunc_begin1         #     jumps to .Ltmp184
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp185-.Lfunc_begin1         # >> Call Site 43 <<
	.uleb128 .Ltmp188-.Ltmp185              #   Call between .Ltmp185 and .Ltmp188
	.uleb128 .Ltmp189-.Lfunc_begin1         #     jumps to .Ltmp189
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp197-.Lfunc_begin1         # >> Call Site 44 <<
	.uleb128 .Ltmp200-.Ltmp197              #   Call between .Ltmp197 and .Ltmp200
	.uleb128 .Ltmp201-.Lfunc_begin1         #     jumps to .Ltmp201
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp202-.Lfunc_begin1         # >> Call Site 45 <<
	.uleb128 .Ltmp203-.Ltmp202              #   Call between .Ltmp202 and .Ltmp203
	.uleb128 .Ltmp204-.Lfunc_begin1         #     jumps to .Ltmp204
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp203-.Lfunc_begin1         # >> Call Site 46 <<
	.uleb128 .Ltmp205-.Ltmp203              #   Call between .Ltmp203 and .Ltmp205
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp205-.Lfunc_begin1         # >> Call Site 47 <<
	.uleb128 .Ltmp206-.Ltmp205              #   Call between .Ltmp205 and .Ltmp206
	.uleb128 .Ltmp207-.Lfunc_begin1         #     jumps to .Ltmp207
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp206-.Lfunc_begin1         # >> Call Site 48 <<
	.uleb128 .Ltmp211-.Ltmp206              #   Call between .Ltmp206 and .Ltmp211
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp211-.Lfunc_begin1         # >> Call Site 49 <<
	.uleb128 .Ltmp214-.Ltmp211              #   Call between .Ltmp211 and .Ltmp214
	.uleb128 .Ltmp215-.Lfunc_begin1         #     jumps to .Ltmp215
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp195-.Lfunc_begin1         # >> Call Site 50 <<
	.uleb128 .Ltmp196-.Ltmp195              #   Call between .Ltmp195 and .Ltmp196
	.uleb128 .Ltmp201-.Lfunc_begin1         #     jumps to .Ltmp201
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp190-.Lfunc_begin1         # >> Call Site 51 <<
	.uleb128 .Ltmp193-.Ltmp190              #   Call between .Ltmp190 and .Ltmp193
	.uleb128 .Ltmp194-.Lfunc_begin1         #     jumps to .Ltmp194
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp219-.Lfunc_begin1         # >> Call Site 52 <<
	.uleb128 .Ltmp220-.Ltmp219              #   Call between .Ltmp219 and .Ltmp220
	.uleb128 .Ltmp221-.Lfunc_begin1         #     jumps to .Ltmp221
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp220-.Lfunc_begin1         # >> Call Site 53 <<
	.uleb128 .Ltmp225-.Ltmp220              #   Call between .Ltmp220 and .Ltmp225
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp225-.Lfunc_begin1         # >> Call Site 54 <<
	.uleb128 .Ltmp228-.Ltmp225              #   Call between .Ltmp225 and .Ltmp228
	.uleb128 .Ltmp229-.Lfunc_begin1         #     jumps to .Ltmp229
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp154-.Lfunc_begin1         # >> Call Site 55 <<
	.uleb128 .Ltmp155-.Ltmp154              #   Call between .Ltmp154 and .Ltmp155
	.uleb128 .Ltmp156-.Lfunc_begin1         #     jumps to .Ltmp156
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp222-.Lfunc_begin1         # >> Call Site 56 <<
	.uleb128 .Ltmp223-.Ltmp222              #   Call between .Ltmp222 and .Ltmp223
	.uleb128 .Ltmp224-.Lfunc_begin1         #     jumps to .Ltmp224
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp208-.Lfunc_begin1         # >> Call Site 57 <<
	.uleb128 .Ltmp209-.Ltmp208              #   Call between .Ltmp208 and .Ltmp209
	.uleb128 .Ltmp210-.Lfunc_begin1         #     jumps to .Ltmp210
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp233-.Lfunc_begin1         # >> Call Site 58 <<
	.uleb128 .Ltmp234-.Ltmp233              #   Call between .Ltmp233 and .Ltmp234
	.uleb128 .Ltmp239-.Lfunc_begin1         #     jumps to .Ltmp239
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp137-.Lfunc_begin1         # >> Call Site 59 <<
	.uleb128 .Ltmp138-.Ltmp137              #   Call between .Ltmp137 and .Ltmp138
	.uleb128 .Ltmp139-.Lfunc_begin1         #     jumps to .Ltmp139
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp146-.Lfunc_begin1         # >> Call Site 60 <<
	.uleb128 .Ltmp147-.Ltmp146              #   Call between .Ltmp146 and .Ltmp147
	.uleb128 .Ltmp164-.Lfunc_begin1         #     jumps to .Ltmp164
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp44-.Lfunc_begin1          # >> Call Site 61 <<
	.uleb128 .Ltmp45-.Ltmp44                #   Call between .Ltmp44 and .Ltmp45
	.uleb128 .Ltmp50-.Lfunc_begin1          #     jumps to .Ltmp50
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp84-.Lfunc_begin1          # >> Call Site 62 <<
	.uleb128 .Ltmp85-.Ltmp84                #   Call between .Ltmp84 and .Ltmp85
	.uleb128 .Ltmp90-.Lfunc_begin1          #     jumps to .Ltmp90
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp29-.Lfunc_begin1          # >> Call Site 63 <<
	.uleb128 .Ltmp30-.Ltmp29                #   Call between .Ltmp29 and .Ltmp30
	.uleb128 .Ltmp35-.Lfunc_begin1          #     jumps to .Ltmp35
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp14-.Lfunc_begin1          # >> Call Site 64 <<
	.uleb128 .Ltmp15-.Ltmp14                #   Call between .Ltmp14 and .Ltmp15
	.uleb128 .Ltmp20-.Lfunc_begin1          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp59-.Lfunc_begin1          # >> Call Site 65 <<
	.uleb128 .Ltmp60-.Ltmp59                #   Call between .Ltmp59 and .Ltmp60
	.uleb128 .Ltmp65-.Lfunc_begin1          #     jumps to .Ltmp65
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp74-.Lfunc_begin1          # >> Call Site 66 <<
	.uleb128 .Ltmp75-.Ltmp74                #   Call between .Ltmp74 and .Ltmp75
	.uleb128 .Ltmp80-.Lfunc_begin1          #     jumps to .Ltmp80
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp216-.Lfunc_begin1         # >> Call Site 67 <<
	.uleb128 .Ltmp217-.Ltmp216              #   Call between .Ltmp216 and .Ltmp217
	.uleb128 .Ltmp218-.Lfunc_begin1         #     jumps to .Ltmp218
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp108-.Lfunc_begin1         # >> Call Site 68 <<
	.uleb128 .Ltmp109-.Ltmp108              #   Call between .Ltmp108 and .Ltmp109
	.uleb128 .Ltmp110-.Lfunc_begin1         #     jumps to .Ltmp110
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp128-.Lfunc_begin1         # >> Call Site 69 <<
	.uleb128 .Ltmp129-.Ltmp128              #   Call between .Ltmp128 and .Ltmp129
	.uleb128 .Ltmp130-.Lfunc_begin1         #     jumps to .Ltmp130
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp165-.Lfunc_begin1         # >> Call Site 70 <<
	.uleb128 .Ltmp166-.Ltmp165              #   Call between .Ltmp165 and .Ltmp166
	.uleb128 .Ltmp167-.Lfunc_begin1         #     jumps to .Ltmp167
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp162-.Lfunc_begin1         # >> Call Site 71 <<
	.uleb128 .Ltmp163-.Ltmp162              #   Call between .Ltmp162 and .Ltmp163
	.uleb128 .Ltmp164-.Lfunc_begin1         #     jumps to .Ltmp164
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp171-.Lfunc_begin1         # >> Call Site 72 <<
	.uleb128 .Ltmp172-.Ltmp171              #   Call between .Ltmp171 and .Ltmp172
	.uleb128 .Ltmp173-.Lfunc_begin1         #     jumps to .Ltmp173
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp111-.Lfunc_begin1         # >> Call Site 73 <<
	.uleb128 .Ltmp112-.Ltmp111              #   Call between .Ltmp111 and .Ltmp112
	.uleb128 .Ltmp113-.Lfunc_begin1         #     jumps to .Ltmp113
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp237-.Lfunc_begin1         # >> Call Site 74 <<
	.uleb128 .Ltmp236-.Ltmp237              #   Call between .Ltmp237 and .Ltmp236
	.uleb128 .Ltmp239-.Lfunc_begin1         #     jumps to .Ltmp239
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp168-.Lfunc_begin1         # >> Call Site 75 <<
	.uleb128 .Ltmp169-.Ltmp168              #   Call between .Ltmp168 and .Ltmp169
	.uleb128 .Ltmp170-.Lfunc_begin1         #     jumps to .Ltmp170
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp48-.Lfunc_begin1          # >> Call Site 76 <<
	.uleb128 .Ltmp49-.Ltmp48                #   Call between .Ltmp48 and .Ltmp49
	.uleb128 .Ltmp50-.Lfunc_begin1          #     jumps to .Ltmp50
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp88-.Lfunc_begin1          # >> Call Site 77 <<
	.uleb128 .Ltmp89-.Ltmp88                #   Call between .Ltmp88 and .Ltmp89
	.uleb128 .Ltmp90-.Lfunc_begin1          #     jumps to .Ltmp90
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp33-.Lfunc_begin1          # >> Call Site 78 <<
	.uleb128 .Ltmp34-.Ltmp33                #   Call between .Ltmp33 and .Ltmp34
	.uleb128 .Ltmp35-.Lfunc_begin1          #     jumps to .Ltmp35
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp18-.Lfunc_begin1          # >> Call Site 79 <<
	.uleb128 .Ltmp19-.Ltmp18                #   Call between .Ltmp18 and .Ltmp19
	.uleb128 .Ltmp20-.Lfunc_begin1          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp11-.Lfunc_begin1          # >> Call Site 80 <<
	.uleb128 .Ltmp12-.Ltmp11                #   Call between .Ltmp11 and .Ltmp12
	.uleb128 .Ltmp13-.Lfunc_begin1          #     jumps to .Ltmp13
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp41-.Lfunc_begin1          # >> Call Site 81 <<
	.uleb128 .Ltmp42-.Ltmp41                #   Call between .Ltmp41 and .Ltmp42
	.uleb128 .Ltmp43-.Lfunc_begin1          #     jumps to .Ltmp43
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp26-.Lfunc_begin1          # >> Call Site 82 <<
	.uleb128 .Ltmp27-.Ltmp26                #   Call between .Ltmp26 and .Ltmp27
	.uleb128 .Ltmp28-.Lfunc_begin1          #     jumps to .Ltmp28
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp63-.Lfunc_begin1          # >> Call Site 83 <<
	.uleb128 .Ltmp64-.Ltmp63                #   Call between .Ltmp63 and .Ltmp64
	.uleb128 .Ltmp65-.Lfunc_begin1          #     jumps to .Ltmp65
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp56-.Lfunc_begin1          # >> Call Site 84 <<
	.uleb128 .Ltmp57-.Ltmp56                #   Call between .Ltmp56 and .Ltmp57
	.uleb128 .Ltmp58-.Lfunc_begin1          #     jumps to .Ltmp58
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp31-.Lfunc_begin1          # >> Call Site 85 <<
	.uleb128 .Ltmp32-.Ltmp31                #   Call between .Ltmp31 and .Ltmp32
	.uleb128 .Ltmp35-.Lfunc_begin1          #     jumps to .Ltmp35
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp46-.Lfunc_begin1          # >> Call Site 86 <<
	.uleb128 .Ltmp47-.Ltmp46                #   Call between .Ltmp46 and .Ltmp47
	.uleb128 .Ltmp50-.Lfunc_begin1          #     jumps to .Ltmp50
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp86-.Lfunc_begin1          # >> Call Site 87 <<
	.uleb128 .Ltmp87-.Ltmp86                #   Call between .Ltmp86 and .Ltmp87
	.uleb128 .Ltmp90-.Lfunc_begin1          #     jumps to .Ltmp90
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp16-.Lfunc_begin1          # >> Call Site 88 <<
	.uleb128 .Ltmp17-.Ltmp16                #   Call between .Ltmp16 and .Ltmp17
	.uleb128 .Ltmp20-.Lfunc_begin1          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp9-.Lfunc_begin1           # >> Call Site 89 <<
	.uleb128 .Ltmp10-.Ltmp9                 #   Call between .Ltmp9 and .Ltmp10
	.uleb128 .Ltmp13-.Lfunc_begin1          #     jumps to .Ltmp13
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp24-.Lfunc_begin1          # >> Call Site 90 <<
	.uleb128 .Ltmp25-.Ltmp24                #   Call between .Ltmp24 and .Ltmp25
	.uleb128 .Ltmp28-.Lfunc_begin1          #     jumps to .Ltmp28
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp39-.Lfunc_begin1          # >> Call Site 91 <<
	.uleb128 .Ltmp40-.Ltmp39                #   Call between .Ltmp39 and .Ltmp40
	.uleb128 .Ltmp43-.Lfunc_begin1          #     jumps to .Ltmp43
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp230-.Lfunc_begin1         # >> Call Site 92 <<
	.uleb128 .Ltmp231-.Ltmp230              #   Call between .Ltmp230 and .Ltmp231
	.uleb128 .Ltmp232-.Lfunc_begin1         #     jumps to .Ltmp232
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp78-.Lfunc_begin1          # >> Call Site 93 <<
	.uleb128 .Ltmp79-.Ltmp78                #   Call between .Ltmp78 and .Ltmp79
	.uleb128 .Ltmp80-.Lfunc_begin1          #     jumps to .Ltmp80
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp71-.Lfunc_begin1          # >> Call Site 94 <<
	.uleb128 .Ltmp72-.Ltmp71                #   Call between .Ltmp71 and .Ltmp72
	.uleb128 .Ltmp73-.Lfunc_begin1          #     jumps to .Ltmp73
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp61-.Lfunc_begin1          # >> Call Site 95 <<
	.uleb128 .Ltmp62-.Ltmp61                #   Call between .Ltmp61 and .Ltmp62
	.uleb128 .Ltmp65-.Lfunc_begin1          #     jumps to .Ltmp65
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp54-.Lfunc_begin1          # >> Call Site 96 <<
	.uleb128 .Ltmp55-.Ltmp54                #   Call between .Ltmp54 and .Ltmp55
	.uleb128 .Ltmp58-.Lfunc_begin1          #     jumps to .Ltmp58
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp76-.Lfunc_begin1          # >> Call Site 97 <<
	.uleb128 .Ltmp77-.Ltmp76                #   Call between .Ltmp76 and .Ltmp77
	.uleb128 .Ltmp80-.Lfunc_begin1          #     jumps to .Ltmp80
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp69-.Lfunc_begin1          # >> Call Site 98 <<
	.uleb128 .Ltmp70-.Ltmp69                #   Call between .Ltmp69 and .Ltmp70
	.uleb128 .Ltmp73-.Lfunc_begin1          #     jumps to .Ltmp73
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp70-.Lfunc_begin1          # >> Call Site 99 <<
	.uleb128 .Lfunc_end12-.Ltmp70           #   Call between .Ltmp70 and .Lfunc_end12
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end1:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,comdat
	.weak	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev # -- Begin function _ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.p2align	4, 0x90
	.type	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,@function
_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev:    # @_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %rbx
	movq	8(%rdi), %r15
	cmpq	%r15, %rbx
	je	.LBB13_6
# %bb.1:
	movq	%rdi, %r14
	jmp	.LBB13_2
	.p2align	4, 0x90
.LBB13_4:                               #   in Loop: Header=BB13_2 Depth=1
	addq	$24, %rbx
	cmpq	%r15, %rbx
	je	.LBB13_5
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB13_4
# %bb.3:                                #   in Loop: Header=BB13_2 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB13_4
.LBB13_5:
	movq	(%r14), %rbx
.LBB13_6:
	testq	%rbx, %rbx
	je	.LBB13_7
# %bb.8:
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB13_7:
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev, .Lfunc_end13-_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,comdat
	.weak	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev # -- Begin function _ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.p2align	4, 0x90
	.type	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,@function
_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev:    # @_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %rbx
	movq	8(%rdi), %r15
	cmpq	%r15, %rbx
	je	.LBB14_6
# %bb.1:
	movq	%rdi, %r14
	jmp	.LBB14_2
	.p2align	4, 0x90
.LBB14_4:                               #   in Loop: Header=BB14_2 Depth=1
	addq	$24, %rbx
	cmpq	%r15, %rbx
	je	.LBB14_5
.LBB14_2:                               # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB14_4
# %bb.3:                                #   in Loop: Header=BB14_2 Depth=1
	callq	_ZdlPv@PLT
	jmp	.LBB14_4
.LBB14_5:
	movq	(%r14), %rbx
.LBB14_6:
	testq	%rbx, %rbx
	je	.LBB14_7
# %bb.8:
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB14_7:
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end14:
	.size	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev, .Lfunc_end14-_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,"axG",@progbits,_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,comdat
	.weak	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_ # -- Begin function _ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.p2align	4, 0x90
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,@function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_: # @_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
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
	movq	%rsi, %rbp
	subq	%rdi, %rbp
	sarq	$3, %rbp
	cmpq	$17, %rbp
	jl	.LBB15_38
# %bb.1:
	movq	%rdx, %r14
	movq	%rdi, %rbx
	leaq	8(%rdi), %r12
	movq	$-8, %r13
	subq	%rdi, %r13
	jmp	.LBB15_2
	.p2align	4, 0x90
.LBB15_37:                              #   in Loop: Header=BB15_2 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	sarq	$3, %rbp
	movq	%r15, %rsi
	cmpq	$16, %rbp
	jle	.LBB15_38
.LBB15_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_31 Depth 2
                                        #       Child Loop BB15_32 Depth 3
                                        #       Child Loop BB15_34 Depth 3
	subq	$1, %r14
	jb	.LBB15_3
# %bb.19:                               #   in Loop: Header=BB15_2 Depth=1
	shrq	%rbp
	movq	8(%rbx), %rcx
	movq	(%rbx,%rbp,8), %rdx
	movq	-8(%rsi), %rax
	cmpq	%rdx, %rcx
	jae	.LBB15_25
# %bb.20:                               #   in Loop: Header=BB15_2 Depth=1
	cmpq	%rax, %rdx
	jae	.LBB15_22
# %bb.21:                               #   in Loop: Header=BB15_2 Depth=1
	movq	(%rbx), %rax
	movq	%rdx, (%rbx)
	movq	%rax, (%rbx,%rbp,8)
	jmp	.LBB15_30
	.p2align	4, 0x90
.LBB15_25:                              #   in Loop: Header=BB15_2 Depth=1
	cmpq	%rax, %rcx
	jae	.LBB15_27
# %bb.26:                               #   in Loop: Header=BB15_2 Depth=1
	movq	(%rbx), %rax
	movq	%rcx, (%rbx)
	movq	%rax, 8(%rbx)
	jmp	.LBB15_30
	.p2align	4, 0x90
.LBB15_22:                              #   in Loop: Header=BB15_2 Depth=1
	movq	(%rbx), %rdx
	cmpq	%rax, %rcx
	jae	.LBB15_24
# %bb.23:                               #   in Loop: Header=BB15_2 Depth=1
	movq	%rax, (%rbx)
	movq	%rdx, -8(%rsi)
	jmp	.LBB15_30
	.p2align	4, 0x90
.LBB15_27:                              #   in Loop: Header=BB15_2 Depth=1
	movq	(%rbx), %rcx
	cmpq	%rax, %rdx
	jae	.LBB15_29
# %bb.28:                               #   in Loop: Header=BB15_2 Depth=1
	movq	%rax, (%rbx)
	movq	%rcx, -8(%rsi)
	jmp	.LBB15_30
.LBB15_24:                              #   in Loop: Header=BB15_2 Depth=1
	movq	%rcx, (%rbx)
	movq	%rdx, 8(%rbx)
	jmp	.LBB15_30
.LBB15_29:                              #   in Loop: Header=BB15_2 Depth=1
	movq	%rdx, (%rbx)
	movq	%rcx, (%rbx,%rbp,8)
	.p2align	4, 0x90
.LBB15_30:                              #   in Loop: Header=BB15_2 Depth=1
	movq	%r12, %rax
	movq	%rsi, %rcx
	.p2align	4, 0x90
.LBB15_31:                              #   Parent Loop BB15_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB15_32 Depth 3
                                        #       Child Loop BB15_34 Depth 3
	movq	(%rbx), %rdx
	leaq	(%rax,%r13), %rbp
	.p2align	4, 0x90
.LBB15_32:                              #   Parent Loop BB15_2 Depth=1
                                        #     Parent Loop BB15_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	(%rax), %rdi
	addq	$8, %rax
	addq	$8, %rbp
	cmpq	%rdx, %rdi
	jb	.LBB15_32
# %bb.33:                               #   in Loop: Header=BB15_31 Depth=2
	leaq	-8(%rax), %r15
	.p2align	4, 0x90
.LBB15_34:                              #   Parent Loop BB15_2 Depth=1
                                        #     Parent Loop BB15_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-8(%rcx), %r8
	addq	$-8, %rcx
	cmpq	%r8, %rdx
	jb	.LBB15_34
# %bb.35:                               #   in Loop: Header=BB15_31 Depth=2
	cmpq	%rcx, %r15
	jae	.LBB15_37
# %bb.36:                               #   in Loop: Header=BB15_31 Depth=2
	movq	%r8, (%r15)
	movq	%rdi, (%rcx)
	jmp	.LBB15_31
.LBB15_3:
	leaq	7(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%rsi, %r14
	callq	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	jmp	.LBB15_4
	.p2align	4, 0x90
.LBB15_17:                              #   in Loop: Header=BB15_4 Depth=1
	xorl	%edx, %edx
.LBB15_18:                              #   in Loop: Header=BB15_4 Depth=1
	movq	%rax, (%rbx,%rdx,8)
	cmpq	$8, %rcx
	jle	.LBB15_38
.LBB15_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_7 Depth 2
                                        #     Child Loop BB15_15 Depth 2
	movq	-8(%r14), %rax
	movq	(%rbx), %rdx
	movq	%rdx, -8(%r14)
	addq	$-8, %r14
	movq	%r14, %rcx
	subq	%rbx, %rcx
	movq	%rcx, %rsi
	sarq	$3, %rsi
	cmpq	$3, %rsi
	jl	.LBB15_5
# %bb.6:                                #   in Loop: Header=BB15_4 Depth=1
	leaq	-1(%rsi), %rdx
	shrq	$63, %rdx
	leaq	(%rsi,%rdx), %rdi
	decq	%rdi
	sarq	%rdi
	xorl	%r8d, %r8d
	jmp	.LBB15_7
	.p2align	4, 0x90
.LBB15_9:                               #   in Loop: Header=BB15_7 Depth=2
	leaq	2(,%r8,2), %rdx
.LBB15_10:                              #   in Loop: Header=BB15_7 Depth=2
	movq	(%rbx,%rdx,8), %r9
	movq	%r9, (%rbx,%r8,8)
	movq	%rdx, %r8
	cmpq	%rdi, %rdx
	jge	.LBB15_11
.LBB15_7:                               #   Parent Loop BB15_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r8,%r8), %rdx
	movq	16(%rbx,%rdx,8), %r9
	cmpq	8(%rbx,%rdx,8), %r9
	jae	.LBB15_9
# %bb.8:                                #   in Loop: Header=BB15_7 Depth=2
	leaq	1(,%r8,2), %rdx
	jmp	.LBB15_10
	.p2align	4, 0x90
.LBB15_5:                               #   in Loop: Header=BB15_4 Depth=1
	xorl	%edx, %edx
.LBB15_11:                              #   in Loop: Header=BB15_4 Depth=1
	testb	$8, %cl
	jne	.LBB15_14
# %bb.12:                               #   in Loop: Header=BB15_4 Depth=1
	addq	$-2, %rsi
	sarq	%rsi
	cmpq	%rsi, %rdx
	jne	.LBB15_14
# %bb.13:                               #   in Loop: Header=BB15_4 Depth=1
	leaq	(%rdx,%rdx), %rsi
	movq	8(%rbx,%rsi,8), %rsi
	movq	%rsi, (%rbx,%rdx,8)
	leaq	1(,%rdx,2), %rdx
.LBB15_14:                              #   in Loop: Header=BB15_4 Depth=1
	testq	%rdx, %rdx
	jle	.LBB15_18
	.p2align	4, 0x90
.LBB15_15:                              #   Parent Loop BB15_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rdx), %rsi
	movq	%rsi, %rdi
	shrq	%rdi
	movq	(%rbx,%rdi,8), %r8
	cmpq	%rax, %r8
	jae	.LBB15_18
# %bb.16:                               #   in Loop: Header=BB15_15 Depth=2
	movq	%r8, (%rbx,%rdx,8)
	movq	%rdi, %rdx
	cmpq	$1, %rsi
	ja	.LBB15_15
	jmp	.LBB15_17
.LBB15_38:
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
.Lfunc_end15:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_, .Lfunc_end15-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,"axG",@progbits,_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,comdat
	.weak	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_ # -- Begin function _ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.p2align	4, 0x90
	.type	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,@function
_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_: # @_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rax
	subq	%rdi, %rax
	cmpq	$129, %rax
	jl	.LBB16_2
# %bb.1:
	movq	%rbx, (%rsp)                    # 8-byte Spill
	leaq	8(%r14), %r15
	movl	$8, %r12d
	movq	%r15, %r13
	movq	%r14, %rbp
	jmp	.LBB16_18
.LBB16_2:
	cmpq	%rbx, %r14
	je	.LBB16_30
# %bb.3:
	leaq	8(%r14), %rax
	cmpq	%rbx, %rax
	je	.LBB16_30
# %bb.4:
	movq	%r14, %r15
	jmp	.LBB16_9
	.p2align	4, 0x90
.LBB16_5:                               #   in Loop: Header=BB16_9 Depth=1
	movq	%r15, %rdx
	subq	%r14, %rdx
	movq	%rdx, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jl	.LBB16_13
# %bb.6:                                #   in Loop: Header=BB16_9 Depth=1
	shlq	$3, %rax
	subq	%rax, %rdi
	addq	$16, %rdi
	movq	%r14, %rsi
	callq	memmove@PLT
.LBB16_7:                               #   in Loop: Header=BB16_9 Depth=1
	movq	%r14, %rax
.LBB16_8:                               #   in Loop: Header=BB16_9 Depth=1
	movq	%r12, (%rax)
	leaq	8(%r15), %rax
	cmpq	%rbx, %rax
	je	.LBB16_30
.LBB16_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_12 Depth 2
	movq	%r15, %rdi
	movq	%rax, %r15
	movq	8(%rdi), %r12
	movq	(%r14), %rcx
	cmpq	%rcx, %r12
	jb	.LBB16_5
# %bb.10:                               #   in Loop: Header=BB16_9 Depth=1
	movq	(%rdi), %rcx
	movq	%r15, %rax
	cmpq	%rcx, %r12
	jae	.LBB16_8
# %bb.11:                               #   in Loop: Header=BB16_9 Depth=1
	movq	%r15, %rax
	.p2align	4, 0x90
.LBB16_12:                              #   Parent Loop BB16_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%rax)
	movq	-16(%rax), %rcx
	addq	$-8, %rax
	cmpq	%rcx, %r12
	jb	.LBB16_12
	jmp	.LBB16_8
.LBB16_13:                              #   in Loop: Header=BB16_9 Depth=1
	movq	%r14, %rax
	cmpq	$8, %rdx
	jne	.LBB16_8
# %bb.14:                               #   in Loop: Header=BB16_9 Depth=1
	movq	%rcx, 8(%rdi)
	jmp	.LBB16_7
.LBB16_15:                              #   in Loop: Header=BB16_18 Depth=1
	movq	%rcx, 8(%rax)
	.p2align	4, 0x90
.LBB16_16:                              #   in Loop: Header=BB16_18 Depth=1
	movq	%r14, %rax
.LBB16_17:                              #   in Loop: Header=BB16_18 Depth=1
	movq	%rbx, (%rax)
	addq	$8, %r12
	addq	$8, %r13
	cmpq	$128, %r12
	je	.LBB16_24
.LBB16_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_23 Depth 2
	movq	%rbp, %rax
	leaq	(%r14,%r12), %rbp
	movq	(%r14,%r12), %rbx
	movq	(%r14), %rcx
	cmpq	%rcx, %rbx
	jae	.LBB16_21
# %bb.19:                               #   in Loop: Header=BB16_18 Depth=1
	cmpq	$9, %r12
	jb	.LBB16_15
# %bb.20:                               #   in Loop: Header=BB16_18 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%r12, %rdx
	callq	memmove@PLT
	jmp	.LBB16_16
	.p2align	4, 0x90
.LBB16_21:                              #   in Loop: Header=BB16_18 Depth=1
	movq	(%rax), %rcx
	movq	%rbp, %rax
	cmpq	%rcx, %rbx
	jae	.LBB16_17
# %bb.22:                               #   in Loop: Header=BB16_18 Depth=1
	movq	%r13, %rax
	.p2align	4, 0x90
.LBB16_23:                              #   Parent Loop BB16_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%rax)
	movq	-16(%rax), %rcx
	addq	$-8, %rax
	cmpq	%rcx, %rbx
	jb	.LBB16_23
	jmp	.LBB16_17
.LBB16_24:
	subq	$-128, %r14
	movq	(%rsp), %rsi                    # 8-byte Reload
	jmp	.LBB16_26
	.p2align	4, 0x90
.LBB16_25:                              #   in Loop: Header=BB16_26 Depth=1
	movq	%rax, (%rdx)
	addq	$8, %r14
.LBB16_26:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_29 Depth 2
	cmpq	%rsi, %r14
	je	.LBB16_30
# %bb.27:                               #   in Loop: Header=BB16_26 Depth=1
	movq	-8(%r14), %rcx
	movq	(%r14), %rax
	movq	%r14, %rdx
	cmpq	%rcx, %rax
	jae	.LBB16_25
# %bb.28:                               #   in Loop: Header=BB16_26 Depth=1
	movq	%r14, %rdx
	.p2align	4, 0x90
.LBB16_29:                              #   Parent Loop BB16_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%rdx)
	movq	-16(%rdx), %rcx
	addq	$-8, %rdx
	cmpq	%rcx, %rax
	jb	.LBB16_29
	jmp	.LBB16_25
.LBB16_30:
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
.Lfunc_end16:
	.size	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_, .Lfunc_end16-_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,"axG",@progbits,_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,comdat
	.weak	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_ # -- Begin function _ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.p2align	4, 0x90
	.type	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,@function
_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_: # @_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_startproc
# %bb.0:
	subq	%rdi, %rsi
	movq	%rsi, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jge	.LBB17_2
.LBB17_1:
	retq
.LBB17_2:
	leaq	-2(%rax), %rdx
	movq	%rdx, %rcx
	shrq	%rcx
	decq	%rax
	shrq	%rax
	testb	$8, %sil
	jne	.LBB17_20
# %bb.3:
	orq	$1, %rdx
	movq	%rcx, %rsi
	jmp	.LBB17_6
	.p2align	4, 0x90
.LBB17_4:                               #   in Loop: Header=BB17_6 Depth=1
	movq	%r9, %r10
.LBB17_5:                               #   in Loop: Header=BB17_6 Depth=1
	movq	%r8, (%rdi,%r10,8)
	subq	$1, %rsi
	jb	.LBB17_1
.LBB17_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB17_10 Depth 2
                                        #     Child Loop BB17_15 Depth 2
	movq	(%rdi,%rsi,8), %r8
	movq	%rsi, %r9
	cmpq	%rsi, %rax
	jle	.LBB17_12
# %bb.7:                                #   in Loop: Header=BB17_6 Depth=1
	movq	%rsi, %r10
	jmp	.LBB17_10
	.p2align	4, 0x90
.LBB17_8:                               #   in Loop: Header=BB17_10 Depth=2
	leaq	2(,%r10,2), %r9
.LBB17_9:                               #   in Loop: Header=BB17_10 Depth=2
	movq	(%rdi,%r9,8), %r11
	movq	%r11, (%rdi,%r10,8)
	movq	%r9, %r10
	cmpq	%rax, %r9
	jge	.LBB17_12
.LBB17_10:                              #   Parent Loop BB17_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r10,%r10), %r9
	movq	16(%rdi,%r9,8), %r11
	cmpq	8(%rdi,%r9,8), %r11
	jae	.LBB17_8
# %bb.11:                               #   in Loop: Header=BB17_10 Depth=2
	leaq	1(,%r10,2), %r9
	jmp	.LBB17_9
	.p2align	4, 0x90
.LBB17_12:                              #   in Loop: Header=BB17_6 Depth=1
	cmpq	%rcx, %r9
	jne	.LBB17_14
# %bb.13:                               #   in Loop: Header=BB17_6 Depth=1
	movq	(%rdi,%rdx,8), %r9
	movq	%r9, (%rdi,%rcx,8)
	movq	%rdx, %r9
.LBB17_14:                              #   in Loop: Header=BB17_6 Depth=1
	cmpq	%rsi, %r9
	jle	.LBB17_4
	.p2align	4, 0x90
.LBB17_15:                              #   Parent Loop BB17_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%r9), %r10
	shrq	$63, %r10
	addq	%r9, %r10
	decq	%r10
	sarq	%r10
	movq	(%rdi,%r10,8), %r11
	cmpq	%r8, %r11
	jae	.LBB17_4
# %bb.16:                               #   in Loop: Header=BB17_15 Depth=2
	movq	%r11, (%rdi,%r9,8)
	movq	%r10, %r9
	cmpq	%rsi, %r10
	jg	.LBB17_15
	jmp	.LBB17_5
	.p2align	4, 0x90
.LBB17_18:                              #   in Loop: Header=BB17_20 Depth=1
	movq	%rsi, %r8
.LBB17_19:                              #   in Loop: Header=BB17_20 Depth=1
	movq	%rdx, (%rdi,%r8,8)
	subq	$1, %rcx
	jb	.LBB17_1
.LBB17_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB17_24 Depth 2
                                        #     Child Loop BB17_27 Depth 2
	movq	(%rdi,%rcx,8), %rdx
	movq	%rcx, %r8
	cmpq	%rcx, %rax
	jle	.LBB17_19
# %bb.21:                               #   in Loop: Header=BB17_20 Depth=1
	movq	%rcx, %r8
	jmp	.LBB17_24
	.p2align	4, 0x90
.LBB17_22:                              #   in Loop: Header=BB17_24 Depth=2
	leaq	2(,%r8,2), %rsi
.LBB17_23:                              #   in Loop: Header=BB17_24 Depth=2
	movq	(%rdi,%rsi,8), %r9
	movq	%r9, (%rdi,%r8,8)
	movq	%rsi, %r8
	cmpq	%rax, %rsi
	jge	.LBB17_26
.LBB17_24:                              #   Parent Loop BB17_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r8,%r8), %rsi
	movq	16(%rdi,%rsi,8), %r9
	cmpq	8(%rdi,%rsi,8), %r9
	jae	.LBB17_22
# %bb.25:                               #   in Loop: Header=BB17_24 Depth=2
	leaq	1(,%r8,2), %rsi
	jmp	.LBB17_23
	.p2align	4, 0x90
.LBB17_26:                              #   in Loop: Header=BB17_20 Depth=1
	cmpq	%rcx, %rsi
	jle	.LBB17_18
	.p2align	4, 0x90
.LBB17_27:                              #   Parent Loop BB17_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rsi), %r8
	shrq	$63, %r8
	addq	%rsi, %r8
	decq	%r8
	sarq	%r8
	movq	(%rdi,%r8,8), %r9
	cmpq	%rdx, %r9
	jae	.LBB17_18
# %bb.28:                               #   in Loop: Header=BB17_27 Depth=2
	movq	%r9, (%rdi,%rsi,8)
	movq	%r8, %rsi
	cmpq	%rcx, %r8
	jg	.LBB17_27
	jmp	.LBB17_19
.Lfunc_end17:
	.size	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_, .Lfunc_end17-_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_endproc
                                        # -- End function
	.section	.text.__clang_call_terminate,"axG",@progbits,__clang_call_terminate,comdat
	.hidden	__clang_call_terminate          # -- Begin function __clang_call_terminate
	.weak	__clang_call_terminate
	.p2align	4, 0x90
	.type	__clang_call_terminate,@function
__clang_call_terminate:                 # @__clang_call_terminate
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	__cxa_begin_catch@PLT
	callq	_ZSt9terminatev@PLT
.Lfunc_end18:
	.size	__clang_call_terminate, .Lfunc_end18-__clang_call_terminate
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag # -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
	.p2align	4, 0x90
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag: # @_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
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
	cmpq	%rdx, %rsi
	je	.LBB19_29
# %bb.1:
	movq	$-1, %r8
	xorl	%r14d, %r14d
	movq	%rsi, %rax
	.p2align	4, 0x90
.LBB19_2:                               # =>This Inner Loop Header: Depth=1
	movq	(%rax), %rax
	incq	%r8
	addq	$8, %r14
	cmpq	%rdx, %rax
	jne	.LBB19_2
# %bb.3:
	movq	(%rdi), %rbx
	movq	16(%rdi), %rax
	subq	%rbx, %rax
	sarq	$3, %rax
	cmpq	%rax, %r8
	jae	.LBB19_4
# %bb.10:
	movq	8(%rdi), %rax
	addq	$8, %rdi
	movq	%rax, %rcx
	subq	%rbx, %rcx
	sarq	$3, %rcx
	cmpq	%r8, %rcx
	jbe	.LBB19_14
	.p2align	4, 0x90
.LBB19_11:                              # =>This Inner Loop Header: Depth=1
	movq	8(%rsi), %rcx
	movq	%rcx, (%rbx)
	addq	$8, %rbx
	movq	(%rsi), %rsi
	cmpq	%rdx, %rsi
	jne	.LBB19_11
# %bb.12:
	cmpq	%rbx, %rax
	jne	.LBB19_13
	jmp	.LBB19_28
.LBB19_29:
	movq	(%rdi), %rbx
	movq	8(%rdi), %rax
	addq	$8, %rdi
	cmpq	%rbx, %rax
	je	.LBB19_28
.LBB19_13:
	movq	%rbx, (%rdi)
	jmp	.LBB19_28
.LBB19_4:
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %r8
	jae	.LBB19_30
# %bb.5:
	movq	%rsi, %rbp
	movq	%rdx, %r13
	movq	%rdi, %r12
	movq	%r14, %rdi
	callq	_Znwm@PLT
	movq	%rax, %r15
	movq	%r13, %rcx
	.p2align	4, 0x90
.LBB19_6:                               # =>This Inner Loop Header: Depth=1
	movq	8(%rbp), %rdx
	movq	%rdx, (%rax)
	addq	$8, %rax
	movq	(%rbp), %rbp
	cmpq	%rcx, %rbp
	jne	.LBB19_6
# %bb.7:
	testq	%rbx, %rbx
	je	.LBB19_9
# %bb.8:
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB19_9:
	movq	%r15, (%r12)
	addq	%r14, %r15
	movq	%r15, 8(%r12)
	movq	%r15, 16(%r12)
	jmp	.LBB19_28
.LBB19_14:
	cmpq	%rbx, %rax
	je	.LBB19_26
# %bb.15:
	leaq	-1(%rcx), %r9
	movq	%rcx, %r10
	andq	$7, %r10
	je	.LBB19_16
# %bb.17:
	xorl	%r11d, %r11d
	movq	%rsi, %r8
	.p2align	4, 0x90
.LBB19_18:                              # =>This Inner Loop Header: Depth=1
	movq	(%r8), %r8
	incq	%r11
	cmpq	%r11, %r10
	jne	.LBB19_18
# %bb.19:
	subq	%r11, %rcx
	cmpq	$7, %r9
	jb	.LBB19_22
	.p2align	4, 0x90
.LBB19_21:                              # =>This Inner Loop Header: Depth=1
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	movq	(%r8), %r8
	addq	$-8, %rcx
	jne	.LBB19_21
.LBB19_22:
	cmpq	%rsi, %r8
	je	.LBB19_26
	.p2align	4, 0x90
.LBB19_23:                              # =>This Inner Loop Header: Depth=1
	movq	8(%rsi), %rcx
	movq	%rcx, (%rbx)
	addq	$8, %rbx
	movq	(%rsi), %rsi
	cmpq	%r8, %rsi
	jne	.LBB19_23
# %bb.24:
	movq	%r8, %rsi
	jmp	.LBB19_26
	.p2align	4, 0x90
.LBB19_25:                              #   in Loop: Header=BB19_26 Depth=1
	movq	8(%rsi), %rcx
	movq	%rcx, (%rax)
	addq	$8, %rax
	movq	(%rsi), %rsi
.LBB19_26:                              # =>This Inner Loop Header: Depth=1
	cmpq	%rdx, %rsi
	jne	.LBB19_25
# %bb.27:
	movq	%rax, (%rdi)
.LBB19_28:
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
.LBB19_16:
	.cfi_def_cfa_offset 64
	movq	%rsi, %r8
	cmpq	$7, %r9
	jae	.LBB19_21
	jmp	.LBB19_22
.LBB19_30:
	leaq	.L.str.23(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Lfunc_end19:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag, .Lfunc_end19-_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag # -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
	.p2align	4, 0x90
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag: # @_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
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
	cmpq	%r8, %rdx
	je	.LBB20_59
# %bb.1:
	xorl	%r12d, %r12d
	movq	%rdx, %r10
	movq	%rsi, %rax
	.p2align	4, 0x90
.LBB20_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_3 Depth 2
	movq	%r12, %rcx
	addq	$8, %r10
	movzbl	1(%rax), %r9d
	incq	%rax
	cmpb	$-2, %r9b
	jg	.LBB20_4
	.p2align	4, 0x90
.LBB20_3:                               #   Parent Loop BB20_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %r10
	movzbl	1(%rax), %r9d
	incq	%rax
	cmpb	$-1, %r9b
	jl	.LBB20_3
.LBB20_4:                               #   in Loop: Header=BB20_2 Depth=1
	cmpb	$-1, %r9b
	je	.LBB20_5
# %bb.6:                                #   in Loop: Header=BB20_2 Depth=1
	leaq	1(%rcx), %r12
	cmpq	%r8, %r10
	jne	.LBB20_2
	jmp	.LBB20_7
.LBB20_5:                               #   in Loop: Header=BB20_2 Depth=1
	xorl	%r10d, %r10d
	leaq	1(%rcx), %r12
	cmpq	%r8, %r10
	jne	.LBB20_2
.LBB20_7:
	movq	(%rdi), %r14
	movq	16(%rdi), %rax
	subq	%r14, %rax
	sarq	$3, %rax
	cmpq	%rax, %rcx
	jae	.LBB20_8
# %bb.18:
	movq	8(%rdi), %rax
	addq	$8, %rdi
	movq	%rax, %r10
	subq	%r14, %r10
	movq	%r10, %r9
	sarq	$3, %r9
	cmpq	%rcx, %r9
	jbe	.LBB20_26
	.p2align	4, 0x90
.LBB20_19:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_20 Depth 2
	movq	(%rdx), %rcx
	movq	%rcx, (%r14)
	addq	$8, %rdx
	movzbl	1(%rsi), %ecx
	incq	%rsi
	cmpb	$-2, %cl
	jg	.LBB20_21
	.p2align	4, 0x90
.LBB20_20:                              #   Parent Loop BB20_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rdx
	movzbl	1(%rsi), %ecx
	incq	%rsi
	cmpb	$-1, %cl
	jl	.LBB20_20
.LBB20_21:                              #   in Loop: Header=BB20_19 Depth=1
	cmpb	$-1, %cl
	je	.LBB20_22
# %bb.23:                               #   in Loop: Header=BB20_19 Depth=1
	addq	$8, %r14
	cmpq	%r8, %rdx
	jne	.LBB20_19
	jmp	.LBB20_24
.LBB20_22:                              #   in Loop: Header=BB20_19 Depth=1
	xorl	%edx, %edx
	addq	$8, %r14
	cmpq	%r8, %rdx
	jne	.LBB20_19
	jmp	.LBB20_24
.LBB20_59:
	movq	(%rdi), %r14
	movq	8(%rdi), %rax
	addq	$8, %rdi
.LBB20_24:
	cmpq	%r14, %rax
	je	.LBB20_58
# %bb.25:
	movq	%r14, (%rdi)
	jmp	.LBB20_58
.LBB20_8:
	movabsq	$1152921504606846975, %rax      # imm = 0xFFFFFFFFFFFFFFF
	cmpq	%rax, %rcx
	jae	.LBB20_60
# %bb.9:
	movq	%rdi, %r15
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%r8, %rbx
	leaq	(,%r12,8), %rdi
	callq	_Znwm@PLT
	movq	%rax, %r8
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	movq	%r13, %rsi
	.p2align	4, 0x90
.LBB20_10:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_11 Depth 2
	movq	(%rsi), %rdi
	movq	%rdi, (%r8)
	addq	$8, %rsi
	movzbl	1(%rdx), %edi
	incq	%rdx
	cmpb	$-2, %dil
	jg	.LBB20_12
	.p2align	4, 0x90
.LBB20_11:                              #   Parent Loop BB20_10 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rsi
	movzbl	1(%rdx), %edi
	incq	%rdx
	cmpb	$-1, %dil
	jl	.LBB20_11
.LBB20_12:                              #   in Loop: Header=BB20_10 Depth=1
	cmpb	$-1, %dil
	je	.LBB20_13
# %bb.14:                               #   in Loop: Header=BB20_10 Depth=1
	addq	$8, %r8
	cmpq	%rcx, %rsi
	jne	.LBB20_10
	jmp	.LBB20_15
.LBB20_13:                              #   in Loop: Header=BB20_10 Depth=1
	xorl	%esi, %esi
	addq	$8, %r8
	cmpq	%rcx, %rsi
	jne	.LBB20_10
.LBB20_15:
	testq	%r14, %r14
	je	.LBB20_17
# %bb.16:
	movq	%r14, %rdi
	movq	%rax, %r14
	callq	_ZdlPv@PLT
	movq	%r14, %rax
.LBB20_17:
	movq	%rax, (%r15)
	leaq	(%rax,%r12,8), %rax
	movq	%rax, 8(%r15)
	movq	%rax, 16(%r15)
	jmp	.LBB20_58
.LBB20_26:
	cmpq	%r14, %rax
	je	.LBB20_51
# %bb.27:
	testb	$8, %r10b
	jne	.LBB20_29
# %bb.28:
	movq	%rdx, %rbx
	movq	%rsi, %rcx
	cmpq	$8, %r10
	jne	.LBB20_34
	jmp	.LBB20_43
.LBB20_29:
	leaq	1(%rsi), %rcx
	leaq	8(%rdx), %rbx
	movzbl	1(%rsi), %r11d
	cmpb	$-2, %r11b
	jg	.LBB20_31
	.p2align	4, 0x90
.LBB20_30:                              # =>This Inner Loop Header: Depth=1
	addq	$8, %rbx
	movzbl	1(%rcx), %r11d
	incq	%rcx
	cmpb	$-1, %r11b
	jl	.LBB20_30
.LBB20_31:
	decq	%r9
	cmpb	$-1, %r11b
	je	.LBB20_32
# %bb.33:
	cmpq	$8, %r10
	je	.LBB20_43
	.p2align	4, 0x90
.LBB20_34:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_35 Depth 2
                                        #     Child Loop BB20_39 Depth 2
	addq	$8, %rbx
	movzbl	1(%rcx), %r10d
	cmpb	$-2, %r10b
	jg	.LBB20_36
	.p2align	4, 0x90
.LBB20_35:                              #   Parent Loop BB20_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rbx
	movzbl	2(%rcx), %r10d
	incq	%rcx
	cmpb	$-1, %r10b
	jl	.LBB20_35
.LBB20_36:                              #   in Loop: Header=BB20_34 Depth=1
	cmpb	$-1, %r10b
	je	.LBB20_37
.LBB20_38:                              #   in Loop: Header=BB20_34 Depth=1
	addq	$8, %rbx
	movzbl	2(%rcx), %r10d
	addq	$2, %rcx
	cmpb	$-2, %r10b
	jg	.LBB20_40
	.p2align	4, 0x90
.LBB20_39:                              #   Parent Loop BB20_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rbx
	movzbl	1(%rcx), %r10d
	incq	%rcx
	cmpb	$-1, %r10b
	jl	.LBB20_39
.LBB20_40:                              #   in Loop: Header=BB20_34 Depth=1
	cmpb	$-1, %r10b
	je	.LBB20_41
# %bb.42:                               #   in Loop: Header=BB20_34 Depth=1
	addq	$-2, %r9
	jne	.LBB20_34
	jmp	.LBB20_43
.LBB20_37:                              #   in Loop: Header=BB20_34 Depth=1
	xorl	%ebx, %ebx
	jmp	.LBB20_38
.LBB20_41:                              #   in Loop: Header=BB20_34 Depth=1
	xorl	%ebx, %ebx
	addq	$-2, %r9
	jne	.LBB20_34
	jmp	.LBB20_43
.LBB20_32:
	xorl	%ebx, %ebx
	cmpq	$8, %r10
	jne	.LBB20_34
.LBB20_43:
	cmpq	%rdx, %rbx
	je	.LBB20_44
	.p2align	4, 0x90
.LBB20_45:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_46 Depth 2
	movq	(%rdx), %r9
	movq	%r9, (%r14)
	addq	$8, %rdx
	movzbl	1(%rsi), %r9d
	incq	%rsi
	cmpb	$-2, %r9b
	jg	.LBB20_47
	.p2align	4, 0x90
.LBB20_46:                              #   Parent Loop BB20_45 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rdx
	movzbl	1(%rsi), %r9d
	incq	%rsi
	cmpb	$-1, %r9b
	jl	.LBB20_46
.LBB20_47:                              #   in Loop: Header=BB20_45 Depth=1
	cmpb	$-1, %r9b
	je	.LBB20_48
# %bb.49:                               #   in Loop: Header=BB20_45 Depth=1
	addq	$8, %r14
	cmpq	%rbx, %rdx
	jne	.LBB20_45
	jmp	.LBB20_50
.LBB20_48:                              #   in Loop: Header=BB20_45 Depth=1
	xorl	%edx, %edx
	addq	$8, %r14
	cmpq	%rbx, %rdx
	jne	.LBB20_45
.LBB20_50:
	movq	%rcx, %rsi
	movq	%rbx, %rdx
	cmpq	%r8, %rdx
	jne	.LBB20_52
	jmp	.LBB20_57
.LBB20_44:
	movq	%rcx, %rsi
	.p2align	4, 0x90
.LBB20_51:
	cmpq	%r8, %rdx
	je	.LBB20_57
.LBB20_52:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB20_53 Depth 2
	movq	(%rdx), %rcx
	movq	%rcx, (%rax)
	addq	$8, %rdx
	movzbl	1(%rsi), %ecx
	incq	%rsi
	cmpb	$-2, %cl
	jg	.LBB20_54
	.p2align	4, 0x90
.LBB20_53:                              #   Parent Loop BB20_52 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rdx
	movzbl	1(%rsi), %ecx
	incq	%rsi
	cmpb	$-1, %cl
	jl	.LBB20_53
.LBB20_54:                              #   in Loop: Header=BB20_52 Depth=1
	cmpb	$-1, %cl
	je	.LBB20_55
.LBB20_56:                              #   in Loop: Header=BB20_52 Depth=1
	addq	$8, %rax
	cmpq	%r8, %rdx
	jne	.LBB20_52
	jmp	.LBB20_57
.LBB20_55:                              #   in Loop: Header=BB20_52 Depth=1
	xorl	%edx, %edx
	jmp	.LBB20_56
.LBB20_57:
	movq	%rax, (%rdi)
.LBB20_58:
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
.LBB20_60:
	.cfi_def_cfa_offset 64
	leaq	.L.str.23(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Lfunc_end20:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag, .Lfunc_end20-_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag # -- Begin function _ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
	.p2align	4, 0x90
	.type	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag: # @_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	cmpq	%rcx, %rdx
	je	.LBB21_46
# %bb.1:
	movq	%rsi, %r14
	movq	%rdi, %r15
	movq	%rcx, %r13
	subq	%rdx, %r13
	movq	%r13, %rax
	sarq	$3, %rax
	movq	8(%rdi), %r12
	movq	16(%rdi), %rsi
	subq	%r12, %rsi
	cmpq	%r13, %rsi
	jae	.LBB21_2
# %bb.27:
	movq	%r14, (%rsp)                    # 8-byte Spill
	movabsq	$1152921504606846975, %rcx      # imm = 0xFFFFFFFFFFFFFFF
	movq	(%r15), %rsi
	movq	%r12, %rdi
	subq	%rsi, %rdi
	sarq	$3, %rdi
	movq	%rcx, %r8
	subq	%rdi, %r8
	cmpq	%rax, %r8
	jb	.LBB21_47
# %bb.28:
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	cmpq	%rax, %rdi
	cmovaq	%rdi, %rax
	leaq	(%rax,%rdi), %r14
	cmpq	%rcx, %r14
	cmovaeq	%rcx, %r14
	addq	%rdi, %rax
	cmovbq	%rcx, %r14
	testq	%r14, %r14
	je	.LBB21_29
# %bb.30:
	leaq	(,%r14,8), %rdi
	movq	%rsi, %rbx
	callq	_Znwm@PLT
	movq	%rbx, %rsi
	movq	%rax, %rbx
	jmp	.LBB21_31
.LBB21_2:
	movq	%r12, %rbx
	subq	%r14, %rbx
	movq	%rbx, %rsi
	sarq	$3, %rsi
	movq	%rax, %rbp
	subq	%rsi, %rbp
	jae	.LBB21_16
# %bb.3:
	movq	%rdx, %rbp
	shlq	$3, %rax
	movq	%r12, %rbx
	subq	%rax, %rbx
	cmpq	$9, %r13
	jl	.LBB21_5
# %bb.4:
	movq	%r12, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB21_7:
	addq	%r13, 8(%r15)
	subq	%r14, %rbx
	movq	%rbx, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jl	.LBB21_9
# %bb.8:
	shlq	$3, %rax
	subq	%rax, %r12
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	memmove@PLT
.LBB21_11:
	cmpq	$9, %r13
	movq	%rbp, %rsi
	jl	.LBB21_14
# %bb.12:
	movq	%r14, %rdi
	movq	%r13, %rdx
	jmp	.LBB21_13
.LBB21_16:
	movq	%rdx, %r13
	leaq	(%rdx,%rbx), %rsi
	subq	%rsi, %rcx
	cmpq	$9, %rcx
	jl	.LBB21_18
# %bb.17:
	movq	%r12, %rdi
	movq	%rcx, %rdx
	callq	memmove@PLT
.LBB21_20:
	shlq	$3, %rbp
	addq	8(%r15), %rbp
	movq	%rbp, 8(%r15)
	cmpq	$9, %rbx
	jl	.LBB21_22
# %bb.21:
	movq	%rbp, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	memmove@PLT
.LBB21_24:
	addq	%rbx, 8(%r15)
	cmpq	$9, %rbx
	movq	%r13, %rsi
	jl	.LBB21_26
# %bb.25:
	movq	%r14, %rdi
	movq	%rbx, %rdx
.LBB21_13:
	addq	$24, %rsp
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
	jmp	memmove@PLT                     # TAILCALL
.LBB21_29:
	.cfi_def_cfa_offset 80
	xorl	%ebx, %ebx
.LBB21_31:
	movq	(%rsp), %rbp                    # 8-byte Reload
	subq	%rsi, %rbp
	cmpq	$9, %rbp
	movq	%rsi, 16(%rsp)                  # 8-byte Spill
	jl	.LBB21_33
# %bb.32:
	movq	%rbx, %rdi
	movq	%rbp, %rdx
	callq	memmove@PLT
	movq	8(%rsp), %rsi                   # 8-byte Reload
.LBB21_35:
	addq	%rbx, %rbp
	cmpq	$9, %r13
	jl	.LBB21_37
# %bb.36:
	movq	%rbp, %rdi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB21_39:
	addq	%r13, %rbp
	movq	(%rsp), %rsi                    # 8-byte Reload
	subq	%rsi, %r12
	cmpq	$9, %r12
	jl	.LBB21_41
# %bb.40:
	movq	%rbp, %rdi
	movq	%r12, %rdx
	callq	memmove@PLT
.LBB21_43:
	addq	%r12, %rbp
	movq	16(%rsp), %rdi                  # 8-byte Reload
	testq	%rdi, %rdi
	je	.LBB21_45
# %bb.44:
	callq	_ZdlPv@PLT
.LBB21_45:
	movq	%rbx, (%r15)
	movq	%rbp, 8(%r15)
	leaq	(%rbx,%r14,8), %rax
	movq	%rax, 16(%r15)
.LBB21_46:
	addq	$24, %rsp
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
.LBB21_33:
	.cfi_def_cfa_offset 80
	cmpq	$8, %rbp
	movq	8(%rsp), %rsi                   # 8-byte Reload
	jne	.LBB21_35
# %bb.34:
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, (%rbx)
	jmp	.LBB21_35
.LBB21_37:
	cmpq	$8, %r13
	jne	.LBB21_39
# %bb.38:
	movq	(%rsi), %rax
	movq	%rax, (%rbp)
	jmp	.LBB21_39
.LBB21_41:
	cmpq	$8, %r12
	jne	.LBB21_43
# %bb.42:
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	(%rax), %rax
	movq	%rax, (%rbp)
	jmp	.LBB21_43
.LBB21_5:
	cmpq	$8, %r13
	jne	.LBB21_7
# %bb.6:
	movq	(%rbx), %rax
	movq	%rax, (%r12)
	jmp	.LBB21_7
.LBB21_9:
	cmpq	$8, %rbx
	jne	.LBB21_11
# %bb.10:
	movq	(%r14), %rax
	movq	%rax, -8(%r12)
	jmp	.LBB21_11
.LBB21_14:
	cmpq	$8, %r13
	jne	.LBB21_46
	jmp	.LBB21_15
.LBB21_18:
	cmpq	$8, %rcx
	jne	.LBB21_20
# %bb.19:
	movq	(%rsi), %rax
	movq	%rax, (%r12)
	jmp	.LBB21_20
.LBB21_22:
	cmpq	$8, %rbx
	jne	.LBB21_24
# %bb.23:
	movq	(%r14), %rax
	movq	%rax, (%rbp)
	jmp	.LBB21_24
.LBB21_26:
	cmpq	$8, %rbx
	jne	.LBB21_46
.LBB21_15:
	movq	(%rsi), %rax
	movq	%rax, (%r14)
	jmp	.LBB21_46
.LBB21_47:
	leaq	.L.str.30(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Lfunc_end21:
	.size	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag, .Lfunc_end21-_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag # -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.p2align	4, 0x90
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag: # @_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movq	%rdx, %r15
	subq	%rsi, %r15
	movq	(%rdi), %r14
	movq	16(%rdi), %rax
	subq	%r14, %rax
	cmpq	%rax, %r15
	jbe	.LBB22_9
# %bb.1:
	movabsq	$9223372036854775801, %rax      # imm = 0x7FFFFFFFFFFFFFF9
	cmpq	%rax, %r15
	jae	.LBB22_26
# %bb.2:
	movq	%rsi, %r13
	movq	%r15, %rdi
	callq	_Znwm@PLT
	movq	%rax, %r12
	cmpq	$9, %r15
	jl	.LBB22_4
# %bb.3:
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB22_6:
	testq	%r14, %r14
	je	.LBB22_8
# %bb.7:
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
.LBB22_8:
	movq	%r12, (%rbx)
	addq	%r15, %r12
	movq	%r12, 8(%rbx)
	movq	%r12, 16(%rbx)
	jmp	.LBB22_25
.LBB22_9:
	movq	%rdx, %r13
	movq	8(%rbx), %r12
	movq	%r12, %rdx
	subq	%r14, %rdx
	cmpq	%r15, %rdx
	jae	.LBB22_10
# %bb.16:
	leaq	(%rsi,%rdx), %r15
	cmpq	$9, %rdx
	jl	.LBB22_18
# %bb.17:
	movq	%r14, %rdi
	callq	memmove@PLT
	movq	8(%rbx), %r12
.LBB22_20:
	subq	%r15, %r13
	cmpq	$9, %r13
	jl	.LBB22_22
# %bb.21:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB22_24:
	addq	%r13, %r12
	movq	%r12, 8(%rbx)
	jmp	.LBB22_25
.LBB22_10:
	cmpq	$9, %r15
	jl	.LBB22_12
# %bb.11:
	movq	%r14, %rdi
	movq	%r15, %rdx
	callq	memmove@PLT
	movq	8(%rbx), %r12
.LBB22_14:
	addq	%r15, %r14
	cmpq	%r14, %r12
	je	.LBB22_25
# %bb.15:
	movq	%r14, 8(%rbx)
.LBB22_25:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB22_4:
	.cfi_def_cfa_offset 48
	cmpq	$8, %r15
	jne	.LBB22_6
# %bb.5:
	movq	(%r13), %rax
	movq	%rax, (%r12)
	jmp	.LBB22_6
.LBB22_18:
	cmpq	$8, %rdx
	jne	.LBB22_20
# %bb.19:
	movq	(%rsi), %rax
	movq	%rax, (%r14)
	jmp	.LBB22_20
.LBB22_22:
	cmpq	$8, %r13
	jne	.LBB22_24
# %bb.23:
	movq	(%r15), %rax
	movq	%rax, (%r12)
	jmp	.LBB22_24
.LBB22_12:
	cmpq	$8, %r15
	jne	.LBB22_14
# %bb.13:
	movq	(%rsi), %rax
	movq	%rax, (%r14)
	jmp	.LBB22_14
.LBB22_26:
	leaq	.L.str.23(%rip), %rdi
	callq	_ZSt20__throw_length_errorPKc@PLT
.Lfunc_end22:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag, .Lfunc_end22-_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,"axG",@progbits,_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,comdat
	.weak	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_ # -- Begin function _ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.p2align	4, 0x90
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,@function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_: # @_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
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
	movq	%rsi, %rbp
	subq	%rdi, %rbp
	sarq	$3, %rbp
	cmpq	$17, %rbp
	jl	.LBB23_38
# %bb.1:
	movq	%rdx, %r14
	movq	%rdi, %rbx
	leaq	8(%rdi), %r12
	movq	$-8, %r13
	subq	%rdi, %r13
	jmp	.LBB23_2
	.p2align	4, 0x90
.LBB23_37:                              #   in Loop: Header=BB23_2 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	sarq	$3, %rbp
	movq	%r15, %rsi
	cmpq	$16, %rbp
	jle	.LBB23_38
.LBB23_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_31 Depth 2
                                        #       Child Loop BB23_32 Depth 3
                                        #       Child Loop BB23_34 Depth 3
	subq	$1, %r14
	jb	.LBB23_3
# %bb.19:                               #   in Loop: Header=BB23_2 Depth=1
	shrq	%rbp
	movsd	8(%rbx), %xmm1                  # xmm1 = mem[0],zero
	movsd	(%rbx,%rbp,8), %xmm2            # xmm2 = mem[0],zero
	ucomisd	%xmm1, %xmm2
	movsd	-8(%rsi), %xmm0                 # xmm0 = mem[0],zero
	jbe	.LBB23_25
# %bb.20:                               #   in Loop: Header=BB23_2 Depth=1
	ucomisd	%xmm2, %xmm0
	jbe	.LBB23_22
# %bb.21:                               #   in Loop: Header=BB23_2 Depth=1
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	movsd	%xmm2, (%rbx)
	movsd	%xmm0, (%rbx,%rbp,8)
	jmp	.LBB23_30
	.p2align	4, 0x90
.LBB23_25:                              #   in Loop: Header=BB23_2 Depth=1
	ucomisd	%xmm1, %xmm0
	jbe	.LBB23_27
# %bb.26:                               #   in Loop: Header=BB23_2 Depth=1
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	movsd	%xmm1, (%rbx)
	movsd	%xmm0, 8(%rbx)
	jmp	.LBB23_30
	.p2align	4, 0x90
.LBB23_22:                              #   in Loop: Header=BB23_2 Depth=1
	ucomisd	%xmm1, %xmm0
	movsd	(%rbx), %xmm2                   # xmm2 = mem[0],zero
	jbe	.LBB23_24
# %bb.23:                               #   in Loop: Header=BB23_2 Depth=1
	movsd	%xmm0, (%rbx)
	movsd	%xmm2, -8(%rsi)
	jmp	.LBB23_30
	.p2align	4, 0x90
.LBB23_27:                              #   in Loop: Header=BB23_2 Depth=1
	ucomisd	%xmm2, %xmm0
	movsd	(%rbx), %xmm1                   # xmm1 = mem[0],zero
	jbe	.LBB23_29
# %bb.28:                               #   in Loop: Header=BB23_2 Depth=1
	movsd	%xmm0, (%rbx)
	movsd	%xmm1, -8(%rsi)
	jmp	.LBB23_30
.LBB23_24:                              #   in Loop: Header=BB23_2 Depth=1
	movsd	%xmm1, (%rbx)
	movsd	%xmm2, 8(%rbx)
	jmp	.LBB23_30
.LBB23_29:                              #   in Loop: Header=BB23_2 Depth=1
	movsd	%xmm2, (%rbx)
	movsd	%xmm1, (%rbx,%rbp,8)
	.p2align	4, 0x90
.LBB23_30:                              #   in Loop: Header=BB23_2 Depth=1
	movq	%r12, %rax
	movq	%rsi, %rcx
	.p2align	4, 0x90
.LBB23_31:                              #   Parent Loop BB23_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB23_32 Depth 3
                                        #       Child Loop BB23_34 Depth 3
	movsd	(%rbx), %xmm0                   # xmm0 = mem[0],zero
	leaq	(%rax,%r13), %rbp
	.p2align	4, 0x90
.LBB23_32:                              #   Parent Loop BB23_2 Depth=1
                                        #     Parent Loop BB23_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movsd	(%rax), %xmm1                   # xmm1 = mem[0],zero
	addq	$8, %rax
	addq	$8, %rbp
	ucomisd	%xmm1, %xmm0
	ja	.LBB23_32
# %bb.33:                               #   in Loop: Header=BB23_31 Depth=2
	leaq	-8(%rax), %r15
	.p2align	4, 0x90
.LBB23_34:                              #   Parent Loop BB23_2 Depth=1
                                        #     Parent Loop BB23_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movsd	-8(%rcx), %xmm2                 # xmm2 = mem[0],zero
	addq	$-8, %rcx
	ucomisd	%xmm0, %xmm2
	ja	.LBB23_34
# %bb.35:                               #   in Loop: Header=BB23_31 Depth=2
	cmpq	%rcx, %r15
	jae	.LBB23_37
# %bb.36:                               #   in Loop: Header=BB23_31 Depth=2
	movsd	%xmm2, (%r15)
	movsd	%xmm1, (%rcx)
	jmp	.LBB23_31
.LBB23_3:
	leaq	7(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%rsi, %r14
	callq	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	jmp	.LBB23_4
	.p2align	4, 0x90
.LBB23_17:                              #   in Loop: Header=BB23_4 Depth=1
	xorl	%ecx, %ecx
.LBB23_18:                              #   in Loop: Header=BB23_4 Depth=1
	movsd	%xmm0, (%rbx,%rcx,8)
	cmpq	$8, %rax
	jle	.LBB23_38
.LBB23_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_7 Depth 2
                                        #     Child Loop BB23_15 Depth 2
	movsd	-8(%r14), %xmm0                 # xmm0 = mem[0],zero
	movsd	(%rbx), %xmm1                   # xmm1 = mem[0],zero
	movsd	%xmm1, -8(%r14)
	addq	$-8, %r14
	movq	%r14, %rax
	subq	%rbx, %rax
	movq	%rax, %rdx
	sarq	$3, %rdx
	cmpq	$3, %rdx
	jl	.LBB23_5
# %bb.6:                                #   in Loop: Header=BB23_4 Depth=1
	leaq	-1(%rdx), %rcx
	shrq	$63, %rcx
	leaq	(%rdx,%rcx), %rsi
	decq	%rsi
	sarq	%rsi
	xorl	%edi, %edi
	jmp	.LBB23_7
	.p2align	4, 0x90
.LBB23_9:                               #   in Loop: Header=BB23_7 Depth=2
	leaq	2(,%rdi,2), %rcx
.LBB23_10:                              #   in Loop: Header=BB23_7 Depth=2
	movsd	(%rbx,%rcx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rbx,%rdi,8)
	movq	%rcx, %rdi
	cmpq	%rsi, %rcx
	jge	.LBB23_11
.LBB23_7:                               #   Parent Loop BB23_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rdi,%rdi), %rcx
	movsd	8(%rbx,%rcx,8), %xmm1           # xmm1 = mem[0],zero
	ucomisd	16(%rbx,%rcx,8), %xmm1
	jbe	.LBB23_9
# %bb.8:                                #   in Loop: Header=BB23_7 Depth=2
	leaq	1(,%rdi,2), %rcx
	jmp	.LBB23_10
	.p2align	4, 0x90
.LBB23_5:                               #   in Loop: Header=BB23_4 Depth=1
	xorl	%ecx, %ecx
.LBB23_11:                              #   in Loop: Header=BB23_4 Depth=1
	testb	$8, %al
	jne	.LBB23_14
# %bb.12:                               #   in Loop: Header=BB23_4 Depth=1
	addq	$-2, %rdx
	sarq	%rdx
	cmpq	%rdx, %rcx
	jne	.LBB23_14
# %bb.13:                               #   in Loop: Header=BB23_4 Depth=1
	leaq	(%rcx,%rcx), %rdx
	movsd	8(%rbx,%rdx,8), %xmm1           # xmm1 = mem[0],zero
	movsd	%xmm1, (%rbx,%rcx,8)
	leaq	1(,%rcx,2), %rcx
.LBB23_14:                              #   in Loop: Header=BB23_4 Depth=1
	testq	%rcx, %rcx
	jle	.LBB23_18
	.p2align	4, 0x90
.LBB23_15:                              #   Parent Loop BB23_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rcx), %rdx
	movq	%rdx, %rsi
	shrq	%rsi
	movsd	(%rbx,%rsi,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB23_18
# %bb.16:                               #   in Loop: Header=BB23_15 Depth=2
	movsd	%xmm1, (%rbx,%rcx,8)
	movq	%rsi, %rcx
	cmpq	$1, %rdx
	ja	.LBB23_15
	jmp	.LBB23_17
.LBB23_38:
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
.Lfunc_end23:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_, .Lfunc_end23-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,"axG",@progbits,_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,comdat
	.weak	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_ # -- Begin function _ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.p2align	4, 0x90
	.type	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,@function
_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_: # @_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rax
	subq	%rdi, %rax
	cmpq	$129, %rax
	jl	.LBB24_2
# %bb.1:
	leaq	8(%r14), %r15
	movl	$8, %r12d
	movq	%r15, %r13
	movq	%r14, %rbp
	jmp	.LBB24_18
.LBB24_2:
	cmpq	%rbx, %r14
	je	.LBB24_30
# %bb.3:
	leaq	8(%r14), %rax
	cmpq	%rbx, %rax
	je	.LBB24_30
# %bb.4:
	movq	%r14, %r15
	jmp	.LBB24_9
	.p2align	4, 0x90
.LBB24_5:                               #   in Loop: Header=BB24_9 Depth=1
	movq	%r15, %rdx
	subq	%r14, %rdx
	movq	%rdx, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jl	.LBB24_13
# %bb.6:                                #   in Loop: Header=BB24_9 Depth=1
	shlq	$3, %rax
	subq	%rax, %rdi
	addq	$16, %rdi
	movq	%r14, %rsi
	movsd	%xmm1, (%rsp)                   # 8-byte Spill
	callq	memmove@PLT
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
.LBB24_7:                               #   in Loop: Header=BB24_9 Depth=1
	movq	%r14, %rax
.LBB24_8:                               #   in Loop: Header=BB24_9 Depth=1
	movsd	%xmm1, (%rax)
	leaq	8(%r15), %rax
	cmpq	%rbx, %rax
	je	.LBB24_30
.LBB24_9:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_12 Depth 2
	movq	%r15, %rdi
	movq	%rax, %r15
	movsd	8(%rdi), %xmm1                  # xmm1 = mem[0],zero
	movsd	(%r14), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	ja	.LBB24_5
# %bb.10:                               #   in Loop: Header=BB24_9 Depth=1
	movsd	(%rdi), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	movq	%r15, %rax
	jbe	.LBB24_8
# %bb.11:                               #   in Loop: Header=BB24_9 Depth=1
	movq	%r15, %rax
	.p2align	4, 0x90
.LBB24_12:                              #   Parent Loop BB24_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movsd	%xmm0, (%rax)
	movsd	-16(%rax), %xmm0                # xmm0 = mem[0],zero
	addq	$-8, %rax
	ucomisd	%xmm1, %xmm0
	ja	.LBB24_12
	jmp	.LBB24_8
.LBB24_13:                              #   in Loop: Header=BB24_9 Depth=1
	movq	%r14, %rax
	cmpq	$8, %rdx
	jne	.LBB24_8
# %bb.14:                               #   in Loop: Header=BB24_9 Depth=1
	movsd	%xmm0, 8(%rdi)
	jmp	.LBB24_7
.LBB24_15:                              #   in Loop: Header=BB24_18 Depth=1
	movsd	%xmm0, 8(%rax)
	.p2align	4, 0x90
.LBB24_16:                              #   in Loop: Header=BB24_18 Depth=1
	movq	%r14, %rax
.LBB24_17:                              #   in Loop: Header=BB24_18 Depth=1
	movsd	%xmm1, (%rax)
	addq	$8, %r12
	addq	$8, %r13
	cmpq	$128, %r12
	je	.LBB24_24
.LBB24_18:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_23 Depth 2
	movq	%rbp, %rax
	leaq	(%r14,%r12), %rbp
	movsd	(%r14,%r12), %xmm1              # xmm1 = mem[0],zero
	movsd	(%r14), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB24_21
# %bb.19:                               #   in Loop: Header=BB24_18 Depth=1
	cmpq	$9, %r12
	jb	.LBB24_15
# %bb.20:                               #   in Loop: Header=BB24_18 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%r12, %rdx
	movsd	%xmm1, (%rsp)                   # 8-byte Spill
	callq	memmove@PLT
	movsd	(%rsp), %xmm1                   # 8-byte Reload
                                        # xmm1 = mem[0],zero
	jmp	.LBB24_16
	.p2align	4, 0x90
.LBB24_21:                              #   in Loop: Header=BB24_18 Depth=1
	movsd	(%rax), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	movq	%rbp, %rax
	jbe	.LBB24_17
# %bb.22:                               #   in Loop: Header=BB24_18 Depth=1
	movq	%r13, %rax
	.p2align	4, 0x90
.LBB24_23:                              #   Parent Loop BB24_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movsd	%xmm0, (%rax)
	movsd	-16(%rax), %xmm0                # xmm0 = mem[0],zero
	addq	$-8, %rax
	ucomisd	%xmm1, %xmm0
	ja	.LBB24_23
	jmp	.LBB24_17
.LBB24_24:
	subq	$-128, %r14
	jmp	.LBB24_26
	.p2align	4, 0x90
.LBB24_25:                              #   in Loop: Header=BB24_26 Depth=1
	movsd	%xmm0, (%rax)
	addq	$8, %r14
.LBB24_26:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB24_29 Depth 2
	cmpq	%rbx, %r14
	je	.LBB24_30
# %bb.27:                               #   in Loop: Header=BB24_26 Depth=1
	movsd	-8(%r14), %xmm1                 # xmm1 = mem[0],zero
	movsd	(%r14), %xmm0                   # xmm0 = mem[0],zero
	ucomisd	%xmm0, %xmm1
	movq	%r14, %rax
	jbe	.LBB24_25
# %bb.28:                               #   in Loop: Header=BB24_26 Depth=1
	movq	%r14, %rax
	.p2align	4, 0x90
.LBB24_29:                              #   Parent Loop BB24_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movsd	%xmm1, (%rax)
	movsd	-16(%rax), %xmm1                # xmm1 = mem[0],zero
	addq	$-8, %rax
	ucomisd	%xmm0, %xmm1
	ja	.LBB24_29
	jmp	.LBB24_25
.LBB24_30:
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
.Lfunc_end24:
	.size	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_, .Lfunc_end24-_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,"axG",@progbits,_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,comdat
	.weak	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_ # -- Begin function _ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.p2align	4, 0x90
	.type	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,@function
_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_: # @_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_startproc
# %bb.0:
	subq	%rdi, %rsi
	movq	%rsi, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jge	.LBB25_2
.LBB25_1:
	retq
.LBB25_2:
	leaq	-2(%rax), %rdx
	movq	%rdx, %rcx
	shrq	%rcx
	decq	%rax
	shrq	%rax
	testb	$8, %sil
	jne	.LBB25_20
# %bb.3:
	orq	$1, %rdx
	movq	%rcx, %rsi
	jmp	.LBB25_6
	.p2align	4, 0x90
.LBB25_4:                               #   in Loop: Header=BB25_6 Depth=1
	movq	%r8, %r9
.LBB25_5:                               #   in Loop: Header=BB25_6 Depth=1
	movsd	%xmm0, (%rdi,%r9,8)
	subq	$1, %rsi
	jb	.LBB25_1
.LBB25_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB25_10 Depth 2
                                        #     Child Loop BB25_15 Depth 2
	movsd	(%rdi,%rsi,8), %xmm0            # xmm0 = mem[0],zero
	movq	%rsi, %r8
	cmpq	%rsi, %rax
	jle	.LBB25_12
# %bb.7:                                #   in Loop: Header=BB25_6 Depth=1
	movq	%rsi, %r9
	jmp	.LBB25_10
	.p2align	4, 0x90
.LBB25_8:                               #   in Loop: Header=BB25_10 Depth=2
	leaq	2(,%r9,2), %r8
.LBB25_9:                               #   in Loop: Header=BB25_10 Depth=2
	movsd	(%rdi,%r8,8), %xmm1             # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%r9,8)
	movq	%r8, %r9
	cmpq	%rax, %r8
	jge	.LBB25_12
.LBB25_10:                              #   Parent Loop BB25_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%r9,%r9), %r8
	movsd	8(%rdi,%r8,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	16(%rdi,%r8,8), %xmm1
	jbe	.LBB25_8
# %bb.11:                               #   in Loop: Header=BB25_10 Depth=2
	leaq	1(,%r9,2), %r8
	jmp	.LBB25_9
	.p2align	4, 0x90
.LBB25_12:                              #   in Loop: Header=BB25_6 Depth=1
	cmpq	%rcx, %r8
	jne	.LBB25_14
# %bb.13:                               #   in Loop: Header=BB25_6 Depth=1
	movsd	(%rdi,%rdx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%rcx,8)
	movq	%rdx, %r8
.LBB25_14:                              #   in Loop: Header=BB25_6 Depth=1
	cmpq	%rsi, %r8
	jle	.LBB25_4
	.p2align	4, 0x90
.LBB25_15:                              #   Parent Loop BB25_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%r8), %r9
	shrq	$63, %r9
	addq	%r8, %r9
	decq	%r9
	sarq	%r9
	movsd	(%rdi,%r9,8), %xmm1             # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB25_4
# %bb.16:                               #   in Loop: Header=BB25_15 Depth=2
	movsd	%xmm1, (%rdi,%r8,8)
	movq	%r9, %r8
	cmpq	%rsi, %r9
	jg	.LBB25_15
	jmp	.LBB25_5
	.p2align	4, 0x90
.LBB25_18:                              #   in Loop: Header=BB25_20 Depth=1
	movq	%rdx, %rsi
.LBB25_19:                              #   in Loop: Header=BB25_20 Depth=1
	movsd	%xmm0, (%rdi,%rsi,8)
	subq	$1, %rcx
	jb	.LBB25_1
.LBB25_20:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB25_24 Depth 2
                                        #     Child Loop BB25_27 Depth 2
	movsd	(%rdi,%rcx,8), %xmm0            # xmm0 = mem[0],zero
	movq	%rcx, %rsi
	cmpq	%rcx, %rax
	jle	.LBB25_19
# %bb.21:                               #   in Loop: Header=BB25_20 Depth=1
	movq	%rcx, %rsi
	jmp	.LBB25_24
	.p2align	4, 0x90
.LBB25_22:                              #   in Loop: Header=BB25_24 Depth=2
	leaq	2(,%rsi,2), %rdx
.LBB25_23:                              #   in Loop: Header=BB25_24 Depth=2
	movsd	(%rdi,%rdx,8), %xmm1            # xmm1 = mem[0],zero
	movsd	%xmm1, (%rdi,%rsi,8)
	movq	%rdx, %rsi
	cmpq	%rax, %rdx
	jge	.LBB25_26
.LBB25_24:                              #   Parent Loop BB25_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rsi,%rsi), %rdx
	movsd	8(%rdi,%rdx,8), %xmm1           # xmm1 = mem[0],zero
	ucomisd	16(%rdi,%rdx,8), %xmm1
	jbe	.LBB25_22
# %bb.25:                               #   in Loop: Header=BB25_24 Depth=2
	leaq	1(,%rsi,2), %rdx
	jmp	.LBB25_23
	.p2align	4, 0x90
.LBB25_26:                              #   in Loop: Header=BB25_20 Depth=1
	cmpq	%rcx, %rdx
	jle	.LBB25_18
	.p2align	4, 0x90
.LBB25_27:                              #   Parent Loop BB25_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	-1(%rdx), %rsi
	shrq	$63, %rsi
	addq	%rdx, %rsi
	decq	%rsi
	sarq	%rsi
	movsd	(%rdi,%rsi,8), %xmm1            # xmm1 = mem[0],zero
	ucomisd	%xmm1, %xmm0
	jbe	.LBB25_18
# %bb.28:                               #   in Loop: Header=BB25_27 Depth=2
	movsd	%xmm1, (%rdi,%rdx,8)
	movq	%rsi, %rdx
	cmpq	%rcx, %rsi
	jg	.LBB25_27
	jmp	.LBB25_19
.Lfunc_end25:
	.size	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_, .Lfunc_end25-_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
.LCPI26_0:
	.long	1127219200                      # 0x43300000
	.long	1160773632                      # 0x45300000
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI26_1:
	.quad	0x4330000000000000              # double 4503599627370496
	.quad	0x4530000000000000              # double 1.9342813113834067E+25
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI26_2:
	.quad	0x43e0000000000000              # double 9.2233720368547758E+18
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	.p2align	4, 0x90
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm: # @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception2
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r14
	movq	%rdi, %rbx
	leaq	32(%rdi), %r15
	movq	40(%rdi), %r12
	movq	24(%rdi), %rax
	incq	%rax
	movq	%rax, %xmm1
	punpckldq	.LCPI26_0(%rip), %xmm1  # xmm1 = xmm1[0],mem[0],xmm1[1],mem[1]
	subpd	.LCPI26_1(%rip), %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm0                    # xmm0 = xmm0[1],xmm1[1]
	addsd	%xmm1, %xmm0
	movss	32(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm1, %xmm1
	divsd	%xmm1, %xmm0
	callq	ceil@PLT
	cvttsd2si	%xmm0, %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	subsd	.LCPI26_2(%rip), %xmm0
	cvttsd2si	%xmm0, %rsi
	andq	%rcx, %rsi
	orq	%rax, %rsi
	cmpq	%r14, %rsi
	cmovbeq	%r14, %rsi
	movq	%r15, %rdi
	callq	_ZNKSt8__detail20_Prime_rehash_policy11_M_next_bktEm@PLT
	cmpq	8(%rbx), %rax
	jne	.LBB26_1
# %bb.7:
	movq	%r12, 40(%rbx)
	jmp	.LBB26_8
.LBB26_1:
.Ltmp240:
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
.Ltmp241:
.LBB26_8:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB26_5:
	.cfi_def_cfa_offset 48
.Ltmp242:
	movq	%rax, %rdi
	callq	__cxa_begin_catch@PLT
	movq	%r12, 40(%rbx)
.Ltmp243:
	callq	__cxa_rethrow@PLT
.Ltmp244:
# %bb.6:
.LBB26_2:
.Ltmp245:
	movq	%rax, %rbx
.Ltmp246:
	callq	__cxa_end_catch@PLT
.Ltmp247:
# %bb.3:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB26_4:
.Ltmp248:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end26:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm, .Lfunc_end26-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,comdat
	.p2align	2, 0x0
GCC_except_table26:
.Lexception2:
	.byte	255                             # @LPStart Encoding = omit
	.byte	155                             # @TType Encoding = indirect pcrel sdata4
	.uleb128 .Lttbase1-.Lttbaseref1
.Lttbaseref1:
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Lfunc_begin2-.Lfunc_begin2    # >> Call Site 1 <<
	.uleb128 .Ltmp240-.Lfunc_begin2         #   Call between .Lfunc_begin2 and .Ltmp240
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp240-.Lfunc_begin2         # >> Call Site 2 <<
	.uleb128 .Ltmp241-.Ltmp240              #   Call between .Ltmp240 and .Ltmp241
	.uleb128 .Ltmp242-.Lfunc_begin2         #     jumps to .Ltmp242
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp241-.Lfunc_begin2         # >> Call Site 3 <<
	.uleb128 .Ltmp243-.Ltmp241              #   Call between .Ltmp241 and .Ltmp243
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp243-.Lfunc_begin2         # >> Call Site 4 <<
	.uleb128 .Ltmp244-.Ltmp243              #   Call between .Ltmp243 and .Ltmp244
	.uleb128 .Ltmp245-.Lfunc_begin2         #     jumps to .Ltmp245
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp246-.Lfunc_begin2         # >> Call Site 5 <<
	.uleb128 .Ltmp247-.Ltmp246              #   Call between .Ltmp246 and .Ltmp247
	.uleb128 .Ltmp248-.Lfunc_begin2         #     jumps to .Ltmp248
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp247-.Lfunc_begin2         # >> Call Site 6 <<
	.uleb128 .Lfunc_end26-.Ltmp247          #   Call between .Ltmp247 and .Lfunc_end26
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end2:
	.byte	1                               # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                               #   No further actions
	.p2align	2, 0x0
                                        # >> Catch TypeInfos <<
	.long	0                               # TypeInfo 1
.Lttbase1:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE # -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.p2align	4, 0x90
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE: # @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %rbx
	movq	%rdi, %r14
	cmpq	$1, %rsi
	je	.LBB27_1
# %bb.2:
	movq	%rbx, %rax
	shrq	$60, %rax
	jne	.LBB27_3
# %bb.5:
	leaq	(,%rbx,8), %r12
	movq	%r12, %rdi
	callq	_Znwm@PLT
	movq	%rax, %r15
	movq	%rax, %rdi
	xorl	%esi, %esi
	movq	%r12, %rdx
	callq	memset@PLT
	movq	16(%r14), %rsi
	movq	$0, 16(%r14)
	testq	%rsi, %rsi
	je	.LBB27_17
.LBB27_7:
	leaq	16(%r14), %rcx
	xorl	%r8d, %r8d
	jmp	.LBB27_8
	.p2align	4, 0x90
.LBB27_14:                              #   in Loop: Header=BB27_8 Depth=1
	movq	(%rax), %rax
	movq	%rax, (%rsi)
	movq	(%r15,%rdx,8), %rax
	movq	%r8, %rdx
.LBB27_15:                              #   in Loop: Header=BB27_8 Depth=1
	movq	%rsi, (%rax)
.LBB27_16:                              #   in Loop: Header=BB27_8 Depth=1
	movq	%rdi, %rsi
	movq	%rdx, %r8
	testq	%rdi, %rdi
	je	.LBB27_17
.LBB27_8:                               # =>This Inner Loop Header: Depth=1
	movq	(%rsi), %rdi
	movq	8(%rsi), %rax
	movq	%rax, %rdx
	orq	%rbx, %rdx
	shrq	$32, %rdx
	je	.LBB27_9
# %bb.10:                               #   in Loop: Header=BB27_8 Depth=1
	xorl	%edx, %edx
	divq	%rbx
	movq	(%r15,%rdx,8), %rax
	testq	%rax, %rax
	jne	.LBB27_14
	jmp	.LBB27_12
	.p2align	4, 0x90
.LBB27_9:                               #   in Loop: Header=BB27_8 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%ebx
                                        # kill: def $edx killed $edx def $rdx
	movq	(%r15,%rdx,8), %rax
	testq	%rax, %rax
	jne	.LBB27_14
.LBB27_12:                              #   in Loop: Header=BB27_8 Depth=1
	movq	(%rcx), %rax
	movq	%rax, (%rsi)
	movq	%rsi, (%rcx)
	movq	%rcx, (%r15,%rdx,8)
	cmpq	$0, (%rsi)
	je	.LBB27_16
# %bb.13:                               #   in Loop: Header=BB27_8 Depth=1
	leaq	(%r15,%r8,8), %rax
	jmp	.LBB27_15
.LBB27_1:
	leaq	48(%r14), %r15
	movq	$0, 48(%r14)
	movq	16(%r14), %rsi
	movq	$0, 16(%r14)
	testq	%rsi, %rsi
	jne	.LBB27_7
.LBB27_17:
	movq	(%r14), %rdi
	leaq	48(%r14), %rax
	cmpq	%rdi, %rax
	je	.LBB27_19
# %bb.18:
	callq	_ZdlPv@PLT
.LBB27_19:
	movq	%rbx, 8(%r14)
	movq	%r15, (%r14)
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB27_3:
	.cfi_def_cfa_offset 48
	shrq	$61, %rbx
	je	.LBB27_4
# %bb.20:
	callq	_ZSt28__throw_bad_array_new_lengthv@PLT
.LBB27_4:
	callq	_ZSt17__throw_bad_allocv@PLT
.Lfunc_end27:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE, .Lfunc_end27-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_ # -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	.p2align	4, 0x90
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_: # @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
.Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception3
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	cmpq	$0, 24(%rdi)
	je	.LBB28_3
# %bb.1:
	movq	(%rsi), %rbx
	movq	8(%rdi), %r8
	movq	%rbx, %rax
	orq	%r8, %rax
	shrq	$32, %rax
	je	.LBB28_7
# %bb.2:
	movq	%rbx, %rax
	xorl	%edx, %edx
	divq	%r8
	movq	%rdx, %r14
	movq	(%rdi), %rax
	movq	(%rax,%r14,8), %rax
	testq	%rax, %rax
	jne	.LBB28_8
	jmp	.LBB28_16
.LBB28_3:
	leaq	16(%rdi), %rcx
	movq	(%rsi), %rbx
	.p2align	4, 0x90
.LBB28_4:                               # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB28_17
# %bb.5:                                #   in Loop: Header=BB28_4 Depth=1
	cmpq	8(%rcx), %rbx
	jne	.LBB28_4
	jmp	.LBB28_9
.LBB28_7:
	movl	%ebx, %eax
	xorl	%edx, %edx
	divl	%r8d
	movl	%edx, %r14d
	movq	(%rdi), %rax
	movq	(%rax,%r14,8), %rax
	testq	%rax, %rax
	je	.LBB28_16
.LBB28_8:
	movq	(%rax), %rcx
	cmpq	8(%rcx), %rbx
	jne	.LBB28_10
.LBB28_9:
	xorl	%edx, %edx
	jmp	.LBB28_22
	.p2align	4, 0x90
.LBB28_13:                              #   in Loop: Header=BB28_10 Depth=1
	movl	%esi, %eax
	xorl	%edx, %edx
	divl	%r8d
                                        # kill: def $edx killed $edx def $rdx
	cmpq	%r14, %rdx
	jne	.LBB28_16
.LBB28_14:                              #   in Loop: Header=BB28_10 Depth=1
	cmpq	%rsi, %rbx
	je	.LBB28_9
.LBB28_10:                              # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB28_16
# %bb.11:                               #   in Loop: Header=BB28_10 Depth=1
	movq	8(%rcx), %rsi
	movq	%rsi, %rax
	orq	%r8, %rax
	shrq	$32, %rax
	je	.LBB28_13
# %bb.12:                               #   in Loop: Header=BB28_10 Depth=1
	movq	%rsi, %rax
	xorl	%edx, %edx
	divq	%r8
	cmpq	%r14, %rdx
	je	.LBB28_14
.LBB28_16:
	movq	%rdi, %r15
	jmp	.LBB28_20
.LBB28_17:
	movq	%rdi, %r15
	movq	8(%rdi), %rcx
	movq	%rbx, %rax
	orq	%rcx, %rax
	shrq	$32, %rax
	je	.LBB28_19
# %bb.18:
	movq	%rbx, %rax
	xorl	%edx, %edx
	divq	%rcx
	movq	%rdx, %r14
	jmp	.LBB28_20
.LBB28_19:
	movl	%ebx, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%edx, %r14d
.LBB28_20:
	movl	$16, %edi
	callq	_Znwm@PLT
	movq	%rax, %r12
	movq	$0, (%rax)
	movq	%rbx, 8(%rax)
.Ltmp249:
	movl	$1, %r8d
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%rax, %rcx
	callq	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
.Ltmp250:
# %bb.21:
	movq	%rax, %rcx
	movb	$1, %dl
.LBB28_22:
	movq	%rcx, %rax
                                        # kill: def $dl killed $dl killed $edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB28_23:
	.cfi_def_cfa_offset 48
.Ltmp251:
	movq	%rax, %rbx
	movq	%r12, %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end28:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_, .Lfunc_end28-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,comdat
	.p2align	2, 0x0
GCC_except_table28:
.Lexception3:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end3-.Lcst_begin3
.Lcst_begin3:
	.uleb128 .Lfunc_begin3-.Lfunc_begin3    # >> Call Site 1 <<
	.uleb128 .Ltmp249-.Lfunc_begin3         #   Call between .Lfunc_begin3 and .Ltmp249
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp249-.Lfunc_begin3         # >> Call Site 2 <<
	.uleb128 .Ltmp250-.Ltmp249              #   Call between .Ltmp249 and .Ltmp250
	.uleb128 .Ltmp251-.Lfunc_begin3         #     jumps to .Ltmp251
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp250-.Lfunc_begin3         # >> Call Site 3 <<
	.uleb128 .Lfunc_end28-.Ltmp250          #   Call between .Ltmp250 and .Lfunc_end28
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end3:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm # -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
	.p2align	4, 0x90
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm: # @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
.Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception4
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rcx, %r14
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %rbx
	addq	$32, %rdi
	movq	40(%rbx), %r13
	movq	8(%rbx), %rsi
	movq	24(%rbx), %rdx
	movq	%r8, %rcx
	callq	_ZNKSt8__detail20_Prime_rehash_policy14_M_need_rehashEmmm@PLT
	testb	$1, %al
	je	.LBB29_10
# %bb.1:
.Ltmp252:
	movq	%rbx, %rdi
	movq	%rdx, %rsi
	callq	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
.Ltmp253:
# %bb.2:
	movq	8(%rbx), %rcx
	movq	%r12, %rax
	orq	%rcx, %rax
	shrq	$32, %rax
	je	.LBB29_3
# %bb.9:
	movq	%r12, %rax
	xorl	%edx, %edx
	divq	%rcx
	movq	%rdx, %r15
.LBB29_10:
	movq	(%rbx), %rcx
	movq	(%rcx,%r15,8), %rax
	testq	%rax, %rax
	je	.LBB29_12
.LBB29_11:
	movq	(%rax), %rax
	movq	%rax, (%r14)
	movq	(%rcx,%r15,8), %rax
	movq	%r14, (%rax)
	jmp	.LBB29_18
.LBB29_3:
	movl	%r12d, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%edx, %r15d
	movq	(%rbx), %rcx
	movq	(%rcx,%r15,8), %rax
	testq	%rax, %rax
	jne	.LBB29_11
.LBB29_12:
	leaq	16(%rbx), %rsi
	movq	16(%rbx), %rax
	movq	%rax, (%r14)
	movq	%r14, 16(%rbx)
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB29_17
# %bb.13:
	movq	8(%rbx), %rdi
	movq	8(%rax), %rax
	movq	%rax, %rdx
	orq	%rdi, %rdx
	shrq	$32, %rdx
	je	.LBB29_14
# %bb.15:
	xorl	%edx, %edx
	divq	%rdi
	jmp	.LBB29_16
.LBB29_14:
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%edi
                                        # kill: def $edx killed $edx def $rdx
.LBB29_16:
	movq	%r14, (%rcx,%rdx,8)
	movq	(%rbx), %rcx
.LBB29_17:
	movq	%rsi, (%rcx,%r15,8)
.LBB29_18:
	incq	24(%rbx)
	movq	%r14, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB29_7:
	.cfi_def_cfa_offset 48
.Ltmp254:
	movq	%rax, %rdi
	callq	__cxa_begin_catch@PLT
	movq	%r13, 40(%rbx)
.Ltmp255:
	callq	__cxa_rethrow@PLT
.Ltmp256:
# %bb.8:
.LBB29_4:
.Ltmp257:
	movq	%rax, %rbx
.Ltmp258:
	callq	__cxa_end_catch@PLT
.Ltmp259:
# %bb.5:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB29_6:
.Ltmp260:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end29:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm, .Lfunc_end29-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,comdat
	.p2align	2, 0x0
GCC_except_table29:
.Lexception4:
	.byte	255                             # @LPStart Encoding = omit
	.byte	155                             # @TType Encoding = indirect pcrel sdata4
	.uleb128 .Lttbase2-.Lttbaseref2
.Lttbaseref2:
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end4-.Lcst_begin4
.Lcst_begin4:
	.uleb128 .Lfunc_begin4-.Lfunc_begin4    # >> Call Site 1 <<
	.uleb128 .Ltmp252-.Lfunc_begin4         #   Call between .Lfunc_begin4 and .Ltmp252
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp252-.Lfunc_begin4         # >> Call Site 2 <<
	.uleb128 .Ltmp253-.Ltmp252              #   Call between .Ltmp252 and .Ltmp253
	.uleb128 .Ltmp254-.Lfunc_begin4         #     jumps to .Ltmp254
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp253-.Lfunc_begin4         # >> Call Site 3 <<
	.uleb128 .Ltmp255-.Ltmp253              #   Call between .Ltmp253 and .Ltmp255
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp255-.Lfunc_begin4         # >> Call Site 4 <<
	.uleb128 .Ltmp256-.Ltmp255              #   Call between .Ltmp255 and .Ltmp256
	.uleb128 .Ltmp257-.Lfunc_begin4         #     jumps to .Ltmp257
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp258-.Lfunc_begin4         # >> Call Site 5 <<
	.uleb128 .Ltmp259-.Ltmp258              #   Call between .Ltmp258 and .Ltmp259
	.uleb128 .Ltmp260-.Lfunc_begin4         #     jumps to .Ltmp260
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp259-.Lfunc_begin4         # >> Call Site 6 <<
	.uleb128 .Lfunc_end29-.Ltmp259          #   Call between .Ltmp259 and .Lfunc_end29
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end4:
	.byte	1                               # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                               #   No further actions
	.p2align	2, 0x0
                                        # >> Catch TypeInfos <<
	.long	0                               # TypeInfo 1
.Lttbase2:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,"axG",@progbits,_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,comdat
	.weak	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm # -- Begin function _ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.p2align	4, 0x90
	.type	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,@function
_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm: # @_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.cfi_startproc
# %bb.0:
	movq	%rdx, %rax
	xorq	(%rsi), %rax
	movabsq	$8779197792823184629, %rcx      # imm = 0x79D5F9E0DE1E8CF5
	mulq	%rcx
	xorq	%rdx, %rax
	retq
.Lfunc_end30:
	.size	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm, .Lfunc_end30-_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.cfi_endproc
                                        # -- End function
	.section	.text._ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,"axG",@progbits,_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,comdat
	.weak	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m # -- Begin function _ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.p2align	4, 0x90
	.type	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,@function
_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m: # @_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.cfi_startproc
# %bb.0:
	movq	%rsi, %rdi
	leaq	(,%rcx,8), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdx
	jmp	memcpy@PLT                      # TAILCALL
.Lfunc_end31:
	.size	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m, .Lfunc_end31-_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function _ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
.LCPI32_0:
	.zero	16,128
	.section	.text._ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,"axG",@progbits,_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,comdat
	.weak	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.p2align	4, 0x90
	.type	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,@function
_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE: # @_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, %r11
	movq	%rdx, %r14
	movzbl	(%rdi), %ecx
	movq	$-1, %r13
	shlq	%cl, %r13
	movq	8(%rdi), %r15
	movq	%r15, %r10
	subq	%r13, %r10
	notq	%r13
	movq	%r13, %rcx
	shrq	%rcx
	addq	$15, %r10
	movq	%rcx, %rbp
	andq	$-16, %rbp
	xorl	%ebx, %ebx
	movaps	.LCPI32_0(%rip), %xmm1          # xmm1 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	jmp	.LBB32_1
	.p2align	4, 0x90
.LBB32_2:                               #   in Loop: Header=BB32_1 Depth=1
	addq	$16, %rbx
	movq	24(%rsp), %rcx                  # 8-byte Reload
	cmpq	%rcx, %rbx
	jae	.LBB32_3
.LBB32_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB32_4 Depth 2
	movdqu	(%rsi,%rbx), %xmm0
	leaq	(%r15,%rbx), %rax
	movups	%xmm1, (%r15,%rbx)
	movups	%xmm1, 1(%rcx,%rax)
	pmovmskb	%xmm0, %r12d
	#APP
	#NO_APP
	xorl	$65535, %r12d                   # imm = 0xFFFF
	jne	.LBB32_4
	jmp	.LBB32_2
.LBB32_6:                               #   in Loop: Header=BB32_4 Depth=2
	movq	%r10, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	andq	%rdx, %rcx
	cmpq	%r9, %rcx
	jae	.LBB32_11
# %bb.7:                                #   in Loop: Header=BB32_4 Depth=2
	movq	%rdx, %rcx
	andq	%r13, %rcx
	movdqu	(%r15,%rcx), %xmm0
	pmovmskb	%xmm0, %r10d
	#APP
	#NO_APP
	testl	%r10d, %r10d
	je	.LBB32_11
# %bb.8:                                #   in Loop: Header=BB32_4 Depth=2
	rep		bsfl	%r10d, %edx
	addq	%rdx, %rcx
	movq	16(%rsp), %r10                  # 8-byte Reload
	jmp	.LBB32_9
.LBB32_11:                              #   in Loop: Header=BB32_4 Depth=2
	movzbl	%al, %eax
	movq	%rdi, 48(%rsp)                  # 8-byte Spill
	movq	%r11, %rdi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movl	%eax, %esi
	movq	%rdx, %rcx
	movq	%r9, %rdx
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	movq	%r11, 32(%rsp)                  # 8-byte Spill
	callq	*8(%rsp)                        # 8-byte Folded Reload
	movaps	.LCPI32_0(%rip), %xmm1          # xmm1 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	movq	32(%rsp), %r11                  # 8-byte Reload
	movq	48(%rsp), %rdi                  # 8-byte Reload
	movq	40(%rsp), %rsi                  # 8-byte Reload
	movq	8(%rsp), %r8                    # 8-byte Reload
	movq	16(%rsp), %r10                  # 8-byte Reload
	jmp	.LBB32_10
	.p2align	4, 0x90
.LBB32_4:                               #   Parent Loop BB32_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	rep		bsfl	%r12d, %r9d
	addq	%rbx, %r9
	movq	(%rdi), %rax
	andl	$1984, %eax                     # imm = 0x7C0
	xorq	(%r14,%r9,8), %rax
	movabsq	$8779197792823184629, %rcx      # imm = 0x79D5F9E0DE1E8CF5
	mulq	%rcx
	xorq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$57, %rax
	movq	%r9, %rcx
	subq	%rdx, %rcx
	testq	%rcx, %rbp
	jne	.LBB32_6
# %bb.5:                                #   in Loop: Header=BB32_4 Depth=2
	andl	$15, %ecx
	addq	%rdx, %rcx
	andq	%r13, %rcx
.LBB32_9:                               #   in Loop: Header=BB32_4 Depth=2
	movb	%al, (%r15,%rcx)
	movq	(%r14,%r9,8), %rax
	movq	%rax, (%r10,%rcx,8)
.LBB32_10:                              #   in Loop: Header=BB32_4 Depth=2
	leal	-1(%r12), %eax
	andl	%r12d, %eax
	movl	%eax, %r12d
	jne	.LBB32_4
	jmp	.LBB32_2
.LBB32_3:
	addq	$56, %rsp
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
.Lfunc_end32:
	.size	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE, .Lfunc_end32-_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.cfi_endproc
                                        # -- End function
	.section	.text._ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,"axG",@progbits,_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,comdat
	.weak	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE # -- Begin function _ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.p2align	4, 0x90
	.type	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,@function
_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE: # @_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.cfi_startproc
# %bb.0:
	movq	%rsi, %rax
	movq	8(%rdi), %rcx
	xorq	(%rcx), %rax
	movabsq	$8779197792823184629, %rcx      # imm = 0x79D5F9E0DE1E8CF5
	mulq	%rcx
	xorq	%rdx, %rax
	retq
.Lfunc_end33:
	.size	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE, .Lfunc_end33-_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"axG",@progbits,_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.weak	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_ # -- Begin function _ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.p2align	4, 0x90
	.type	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,@function
_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_: # @_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
.Lfunc_begin5:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception5
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	cmpq	%rsi, %rdi
	je	.LBB34_17
# %bb.1:
	cmpq	%rdx, %rsi
	je	.LBB34_17
# %bb.2:
	movq	%rsi, %rbx
	subq	%rdi, %rbx
	sarq	$3, %rbx
	movq	%rdx, %r14
	subq	%rsi, %r14
	sarq	$3, %r14
	cmpq	%rbx, %r14
	movq	%rbx, %r13
	cmovlq	%r14, %r13
	testq	%r13, %r13
	jle	.LBB34_3
# %bb.4:
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	%rsi, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	_ZSt7nothrow@GOTPCREL(%rip), %r12
	movq	%r13, %rbp
	.p2align	4, 0x90
.LBB34_5:                               # =>This Inner Loop Header: Depth=1
	leaq	(,%rbp,8), %rdi
	movq	%r12, %rsi
	callq	_ZnwmRKSt9nothrow_t@PLT
	testq	%rax, %rax
	jne	.LBB34_6
# %bb.7:                                #   in Loop: Header=BB34_5 Depth=1
	leaq	1(%rbp), %rax
	shrq	%rax
	cmpq	$1, %rbp
	movq	%rax, %rbp
	ja	.LBB34_5
# %bb.8:
	xorl	%r15d, %r15d
	xorl	%ebp, %ebp
	jmp	.LBB34_9
.LBB34_17:
	addq	$40, %rsp
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
.LBB34_3:
	.cfi_def_cfa_offset 96
	xorl	%r15d, %r15d
	xorl	%ebp, %ebp
	jmp	.LBB34_10
.LBB34_6:
	movq	%rax, %r15
.LBB34_9:
	movq	16(%rsp), %rdx                  # 8-byte Reload
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	32(%rsp), %rdi                  # 8-byte Reload
.LBB34_10:
	cmpq	%r13, %rbp
	jne	.LBB34_13
# %bb.11:
.Ltmp265:
	movq	%rbx, %rcx
	movq	%r14, %r8
	movq	%r15, %r9
	callq	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
.Ltmp266:
.LBB34_16:
	movq	%r15, %rdi
	addq	$40, %rsp
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
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB34_13:
	.cfi_def_cfa_offset 96
	testq	%r15, %r15
	je	.LBB34_14
# %bb.15:
.Ltmp261:
	movq	%rbp, (%rsp)
	movq	%rbx, %rcx
	movq	%r14, %r8
	movq	%r15, %r9
	callq	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
.Ltmp262:
	jmp	.LBB34_16
.LBB34_14:
.Ltmp263:
	movq	%rbx, %rcx
	movq	%r14, %r8
	callq	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
.Ltmp264:
	jmp	.LBB34_16
.LBB34_12:
.Ltmp267:
	movq	%rax, %rbx
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end34:
	.size	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_, .Lfunc_end34-_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_endproc
	.section	.gcc_except_table._ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"aG",@progbits,_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.p2align	2, 0x0
GCC_except_table34:
.Lexception5:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end5-.Lcst_begin5
.Lcst_begin5:
	.uleb128 .Ltmp265-.Lfunc_begin5         # >> Call Site 1 <<
	.uleb128 .Ltmp264-.Ltmp265              #   Call between .Ltmp265 and .Ltmp264
	.uleb128 .Ltmp267-.Lfunc_begin5         #     jumps to .Ltmp267
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp264-.Lfunc_begin5         # >> Call Site 2 <<
	.uleb128 .Lfunc_end34-.Ltmp264          #   Call between .Ltmp264 and .Lfunc_end34
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end5:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,"axG",@progbits,_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,comdat
	.weak	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_ # -- Begin function _ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.p2align	4, 0x90
	.type	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,@function
_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_: # @_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%r9, %rbx
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %r14
	cmpq	%r8, %rcx
	jle	.LBB35_1
# %bb.16:
	movq	%r12, %r13
	subq	%r15, %r13
	cmpq	$9, %r13
	jl	.LBB35_18
# %bb.17:
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB35_20:
	cmpq	%r15, %r14
	je	.LBB35_21
# %bb.25:
	cmpq	%r15, %r12
	je	.LBB35_9
# %bb.26:
	addq	%rbx, %r13
	addq	$-8, %r13
.LBB35_27:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB35_28 Depth 2
	movq	%r13, %rsi
	movq	%r12, %rax
	addq	$-8, %r15
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB35_28:                              #   Parent Loop BB35_27 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leaq	(%rsi,%rcx), %r13
	movq	(%rsi,%rcx), %rdx
	movq	(%r15), %rdi
	cmpq	%rdi, %rdx
	jb	.LBB35_29
# %bb.34:                               #   in Loop: Header=BB35_28 Depth=2
	movq	%rdx, -8(%rax,%rcx)
	cmpq	%rbx, %r13
	je	.LBB35_9
# %bb.35:                               #   in Loop: Header=BB35_28 Depth=2
	addq	$-8, %rcx
	jmp	.LBB35_28
.LBB35_29:                              #   in Loop: Header=BB35_27 Depth=1
	leaq	(%rax,%rcx), %r12
	addq	$-8, %r12
	movq	%rdi, -8(%rax,%rcx)
	cmpq	%r14, %r15
	jne	.LBB35_27
# %bb.30:
	subq	%rbx, %rsi
	leaq	(%rsi,%rcx), %rdx
	addq	$8, %rdx
	movq	%rdx, %rdi
	sarq	$3, %rdi
	cmpq	$2, %rdi
	jl	.LBB35_32
# %bb.31:
	shlq	$3, %rdi
	subq	%rdi, %rax
	leaq	(%rax,%rcx), %rdi
	addq	$-8, %rdi
	movq	%rbx, %rsi
	jmp	.LBB35_13
.LBB35_1:
	movq	%r15, %r13
	subq	%r14, %r13
	cmpq	$9, %r13
	jl	.LBB35_3
# %bb.2:
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB35_5:
	cmpq	%r14, %r15
	je	.LBB35_9
# %bb.6:
	addq	%rbx, %r13
	.p2align	4, 0x90
.LBB35_7:                               # =>This Inner Loop Header: Depth=1
	cmpq	%r12, %r15
	je	.LBB35_10
# %bb.8:                                #   in Loop: Header=BB35_7 Depth=1
	movq	(%r15), %rax
	movq	(%rbx), %rcx
	xorl	%edx, %edx
	xorl	%esi, %esi
	cmpq	%rcx, %rax
	setae	%dl
	setb	%sil
	cmovbq	%rax, %rcx
	leaq	(%r15,%rsi,8), %r15
	leaq	(%rbx,%rdx,8), %rbx
	movq	%rcx, (%r14)
	addq	$8, %r14
	cmpq	%r13, %rbx
	jne	.LBB35_7
.LBB35_9:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB35_21:
	.cfi_def_cfa_offset 48
	movq	%r13, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jl	.LBB35_23
# %bb.22:
	shlq	$3, %rax
	subq	%rax, %r12
	movq	%r12, %rdi
	jmp	.LBB35_12
.LBB35_10:
	subq	%rbx, %r13
	cmpq	$9, %r13
	jl	.LBB35_14
# %bb.11:
	movq	%r14, %rdi
.LBB35_12:
	movq	%rbx, %rsi
	movq	%r13, %rdx
.LBB35_13:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	memmove@PLT                     # TAILCALL
.LBB35_18:
	.cfi_def_cfa_offset 48
	cmpq	$8, %r13
	jne	.LBB35_20
# %bb.19:
	movq	(%r15), %rax
	movq	%rax, (%rbx)
	jmp	.LBB35_20
.LBB35_3:
	cmpq	$8, %r13
	jne	.LBB35_5
# %bb.4:
	movq	(%r14), %rax
	movq	%rax, (%rbx)
	jmp	.LBB35_5
.LBB35_23:
	cmpq	$8, %r13
	jne	.LBB35_9
# %bb.24:
	movq	(%rbx), %rax
	movq	%rax, -8(%r12)
	jmp	.LBB35_9
.LBB35_14:
	cmpq	$8, %r13
	jne	.LBB35_9
# %bb.15:
	movq	(%rbx), %rax
	movq	%rax, (%r14)
	jmp	.LBB35_9
.LBB35_32:
	addq	%rcx, %rsi
	jne	.LBB35_9
# %bb.33:
	movq	(%rbx), %rdx
	movq	%rdx, -16(%rax,%rcx)
	jmp	.LBB35_9
.Lfunc_end35:
	.size	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_, .Lfunc_end35-_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,"axG",@progbits,_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,comdat
	.weak	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_ # -- Begin function _ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	.p2align	4, 0x90
	.type	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,@function
_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_: # @_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, (%rsp)                    # 8-byte Spill
	testq	%rcx, %rcx
	je	.LBB36_21
# %bb.1:
	testq	%r8, %r8
	je	.LBB36_21
# %bb.2:
	movq	%rdi, %r15
	.p2align	4, 0x90
.LBB36_3:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_16 Depth 2
                                        #     Child Loop BB36_10 Depth 2
	leaq	(%r8,%rcx), %rax
	cmpq	$2, %rax
	je	.LBB36_4
# %bb.6:                                #   in Loop: Header=BB36_3 Depth=1
	cmpq	%r8, %rcx
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	jle	.LBB36_13
# %bb.7:                                #   in Loop: Header=BB36_3 Depth=1
	movq	%rcx, %r14
	shrq	$63, %r14
	addq	%rcx, %r14
	sarq	%r14
	leaq	(%r15,%r14,8), %r12
	movq	(%rsp), %rcx                    # 8-byte Reload
	subq	%rsi, %rcx
	sarq	$3, %rcx
	testq	%rcx, %rcx
	jle	.LBB36_8
# %bb.9:                                #   in Loop: Header=BB36_3 Depth=1
	movq	(%r12), %rax
	movq	%rsi, %r13
	.p2align	4, 0x90
.LBB36_10:                              #   Parent Loop BB36_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r13, %rdx
	movq	%rcx, %rdi
	shrq	%rdi
	movq	%rdi, %r8
	notq	%r8
	addq	%rcx, %r8
	cmpq	%rax, (%r13,%rdi,8)
	leaq	8(%r13,%rdi,8), %r13
	cmovaeq	%rdx, %r13
	cmovaeq	%rdi, %r8
	movq	%r8, %rcx
	testq	%r8, %r8
	jg	.LBB36_10
# %bb.11:                               #   in Loop: Header=BB36_3 Depth=1
	movq	%r13, %rbp
	jmp	.LBB36_12
	.p2align	4, 0x90
.LBB36_13:                              #   in Loop: Header=BB36_3 Depth=1
	movq	%r8, %rbp
	shrq	$63, %rbp
	addq	%r8, %rbp
	sarq	%rbp
	leaq	(%rsi,%rbp,8), %r13
	movq	%rsi, %rcx
	subq	%r15, %rcx
	sarq	$3, %rcx
	testq	%rcx, %rcx
	jle	.LBB36_14
# %bb.15:                               #   in Loop: Header=BB36_3 Depth=1
	movq	(%r13), %rax
	movq	%r15, %r12
	.p2align	4, 0x90
.LBB36_16:                              #   Parent Loop BB36_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r12, %rdx
	movq	%rcx, %rdi
	shrq	%rdi
	movq	%rdi, %r8
	notq	%r8
	addq	%rcx, %r8
	cmpq	(%r12,%rdi,8), %rax
	leaq	8(%r12,%rdi,8), %r12
	cmovbq	%rdx, %r12
	cmovbq	%rdi, %r8
	movq	%r8, %rcx
	testq	%r8, %r8
	jg	.LBB36_16
# %bb.17:                               #   in Loop: Header=BB36_3 Depth=1
	movq	%r12, %r14
	jmp	.LBB36_18
.LBB36_8:                               #   in Loop: Header=BB36_3 Depth=1
	movq	%rsi, %rbp
	movq	%rsi, %r13
.LBB36_12:                              #   in Loop: Header=BB36_3 Depth=1
	subq	%rsi, %rbp
	sarq	$3, %rbp
	jmp	.LBB36_19
.LBB36_14:                              #   in Loop: Header=BB36_3 Depth=1
	movq	%r15, %r14
	movq	%r15, %r12
.LBB36_18:                              #   in Loop: Header=BB36_3 Depth=1
	subq	%r15, %r14
	sarq	$3, %r14
.LBB36_19:                              #   in Loop: Header=BB36_3 Depth=1
	movq	%r12, %rdi
	movq	%r13, %rdx
	callq	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	movq	%rax, %rbx
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rax, %rdx
	movq	%r14, %rcx
	movq	%rbp, %r8
	callq	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	movq	8(%rsp), %rcx                   # 8-byte Reload
	subq	%r14, %rcx
	movq	16(%rsp), %r8                   # 8-byte Reload
	je	.LBB36_21
# %bb.20:                               #   in Loop: Header=BB36_3 Depth=1
	movq	%r13, %rsi
	movq	%rbx, %r15
	subq	%rbp, %r8
	jne	.LBB36_3
	jmp	.LBB36_21
.LBB36_4:
	movq	(%rsi), %rax
	movq	(%r15), %rcx
	cmpq	%rcx, %rax
	jae	.LBB36_21
# %bb.5:
	movq	%rax, (%r15)
	movq	%rcx, (%rsi)
.LBB36_21:
	addq	$24, %rsp
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
.Lfunc_end36:
	.size	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_, .Lfunc_end36-_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,"axG",@progbits,_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,comdat
	.weak	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_ # -- Begin function _ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	.p2align	4, 0x90
	.type	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,@function
_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_: # @_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	112(%rsp), %r12
	cmpq	%r12, %rcx
	jle	.LBB37_1
# %bb.2:
	cmpq	%r12, %r8
	jle	.LBB37_1
# %bb.3:
	movq	24(%rsp), %rbx                  # 8-byte Reload
	.p2align	4, 0x90
.LBB37_4:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB37_14 Depth 2
                                        #     Child Loop BB37_8 Depth 2
	cmpq	%r8, %rcx
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	jle	.LBB37_11
# %bb.5:                                #   in Loop: Header=BB37_4 Depth=1
	movq	%rcx, %r15
	shrq	$63, %r15
	addq	%rcx, %r15
	sarq	%r15
	leaq	(%rdi,%r15,8), %r13
	movq	16(%rsp), %r9                   # 8-byte Reload
	subq	%rsi, %r9
	sarq	$3, %r9
	testq	%r9, %r9
	jle	.LBB37_6
# %bb.7:                                #   in Loop: Header=BB37_4 Depth=1
	movq	(%r13), %rax
	movq	%rsi, %rbp
	.p2align	4, 0x90
.LBB37_8:                               #   Parent Loop BB37_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdx
	movq	%r9, %r11
	shrq	%r11
	movq	%r11, %r8
	notq	%r8
	addq	%r9, %r8
	cmpq	%rax, (%rbp,%r11,8)
	leaq	8(%rbp,%r11,8), %rbp
	cmovaeq	%rdx, %rbp
	cmovaeq	%r11, %r8
	movq	%r8, %r9
	testq	%r8, %r8
	jg	.LBB37_8
# %bb.9:                                #   in Loop: Header=BB37_4 Depth=1
	movq	%rbp, %r14
	jmp	.LBB37_10
	.p2align	4, 0x90
.LBB37_11:                              #   in Loop: Header=BB37_4 Depth=1
	movq	%r8, %r14
	shrq	$63, %r14
	addq	%r8, %r14
	sarq	%r14
	leaq	(%rsi,%r14,8), %rbp
	movq	%rsi, %r9
	subq	%rdi, %r9
	sarq	$3, %r9
	testq	%r9, %r9
	jle	.LBB37_12
# %bb.13:                               #   in Loop: Header=BB37_4 Depth=1
	movq	(%rbp), %rax
	movq	%rdi, %r13
	.p2align	4, 0x90
.LBB37_14:                              #   Parent Loop BB37_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r13, %rdx
	movq	%r9, %r11
	shrq	%r11
	movq	%r11, %r8
	notq	%r8
	addq	%r9, %r8
	cmpq	(%r13,%r11,8), %rax
	leaq	8(%r13,%r11,8), %r13
	cmovbq	%rdx, %r13
	cmovbq	%r11, %r8
	movq	%r8, %r9
	testq	%r8, %r8
	jg	.LBB37_14
# %bb.15:                               #   in Loop: Header=BB37_4 Depth=1
	movq	%r13, %r15
	jmp	.LBB37_16
.LBB37_6:                               #   in Loop: Header=BB37_4 Depth=1
	movq	%rsi, %r14
	movq	%rsi, %rbp
.LBB37_10:                              #   in Loop: Header=BB37_4 Depth=1
	subq	%rsi, %r14
	sarq	$3, %r14
	jmp	.LBB37_17
.LBB37_12:                              #   in Loop: Header=BB37_4 Depth=1
	movq	%rdi, %r15
	movq	%rdi, %r13
.LBB37_16:                              #   in Loop: Header=BB37_4 Depth=1
	subq	%rdi, %r15
	sarq	$3, %r15
.LBB37_17:                              #   in Loop: Header=BB37_4 Depth=1
	subq	%r15, %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	%r12, (%rsp)
	movq	%r13, %rdi
	movq	%rbp, %rdx
	movq	%r14, %r8
	movq	%rbx, %r9
	callq	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	movq	%r12, (%rsp)
	movq	32(%rsp), %rdi                  # 8-byte Reload
	movq	%r13, %rsi
	movq	%rax, %r13
	movq	%rax, %rdx
	movq	%r15, %rcx
	movq	%r14, %r8
	movq	%rbx, %r9
	callq	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	movq	40(%rsp), %rcx                  # 8-byte Reload
	movq	48(%rsp), %r8                   # 8-byte Reload
	subq	%r14, %r8
	cmpq	%r12, %rcx
	jle	.LBB37_19
# %bb.18:                               #   in Loop: Header=BB37_4 Depth=1
	movq	%rbp, %rsi
	movq	%r13, %rdi
	cmpq	%r12, %r8
	jg	.LBB37_4
	jmp	.LBB37_19
.LBB37_1:
	movq	%rdi, %r13
	movq	%rsi, %rbp
.LBB37_19:
	movq	%r13, %rdi
	movq	%rbp, %rsi
	movq	16(%rsp), %rdx                  # 8-byte Reload
	movq	24(%rsp), %r9                   # 8-byte Reload
	addq	$56, %rsp
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
	jmp	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_ # TAILCALL
.Lfunc_end37:
	.size	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_, .Lfunc_end37-_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,"axG",@progbits,_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,comdat
	.weak	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag # -- Begin function _ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.p2align	4, 0x90
	.type	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,@function
_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag: # @_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rax
	cmpq	%rsi, %rdi
	je	.LBB38_9
# %bb.1:
	movq	%rax, %rbx
	subq	%rsi, %rbx
	je	.LBB38_10
# %bb.2:
	subq	%rdi, %rax
	sarq	$3, %rax
	movq	%rsi, %rdx
	subq	%rdi, %rdx
	movq	%rdx, %rcx
	sarq	$2, %rcx
	cmpq	%rcx, %rax
	jne	.LBB38_12
# %bb.3:
	addq	$-8, %rdx
	cmpq	$120, %rdx
	jb	.LBB38_6
# %bb.4:
	movq	%rdx, %rax
	andq	$-8, %rax
	leaq	(%rsi,%rax), %rcx
	addq	$8, %rcx
	cmpq	%rdi, %rcx
	jbe	.LBB38_62
# %bb.5:
	addq	%rdi, %rax
	addq	$8, %rax
	cmpq	%rsi, %rax
	jbe	.LBB38_62
.LBB38_6:
	movq	%rsi, %rax
	movq	%rdi, %rcx
	.p2align	4, 0x90
.LBB38_7:                               # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rdx
	movq	(%rax), %rdi
	movq	%rdi, (%rcx)
	movq	%rdx, (%rax)
	addq	$8, %rcx
	addq	$8, %rax
	cmpq	%rsi, %rcx
	jne	.LBB38_7
.LBB38_8:
	movq	%rsi, %rbx
	jmp	.LBB38_11
.LBB38_9:
	movq	%rax, %rbx
	jmp	.LBB38_11
.LBB38_10:
	movq	%rdi, %rbx
.LBB38_11:
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB38_12:
	.cfi_def_cfa_offset 48
	sarq	$3, %rdx
	movabsq	$9223372036854775804, %rsi      # imm = 0x7FFFFFFFFFFFFFFC
	addq	%rdi, %rbx
	jmp	.LBB38_14
.LBB38_36:                              #   in Loop: Header=BB38_14 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%r8d
	movl	%edx, %eax
	testq	%rax, %rax
	je	.LBB38_11
.LBB38_37:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%r8, %rdx
	subq	%rax, %rdx
	movq	%rcx, %rdi
	movq	%r8, %rax
.LBB38_14:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB38_53 Depth 2
                                        #     Child Loop BB38_30 Depth 2
                                        #     Child Loop BB38_46 Depth 2
                                        #     Child Loop BB38_50 Depth 2
                                        #     Child Loop BB38_22 Depth 2
	movq	%rdx, %r8
	movq	%rax, %r9
	subq	%rdx, %r9
	cmpq	%r9, %rdx
	jge	.LBB38_24
# %bb.15:                               #   in Loop: Header=BB38_14 Depth=1
	cmpq	$1, %r8
	je	.LBB38_60
# %bb.16:                               #   in Loop: Header=BB38_14 Depth=1
	testq	%r9, %r9
	jle	.LBB38_32
# %bb.17:                               #   in Loop: Header=BB38_14 Depth=1
	leaq	(%rdi,%r8,8), %rdx
	cmpq	$6, %r9
	jb	.LBB38_20
# %bb.18:                               #   in Loop: Header=BB38_14 Depth=1
	leaq	(%rdi,%rax,8), %rcx
	cmpq	%rcx, %rdi
	jae	.LBB38_49
# %bb.19:                               #   in Loop: Header=BB38_14 Depth=1
	movq	%rax, %rcx
	subq	%r8, %rcx
	leaq	(%rdi,%rcx,8), %rcx
	cmpq	%rcx, %rdx
	jae	.LBB38_49
.LBB38_20:                              #   in Loop: Header=BB38_14 Depth=1
	xorl	%r10d, %r10d
	movq	%rdi, %rcx
.LBB38_21:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%rax, %rdi
	subq	%r10, %rdi
	subq	%r8, %rdi
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB38_22:                              #   Parent Loop BB38_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rcx,%r10,8), %r11
	movq	(%rdx,%r10,8), %r14
	movq	%r14, (%rcx,%r10,8)
	movq	%r11, (%rdx,%r10,8)
	incq	%r10
	addq	$-8, %r9
	cmpq	%r10, %rdi
	jne	.LBB38_22
# %bb.23:                               #   in Loop: Header=BB38_14 Depth=1
	subq	%r9, %rcx
	jmp	.LBB38_33
	.p2align	4, 0x90
.LBB38_24:                              #   in Loop: Header=BB38_14 Depth=1
	leaq	(%rdi,%rax,8), %rcx
	cmpq	$1, %r9
	je	.LBB38_58
# %bb.25:                               #   in Loop: Header=BB38_14 Depth=1
	leaq	(,%r9,8), %r10
	movq	%rcx, %rdx
	subq	%r10, %rdx
	testq	%r8, %r8
	jle	.LBB38_35
# %bb.26:                               #   in Loop: Header=BB38_14 Depth=1
	cmpq	$30, %r8
	jae	.LBB38_38
.LBB38_27:                              #   in Loop: Header=BB38_14 Depth=1
	xorl	%r10d, %r10d
.LBB38_28:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%r8, %r11
	andq	$3, %r11
	je	.LBB38_44
# %bb.29:                               #   in Loop: Header=BB38_14 Depth=1
	negq	%r11
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB38_30:                              #   Parent Loop BB38_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rdx), %r15
	movq	-8(%rcx), %r12
	movq	%r12, -8(%rdx)
	addq	$-8, %rdx
	movq	%r15, -8(%rcx)
	addq	$-8, %rcx
	decq	%r14
	cmpq	%r14, %r11
	jne	.LBB38_30
# %bb.31:                               #   in Loop: Header=BB38_14 Depth=1
	movq	%r10, %r11
	subq	%r14, %r11
	subq	%r8, %r10
	cmpq	$-4, %r10
	jbe	.LBB38_45
	jmp	.LBB38_47
.LBB38_32:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%rdi, %rcx
.LBB38_33:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%rax, %rdx
	orq	%r8, %rdx
	shrq	$32, %rdx
	je	.LBB38_36
# %bb.34:                               #   in Loop: Header=BB38_14 Depth=1
	cqto
	idivq	%r8
	movq	%rdx, %rax
	testq	%rax, %rax
	jne	.LBB38_37
	jmp	.LBB38_11
.LBB38_35:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%rdx, %rdi
	jmp	.LBB38_47
.LBB38_38:                              #   in Loop: Header=BB38_14 Depth=1
	leaq	(%rdi,%r8,8), %r11
	addq	$-8, %r11
	leaq	-8(,%r8,8), %r10
	movq	%r11, %r14
	subq	%r10, %r14
	cmpq	%r11, %r14
	ja	.LBB38_27
# %bb.39:                               #   in Loop: Header=BB38_14 Depth=1
	leaq	(%rdi,%rax,8), %r11
	addq	$-8, %r11
	movq	%r11, %r14
	subq	%r10, %r14
	cmpq	%r11, %r14
	ja	.LBB38_27
# %bb.40:                               #   in Loop: Header=BB38_14 Depth=1
	leaq	-1(%r8), %r10
	shrq	$61, %r10
	jne	.LBB38_27
# %bb.41:                               #   in Loop: Header=BB38_14 Depth=1
	cmpq	%rcx, %rdi
	jae	.LBB38_52
# %bb.42:                               #   in Loop: Header=BB38_14 Depth=1
	movq	%rax, %r10
	subq	%r8, %r10
	leaq	(%rdi,%r10,8), %r10
	cmpq	%rdx, %r10
	jb	.LBB38_27
.LBB38_52:                              #   in Loop: Header=BB38_14 Depth=1
	leaq	(,%r8,8), %r11
	leaq	(,%rax,8), %r14
	movq	%r8, %r10
	andq	%rsi, %r10
	leaq	(,%r10,8), %r15
	subq	%r15, %rcx
	subq	%r15, %rdx
	addq	%rdi, %r11
	addq	$-16, %r11
	addq	%rdi, %r14
	addq	$-16, %r14
	movq	%r10, %r15
	negq	%r15
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB38_53:                              #   Parent Loop BB38_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-16(%r11,%r12,8), %xmm0
	movups	(%r11,%r12,8), %xmm1
	movups	-16(%r14,%r12,8), %xmm2
	movups	(%r14,%r12,8), %xmm3
	movups	%xmm3, (%r11,%r12,8)
	movups	%xmm2, -16(%r11,%r12,8)
	movups	%xmm1, (%r14,%r12,8)
	movups	%xmm0, -16(%r14,%r12,8)
	addq	$-4, %r12
	cmpq	%r12, %r15
	jne	.LBB38_53
# %bb.54:                               #   in Loop: Header=BB38_14 Depth=1
	cmpq	%r10, %r8
	jne	.LBB38_28
	jmp	.LBB38_47
.LBB38_44:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%r10, %r11
	subq	%r8, %r10
	cmpq	$-4, %r10
	ja	.LBB38_47
.LBB38_45:                              #   in Loop: Header=BB38_14 Depth=1
	subq	%r8, %r11
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB38_46:                              #   Parent Loop BB38_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rdx,%r8,8), %r10
	movq	-8(%rcx,%r8,8), %r14
	movq	%r14, -8(%rdx,%r8,8)
	movq	%r10, -8(%rcx,%r8,8)
	movq	-16(%rdx,%r8,8), %r10
	movq	-16(%rcx,%r8,8), %r14
	movq	%r14, -16(%rdx,%r8,8)
	movq	%r10, -16(%rcx,%r8,8)
	movq	-24(%rdx,%r8,8), %r10
	movq	-24(%rcx,%r8,8), %r14
	movq	%r14, -24(%rdx,%r8,8)
	movq	%r10, -24(%rcx,%r8,8)
	movq	-32(%rdx,%r8,8), %r10
	movq	-32(%rcx,%r8,8), %r14
	movq	%r14, -32(%rdx,%r8,8)
	movq	%r10, -32(%rcx,%r8,8)
	addq	$-4, %r8
	cmpq	%r8, %r11
	jne	.LBB38_46
.LBB38_47:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%rax, %rcx
	orq	%r9, %rcx
	shrq	$32, %rcx
	je	.LBB38_13
# %bb.48:                               #   in Loop: Header=BB38_14 Depth=1
	cqto
	idivq	%r9
	movq	%r9, %rax
	testq	%rdx, %rdx
	jne	.LBB38_14
	jmp	.LBB38_11
.LBB38_13:                              #   in Loop: Header=BB38_14 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%r9d
                                        # kill: def $edx killed $edx def $rdx
	movq	%r9, %rax
	testq	%rdx, %rdx
	jne	.LBB38_14
	jmp	.LBB38_11
.LBB38_49:                              #   in Loop: Header=BB38_14 Depth=1
	movq	%r9, %r10
	andq	%rsi, %r10
	leaq	(%rdi,%r10,8), %rcx
	leaq	(%rdx,%r10,8), %rdx
	leaq	(%rdi,%r8,8), %r11
	addq	$16, %r11
	addq	$16, %rdi
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB38_50:                              #   Parent Loop BB38_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movups	-16(%rdi,%r14,8), %xmm0
	movups	(%rdi,%r14,8), %xmm1
	movups	-16(%r11,%r14,8), %xmm2
	movups	(%r11,%r14,8), %xmm3
	movups	%xmm2, -16(%rdi,%r14,8)
	movups	%xmm3, (%rdi,%r14,8)
	movups	%xmm0, -16(%r11,%r14,8)
	movups	%xmm1, (%r11,%r14,8)
	addq	$4, %r14
	cmpq	%r14, %r10
	jne	.LBB38_50
# %bb.51:                               #   in Loop: Header=BB38_14 Depth=1
	cmpq	%r10, %r9
	jne	.LBB38_21
	jmp	.LBB38_33
.LBB38_58:
	leaq	-8(%rcx), %rax
	movq	-8(%rcx), %r15
	movq	%rax, %rdx
	movq	%rdi, %r14
	subq	%rdi, %rdx
	movq	%rdx, %rsi
	sarq	$3, %rsi
	cmpq	$2, %rsi
	jl	.LBB38_66
# %bb.59:
	shlq	$3, %rsi
	subq	%rsi, %rcx
	movq	%rcx, %rdi
	movq	%r14, %rsi
	callq	memmove@PLT
	movq	%r15, (%r14)
	jmp	.LBB38_11
.LBB38_60:
	movq	(%rdi), %r14
	leaq	-8(,%rax,8), %rdx
	movq	%rax, %r15
	cmpq	$3, %rax
	jl	.LBB38_69
# %bb.61:
	leaq	8(%rdi), %rsi
	movq	%rdi, %r12
	callq	memmove@PLT
	movq	%r14, -8(%r12,%r15,8)
	jmp	.LBB38_11
.LBB38_62:
	shrq	$3, %rdx
	incq	%rdx
	movq	%rdx, %r8
	andq	$-4, %r8
	leaq	(%rsi,%r8,8), %rax
	leaq	(%rdi,%r8,8), %rcx
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB38_63:                              # =>This Inner Loop Header: Depth=1
	movups	(%rdi,%r9,8), %xmm0
	movups	16(%rdi,%r9,8), %xmm1
	movups	(%rsi,%r9,8), %xmm2
	movups	16(%rsi,%r9,8), %xmm3
	movups	%xmm2, (%rdi,%r9,8)
	movups	%xmm3, 16(%rdi,%r9,8)
	movups	%xmm0, (%rsi,%r9,8)
	movups	%xmm1, 16(%rsi,%r9,8)
	addq	$4, %r9
	cmpq	%r9, %r8
	jne	.LBB38_63
# %bb.64:
	cmpq	%r8, %rdx
	jne	.LBB38_7
	jmp	.LBB38_8
.LBB38_66:
	cmpq	$8, %rdx
	jne	.LBB38_68
# %bb.67:
	movq	(%r14), %rcx
	movq	%rcx, (%rax)
.LBB38_68:
	movq	%r15, (%r14)
	jmp	.LBB38_11
.LBB38_69:
	movq	%rdi, %r12
	cmpq	$8, %rdx
	jne	.LBB38_71
# %bb.70:
	movq	%r12, %rax
	movq	8(%r12), %rcx
	movq	%rcx, (%r12)
.LBB38_71:
	movq	%r14, -8(%r12,%r15,8)
	jmp	.LBB38_11
.Lfunc_end38:
	.size	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag, .Lfunc_end38-_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,"axG",@progbits,_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,comdat
	.weak	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_ # -- Begin function _ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.p2align	4, 0x90
	.type	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,@function
_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_: # @_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%r9, %rbx
	movq	%rdx, %r14
	movq	%rsi, %r12
	movq	%rdi, %r15
	movq	48(%rsp), %rax
	cmpq	%r8, %rcx
	jle	.LBB39_16
# %bb.1:
	cmpq	%rax, %r8
	jg	.LBB39_16
# %bb.2:
	testq	%r8, %r8
	je	.LBB39_32
# %bb.3:
	movq	%r14, %r13
	subq	%r12, %r13
	cmpq	$9, %r13
	jl	.LBB39_5
# %bb.4:
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB39_7:
	subq	%r15, %r12
	movq	%r12, %rax
	sarq	$3, %rax
	cmpq	$2, %rax
	jl	.LBB39_9
# %bb.8:
	shlq	$3, %rax
	subq	%rax, %r14
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memmove@PLT
.LBB39_11:
	cmpq	$9, %r13
	jl	.LBB39_13
# %bb.12:
	movq	%r15, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
	addq	%r13, %r15
	jmp	.LBB39_32
.LBB39_16:
	cmpq	%rax, %rcx
	jle	.LBB39_17
# %bb.33:
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag # TAILCALL
.LBB39_17:
	.cfi_def_cfa_offset 48
	testq	%rcx, %rcx
	je	.LBB39_31
# %bb.18:
	movq	%r12, %r13
	subq	%r15, %r13
	cmpq	$9, %r13
	jl	.LBB39_20
# %bb.19:
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB39_22:
	movq	%r14, %rdx
	subq	%r12, %rdx
	cmpq	$9, %rdx
	jl	.LBB39_24
# %bb.23:
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	memmove@PLT
.LBB39_26:
	movq	%r13, %r15
	sarq	$3, %r15
	cmpq	$2, %r15
	jl	.LBB39_28
# %bb.27:
	leaq	(,%r15,8), %rax
	movq	%r14, %rdi
	subq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB39_30:
	shlq	$3, %r15
	subq	%r15, %r14
.LBB39_31:
	movq	%r14, %r15
.LBB39_32:
	movq	%r15, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB39_5:
	.cfi_def_cfa_offset 48
	cmpq	$8, %r13
	jne	.LBB39_7
# %bb.6:
	movq	(%r12), %rax
	movq	%rax, (%rbx)
	jmp	.LBB39_7
.LBB39_9:
	cmpq	$8, %r12
	jne	.LBB39_11
# %bb.10:
	movq	(%r15), %rax
	movq	%rax, -8(%r14)
	jmp	.LBB39_11
.LBB39_13:
	cmpq	$8, %r13
	jne	.LBB39_15
# %bb.14:
	movq	(%rbx), %rax
	movq	%rax, (%r15)
.LBB39_15:
	addq	%r13, %r15
	jmp	.LBB39_32
.LBB39_20:
	cmpq	$8, %r13
	jne	.LBB39_22
# %bb.21:
	movq	(%r15), %rax
	movq	%rax, (%rbx)
	jmp	.LBB39_22
.LBB39_24:
	cmpq	$8, %rdx
	jne	.LBB39_26
# %bb.25:
	movq	(%r12), %rax
	movq	%rax, (%r15)
	jmp	.LBB39_26
.LBB39_28:
	cmpq	$8, %r13
	jne	.LBB39_30
# %bb.29:
	movq	(%rbx), %rax
	movq	%rax, -8(%r14)
	jmp	.LBB39_30
.Lfunc_end39:
	.size	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_, .Lfunc_end39-_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"sort"
	.size	.L.str, 5

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"--alg"
	.size	.L.str.1, 6

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"--n"
	.size	.L.str.2, 4

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"--u"
	.size	.L.str.3, 4

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"--reserve"
	.size	.L.str.4, 10

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"--calls"
	.size	.L.str.5, 8

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"--nlocal"
	.size	.L.str.6, 9

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"bad arg %s\n"
	.size	.L.str.7, 12

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"merge"
	.size	.L.str.8, 6

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"unique"
	.size	.L.str.9, 7

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"uset"
	.size	.L.str.10, 5

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"flat"
	.size	.L.str.11, 5

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"insert"
	.size	.L.str.12, 7

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"assign"
	.size	.L.str.13, 7

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"dtor"
	.size	.L.str.14, 5

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"radix"
	.size	.L.str.15, 6

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"count"
	.size	.L.str.16, 6

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"scatter"
	.size	.L.str.17, 8

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"sortdelta"
	.size	.L.str.18, 10

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"inplace_merge"
	.size	.L.str.19, 14

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"unknown alg\n"
	.size	.L.str.20, 13

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"WRONG RESULT %s\n"
	.size	.L.str.21, 17

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"%s,%s,%zu,%zu,%.2f\n"
	.size	.L.str.22, 20

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"cannot create std::vector larger than max_size()"
	.size	.L.str.23, 49

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"basic_string: construction from null is not valid"
	.size	.L.str.26, 50

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	"basic_string::_M_create"
	.size	.L.str.27, 24

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"stoull"
	.size	.L.str.28, 7

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"vector::_M_realloc_insert"
	.size	.L.str.29, 26

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"vector::_M_range_insert"
	.size	.L.str.30, 24

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"vector::_M_fill_insert"
	.size	.L.str.31, 23

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"vector::reserve"
	.size	.L.str.32, 16

	.type	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,@object # @_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.section	.data.rel.ro._ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,"awG",@progbits,_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,comdat
	.weak	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.p2align	3, 0x0
_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value:
	.long	8                               # 0x8
	.long	8                               # 0x8
	.long	8                               # 0x8
	.short	8                               # 0x8
	.byte	1                               # 0x1
	.byte	1                               # 0x1
	.quad	_ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.quad	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.quad	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.quad	_ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.quad	_ZN4absl12lts_2026081718container_internal20AllocateBackingArrayILm8ESaIcEEEPvS4_m
	.quad	_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm
	.quad	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.size	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value, 72

	.section	".linker-options","e",@llvm_linker_options
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.p2align	3, 0x0
	.type	DW.ref.__gxx_personality_v0,@object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __gxx_personality_v0
	.addrsig_sym _ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm
	.addrsig_sym _ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.addrsig_sym _ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.addrsig_sym _ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.addrsig_sym _ZN4absl12lts_2026081718container_internal20AllocateBackingArrayILm8ESaIcEEEPvS4_m
	.addrsig_sym _ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.addrsig_sym _ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.addrsig_sym _Unwind_Resume
	.addrsig_sym _ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.addrsig_sym _ZN4absl12lts_2026081718container_internal11kSooControlE
	.addrsig_sym _ZSt7nothrow
