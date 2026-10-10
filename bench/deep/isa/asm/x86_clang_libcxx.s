	.text
	.file	"isa_bench.cpp"
	.globl	phase_sort                      # -- Begin function phase_sort
	.p2align	4, 0x90
	.type	phase_sort,@function
phase_sort:                             # @phase_sort
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	leaq	7(%rsp), %rdx
	movq	%rax, %rdi
	callq	_ZNSt3__16__sortIRNS_6__lessImmEEPmEEvT0_S5_T_@PLT
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
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
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %r14
	movq	8(%rdi), %rbx
	cmpq	%rbx, %r14
	je	.LBB1_10
# %bb.1:
	addq	$8, %r14
	.p2align	4, 0x90
.LBB1_2:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rbx, %r14
	je	.LBB1_14
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=1
	movq	-8(%r14), %rax
	leaq	8(%r14), %rcx
	cmpq	(%r14), %rax
	movq	%rcx, %r14
	jne	.LBB1_2
# %bb.4:
	leaq	-16(%rcx), %r14
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_8:                                #   in Loop: Header=BB1_5 Depth=1
	addq	$8, %rcx
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
	cmpq	%rbx, %rcx
	je	.LBB1_9
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
	movq	%rax, %rdx
	movq	(%rcx), %rax
	cmpq	%rax, %rdx
	je	.LBB1_8
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
	movq	%rax, 8(%r14)
	addq	$8, %r14
	jmp	.LBB1_8
.LBB1_9:
	addq	$8, %r14
.LBB1_10:
	cmpq	%rbx, %r14
	je	.LBB1_14
# %bb.11:
	movq	%rbx, %rsi
	subq	%r14, %rsi
	addq	%r14, %rsi
	subq	%rsi, %rbx
	je	.LBB1_13
# %bb.12:
	movq	%rdi, %r15
	movq	%r14, %rdi
	movq	%rbx, %rdx
	callq	memmove@PLT
	movq	%r15, %rdi
.LBB1_13:
	addq	%rbx, %r14
	movq	%r14, 8(%rdi)
.LBB1_14:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	phase_unique, .Lfunc_end1-phase_unique
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function phase_uset_insert
.LCPI2_0:
	.long	0x5f000000                      # float 9.22337203E+18
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
	movq	%rsi, %r15
	movq	%rdi, %r14
	movl	$40, %edi
	callq	_Znwm@PLT
	movq	%rax, %rbx
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	movups	%xmm0, 16(%rax)
	movl	$1065353216, 32(%rax)           # imm = 0x3F800000
	testq	%r15, %r15
	js	.LBB2_1
# %bb.2:
	xorps	%xmm0, %xmm0
	cvtsi2ss	%r15, %xmm0
	jmp	.LBB2_3
.LBB2_1:
	movq	%r15, %rax
	shrq	%rax
	andl	$1, %r15d
	orq	%rax, %r15
	xorps	%xmm0, %xmm0
	cvtsi2ss	%r15, %xmm0
	addss	%xmm0, %xmm0
.LBB2_3:
	cvttss2si	%xmm0, %rcx
	movq	%rcx, %rdx
	sarq	$63, %rdx
	subss	.LCPI2_0(%rip), %xmm0
	cvttss2si	%xmm0, %rax
	andq	%rdx, %rax
	orq	%rcx, %rax
	movl	$2, %esi
	cmpq	$1, %rax
	je	.LBB2_7
# %bb.4:
	leaq	-1(%rax), %rcx
	testq	%rcx, %rax
	je	.LBB2_6
# %bb.5:
	movq	%rax, %rdi
	callq	_ZNSt3__112__next_primeEm@PLT
.LBB2_6:
	movq	%rax, %rsi
	testq	%rax, %rax
	je	.LBB2_8
.LBB2_7:
	movq	%rbx, %rdi
	callq	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm
.LBB2_8:
	movq	(%r14), %r15
	movq	8(%r14), %r12
	cmpq	%r12, %r15
	je	.LBB2_11
# %bb.9:
	movq	%rsp, %r14
	.p2align	4, 0x90
.LBB2_10:                               # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	movq	%rax, (%rsp)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r14, %rdx
	callq	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_
	addq	$8, %r15
	cmpq	%r12, %r15
	jne	.LBB2_10
.LBB2_11:
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
	xorl	%ecx, %ecx
	testq	%rsi, %rsi
	je	.LBB3_3
# %bb.1:
	movq	%rsi, %rax
	.p2align	4, 0x90
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	incq	%rcx
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.LBB3_2
.LBB3_3:
	xorl	%edx, %edx
	jmp	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l # TAILCALL
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
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	movq	16(%rdi), %rdi
	testq	%rdi, %rdi
	je	.LBB4_3
	.p2align	4, 0x90
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	movq	(%rdi), %r14
	callq	_ZdlPv@PLT
	movq	%r14, %rdi
	testq	%r14, %r14
	jne	.LBB4_2
.LBB4_3:
	movq	(%rbx), %rdi
	movq	$0, (%rbx)
	testq	%rdi, %rdi
	je	.LBB4_5
# %bb.4:
	callq	_ZdlPv@PLT
.LBB4_5:
	movq	%rbx, %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	_ZdlPv@PLT                      # TAILCALL
.LBB4_6:
	.cfi_restore %rbx
	.cfi_restore %r14
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
# %bb.2:
	movq	%rsi, %rdx
	addq	$8, %rdx
	testb	$62, %cl
	je	.LBB6_3
# %bb.4:
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
	jg	.LBB6_5
	.p2align	4, 0x90
.LBB6_6:                                # =>This Inner Loop Header: Depth=1
	leaq	1(%rax), %rsi
	addq	$8, %rdx
	cmpb	$-1, 1(%rax)
	movq	%rsi, %rax
	jl	.LBB6_6
	jmp	.LBB6_7
.LBB6_3:
	movq	_ZN4absl12lts_2026081718container_internal11kSooControlE@GOTPCREL(%rip), %rsi
	jmp	.LBB6_7
.LBB6_5:
	movq	%rax, %rsi
.LBB6_7:
	xorl	%r9d, %r9d
	movq	%rsi, %rax
	jmp	.LBB6_8
	.p2align	4, 0x90
.LBB6_10:                               #   in Loop: Header=BB6_8 Depth=1
	incq	%r9
	cmpb	$-1, %cl
	je	.LBB6_11
.LBB6_8:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_9 Depth 2
	movzbl	1(%rax), %ecx
	incq	%rax
	cmpb	$-2, %cl
	jg	.LBB6_10
	.p2align	4, 0x90
.LBB6_9:                                #   Parent Loop BB6_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	1(%rax), %ecx
	incq	%rax
	cmpb	$-1, %cl
	jl	.LBB6_9
	jmp	.LBB6_10
.LBB6_11:
	xorl	%r8d, %r8d
	jmp	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l # TAILCALL
.LBB6_1:
	xorl	%edx, %edx
                                        # implicit-def: $rsi
	xorl	%r9d, %r9d
	xorl	%r8d, %r8d
	jmp	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l # TAILCALL
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
	movq	_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ENSt3__19allocatorIcEEEEvPvmPNS1_6ctrl_tEmmbm@GOTPCREL(%rip), %r8
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
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	(%rdi), %r13
	movq	8(%rdi), %rsi
	leaq	(,%r12,8), %r15
	addq	%r13, %r15
	leaq	15(%rsp), %rdx
	movq	%r15, %rdi
	callq	_ZNSt3__16__sortIRNS_6__lessImmEEPmEEvT0_S5_T_@PLT
	movq	8(%rbx), %r14
	cmpq	%r14, %r15
	je	.LBB10_10
# %bb.1:
	leaq	8(,%r12,8), %rdx
	addq	%r13, %rdx
	.p2align	4, 0x90
.LBB10_2:                               # =>This Inner Loop Header: Depth=1
	cmpq	%r14, %rdx
	je	.LBB10_14
# %bb.3:                                #   in Loop: Header=BB10_2 Depth=1
	movq	-8(%rdx), %rax
	leaq	8(%rdx), %rcx
	cmpq	(%rdx), %rax
	movq	%rcx, %rdx
	jne	.LBB10_2
# %bb.4:
	leaq	-16(%rcx), %r15
	jmp	.LBB10_5
	.p2align	4, 0x90
.LBB10_8:                               #   in Loop: Header=BB10_5 Depth=1
	addq	$8, %rcx
.LBB10_5:                               # =>This Inner Loop Header: Depth=1
	cmpq	%r14, %rcx
	je	.LBB10_9
# %bb.6:                                #   in Loop: Header=BB10_5 Depth=1
	movq	%rax, %rdx
	movq	(%rcx), %rax
	cmpq	%rax, %rdx
	je	.LBB10_8
# %bb.7:                                #   in Loop: Header=BB10_5 Depth=1
	movq	%rax, 8(%r15)
	addq	$8, %r15
	jmp	.LBB10_8
.LBB10_9:
	addq	$8, %r15
.LBB10_10:
	cmpq	%r14, %r15
	je	.LBB10_14
# %bb.11:
	movq	%r14, %rsi
	subq	%r15, %rsi
	addq	%r15, %rsi
	subq	%rsi, %r14
	je	.LBB10_13
# %bb.12:
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB10_13:
	addq	%r14, %r15
	movq	%r15, 8(%rbx)
.LBB10_14:
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
.Lfunc_end10:
	.size	phase_merge_sortdelta, .Lfunc_end10-phase_merge_sortdelta
	.cfi_endproc
                                        # -- End function
	.globl	phase_merge_inplace             # -- Begin function phase_merge_inplace
	.p2align	4, 0x90
	.type	phase_merge_inplace,@function
phase_merge_inplace:                    # @phase_merge_inplace
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r13
	movq	%rdi, %r12
	movq	(%rdi), %rdi
	movq	8(%r12), %rdx
	leaq	(%rdi,%rsi,8), %rbp
	movq	%rdx, %r15
	subq	%rbp, %r15
	sarq	$3, %r15
	cmpq	%rsi, %r15
	movq	%rsi, %r14
	cmovlq	%r15, %r14
	testq	%r14, %r14
	jle	.LBB11_1
# %bb.2:
	movq	%rdi, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	movq	_ZSt7nothrow@GOTPCREL(%rip), %r12
	.p2align	4, 0x90
.LBB11_3:                               # =>This Inner Loop Header: Depth=1
	leaq	(,%r14,8), %rdi
	.cfi_escape 0x2e, 0x00
	movq	%r12, %rsi
	callq	_ZnwmRKSt9nothrow_t@PLT
	testq	%rax, %rax
	jne	.LBB11_4
# %bb.5:                                #   in Loop: Header=BB11_3 Depth=1
	movq	%r14, %rax
	shrq	%rax
	cmpq	$1, %r14
	movq	%rax, %r14
	ja	.LBB11_3
# %bb.6:
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	jmp	.LBB11_7
.LBB11_1:
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	jmp	.LBB11_8
.LBB11_4:
	movq	%rax, %rbx
.LBB11_7:
	movq	32(%rsp), %r12                  # 8-byte Reload
	movq	24(%rsp), %rdx                  # 8-byte Reload
	movq	16(%rsp), %rdi                  # 8-byte Reload
.LBB11_8:
.Ltmp3:
	.cfi_escape 0x2e, 0x10
	leaq	15(%rsp), %rcx
	movq	%rbp, %rsi
	movq	%r13, %r8
	movq	%r15, %r9
	pushq	%r14
	.cfi_adjust_cfa_offset 8
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	callq	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
.Ltmp4:
# %bb.9:
	testq	%rbx, %rbx
	je	.LBB11_11
# %bb.10:
	.cfi_escape 0x2e, 0x00
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB11_11:
	movq	(%r12), %r15
	movq	8(%r12), %r14
	cmpq	%r14, %r15
	je	.LBB11_21
# %bb.12:
	addq	$8, %r15
	.p2align	4, 0x90
.LBB11_13:                              # =>This Inner Loop Header: Depth=1
	cmpq	%r14, %r15
	je	.LBB11_25
# %bb.14:                               #   in Loop: Header=BB11_13 Depth=1
	movq	-8(%r15), %rax
	leaq	8(%r15), %rcx
	cmpq	(%r15), %rax
	movq	%rcx, %r15
	jne	.LBB11_13
# %bb.15:
	leaq	-16(%rcx), %r15
	jmp	.LBB11_16
	.p2align	4, 0x90
.LBB11_19:                              #   in Loop: Header=BB11_16 Depth=1
	addq	$8, %rcx
.LBB11_16:                              # =>This Inner Loop Header: Depth=1
	cmpq	%r14, %rcx
	je	.LBB11_20
# %bb.17:                               #   in Loop: Header=BB11_16 Depth=1
	movq	%rax, %rdx
	movq	(%rcx), %rax
	cmpq	%rax, %rdx
	je	.LBB11_19
# %bb.18:                               #   in Loop: Header=BB11_16 Depth=1
	movq	%rax, 8(%r15)
	addq	$8, %r15
	jmp	.LBB11_19
.LBB11_20:
	addq	$8, %r15
.LBB11_21:
	cmpq	%r14, %r15
	je	.LBB11_25
# %bb.22:
	movq	%r14, %rsi
	subq	%r15, %rsi
	addq	%r15, %rsi
	subq	%rsi, %r14
	je	.LBB11_24
# %bb.23:
	.cfi_escape 0x2e, 0x00
	movq	%r15, %rdi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB11_24:
	addq	%r14, %r15
	movq	%r15, 8(%r12)
.LBB11_25:
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
.LBB11_26:
	.cfi_def_cfa_offset 96
.Ltmp5:
	movq	%rax, %r14
	testq	%rbx, %rbx
	je	.LBB11_28
# %bb.27:
	.cfi_escape 0x2e, 0x00
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
.LBB11_28:
	.cfi_escape 0x2e, 0x00
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end11:
	.size	phase_merge_inplace, .Lfunc_end11-phase_merge_inplace
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table11:
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
	.uleb128 .Lfunc_end11-.Ltmp4            #   Call between .Ltmp4 and .Lfunc_end11
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end1:
	.p2align	2, 0x0
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
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception2
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
	subq	$8808, %rsp                     # imm = 0x2268
	.cfi_def_cfa_offset 8864
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movb	$8, 112(%rsp)
	movl	$1953656691, 113(%rsp)          # imm = 0x74726F73
	movb	$0, 117(%rsp)
	movl	%edi, 176(%rsp)                 # 4-byte Spill
	cmpl	$2, %edi
	jl	.LBB12_75
# %bb.1:
	movq	%rsi, %r13
	movl	$1, %eax
	movq	%rax, 272(%rsp)                 # 8-byte Spill
	movl	$1, %ebp
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movl	$1048576, %r14d                 # imm = 0x100000
	xorl	%eax, %eax
	movq	%rax, 248(%rsp)                 # 8-byte Spill
	xorl	%r12d, %r12d
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	.p2align	4, 0x90
.LBB12_2:                               # =>This Inner Loop Header: Depth=1
	movq	%r14, 72(%rsp)                  # 8-byte Spill
	movslq	%ebp, %rbx
	movq	(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_476
# %bb.3:                                #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	movq	%r12, 64(%rsp)                  # 8-byte Spill
	cmpq	$23, %rax
	jae	.LBB12_7
# %bb.4:                                #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 608(%rsp)
	leaq	609(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_9
	.p2align	4, 0x90
# %bb.5:                                #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
	movzbl	608(%rsp), %edx
	testb	$1, %dl
	je	.LBB12_10
.LBB12_6:                               #   in Loop: Header=BB12_2 Depth=1
	movq	616(%rsp), %rdx
	movq	624(%rsp), %r14
	movq	64(%rsp), %r12                  # 8-byte Reload
	leaq	-3(%rdx), %rax
	cmpq	$6, %rax
	jbe	.LBB12_11
	jmp	.LBB12_56
	.p2align	4, 0x90
.LBB12_7:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp6:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp7:
# %bb.8:                                #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 624(%rsp)
	orq	$1, %r13
	movq	%r13, 608(%rsp)
	movq	%r14, 616(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_9:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
	movb	$0, (%r12,%r14)
	movzbl	608(%rsp), %edx
	testb	$1, %dl
	jne	.LBB12_6
.LBB12_10:                              #   in Loop: Header=BB12_2 Depth=1
	shrl	%edx
	leaq	609(%rsp), %r14
	movq	64(%rsp), %r12                  # 8-byte Reload
	leaq	-3(%rdx), %rax
	cmpq	$6, %rax
	ja	.LBB12_56
.LBB12_11:                              #   in Loop: Header=BB12_2 Depth=1
	leaq	.LJTI12_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB12_12:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.2(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_53
# %bb.13:                               #   in Loop: Header=BB12_2 Depth=1
	movzwl	(%r14), %eax
	xorl	$11565, %eax                    # imm = 0x2D2D
	movzbl	2(%r14), %ecx
	xorl	$117, %ecx
	orw	%ax, %cx
	jne	.LBB12_56
# %bb.14:                               #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_500
# %bb.15:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_57
# %bb.16:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_59
	jmp	.LBB12_60
.LBB12_17:                              #   in Loop: Header=BB12_2 Depth=1
	movl	(%r14), %eax
	movl	$1818307885, %ecx               # imm = 0x6C612D2D
	xorl	%ecx, %eax
	movzbl	4(%r14), %ecx
	xorl	$103, %ecx
	orl	%eax, %ecx
	jne	.LBB12_56
# %bb.18:                               #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_492
# %bb.19:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_36
# %bb.20:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_38
# %bb.21:                               #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
	testb	$1, 112(%rsp)
	je	.LBB12_23
.LBB12_22:                              #   in Loop: Header=BB12_2 Depth=1
	movq	128(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB12_23:                              #   in Loop: Header=BB12_2 Depth=1
	incl	%ebp
	movq	32(%rsp), %rax
	movq	%rax, 128(%rsp)
	movdqu	16(%rsp), %xmm0
	movdqa	%xmm0, 112(%rsp)
	movb	$1, %bl
	movq	72(%rsp), %r14                  # 8-byte Reload
	movq	64(%rsp), %r12                  # 8-byte Reload
	testb	$1, 608(%rsp)
	je	.LBB12_72
	jmp	.LBB12_71
.LBB12_24:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.4(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_56
# %bb.25:                               #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_494
# %bb.26:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_39
# %bb.27:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_41
	jmp	.LBB12_42
.LBB12_28:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.6(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_56
# %bb.29:                               #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_496
# %bb.30:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_43
# %bb.31:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_45
	jmp	.LBB12_46
.LBB12_32:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rdi
	leaq	.L.str.5(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	jne	.LBB12_56
# %bb.33:                               #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_490
# %bb.34:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_48
# %bb.35:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_50
	jmp	.LBB12_51
.LBB12_36:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp54:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp55:
# %bb.37:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_38:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
	movb	$0, (%r12,%r14)
	testb	$1, 112(%rsp)
	jne	.LBB12_22
	jmp	.LBB12_23
.LBB12_39:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp27:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp28:
# %bb.40:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_41:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_42:                              #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
.Ltmp30:
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	_ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi@PLT
	movq	%rax, 248(%rsp)                 # 8-byte Spill
.Ltmp31:
	jmp	.LBB12_67
.LBB12_43:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp9:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp10:
# %bb.44:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_45:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_46:                              #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
.Ltmp12:
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	_ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi@PLT
.Ltmp13:
# %bb.47:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	testb	$1, 16(%rsp)
	movq	72(%rsp), %r14                  # 8-byte Reload
	jne	.LBB12_68
	jmp	.LBB12_69
.LBB12_48:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp18:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp19:
# %bb.49:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_50:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_51:                              #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
.Ltmp21:
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	_ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi@PLT
.Ltmp22:
# %bb.52:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, 272(%rsp)                 # 8-byte Spill
.LBB12_67:                              #   in Loop: Header=BB12_2 Depth=1
	testb	$1, 16(%rsp)
	movq	72(%rsp), %r14                  # 8-byte Reload
	movq	64(%rsp), %r12                  # 8-byte Reload
	je	.LBB12_69
.LBB12_68:                              #   in Loop: Header=BB12_2 Depth=1
	movq	32(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB12_69:                              #   in Loop: Header=BB12_2 Depth=1
	incl	%ebp
	movb	$1, %bl
	testb	$1, 608(%rsp)
	je	.LBB12_72
.LBB12_71:                              #   in Loop: Header=BB12_2 Depth=1
	movq	624(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB12_72:                              #   in Loop: Header=BB12_2 Depth=1
	testb	%bl, %bl
	je	.LBB12_448
# %bb.73:                               #   in Loop: Header=BB12_2 Depth=1
	incl	%ebp
	cmpl	176(%rsp), %ebp                 # 4-byte Folded Reload
	jl	.LBB12_2
	jmp	.LBB12_74
.LBB12_53:                              #   in Loop: Header=BB12_2 Depth=1
	movq	8(%r13,%rbx,8), %r15
	movq	%r15, %rdi
	callq	strlen@PLT
	cmpq	$-8, %rax
	jae	.LBB12_502
# %bb.54:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	cmpq	$23, %rax
	jae	.LBB12_62
# %bb.55:                               #   in Loop: Header=BB12_2 Depth=1
	leal	(%r14,%r14), %eax
	movb	%al, 16(%rsp)
	leaq	17(%rsp), %r12
	testq	%r14, %r14
	jne	.LBB12_64
	jmp	.LBB12_65
.LBB12_56:                              #   in Loop: Header=BB12_2 Depth=1
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	xorl	%ebx, %ebx
	leaq	.L.str.7(%rip), %rsi
	movq	%r14, %rdx
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$2, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	72(%rsp), %r14                  # 8-byte Reload
	testb	$1, 608(%rsp)
	je	.LBB12_72
	jmp	.LBB12_71
.LBB12_57:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp36:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp37:
# %bb.58:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_59:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_60:                              #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
.Ltmp39:
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	_ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi@PLT
.Ltmp40:
# %bb.61:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r14
	testb	$1, 16(%rsp)
	movq	64(%rsp), %r12                  # 8-byte Reload
	jne	.LBB12_68
	jmp	.LBB12_69
.LBB12_62:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r14, %rax
	andq	$-8, %rax
	addq	$8, %rax
	movq	%r14, %r13
	orq	$7, %r13
	cmpq	$23, %r13
	cmoveq	%rax, %r13
	incq	%r13
.Ltmp45:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp46:
# %bb.63:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, %r12
	movq	%rax, 32(%rsp)
	orq	$1, %r13
	movq	%r13, 16(%rsp)
	movq	%r14, 24(%rsp)
	movq	8(%rsp), %r13                   # 8-byte Reload
.LBB12_64:                              #   in Loop: Header=BB12_2 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB12_65:                              #   in Loop: Header=BB12_2 Depth=1
	movb	$0, (%r12,%r14)
.Ltmp48:
	leaq	16(%rsp), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	_ZNSt3__16stoullERKNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPmi@PLT
.Ltmp49:
# %bb.66:                               #   in Loop: Header=BB12_2 Depth=1
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	testb	$1, 16(%rsp)
	movq	72(%rsp), %r14                  # 8-byte Reload
	movq	64(%rsp), %r12                  # 8-byte Reload
	je	.LBB12_69
	jmp	.LBB12_68
.LBB12_75:
	movl	$1, %edx
	movl	$1048576, %ecx                  # imm = 0x100000
	xorl	%eax, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movl	$1048576, %r14d                 # imm = 0x100000
	xorl	%r12d, %r12d
	movl	$1048576, %eax                  # imm = 0x100000
	movq	%rax, 248(%rsp)                 # 8-byte Spill
	jmp	.LBB12_76
.LBB12_74:
	movq	248(%rsp), %rax                 # 8-byte Reload
	testq	%rax, %rax
	movq	136(%rsp), %rcx                 # 8-byte Reload
	cmoveq	%rcx, %rax
	movq	%rax, 248(%rsp)                 # 8-byte Spill
	movq	272(%rsp), %rdx                 # 8-byte Reload
.LBB12_76:
	movq	%r14, 72(%rsp)                  # 8-byte Spill
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	cmpq	$4, %rdx
	movl	$4, %ecx
	cmovbq	%rdx, %rcx
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 368(%rsp)
	movq	$0, 384(%rsp)
	leaq	368(%rsp), %rax
	movq	%rax, 608(%rsp)
	movb	$0, 616(%rsp)
	movq	%rdx, 272(%rsp)                 # 8-byte Spill
	testq	%rdx, %rdx
	movq	%r12, 64(%rsp)                  # 8-byte Spill
	movq	%rcx, 424(%rsp)                 # 8-byte Spill
	je	.LBB12_311
# %bb.77:
	leaq	(,%rcx,8), %rax
	movq	%rcx, %r14
	leaq	(%rax,%rax,2), %rbx
.Ltmp60:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp61:
# %bb.78:
	movq	%rax, %r15
	movq	%rax, 368(%rsp)
	leaq	(%r14,%r14,2), %r12
	leaq	(%rax,%r12,8), %rax
	movq	%rax, 384(%rsp)
	leaq	-24(%rbx), %rax
	movzbl	%al, %ecx
	imull	$171, %ecx, %ecx
	shrl	$9, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	subb	%cl, %al
	movzbl	%al, %eax
	negq	%rax
	leaq	(%rbx,%rax), %r13
	addq	$-24, %r13
	leaq	24(%r13), %r14
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	leaq	(%r15,%r13), %rax
	addq	$24, %rax
	movq	%rax, 376(%rsp)
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 288(%rsp)
	movq	$0, 304(%rsp)
	leaq	288(%rsp), %rax
	movq	%rax, 608(%rsp)
	movb	$0, 616(%rsp)
.Ltmp63:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp64:
# %bb.79:
	movq	%rax, %rbx
	movq	136(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rbp
	movq	64(%rsp), %rcx                  # 8-byte Reload
	subq	%rcx, %rbp
	shrq	%rbp
	cmpq	$1, %rbp
	adcq	$0, %rbp
	xorl	%edx, %edx
	movq	%r15, %rax
	subq	%rcx, %rax
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	%rbx, 288(%rsp)
	leaq	(%rbx,%r12,8), %rax
	movq	%rcx, %r12
	movq	%rax, 304(%rsp)
	movq	%rbp, %r13
	movl	$0, %eax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	cmoveq	%rdx, %r13
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	addq	%r14, %rbx
	movq	%rbx, 296(%rsp)
	movq	%r15, %rbx
	leaq	(%r15,%r15), %rax
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	movabsq	$4611686018427387900, %rax      # imm = 0x3FFFFFFFFFFFFFFC
	leaq	3(%rax), %rcx
	movq	%r13, 168(%rsp)                 # 8-byte Spill
	shrq	%r13
	movq	%r13, 144(%rsp)                 # 8-byte Spill
	leaq	-8(,%r12,8), %rdx
	movq	%rdx, 496(%rsp)                 # 8-byte Spill
	shrq	$3, %rdx
	incq	%rdx
	movq	72(%rsp), %r15                  # 8-byte Reload
	leaq	(%r15,%rax), %rsi
	addq	$3, %rsi
	movq	%rcx, 488(%rsp)                 # 8-byte Spill
	andq	%rcx, %rsi
	movq	%rsi, 576(%rsp)                 # 8-byte Spill
	leaq	1(%rsi), %rcx
	leaq	-8(,%r15,8), %rsi
	movq	%rsi, 592(%rsp)                 # 8-byte Spill
	shrq	$3, %rsi
	incq	%rsi
	leaq	2(%rax), %rdi
	movq	%rsi, 560(%rsp)                 # 8-byte Spill
	andq	%rdi, %rsi
	movq	%rsi, %rax
	movabsq	$-7046029254386353131, %r8      # imm = 0x9E3779B97F4A7C15
	imulq	%r8, %rax
	movq	%rax, 544(%rsp)                 # 8-byte Spill
	movq	%rcx, 528(%rsp)                 # 8-byte Spill
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	andq	%rax, %rcx
	movq	%rcx, 520(%rsp)                 # 8-byte Spill
	movq	%rdx, 464(%rsp)                 # 8-byte Spill
	andq	%rdx, %rdi
	movq	%rdi, 456(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	imulq	%r8, %rax
	movq	%rax, 448(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	subq	%r15, %rax
	movq	%rax, 568(%rsp)                 # 8-byte Spill
	leaq	(,%r15,8), %rax
	movq	%rax, 432(%rsp)                 # 8-byte Spill
	leaq	(,%r15,4), %rax
	movq	%rax, 584(%rsp)                 # 8-byte Spill
	leaq	(,%rbx,8), %rax
	movq	%rax, 600(%rsp)                 # 8-byte Spill
	leaq	(,%r12,8), %rax
	movq	%rax, 504(%rsp)                 # 8-byte Spill
	movq	%rbp, 472(%rsp)                 # 8-byte Spill
	leaq	(,%rbp,8), %rax
	movq	%rax, 480(%rsp)                 # 8-byte Spill
	movq	%rsi, 552(%rsp)                 # 8-byte Spill
	leaq	(,%rsi,8), %rax
	movq	%rax, 536(%rsp)                 # 8-byte Spill
	leaq	(,%rcx,4), %rax
	movq	%rax, 512(%rsp)                 # 8-byte Spill
	leaq	(,%rdi,8), %rax
	movq	%rax, 440(%rsp)                 # 8-byte Spill
	jmp	.LBB12_81
	.p2align	4, 0x90
.LBB12_80:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r14, (%rbp)
	movq	%r15, 8(%r12,%r13,8)
	movq	%rbx, 16(%r12,%r13,8)
	movq	152(%rsp), %rcx                 # 8-byte Reload
	incq	%rcx
	movq	%rcx, %rax
	movq	%rcx, 152(%rsp)                 # 8-byte Spill
	cmpq	424(%rsp), %rcx                 # 8-byte Folded Reload
	movq	136(%rsp), %rbx                 # 8-byte Reload
	movq	72(%rsp), %r15                  # 8-byte Reload
	movq	64(%rsp), %r12                  # 8-byte Reload
	je	.LBB12_312
.LBB12_81:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_92 Depth 2
                                        #     Child Loop BB12_97 Depth 2
                                        #     Child Loop BB12_101 Depth 2
                                        #     Child Loop BB12_104 Depth 2
                                        #     Child Loop BB12_107 Depth 2
                                        #     Child Loop BB12_116 Depth 2
                                        #       Child Loop BB12_126 Depth 3
                                        #       Child Loop BB12_128 Depth 3
                                        #       Child Loop BB12_132 Depth 3
                                        #       Child Loop BB12_134 Depth 3
                                        #       Child Loop BB12_139 Depth 3
                                        #       Child Loop BB12_141 Depth 3
                                        #     Child Loop BB12_147 Depth 2
                                        #     Child Loop BB12_182 Depth 2
                                        #     Child Loop BB12_189 Depth 2
                                        #     Child Loop BB12_194 Depth 2
                                        #     Child Loop BB12_198 Depth 2
                                        #     Child Loop BB12_216 Depth 2
                                        #       Child Loop BB12_237 Depth 3
                                        #       Child Loop BB12_228 Depth 3
                                        #     Child Loop BB12_241 Depth 2
                                        #       Child Loop BB12_262 Depth 3
                                        #       Child Loop BB12_251 Depth 3
                                        #     Child Loop BB12_279 Depth 2
                                        #       Child Loop BB12_302 Depth 3
                                        #       Child Loop BB12_289 Depth 3
                                        #     Child Loop BB12_272 Depth 2
                                        #     Child Loop BB12_163 Depth 2
                                        #     Child Loop BB12_167 Depth 2
	movzbl	112(%rsp), %eax
	testb	$1, %al
	je	.LBB12_83
# %bb.82:                               #   in Loop: Header=BB12_81 Depth=1
	movq	120(%rsp), %rcx
	cmpq	$5, %rcx
	je	.LBB12_84
	jmp	.LBB12_87
	.p2align	4, 0x90
.LBB12_83:                              #   in Loop: Header=BB12_81 Depth=1
	movl	%eax, %ecx
	shrl	%ecx
	cmpq	$5, %rcx
	jne	.LBB12_87
.LBB12_84:                              #   in Loop: Header=BB12_81 Depth=1
	leaq	113(%rsp), %rcx
	testb	$1, %al
	je	.LBB12_86
# %bb.85:                               #   in Loop: Header=BB12_81 Depth=1
	movq	128(%rsp), %rcx
.LBB12_86:                              #   in Loop: Header=BB12_81 Depth=1
	movl	(%rcx), %eax
	movl	$1735550317, %edx               # imm = 0x6772656D
	xorl	%edx, %eax
	movzbl	4(%rcx), %ecx
	xorl	$101, %ecx
	orl	%eax, %ecx
	je	.LBB12_177
.LBB12_87:                              #   in Loop: Header=BB12_81 Depth=1
	movq	152(%rsp), %rax                 # 8-byte Reload
	incq	%rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	movabsq	$-7723592293110705685, %rdx     # imm = 0x94D049BB133111EB
	imulq	%rdx, %rax
	movq	%r15, %rcx
	shldq	$33, %rax, %rcx
	xorq	256(%rsp), %rax                 # 8-byte Folded Reload
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
	movq	%rax, %r14
	shrq	$31, %r14
	xorq	%rax, %r14
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 608(%rsp)
	movq	$0, 624(%rsp)
	testq	%r15, %r15
	je	.LBB12_94
# %bb.88:                               #   in Loop: Header=BB12_81 Depth=1
	movabsq	$2305843009213693951, %rax      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rax, %r15
	movq	432(%rsp), %r13                 # 8-byte Reload
	ja	.LBB12_478
# %bb.89:                               #   in Loop: Header=BB12_81 Depth=1
.Ltmp66:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp67:
# %bb.90:                               #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %rbp
	movq	%rax, 608(%rsp)
	leaq	(%rax,%r15,8), %rax
	movq	%rax, 624(%rsp)
	movq	%rbp, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	memset@PLT
	cmpq	$0, 592(%rsp)                   # 8-byte Folded Reload
	je	.LBB12_95
# %bb.91:                               #   in Loop: Header=BB12_81 Depth=1
	movq	536(%rsp), %rax                 # 8-byte Reload
	addq	%rbp, %rax
	movq	%r14, %xmm0
	addq	544(%rsp), %r14                 # 8-byte Folded Reload
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	paddq	.LCPI12_0(%rip), %xmm0
	xorl	%ecx, %ecx
	movq	552(%rsp), %rdx                 # 8-byte Reload
	movdqa	.LCPI12_1(%rip), %xmm4          # xmm4 = [11400714819323198485,11400714819323198485]
	movdqa	.LCPI12_2(%rip), %xmm5          # xmm5 = [13787848793156543929,13787848793156543929]
	movdqa	.LCPI12_3(%rip), %xmm6          # xmm6 = [3210233709,3210233709]
	movdqa	.LCPI12_4(%rip), %xmm7          # xmm7 = [10723151780598845931,10723151780598845931]
	movdqa	.LCPI12_5(%rip), %xmm8          # xmm8 = [2496678331,2496678331]
	movdqa	.LCPI12_6(%rip), %xmm9          # xmm9 = [4354685564936845354,4354685564936845354]
	.p2align	4, 0x90
.LBB12_92:                              #   Parent Loop BB12_81 Depth=1
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
	movdqu	%xmm2, (%rbp,%rcx,8)
	addq	$2, %rcx
	paddq	%xmm9, %xmm0
	cmpq	%rcx, %rdx
	jne	.LBB12_92
# %bb.93:                               #   in Loop: Header=BB12_81 Depth=1
	cmpq	%rdx, 560(%rsp)                 # 8-byte Folded Reload
	movabsq	$-7046029254386353131, %rdi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	jne	.LBB12_96
	jmp	.LBB12_98
	.p2align	4, 0x90
.LBB12_94:                              #   in Loop: Header=BB12_81 Depth=1
	xorl	%r13d, %r13d
	xorl	%ebp, %ebp
	jmp	.LBB12_105
.LBB12_95:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbp, %rax
	movabsq	$-7046029254386353131, %rdi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
.LBB12_96:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbp, %rcx
	addq	432(%rsp), %rcx                 # 8-byte Folded Reload
	.p2align	4, 0x90
.LBB12_97:                              #   Parent Loop BB12_81 Depth=1
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
	movq	%rdx, (%rax)
	addq	$8, %rax
	cmpq	%rcx, %rax
	jne	.LBB12_97
.LBB12_98:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp69:
	movq	584(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp70:
# %bb.99:                               #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %r13
	cmpq	$7, 576(%rsp)                   # 8-byte Folded Reload
	jb	.LBB12_103
# %bb.100:                              #   in Loop: Header=BB12_81 Depth=1
	movq	512(%rsp), %rax                 # 8-byte Reload
	addq	%r13, %rax
	xorl	%ecx, %ecx
	movq	520(%rsp), %rdx                 # 8-byte Reload
	movdqa	.LCPI12_7(%rip), %xmm0          # xmm0 = [1,1,1,1]
	.p2align	4, 0x90
.LBB12_101:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqu	%xmm0, (%r13,%rcx,4)
	movdqu	%xmm0, 16(%r13,%rcx,4)
	addq	$8, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB12_101
# %bb.102:                              #   in Loop: Header=BB12_81 Depth=1
	cmpq	%rdx, 528(%rsp)                 # 8-byte Folded Reload
	je	.LBB12_105
.LBB12_103:                             #   in Loop: Header=BB12_81 Depth=1
	leaq	(,%r15,4), %rcx
	addq	%r13, %rcx
	.p2align	4, 0x90
.LBB12_104:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$1, (%rax)
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.LBB12_104
.LBB12_105:                             #   in Loop: Header=BB12_81 Depth=1
	cmpq	%r15, %rbx
	jbe	.LBB12_109
# %bb.106:                              #   in Loop: Header=BB12_81 Depth=1
	movq	568(%rsp), %rcx                 # 8-byte Reload
	movabsq	$-7046029254386353131, %rsi     # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %rdi     # imm = 0x94D049BB133111EB
	.p2align	4, 0x90
.LBB12_107:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	%rsi, %r14
	movq	%r14, %rax
	shrq	$30, %rax
	xorq	%r14, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	imulq	%rdi, %rdx
	movq	%rdx, %rax
	shrq	$31, %rax
	xorq	%rdx, %rax
	mulq	%r15
	incl	(%r13,%rdx,4)
	decq	%rcx
	jne	.LBB12_107
# %bb.108:                              #   in Loop: Header=BB12_81 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 80(%rsp)
	movq	$0, 96(%rsp)
	jmp	.LBB12_110
	.p2align	4, 0x90
.LBB12_109:                             #   in Loop: Header=BB12_81 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 80(%rsp)
	movq	$0, 96(%rsp)
	testq	%rbx, %rbx
	je	.LBB12_185
.LBB12_110:                             #   in Loop: Header=BB12_81 Depth=1
	movabsq	$2305843009213693951, %rax      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rax, %rbx
	ja	.LBB12_472
# %bb.111:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp75:
	movq	600(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp76:
# %bb.112:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %rcx
	leaq	(%rax,%rbx,8), %rax
	movq	%rcx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rax, 96(%rsp)
	movq	%rcx, %rsi
	testq	%r15, %r15
	je	.LBB12_145
.LBB12_113:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%r15d, %r15d
	movq	%rbp, 160(%rsp)                 # 8-byte Spill
	movq	%r13, 176(%rsp)                 # 8-byte Spill
	jmp	.LBB12_116
	.p2align	4, 0x90
.LBB12_114:                             #   in Loop: Header=BB12_116 Depth=2
	movq	%rax, 88(%rsp)
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
.LBB12_115:                             #   in Loop: Header=BB12_116 Depth=2
	incq	%r15
	cmpq	72(%rsp), %r15                  # 8-byte Folded Reload
	movq	176(%rsp), %r13                 # 8-byte Reload
	je	.LBB12_144
.LBB12_116:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_126 Depth 3
                                        #       Child Loop BB12_128 Depth 3
                                        #       Child Loop BB12_132 Depth 3
                                        #       Child Loop BB12_134 Depth 3
                                        #       Child Loop BB12_139 Depth 3
                                        #       Child Loop BB12_141 Depth 3
	movl	(%r13,%r15,4), %r13d
	testq	%r13, %r13
	je	.LBB12_115
# %bb.117:                              #   in Loop: Header=BB12_116 Depth=2
	movq	88(%rsp), %r12
	movq	96(%rsp), %rax
	movq	%rax, %rcx
	subq	%r12, %rcx
	sarq	$3, %rcx
	cmpq	%r13, %rcx
	jae	.LBB12_123
# %bb.118:                              #   in Loop: Header=BB12_116 Depth=2
	movq	80(%rsp), %rbx
	movq	%r12, %r11
	subq	%rbx, %r11
	movq	%r11, %rbp
	sarq	$3, %rbp
	movq	%rbp, %rcx
	addq	%r13, %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	ja	.LBB12_456
# %bb.119:                              #   in Loop: Header=BB12_116 Depth=2
	subq	%rbx, %rax
	movq	%rax, %rsi
	sarq	$2, %rsi
	cmpq	%rcx, %rsi
	cmovbeq	%rcx, %rsi
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %rsi
	testq	%rsi, %rsi
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	je	.LBB12_129
# %bb.120:                              #   in Loop: Header=BB12_116 Depth=2
	movq	%r11, 232(%rsp)                 # 8-byte Spill
	cmpq	%rdx, %rsi
	ja	.LBB12_458
# %bb.121:                              #   in Loop: Header=BB12_116 Depth=2
	leaq	(,%rsi,8), %rdi
.Ltmp78:
	callq	_Znwm@PLT
.Ltmp79:
# %bb.122:                              #   in Loop: Header=BB12_116 Depth=2
	movq	232(%rsp), %r11                 # 8-byte Reload
	jmp	.LBB12_130
	.p2align	4, 0x90
.LBB12_123:                             #   in Loop: Header=BB12_116 Depth=2
	leaq	(%r12,%r13,8), %rax
	movq	(%rbp,%r15,8), %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	addq	%rdx, %r13
	andq	%rdx, %r13
	cmpq	$3, %r13
	jae	.LBB12_125
# %bb.124:                              #   in Loop: Header=BB12_116 Depth=2
	movq	%r12, %rdx
	jmp	.LBB12_128
.LBB12_125:                             #   in Loop: Header=BB12_116 Depth=2
	incq	%r13
	movq	%r13, %rsi
	movabsq	$4611686018427387900, %rdx      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rdx, %rsi
	leaq	(%r12,%rsi,8), %rdx
	movq	%rcx, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB12_126:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	%xmm0, (%r12,%rdi,8)
	movdqu	%xmm0, 16(%r12,%rdi,8)
	addq	$4, %rdi
	cmpq	%rdi, %rsi
	jne	.LBB12_126
# %bb.127:                              #   in Loop: Header=BB12_116 Depth=2
	cmpq	%rsi, %r13
	je	.LBB12_114
	.p2align	4, 0x90
.LBB12_128:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, (%rdx)
	addq	$8, %rdx
	cmpq	%rax, %rdx
	jne	.LBB12_128
	jmp	.LBB12_114
.LBB12_129:                             #   in Loop: Header=BB12_116 Depth=2
	xorl	%eax, %eax
.LBB12_130:                             #   in Loop: Header=BB12_116 Depth=2
	leaq	(%rax,%rbp,8), %rdx
	leaq	(%rdx,%r13,8), %rcx
	movq	160(%rsp), %rbp                 # 8-byte Reload
	movq	(%rbp,%r15,8), %rsi
	movabsq	$2305843009213693951, %rdi      # imm = 0x1FFFFFFFFFFFFFFF
	addq	%rdi, %r13
	andq	%rdi, %r13
	movq	%rdx, %rdi
	cmpq	$3, %r13
	jb	.LBB12_134
# %bb.131:                              #   in Loop: Header=BB12_116 Depth=2
	incq	%r13
	movq	%r13, %r8
	movabsq	$4611686018427387900, %rdi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rdi, %r8
	leaq	(%rdx,%r8,8), %rdi
	movq	%rsi, %xmm0
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	leaq	(%rax,%r11), %r9
	addq	$16, %r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB12_132:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	%xmm0, -16(%r9,%r10,8)
	movdqu	%xmm0, (%r9,%r10,8)
	addq	$4, %r10
	cmpq	%r10, %r8
	jne	.LBB12_132
# %bb.133:                              #   in Loop: Header=BB12_116 Depth=2
	cmpq	%r8, %r13
	je	.LBB12_135
	.p2align	4, 0x90
.LBB12_134:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rsi, (%rdi)
	addq	$8, %rdi
	cmpq	%rcx, %rdi
	jne	.LBB12_134
.LBB12_135:                             #   in Loop: Header=BB12_116 Depth=2
	cmpq	%r12, %rbx
	je	.LBB12_142
# %bb.136:                              #   in Loop: Header=BB12_116 Depth=2
	leaq	-8(%r11), %rsi
	cmpq	$56, %rsi
	jb	.LBB12_141
# %bb.137:                              #   in Loop: Header=BB12_116 Depth=2
	movq	%r12, %r8
	subq	%r11, %r8
	subq	%rax, %r8
	cmpq	$32, %r8
	jb	.LBB12_141
# %bb.138:                              #   in Loop: Header=BB12_116 Depth=2
	shrq	$3, %rsi
	incq	%rsi
	movq	%rsi, %rdi
	movabsq	$4611686018427387900, %r8       # imm = 0x3FFFFFFFFFFFFFFC
	andq	%r8, %rdi
	leaq	(,%rdi,8), %r8
	subq	%r8, %rdx
	subq	%r8, %r12
	leaq	(%rbx,%r11), %r8
	addq	$-16, %r8
	leaq	(%rax,%r11), %r9
	addq	$-16, %r9
	movq	%rsi, %r10
	andq	$-4, %r10
	negq	%r10
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB12_139:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	-16(%r8,%r11,8), %xmm0
	movdqu	(%r8,%r11,8), %xmm1
	movdqu	%xmm1, (%r9,%r11,8)
	movdqu	%xmm0, -16(%r9,%r11,8)
	addq	$-4, %r11
	cmpq	%r11, %r10
	jne	.LBB12_139
# %bb.140:                              #   in Loop: Header=BB12_116 Depth=2
	cmpq	%rdi, %rsi
	je	.LBB12_142
	.p2align	4, 0x90
.LBB12_141:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_116 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-8(%r12), %rsi
	addq	$-8, %r12
	movq	%rsi, -8(%rdx)
	addq	$-8, %rdx
	cmpq	%rbx, %r12
	jne	.LBB12_141
.LBB12_142:                             #   in Loop: Header=BB12_116 Depth=2
	movq	8(%rsp), %rsi                   # 8-byte Reload
	leaq	(%rax,%rsi,8), %rax
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rax, 96(%rsp)
	testq	%rbx, %rbx
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	je	.LBB12_115
# %bb.143:                              #   in Loop: Header=BB12_116 Depth=2
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_115
	.p2align	4, 0x90
.LBB12_144:                             #   in Loop: Header=BB12_81 Depth=1
	movq	80(%rsp), %rsi
	movq	88(%rsp), %rcx
.LBB12_145:                             #   in Loop: Header=BB12_81 Depth=1
	subq	%rsi, %rcx
	sarq	$3, %rcx
	cmpq	$2, %rcx
	movabsq	$-7046029254386353131, %r8      # imm = 0x9E3779B97F4A7C15
	movabsq	$-7723592293110705685, %r9      # imm = 0x94D049BB133111EB
	jb	.LBB12_148
# %bb.146:                              #   in Loop: Header=BB12_81 Depth=1
	addq	%r8, %r14
	.p2align	4, 0x90
.LBB12_147:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, %rax
	shrq	$30, %rax
	xorq	%r14, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	imulq	%r9, %rdx
	movq	%rdx, %rax
	shrq	$31, %rax
	xorq	%rdx, %rax
	mulq	%rcx
	movq	-8(%rsi,%rcx,8), %rax
	movq	(%rsi,%rdx,8), %rdi
	movq	%rdi, -8(%rsi,%rcx,8)
	leaq	-1(%rcx), %rdi
	movq	%rax, (%rsi,%rdx,8)
	addq	%r8, %r14
	movq	%rdi, %rcx
	cmpq	$1, %rdi
	ja	.LBB12_147
.LBB12_148:                             #   in Loop: Header=BB12_81 Depth=1
	testq	%r13, %r13
	je	.LBB12_150
# %bb.149:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r13, %rdi
	callq	_ZdlPv@PLT
.LBB12_150:                             #   in Loop: Header=BB12_81 Depth=1
	testq	%rbp, %rbp
	je	.LBB12_153
# %bb.151:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbp, %rdi
.LBB12_152:                             #   in Loop: Header=BB12_81 Depth=1
	callq	_ZdlPv@PLT
.LBB12_153:                             #   in Loop: Header=BB12_81 Depth=1
	movq	368(%rsp), %rbx
	movq	152(%rsp), %rax                 # 8-byte Reload
	leaq	(%rax,%rax,2), %r13
	leaq	(%rbx,%r13,8), %r14
	movq	(%rbx,%r13,8), %rdi
	testq	%rdi, %rdi
	pxor	%xmm1, %xmm1
	je	.LBB12_155
# %bb.154:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rdi, 8(%rbx,%r13,8)
	callq	_ZdlPv@PLT
	pxor	%xmm1, %xmm1
	movdqu	%xmm1, (%r14)
	movq	$0, 16(%r14)
.LBB12_155:                             #   in Loop: Header=BB12_81 Depth=1
	movdqa	80(%rsp), %xmm0
	movdqu	%xmm0, (%r14)
	movq	96(%rsp), %rax
	movq	152(%rsp), %rcx                 # 8-byte Reload
	leaq	(,%rcx,8), %rcx
	leaq	(%rcx,%rcx,2), %rcx
	movq	%rax, 16(%rbx,%rcx)
	movq	368(%rsp), %rax
	movq	(%rax,%rcx), %r15
	movq	8(%rax,%rcx), %r12
	movdqa	%xmm1, 608(%rsp)
	movq	$0, 624(%rsp)
	subq	%r15, %r12
	je	.LBB12_159
# %bb.156:                              #   in Loop: Header=BB12_81 Depth=1
	js	.LBB12_474
# %bb.157:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp143:
	movq	%r12, %rdi
	callq	_Znwm@PLT
.Ltmp144:
# %bb.158:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %r14
	movq	%rax, %rbx
	addq	%r12, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	jmp	.LBB12_160
	.p2align	4, 0x90
.LBB12_159:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
.LBB12_160:                             #   in Loop: Header=BB12_81 Depth=1
.Ltmp149:
	movq	%r14, %rdi
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdx
	callq	_ZNSt3__16__sortIRNS_6__lessImmEEPmEEvT0_S5_T_@PLT
.Ltmp150:
# %bb.161:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbx, %r15
	cmpq	%rbx, %r14
	je	.LBB12_175
# %bb.162:                              #   in Loop: Header=BB12_81 Depth=1
	leaq	8(%r14), %rdx
	.p2align	4, 0x90
.LBB12_163:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%rbx, %rdx
	je	.LBB12_170
# %bb.164:                              #   in Loop: Header=BB12_163 Depth=2
	movq	-8(%rdx), %rax
	leaq	8(%rdx), %rcx
	cmpq	(%rdx), %rax
	movq	%rcx, %rdx
	jne	.LBB12_163
# %bb.165:                              #   in Loop: Header=BB12_81 Depth=1
	leaq	-16(%rcx), %r12
	jmp	.LBB12_167
	.p2align	4, 0x90
.LBB12_166:                             #   in Loop: Header=BB12_167 Depth=2
	addq	$8, %rcx
.LBB12_167:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%rbx, %rcx
	je	.LBB12_171
# %bb.168:                              #   in Loop: Header=BB12_167 Depth=2
	movq	%rax, %rdx
	movq	(%rcx), %rax
	cmpq	%rax, %rdx
	je	.LBB12_166
# %bb.169:                              #   in Loop: Header=BB12_167 Depth=2
	movq	%rax, 8(%r12)
	addq	$8, %r12
	jmp	.LBB12_166
	.p2align	4, 0x90
.LBB12_170:                             #   in Loop: Header=BB12_81 Depth=1
	movq	%rbx, %r15
	jmp	.LBB12_175
	.p2align	4, 0x90
.LBB12_171:                             #   in Loop: Header=BB12_81 Depth=1
	addq	$8, %r12
	movq	%rbx, %r15
	cmpq	%rbx, %r12
	je	.LBB12_175
# %bb.172:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbx, %rsi
	subq	%r12, %rsi
	addq	%r12, %rsi
	movq	%rbx, %r15
	subq	%rsi, %r15
	je	.LBB12_174
# %bb.173:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r12, %rdi
	movq	%r15, %rdx
	callq	memmove@PLT
.LBB12_174:                             #   in Loop: Header=BB12_81 Depth=1
	addq	%r15, %r12
	movq	%r12, %r15
	.p2align	4, 0x90
.LBB12_175:                             #   in Loop: Header=BB12_81 Depth=1
	movq	288(%rsp), %r12
	leaq	(%r12,%r13,8), %rbp
	movq	(%r12,%r13,8), %rdi
	testq	%rdi, %rdi
	je	.LBB12_80
# %bb.176:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rdi, 8(%r12,%r13,8)
	callq	_ZdlPv@PLT
	pxor	%xmm0, %xmm0
	movdqu	%xmm0, (%rbp)
	movq	$0, 16(%rbp)
	jmp	.LBB12_80
.LBB12_177:                             #   in Loop: Header=BB12_81 Depth=1
	movq	152(%rsp), %rax                 # 8-byte Reload
	incq	%rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	movabsq	$-4658895280553007687, %rdx     # imm = 0xBF58476D1CE4E5B9
	imulq	%rdx, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	movabsq	$-7723592293110705685, %r15     # imm = 0x94D049BB133111EB
	imulq	%r15, %rax
	movq	256(%rsp), %rcx                 # 8-byte Reload
	xorq	%rax, %rcx
	shrq	$31, %rax
	xorq	%rcx, %rax
	movabsq	$18691697679587, %rcx           # imm = 0x110000001CE3
	xorq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%rdx, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	imulq	%r15, %rax
	movq	%rax, %rcx
	shrq	$31, %rcx
	xorq	%rax, %rcx
	movq	%rcx, %rbp
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 608(%rsp)
	movq	$0, 624(%rsp)
	testq	%r12, %r12
	je	.LBB12_186
# %bb.178:                              #   in Loop: Header=BB12_81 Depth=1
	movabsq	$2305843009213693951, %rax      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rax, %r12
	movabsq	$-7046029254386353131, %r14     # imm = 0x9E3779B97F4A7C15
	ja	.LBB12_488
# %bb.179:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp89:
	movq	504(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp90:
# %bb.180:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %r15
	movq	%rax, 608(%rsp)
	leaq	(%rax,%r12,8), %rax
	movq	%rax, 624(%rsp)
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	memset@PLT
	leaq	(%r15,%r13), %rax
	movq	%rax, %r9
	movq	%rax, 616(%rsp)
	cmpq	$0, 496(%rsp)                   # 8-byte Folded Reload
	je	.LBB12_187
# %bb.181:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r15, %rax
	addq	440(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rbp, %xmm0
	addq	448(%rsp), %rbp                 # 8-byte Folded Reload
	pshufd	$68, %xmm0, %xmm0               # xmm0 = xmm0[0,1,0,1]
	paddq	.LCPI12_0(%rip), %xmm0
	xorl	%ecx, %ecx
	movq	456(%rsp), %rdx                 # 8-byte Reload
	movdqa	.LCPI12_1(%rip), %xmm4          # xmm4 = [11400714819323198485,11400714819323198485]
	movdqa	.LCPI12_2(%rip), %xmm5          # xmm5 = [13787848793156543929,13787848793156543929]
	movdqa	.LCPI12_3(%rip), %xmm6          # xmm6 = [3210233709,3210233709]
	movdqa	.LCPI12_4(%rip), %xmm7          # xmm7 = [10723151780598845931,10723151780598845931]
	movdqa	.LCPI12_5(%rip), %xmm8          # xmm8 = [2496678331,2496678331]
	movdqa	.LCPI12_6(%rip), %xmm9          # xmm9 = [4354685564936845354,4354685564936845354]
	.p2align	4, 0x90
.LBB12_182:                             #   Parent Loop BB12_81 Depth=1
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
	movdqu	%xmm2, (%r15,%rcx,8)
	addq	$2, %rcx
	paddq	%xmm9, %xmm0
	cmpq	%rcx, %rdx
	jne	.LBB12_182
# %bb.183:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r15, %r8
	cmpq	%rdx, 464(%rsp)                 # 8-byte Folded Reload
	jne	.LBB12_188
# %bb.184:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r8, %rdi
	movq	%r9, %rsi
	jmp	.LBB12_191
.LBB12_185:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%ecx, %ecx
	movq	%rcx, %rsi
	testq	%r15, %r15
	jne	.LBB12_113
	jmp	.LBB12_145
.LBB12_186:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%edi, %edi
	xorl	%esi, %esi
	movabsq	$-7046029254386353131, %r14     # imm = 0x9E3779B97F4A7C15
	jmp	.LBB12_191
.LBB12_187:                             #   in Loop: Header=BB12_81 Depth=1
	movq	%r15, %r8
	movq	%r15, %rax
.LBB12_188:                             #   in Loop: Header=BB12_81 Depth=1
	movabsq	$-4658895280553007687, %rsi     # imm = 0xBF58476D1CE4E5B9
	movq	%rbp, %rdi
	movabsq	$-7723592293110705685, %r10     # imm = 0x94D049BB133111EB
	.p2align	4, 0x90
.LBB12_189:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	%r14, %rdi
	movq	%rdi, %rcx
	shrq	$30, %rcx
	xorq	%rdi, %rcx
	imulq	%rsi, %rcx
	movq	%rcx, %rdx
	shrq	$27, %rdx
	xorq	%rcx, %rdx
	imulq	%r10, %rdx
	movq	%rdx, %rcx
	shrq	$31, %rcx
	xorq	%rdx, %rcx
	movq	%rcx, (%rax)
	addq	$8, %rax
	cmpq	%r9, %rax
	jne	.LBB12_189
# %bb.190:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r9, %rsi
	movq	%rdi, %rbp
	movq	%r8, %rdi
.LBB12_191:                             #   in Loop: Header=BB12_81 Depth=1
.Ltmp95:
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movq	%rsi, %r15
	leaq	16(%rsp), %rdx
	callq	_ZNSt3__16__sortIRNS_6__lessImmEEPmEEvT0_S5_T_@PLT
.Ltmp96:
# %bb.192:                              #   in Loop: Header=BB12_81 Depth=1
	testq	%r12, %r12
	je	.LBB12_206
# %bb.193:                              #   in Loop: Header=BB12_81 Depth=1
	movq	8(%rsp), %rax                   # 8-byte Reload
	leaq	8(%rax), %rdx
	.p2align	4, 0x90
.LBB12_194:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%r15, %rdx
	je	.LBB12_206
# %bb.195:                              #   in Loop: Header=BB12_194 Depth=2
	movq	-8(%rdx), %rax
	leaq	8(%rdx), %rcx
	cmpq	(%rdx), %rax
	movq	%rcx, %rdx
	jne	.LBB12_194
# %bb.196:                              #   in Loop: Header=BB12_81 Depth=1
	leaq	-16(%rcx), %rbx
	jmp	.LBB12_198
	.p2align	4, 0x90
.LBB12_197:                             #   in Loop: Header=BB12_198 Depth=2
	addq	$8, %rcx
.LBB12_198:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpq	%r15, %rcx
	je	.LBB12_201
# %bb.199:                              #   in Loop: Header=BB12_198 Depth=2
	movq	%rax, %rdx
	movq	(%rcx), %rax
	cmpq	%rax, %rdx
	je	.LBB12_197
# %bb.200:                              #   in Loop: Header=BB12_198 Depth=2
	movq	%rax, 8(%rbx)
	addq	$8, %rbx
	jmp	.LBB12_197
.LBB12_201:                             #   in Loop: Header=BB12_81 Depth=1
	addq	$8, %rbx
	cmpq	%r15, %rbx
	je	.LBB12_205
# %bb.202:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r15, %r13
	movq	%r15, %rsi
	subq	%rbx, %rsi
	addq	%rbx, %rsi
	subq	%rsi, %r13
	je	.LBB12_204
# %bb.203:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rbx, %rdi
	movq	%r13, %rdx
	callq	memmove@PLT
.LBB12_204:                             #   in Loop: Header=BB12_81 Depth=1
	addq	%rbx, %r13
	movq	%r13, %r15
	movq	%r13, 616(%rsp)
.LBB12_205:                             #   in Loop: Header=BB12_81 Depth=1
	movq	136(%rsp), %rbx                 # 8-byte Reload
.LBB12_206:                             #   in Loop: Header=BB12_81 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 16(%rsp)
	movq	$0, 32(%rsp)
	cmpq	%r12, %rbx
	jne	.LBB12_208
# %bb.207:                              #   in Loop: Header=BB12_81 Depth=1
	xorl	%r13d, %r13d
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	movq	8(%rsp), %rbx                   # 8-byte Reload
	jmp	.LBB12_211
.LBB12_208:                             #   in Loop: Header=BB12_81 Depth=1
	movq	488(%rsp), %rax                 # 8-byte Reload
	cmpq	%rax, 264(%rsp)                 # 8-byte Folded Reload
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	movq	8(%rsp), %rbx                   # 8-byte Reload
	ja	.LBB12_498
# %bb.209:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp98:
	movq	480(%rsp), %rdi                 # 8-byte Reload
	callq	_Znwm@PLT
.Ltmp99:
# %bb.210:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %r13
	movq	472(%rsp), %rax                 # 8-byte Reload
	leaq	(,%rax,8), %rax
	addq	%r13, %rax
	movq	%r13, 16(%rsp)
	movq	%r13, 24(%rsp)
	movq	%rax, 32(%rsp)
.LBB12_211:                             #   in Loop: Header=BB12_81 Depth=1
	subq	%rbx, %r15
	sarq	$3, %r15
	leaq	(%r14,%rbp), %rax
	movq	%rbp, %rsi
	movq	%rax, %rcx
	shrq	$30, %rcx
	xorq	%rax, %rcx
	imulq	%r12, %rcx
	movq	%rcx, %rax
	shrq	$27, %rax
	xorq	%rcx, %rax
	movabsq	$-7723592293110705685, %r8      # imm = 0x94D049BB133111EB
	imulq	%r8, %rax
	movq	%rax, %rcx
	shrq	$31, %rcx
	xorq	%rax, %rcx
	movq	%r15, %rax
	mulq	%rcx
	movabsq	$4354685564936845354, %rax      # imm = 0x3C6EF372FE94F82A
	addq	%rax, %rsi
	cmpq	$2, 168(%rsp)                   # 8-byte Folded Reload
	movq	%rsi, 176(%rsp)                 # 8-byte Spill
	jae	.LBB12_213
# %bb.212:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%r13, %rbp
	jmp	.LBB12_241
.LBB12_213:                             #   in Loop: Header=BB12_81 Depth=1
	movq	%r15, %rdi
	movq	%rdx, %r9
	movq	%rsi, %rax
	shrq	$30, %rax
	xorq	%rsi, %rax
	imulq	%r12, %rax
	movq	%rax, %rcx
	shrq	$27, %rcx
	xorq	%rax, %rcx
	imulq	%r8, %rcx
	movq	%rcx, %rsi
	shrq	$31, %rsi
	xorq	%rcx, %rsi
	orq	$1, %rsi
	xorl	%r15d, %r15d
	movq	%rdi, 160(%rsp)                 # 8-byte Spill
	movq	%rdx, 280(%rsp)                 # 8-byte Spill
	movq	%rsi, 320(%rsp)                 # 8-byte Spill
	jmp	.LBB12_216
	.p2align	4, 0x90
.LBB12_214:                             #   in Loop: Header=BB12_216 Depth=2
	movq	(%rbx,%r8,8), %rax
	movq	%rax, (%r13)
	addq	$8, %r13
	movq	%r13, 24(%rsp)
	incq	%r15
	cmpq	144(%rsp), %r15                 # 8-byte Folded Reload
	je	.LBB12_239
.LBB12_216:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_237 Depth 3
                                        #       Child Loop BB12_228 Depth 3
	movq	%r15, %rax
	imulq	%rsi, %rax
	addq	%r9, %rax
	movq	%rax, %rcx
	orq	%rdi, %rcx
	shrq	$32, %rcx
	je	.LBB12_218
# %bb.217:                              #   in Loop: Header=BB12_216 Depth=2
	xorl	%edx, %edx
	divq	%rdi
	movq	%rdx, %r8
	movq	32(%rsp), %rax
	cmpq	%rax, %r13
	jb	.LBB12_214
	jmp	.LBB12_219
	.p2align	4, 0x90
.LBB12_218:                             #   in Loop: Header=BB12_216 Depth=2
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%edi
	movl	%edx, %r8d
	movq	32(%rsp), %rax
	cmpq	%rax, %r13
	jb	.LBB12_214
.LBB12_219:                             #   in Loop: Header=BB12_216 Depth=2
	movq	16(%rsp), %r14
	movq	%r13, %rbx
	subq	%r14, %rbx
	movq	%rbx, %rbp
	sarq	$3, %rbp
	leaq	1(%rbp), %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	ja	.LBB12_460
# %bb.220:                              #   in Loop: Header=BB12_216 Depth=2
	subq	%r14, %rax
	movq	%rax, %r12
	sarq	$2, %r12
	cmpq	%rcx, %r12
	cmovbeq	%rcx, %r12
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %r12
	testq	%r12, %r12
	je	.LBB12_224
# %bb.221:                              #   in Loop: Header=BB12_216 Depth=2
	movq	%r8, 232(%rsp)                  # 8-byte Spill
	cmpq	%rdx, %r12
	ja	.LBB12_466
# %bb.222:                              #   in Loop: Header=BB12_216 Depth=2
	leaq	(,%r12,8), %rdi
.Ltmp104:
	callq	_Znwm@PLT
.Ltmp105:
# %bb.223:                              #   in Loop: Header=BB12_216 Depth=2
	movq	232(%rsp), %r8                  # 8-byte Reload
	jmp	.LBB12_225
.LBB12_224:                             #   in Loop: Header=BB12_216 Depth=2
	xorl	%eax, %eax
.LBB12_225:                             #   in Loop: Header=BB12_216 Depth=2
	leaq	(%rax,%rbp,8), %rcx
	movq	8(%rsp), %rdx                   # 8-byte Reload
	movq	(%rdx,%r8,8), %rdx
	movq	%rdx, (%rax,%rbp,8)
	movq	%r13, %rdx
	subq	%r14, %rdx
	je	.LBB12_229
# %bb.226:                              #   in Loop: Header=BB12_216 Depth=2
	addq	$-8, %rdx
	cmpq	$456, %rdx                      # imm = 0x1C8
	jae	.LBB12_233
.LBB12_227:                             #   in Loop: Header=BB12_216 Depth=2
	movq	%r13, %rsi
	movq	8(%rsp), %rbx                   # 8-byte Reload
	.p2align	4, 0x90
.LBB12_228:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_216 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-8(%rsi), %rdx
	addq	$-8, %rsi
	movq	%rdx, -8(%rcx)
	addq	$-8, %rcx
	cmpq	%r14, %rsi
	jne	.LBB12_228
	jmp	.LBB12_230
.LBB12_229:                             #   in Loop: Header=BB12_216 Depth=2
	movq	8(%rsp), %rbx                   # 8-byte Reload
.LBB12_230:                             #   in Loop: Header=BB12_216 Depth=2
	leaq	(%rax,%r12,8), %rdx
	leaq	(%rax,%rbp,8), %r13
	addq	$8, %r13
	movq	%rcx, 16(%rsp)
	movq	%r13, 24(%rsp)
	movq	%rdx, 32(%rsp)
	testq	%r14, %r14
	je	.LBB12_232
# %bb.231:                              #   in Loop: Header=BB12_216 Depth=2
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
.LBB12_232:                             #   in Loop: Header=BB12_216 Depth=2
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	movq	160(%rsp), %rdi                 # 8-byte Reload
	movq	280(%rsp), %r9                  # 8-byte Reload
	movq	320(%rsp), %rsi                 # 8-byte Reload
	movq	%r13, 24(%rsp)
	incq	%r15
	cmpq	144(%rsp), %r15                 # 8-byte Folded Reload
	jne	.LBB12_216
	jmp	.LBB12_239
.LBB12_233:                             #   in Loop: Header=BB12_216 Depth=2
	leaq	-8(%r13), %rsi
	movq	%rsi, %rdi
	subq	%r14, %rdi
	andq	$-8, %rdi
	leaq	(%rax,%rbx), %r8
	addq	$-8, %r8
	movq	%r8, %r9
	subq	%rdi, %r9
	cmpq	%r8, %r9
	ja	.LBB12_227
# %bb.234:                              #   in Loop: Header=BB12_216 Depth=2
	movq	%rsi, %r8
	subq	%rdi, %r8
	cmpq	%rsi, %r8
	ja	.LBB12_227
# %bb.235:                              #   in Loop: Header=BB12_216 Depth=2
	movq	%r13, %rdi
	subq	%rbx, %rdi
	subq	%rax, %rdi
	cmpq	$32, %rdi
	jb	.LBB12_227
# %bb.236:                              #   in Loop: Header=BB12_216 Depth=2
	shrq	$3, %rdx
	incq	%rdx
	movq	%rdx, %rdi
	movabsq	$4611686018427387900, %rsi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rsi, %rdi
	leaq	(,%rdi,8), %r8
	subq	%r8, %rcx
	movq	%r13, %rsi
	subq	%r8, %rsi
	leaq	(%rax,%rbx), %r8
	addq	$-16, %r8
	movq	%rdx, %r9
	andq	$-4, %r9
	negq	%r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB12_237:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_216 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	-32(%r13,%r10,8), %xmm0
	movdqu	-16(%r13,%r10,8), %xmm1
	movdqu	%xmm1, (%r8,%r10,8)
	movdqu	%xmm0, -16(%r8,%r10,8)
	addq	$-4, %r10
	cmpq	%r10, %r9
	jne	.LBB12_237
# %bb.238:                              #   in Loop: Header=BB12_216 Depth=2
	cmpq	%rdi, %rdx
	movq	8(%rsp), %rbx                   # 8-byte Reload
	jne	.LBB12_228
	jmp	.LBB12_230
.LBB12_239:                             #   in Loop: Header=BB12_81 Depth=1
	movq	16(%rsp), %rbp
	jmp	.LBB12_241
	.p2align	4, 0x90
.LBB12_240:                             #   in Loop: Header=BB12_241 Depth=2
	movq	%rbx, (%r13)
	addq	$8, %r13
	movq	%r13, 24(%rsp)
.LBB12_241:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_262 Depth 3
                                        #       Child Loop BB12_251 Depth 3
	movq	%r13, %r14
	subq	%rbp, %r14
	movq	%r14, %r15
	sarq	$3, %r15
	cmpq	168(%rsp), %r15                 # 8-byte Folded Reload
	jae	.LBB12_264
# %bb.242:                              #   in Loop: Header=BB12_241 Depth=2
	movabsq	$-7046029254386353131, %rax     # imm = 0x9E3779B97F4A7C15
	movq	176(%rsp), %rdx                 # 8-byte Reload
	addq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$30, %rax
	xorq	%rdx, %rax
	imulq	%r12, %rax
	movq	%rax, %rcx
	shrq	$27, %rcx
	xorq	%rax, %rcx
	movabsq	$-7723592293110705685, %rax     # imm = 0x94D049BB133111EB
	imulq	%rax, %rcx
	movq	%rcx, %rbx
	shrq	$31, %rbx
	xorq	%rcx, %rbx
	movq	32(%rsp), %rax
	cmpq	%rax, %r13
	movq	%rdx, 176(%rsp)                 # 8-byte Spill
	jb	.LBB12_240
# %bb.243:                              #   in Loop: Header=BB12_241 Depth=2
	leaq	1(%r15), %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	ja	.LBB12_464
# %bb.244:                              #   in Loop: Header=BB12_241 Depth=2
	subq	%rbp, %rax
	movq	%rax, %r14
	sarq	$2, %r14
	cmpq	%rcx, %r14
	cmovbeq	%rcx, %r14
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %r14
	testq	%r14, %r14
	je	.LBB12_247
# %bb.245:                              #   in Loop: Header=BB12_241 Depth=2
	cmpq	%rdx, %r14
	ja	.LBB12_470
# %bb.246:                              #   in Loop: Header=BB12_241 Depth=2
	leaq	(,%r14,8), %rdi
.Ltmp112:
	callq	_Znwm@PLT
.Ltmp113:
	jmp	.LBB12_248
.LBB12_247:                             #   in Loop: Header=BB12_241 Depth=2
	xorl	%eax, %eax
.LBB12_248:                             #   in Loop: Header=BB12_241 Depth=2
	leaq	(%rax,%r15,8), %rcx
	movq	%rbx, (%rax,%r15,8)
	movq	%r13, %rdx
	subq	%rbp, %rdx
	je	.LBB12_252
# %bb.249:                              #   in Loop: Header=BB12_241 Depth=2
	addq	$-8, %rdx
	cmpq	$456, %rdx                      # imm = 0x1C8
	jae	.LBB12_255
# %bb.250:                              #   in Loop: Header=BB12_241 Depth=2
	movq	%r13, %rsi
	.p2align	4, 0x90
.LBB12_251:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_241 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-8(%rsi), %rdx
	addq	$-8, %rsi
	movq	%rdx, -8(%rcx)
	addq	$-8, %rcx
	cmpq	%rbp, %rsi
	jne	.LBB12_251
.LBB12_252:                             #   in Loop: Header=BB12_241 Depth=2
	leaq	(%rax,%r14,8), %rdx
	leaq	(%rax,%r15,8), %r13
	addq	$8, %r13
	movq	%rcx, 16(%rsp)
	movq	%r13, 24(%rsp)
	movq	%rdx, 32(%rsp)
	testq	%rbp, %rbp
	je	.LBB12_254
# %bb.253:                              #   in Loop: Header=BB12_241 Depth=2
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	movq	16(%rsp), %rbp
	movq	%r13, 24(%rsp)
	jmp	.LBB12_241
.LBB12_254:                             #   in Loop: Header=BB12_241 Depth=2
	movq	%rcx, %rbp
	movq	%r13, 24(%rsp)
	jmp	.LBB12_241
.LBB12_255:                             #   in Loop: Header=BB12_241 Depth=2
	leaq	-8(%r13), %rsi
	movq	%rsi, %rdi
	subq	%rbp, %rdi
	andq	$-8, %rdi
	leaq	(%rax,%r15,8), %r8
	addq	$-8, %r8
	movq	%r8, %r9
	subq	%rdi, %r9
	cmpq	%r8, %r9
	ja	.LBB12_260
# %bb.256:                              #   in Loop: Header=BB12_241 Depth=2
	movq	%rsi, %r8
	subq	%rdi, %r8
	cmpq	%rsi, %r8
	ja	.LBB12_259
# %bb.257:                              #   in Loop: Header=BB12_241 Depth=2
	leaq	(%rax,%r15,8), %rsi
	movq	%r13, %rdi
	subq	%rsi, %rdi
	cmpq	$32, %rdi
	jae	.LBB12_261
# %bb.258:                              #   in Loop: Header=BB12_241 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_251
.LBB12_259:                             #   in Loop: Header=BB12_241 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_251
.LBB12_260:                             #   in Loop: Header=BB12_241 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_251
.LBB12_261:                             #   in Loop: Header=BB12_241 Depth=2
	shrq	$3, %rdx
	incq	%rdx
	leaq	(,%r15,8), %r8
	movq	%rdx, %rdi
	movabsq	$4611686018427387900, %rsi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rsi, %rdi
	leaq	(,%rdi,8), %r9
	subq	%r9, %rcx
	movq	%r13, %rsi
	subq	%r9, %rsi
	addq	%rax, %r8
	addq	$-16, %r8
	movq	%rdx, %r9
	andq	$-4, %r9
	negq	%r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB12_262:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_241 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	-32(%r13,%r10,8), %xmm0
	movdqu	-16(%r13,%r10,8), %xmm1
	movdqu	%xmm1, (%r8,%r10,8)
	movdqu	%xmm0, -16(%r8,%r10,8)
	addq	$-4, %r10
	cmpq	%r10, %r9
	jne	.LBB12_262
# %bb.263:                              #   in Loop: Header=BB12_241 Depth=2
	cmpq	%rdi, %rdx
	jne	.LBB12_251
	jmp	.LBB12_252
.LBB12_264:                             #   in Loop: Header=BB12_81 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 192(%rsp)
	movq	$0, 208(%rsp)
	cmpq	%rbp, %r13
	je	.LBB12_268
# %bb.265:                              #   in Loop: Header=BB12_81 Depth=1
	testq	%r14, %r14
	js	.LBB12_486
# %bb.266:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp120:
	movq	%r14, %rdi
	callq	_Znwm@PLT
.Ltmp121:
	movabsq	$-7046029254386353131, %r15     # imm = 0x9E3779B97F4A7C15
# %bb.267:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, %rbx
	movq	%rax, 192(%rsp)
	movq	%rax, 200(%rsp)
	movq	%rax, %r13
	addq	%r14, %r13
	movq	%r13, 208(%rsp)
	movq	%rax, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movq	%r13, 200(%rsp)
	jmp	.LBB12_269
.LBB12_268:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%ebx, %ebx
	xorl	%r13d, %r13d
	movabsq	$-7046029254386353131, %r15     # imm = 0x9E3779B97F4A7C15
.LBB12_269:                             #   in Loop: Header=BB12_81 Depth=1
	movq	%r13, %rbp
	subq	%rbx, %rbp
	sarq	$3, %rbp
	cmpq	264(%rsp), %rbp                 # 8-byte Folded Reload
	movq	176(%rsp), %r8                  # 8-byte Reload
	jb	.LBB12_279
.LBB12_270:                             #   in Loop: Header=BB12_81 Depth=1
	cmpq	$2, %rbp
	movabsq	$-7723592293110705685, %rdi     # imm = 0x94D049BB133111EB
	jb	.LBB12_273
# %bb.271:                              #   in Loop: Header=BB12_81 Depth=1
	addq	%r15, %r8
	movq	%rbp, %rcx
	.p2align	4, 0x90
.LBB12_272:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r8, %rax
	shrq	$30, %rax
	xorq	%r8, %rax
	imulq	%r12, %rax
	movq	%rax, %rdx
	shrq	$27, %rdx
	xorq	%rax, %rdx
	imulq	%rdi, %rdx
	movq	%rdx, %rax
	shrq	$31, %rax
	xorq	%rdx, %rax
	mulq	%rcx
	movq	-8(%rbx,%rcx,8), %rax
	movq	(%rbx,%rdx,8), %rsi
	movq	%rsi, -8(%rbx,%rcx,8)
	leaq	-1(%rcx), %rsi
	movq	%rax, (%rbx,%rdx,8)
	addq	%r15, %r8
	movq	%rsi, %rcx
	cmpq	$1, %rsi
	ja	.LBB12_272
.LBB12_273:                             #   in Loop: Header=BB12_81 Depth=1
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 80(%rsp)
	movq	$0, 96(%rsp)
	movq	608(%rsp), %r14
	movq	616(%rsp), %r15
	subq	%r14, %r15
	je	.LBB12_304
# %bb.274:                              #   in Loop: Header=BB12_81 Depth=1
	js	.LBB12_484
# %bb.275:                              #   in Loop: Header=BB12_81 Depth=1
.Ltmp134:
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp135:
# %bb.276:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rax, 80(%rsp)
	movq	%rax, %r12
	addq	%r15, %r12
	movq	%r12, 96(%rsp)
	movq	%rax, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
	movq	%r12, %rsi
	movq	%r12, 88(%rsp)
	jmp	.LBB12_305
	.p2align	4, 0x90
.LBB12_277:                             #   in Loop: Header=BB12_279 Depth=2
	movq	(%r15,%rdx,8), %rax
	movq	%rax, (%r13)
	addq	$8, %r13
	movabsq	$-7046029254386353131, %r15     # imm = 0x9E3779B97F4A7C15
.LBB12_278:                             #   in Loop: Header=BB12_279 Depth=2
	movq	%r13, 200(%rsp)
	movq	%r13, %rbp
	subq	%rbx, %rbp
	sarq	$3, %rbp
	cmpq	264(%rsp), %rbp                 # 8-byte Folded Reload
	jae	.LBB12_270
.LBB12_279:                             #   Parent Loop BB12_81 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_302 Depth 3
                                        #       Child Loop BB12_289 Depth 3
	addq	%r15, %r8
	movq	%r8, %rax
	shrq	$30, %rax
	xorq	%r8, %rax
	imulq	%r12, %rax
	movq	%rax, %rcx
	shrq	$27, %rcx
	xorq	%rax, %rcx
	movabsq	$-7723592293110705685, %rax     # imm = 0x94D049BB133111EB
	imulq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$31, %rax
	xorq	%rcx, %rax
	mulq	168(%rsp)                       # 8-byte Folded Reload
	movq	16(%rsp), %r15
	movq	208(%rsp), %rax
	cmpq	%rax, %r13
	jb	.LBB12_277
# %bb.280:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%r8, 176(%rsp)                  # 8-byte Spill
	leaq	1(%rbp), %rcx
	movabsq	$2305843009213693951, %rsi      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rsi, %rcx
	ja	.LBB12_462
# %bb.281:                              #   in Loop: Header=BB12_279 Depth=2
	subq	%rbx, %rax
	movq	%rax, %r14
	sarq	$2, %r14
	cmpq	%rcx, %r14
	cmovbeq	%rcx, %r14
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rsi, %r14
	testq	%r14, %r14
	je	.LBB12_285
# %bb.282:                              #   in Loop: Header=BB12_279 Depth=2
	cmpq	%rsi, %r14
	ja	.LBB12_468
# %bb.283:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%rdx, %r12
	leaq	(,%r14,8), %rdi
.Ltmp126:
	callq	_Znwm@PLT
.Ltmp127:
# %bb.284:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%r12, %rdx
	movabsq	$-4658895280553007687, %r12     # imm = 0xBF58476D1CE4E5B9
	jmp	.LBB12_286
.LBB12_285:                             #   in Loop: Header=BB12_279 Depth=2
	xorl	%eax, %eax
.LBB12_286:                             #   in Loop: Header=BB12_279 Depth=2
	leaq	(%rax,%rbp,8), %rcx
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, (%rax,%rbp,8)
	movq	%r13, %rdx
	subq	%rbx, %rdx
	je	.LBB12_290
# %bb.287:                              #   in Loop: Header=BB12_279 Depth=2
	addq	$-8, %rdx
	cmpq	$456, %rdx                      # imm = 0x1C8
	movabsq	$-7046029254386353131, %r15     # imm = 0x9E3779B97F4A7C15
	jae	.LBB12_295
# %bb.288:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%r13, %rsi
	.p2align	4, 0x90
.LBB12_289:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_279 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-8(%rsi), %rdx
	addq	$-8, %rsi
	movq	%rdx, -8(%rcx)
	addq	$-8, %rcx
	cmpq	%rbx, %rsi
	jne	.LBB12_289
	jmp	.LBB12_291
.LBB12_290:                             #   in Loop: Header=BB12_279 Depth=2
	movabsq	$-7046029254386353131, %r15     # imm = 0x9E3779B97F4A7C15
.LBB12_291:                             #   in Loop: Header=BB12_279 Depth=2
	leaq	(%rax,%r14,8), %rdx
	leaq	(%rax,%rbp,8), %r13
	addq	$8, %r13
	movq	%rcx, 192(%rsp)
	movq	%r13, 200(%rsp)
	movq	%rdx, 208(%rsp)
	testq	%rbx, %rbx
	je	.LBB12_293
# %bb.292:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%rbx, %rdi
	callq	_ZdlPv@PLT
	movq	192(%rsp), %rbx
	jmp	.LBB12_294
.LBB12_293:                             #   in Loop: Header=BB12_279 Depth=2
	movq	%rcx, %rbx
.LBB12_294:                             #   in Loop: Header=BB12_279 Depth=2
	movq	176(%rsp), %r8                  # 8-byte Reload
	jmp	.LBB12_278
.LBB12_295:                             #   in Loop: Header=BB12_279 Depth=2
	leaq	-8(%r13), %rsi
	movq	%rsi, %rdi
	subq	%rbx, %rdi
	andq	$-8, %rdi
	leaq	(%rax,%rbp,8), %r8
	addq	$-8, %r8
	movq	%r8, %r9
	subq	%rdi, %r9
	cmpq	%r8, %r9
	ja	.LBB12_300
# %bb.296:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%rsi, %r8
	subq	%rdi, %r8
	cmpq	%rsi, %r8
	ja	.LBB12_299
# %bb.297:                              #   in Loop: Header=BB12_279 Depth=2
	leaq	(%rax,%rbp,8), %rsi
	movq	%r13, %rdi
	subq	%rsi, %rdi
	cmpq	$32, %rdi
	jae	.LBB12_301
# %bb.298:                              #   in Loop: Header=BB12_279 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_289
.LBB12_299:                             #   in Loop: Header=BB12_279 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_289
.LBB12_300:                             #   in Loop: Header=BB12_279 Depth=2
	movq	%r13, %rsi
	jmp	.LBB12_289
.LBB12_301:                             #   in Loop: Header=BB12_279 Depth=2
	shrq	$3, %rdx
	incq	%rdx
	leaq	(,%rbp,8), %r8
	movq	%rdx, %rdi
	movabsq	$4611686018427387900, %rsi      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rsi, %rdi
	leaq	(,%rdi,8), %r9
	subq	%r9, %rcx
	movq	%r13, %rsi
	subq	%r9, %rsi
	addq	%rax, %r8
	addq	$-16, %r8
	movq	%rdx, %r9
	andq	$-4, %r9
	negq	%r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB12_302:                             #   Parent Loop BB12_81 Depth=1
                                        #     Parent Loop BB12_279 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movdqu	-32(%r13,%r10,8), %xmm0
	movdqu	-16(%r13,%r10,8), %xmm1
	movdqu	%xmm1, (%r8,%r10,8)
	movdqu	%xmm0, -16(%r8,%r10,8)
	addq	$-4, %r10
	cmpq	%r10, %r9
	jne	.LBB12_302
# %bb.303:                              #   in Loop: Header=BB12_279 Depth=2
	cmpq	%rdi, %rdx
	jne	.LBB12_289
	jmp	.LBB12_291
.LBB12_304:                             #   in Loop: Header=BB12_81 Depth=1
	xorl	%esi, %esi
.LBB12_305:                             #   in Loop: Header=BB12_81 Depth=1
.Ltmp140:
	leaq	80(%rsp), %rdi
	movq	%rbx, %rdx
	movq	%r13, %rcx
	movq	%rbp, %r8
	callq	_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l
.Ltmp141:
# %bb.306:                              #   in Loop: Header=BB12_81 Depth=1
	movq	192(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_308
# %bb.307:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rdi, 200(%rsp)
	callq	_ZdlPv@PLT
.LBB12_308:                             #   in Loop: Header=BB12_81 Depth=1
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_310
# %bb.309:                              #   in Loop: Header=BB12_81 Depth=1
	movq	%rdi, 24(%rsp)
	callq	_ZdlPv@PLT
.LBB12_310:                             #   in Loop: Header=BB12_81 Depth=1
	movq	608(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.LBB12_152
	jmp	.LBB12_153
.LBB12_311:
	movdqa	%xmm0, 288(%rsp)
	movq	$0, 304(%rsp)
.LBB12_312:
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 96(%rsp)
	movdqa	%xmm0, 80(%rsp)
	movzbl	112(%rsp), %eax
	testb	$1, %al
	je	.LBB12_321
# %bb.313:
	movq	120(%rsp), %rdx
	cmpq	$5, %rdx
	je	.LBB12_322
.LBB12_314:
	cmpq	$4, %rdx
	jne	.LBB12_451
# %bb.315:
	leaq	113(%rsp), %rcx
	testb	$1, %al
	je	.LBB12_317
# %bb.316:
	movq	128(%rsp), %rcx
.LBB12_317:
	cmpl	$1953656691, (%rcx)             # imm = 0x74726F73
	je	.LBB12_327
# %bb.318:
	cmpl	$1952805749, (%rcx)             # imm = 0x74657375
	je	.LBB12_320
# %bb.319:
	cmpl	$1952541798, (%rcx)             # imm = 0x74616C66
	jne	.LBB12_451
.LBB12_320:
	leaq	.L.str.12(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L.str.13(%rip), %rax
	movq	%rax, 88(%rsp)
	leaq	.L.str.14(%rip), %rax
	jmp	.LBB12_330
.LBB12_321:
	movl	%eax, %edx
	shrl	%edx
	cmpq	$5, %rdx
	jne	.LBB12_314
.LBB12_322:
	leaq	113(%rsp), %rbx
	testb	$1, %al
	je	.LBB12_324
# %bb.323:
	movq	128(%rsp), %rbx
.LBB12_324:
	leaq	.L.str.15(%rip), %rsi
	movq	%rbx, %rdi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_329
# %bb.325:
	movl	$1735550317, %eax               # imm = 0x6772656D
	xorl	(%rbx), %eax
	movzbl	4(%rbx), %ecx
	xorl	$101, %ecx
	orl	%eax, %ecx
	jne	.LBB12_451
# %bb.326:
	leaq	.L.str.18(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L.str.19(%rip), %rax
	jmp	.LBB12_328
.LBB12_327:
	leaq	.L.str(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L.str.9(%rip), %rax
.LBB12_328:
	movq	%rax, 88(%rsp)
	movl	$2, %ebp
	jmp	.LBB12_331
.LBB12_329:
	leaq	.L.str.16(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L.str.17(%rip), %rax
	movq	%rax, 88(%rsp)
	leaq	.L.str.9(%rip), %rax
.LBB12_330:
	movq	%rax, 96(%rsp)
	movl	$3, %ebp
.LBB12_331:
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 400(%rsp)
	movq	$0, 416(%rsp)
	leaq	400(%rsp), %rax
	movq	%rax, 608(%rsp)
	movb	$0, 616(%rsp)
	leal	(,%rbp,8), %eax
	leaq	(%rax,%rax,2), %rbx
.Ltmp152:
	movq	%rbx, %rdi
	callq	_Znwm@PLT
.Ltmp153:
# %bb.332:
	movq	%rax, %r14
	movq	%rax, 400(%rsp)
	leaq	(,%rbp,2), %rax
	addq	%rbp, %rax
	leaq	(%r14,%rax,8), %rax
	movq	%rax, 416(%rsp)
	addq	$-24, %rbx
	movzbl	%bl, %eax
	imull	$171, %eax, %eax
	shrl	$9, %eax
	andl	$-8, %eax
	leal	(%rax,%rax,2), %eax
	movl	%ebx, %ecx
	subb	%al, %cl
	movzbl	%cl, %eax
	subq	%rax, %rbx
	leaq	24(%rbx), %rdx
	xorl	%r15d, %r15d
	movq	%r14, %rdi
	xorl	%esi, %esi
	callq	memset@PLT
	leaq	(%r14,%rbx), %rax
	addq	$24, %rax
	movq	%rax, 408(%rsp)
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 336(%rsp)
	movq	$0, 352(%rsp)
	movq	136(%rsp), %rbx                 # 8-byte Reload
	testq	%rbx, %rbx
	je	.LBB12_336
# %bb.333:
	movabsq	$2305843009213693951, %rax      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rax, %rbx
	ja	.LBB12_504
# %bb.334:
	leaq	(,%rbx,8), %r15
.Ltmp155:
	movq	%r15, %rdi
	callq	_Znwm@PLT
.Ltmp156:
# %bb.335:
	leaq	(%rax,%rbx,8), %rcx
	movq	%rax, 336(%rsp)
	movq	%rax, 344(%rsp)
	movq	%rcx, 352(%rsp)
.LBB12_336:
.Ltmp160:
	movq	%r15, %rdi
	callq	_Znam@PLT
	movq	%rax, 256(%rsp)                 # 8-byte Spill
.Ltmp161:
# %bb.337:
	movq	%rbx, %xmm0
	punpckldq	.LCPI12_8(%rip), %xmm0  # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI12_9(%rip), %xmm0
	movapd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm1                    # xmm1 = xmm1[1],xmm0[1]
	addsd	%xmm0, %xmm1
	movapd	%xmm1, 176(%rsp)                # 16-byte Spill
	xorl	%eax, %eax
	movq	%rax, 280(%rsp)                 # 8-byte Spill
	leaq	336(%rsp), %r15
	movq	272(%rsp), %rbx                 # 8-byte Reload
	movq	%rbp, 264(%rsp)                 # 8-byte Spill
	jmp	.LBB12_339
	.p2align	4, 0x90
.LBB12_338:                             #   in Loop: Header=BB12_339 Depth=1
	testb	%bl, %bl
	movq	272(%rsp), %rbx                 # 8-byte Reload
	leaq	336(%rsp), %r15
	je	.LBB12_410
.LBB12_339:                             # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_371 Depth 2
                                        #       Child Loop BB12_384 Depth 3
                                        #       Child Loop BB12_386 Depth 3
	movq	280(%rsp), %rax                 # 8-byte Reload
	cmpq	%rbx, %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	je	.LBB12_410
# %bb.340:                              #   in Loop: Header=BB12_339 Depth=1
	movq	%rax, %rcx
	shrq	$32, %rcx
	je	.LBB12_342
# %bb.341:                              #   in Loop: Header=BB12_339 Depth=1
	xorl	%edx, %edx
	divq	424(%rsp)                       # 8-byte Folded Reload
	jmp	.LBB12_343
	.p2align	4, 0x90
.LBB12_342:                             #   in Loop: Header=BB12_339 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	424(%rsp)                       # 4-byte Folded Reload
                                        # kill: def $edx killed $edx def $rdx
.LBB12_343:                             #   in Loop: Header=BB12_339 Depth=1
	movq	368(%rsp), %rax
	leaq	(%rdx,%rdx,2), %rcx
	movq	(%rax,%rcx,8), %rsi
	movq	%rcx, 320(%rsp)                 # 8-byte Spill
	movq	8(%rax,%rcx,8), %rdx
	movq	%rdx, %rcx
	subq	%rsi, %rcx
	sarq	$3, %rcx
.Ltmp163:
	movq	%r15, %rdi
	callq	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l
.Ltmp164:
# %bb.344:                              #   in Loop: Header=BB12_339 Depth=1
	cmpq	$1, 144(%rsp)                   # 8-byte Folded Reload
	je	.LBB12_357
# %bb.345:                              #   in Loop: Header=BB12_339 Depth=1
	cmpq	$1, %rbx
	je	.LBB12_357
# %bb.346:                              #   in Loop: Header=BB12_339 Depth=1
	movzbl	112(%rsp), %eax
	testb	$1, %al
	je	.LBB12_358
.LBB12_347:                             #   in Loop: Header=BB12_339 Depth=1
	movq	120(%rsp), %rdx
	cmpq	$5, %rdx
	je	.LBB12_359
.LBB12_348:                             #   in Loop: Header=BB12_339 Depth=1
	cmpq	$4, %rdx
	jne	.LBB12_362
# %bb.349:                              #   in Loop: Header=BB12_339 Depth=1
	leaq	113(%rsp), %rcx
	testb	$1, %al
	je	.LBB12_351
# %bb.350:                              #   in Loop: Header=BB12_339 Depth=1
	movq	128(%rsp), %rcx
.LBB12_351:                             #   in Loop: Header=BB12_339 Depth=1
	cmpl	$1953656691, (%rcx)             # imm = 0x74726F73
	je	.LBB12_400
# %bb.352:                              #   in Loop: Header=BB12_339 Depth=1
	cmpl	$1952805749, (%rcx)             # imm = 0x74657375
	je	.LBB12_407
# %bb.353:                              #   in Loop: Header=BB12_339 Depth=1
	cmpl	$1952541798, (%rcx)             # imm = 0x74616C66
	jne	.LBB12_362
# %bb.354:                              #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 192(%rsp)
.Ltmp166:
	movq	%r15, %rdi
	movq	248(%rsp), %rsi                 # 8-byte Reload
	callq	phase_flat_insert
.Ltmp167:
# %bb.355:                              #   in Loop: Header=BB12_339 Depth=1
	movq	%rax, %r14
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp168:
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	phase_flat_assign
.Ltmp169:
# %bb.356:                              #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r14, %rdi
	callq	phase_flat_dtor
	jmp	.LBB12_403
	.p2align	4, 0x90
.LBB12_357:                             #   in Loop: Header=BB12_339 Depth=1
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
	movq	%rdx, 328(%rsp)
	movq	328(%rsp), %rax
	movzbl	112(%rsp), %eax
	testb	$1, %al
	jne	.LBB12_347
.LBB12_358:                             #   in Loop: Header=BB12_339 Depth=1
	movl	%eax, %edx
	shrl	%edx
	cmpq	$5, %rdx
	jne	.LBB12_348
.LBB12_359:                             #   in Loop: Header=BB12_339 Depth=1
	leaq	113(%rsp), %rdi
	testb	$1, %al
	je	.LBB12_361
# %bb.360:                              #   in Loop: Header=BB12_339 Depth=1
	movq	128(%rsp), %rdi
.LBB12_361:                             #   in Loop: Header=BB12_339 Depth=1
	leaq	.L.str.15(%rip), %rsi
	callq	bcmp@PLT
	testl	%eax, %eax
	je	.LBB12_402
.LBB12_362:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 192(%rsp)
.Ltmp178:
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	phase_merge_sortdelta
.Ltmp179:
# %bb.363:                              #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp180:
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	phase_merge_inplace
.Ltmp181:
.LBB12_364:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
.LBB12_365:                             #   in Loop: Header=BB12_339 Depth=1
	movq	144(%rsp), %r12                 # 8-byte Reload
.LBB12_366:                             #   in Loop: Header=BB12_339 Depth=1
	leaq	1(%r12), %rcx
	movq	%rcx, %rax
	movq	%rcx, 280(%rsp)                 # 8-byte Spill
	cmpq	%rbx, %rcx
	jne	.LBB12_368
# %bb.367:                              #   in Loop: Header=BB12_339 Depth=1
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
	movq	%rdx, 328(%rsp)
	movq	328(%rsp), %rax
.LBB12_368:                             #   in Loop: Header=BB12_339 Depth=1
	xorl	%r15d, %r15d
	jmp	.LBB12_371
	.p2align	4, 0x90
.LBB12_369:                             #   in Loop: Header=BB12_371 Depth=2
	movsd	%xmm0, (%r12)
	addq	$8, %r12
	incq	%r15
	movq	%r12, (%rbx)
	cmpq	%rbp, %r15
	je	.LBB12_390
.LBB12_371:                             #   Parent Loop BB12_339 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB12_384 Depth 3
                                        #       Child Loop BB12_386 Depth 3
	movq	400(%rsp), %r11
	leaq	(%r15,%r15,2), %r8
	movsd	200(%rsp,%r15,8), %xmm0         # xmm0 = mem[0],zero
	subsd	192(%rsp,%r15,8), %xmm0
	divsd	176(%rsp), %xmm0                # 16-byte Folded Reload
	leaq	(%r11,%r8,8), %rbx
	addq	$8, %rbx
	movq	8(%r11,%r8,8), %r12
	movq	16(%r11,%r8,8), %rax
	cmpq	%rax, %r12
	jb	.LBB12_369
# %bb.372:                              #   in Loop: Header=BB12_371 Depth=2
	leaq	(%r11,%r8,8), %rdi
	movq	(%rdi), %r14
	movq	%r12, %r13
	subq	%r14, %r13
	movq	%r13, %rbp
	sarq	$3, %rbp
	leaq	1(%rbp), %rcx
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	cmpq	%rdx, %rcx
	ja	.LBB12_452
# %bb.373:                              #   in Loop: Header=BB12_371 Depth=2
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	subq	%r14, %rax
	movq	%rax, %rbx
	sarq	$2, %rbx
	cmpq	%rcx, %rbx
	cmovbeq	%rcx, %rbx
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %rbx
	testq	%rbx, %rbx
	je	.LBB12_377
# %bb.374:                              #   in Loop: Header=BB12_371 Depth=2
	movsd	%xmm0, 152(%rsp)                # 8-byte Spill
	movq	%rdi, 232(%rsp)                 # 8-byte Spill
	movq	%r8, 168(%rsp)                  # 8-byte Spill
	movq	%r11, 160(%rsp)                 # 8-byte Spill
	cmpq	%rdx, %rbx
	ja	.LBB12_454
# %bb.375:                              #   in Loop: Header=BB12_371 Depth=2
	leaq	(,%rbx,8), %rdi
.Ltmp183:
	callq	_Znwm@PLT
.Ltmp184:
# %bb.376:                              #   in Loop: Header=BB12_371 Depth=2
	movq	160(%rsp), %r11                 # 8-byte Reload
	movq	168(%rsp), %r8                  # 8-byte Reload
	movq	232(%rsp), %rdi                 # 8-byte Reload
	movsd	152(%rsp), %xmm0                # 8-byte Reload
                                        # xmm0 = mem[0],zero
	jmp	.LBB12_378
.LBB12_377:                             #   in Loop: Header=BB12_371 Depth=2
	xorl	%eax, %eax
.LBB12_378:                             #   in Loop: Header=BB12_371 Depth=2
	leaq	(%rax,%rbp,8), %rcx
	movsd	%xmm0, (%rax,%rbp,8)
	movq	%r12, %rsi
	subq	%r14, %rsi
	je	.LBB12_387
# %bb.379:                              #   in Loop: Header=BB12_371 Depth=2
	addq	$-8, %rsi
	cmpq	$56, %rsi
	jae	.LBB12_381
# %bb.380:                              #   in Loop: Header=BB12_371 Depth=2
	movq	%r12, %rdx
	jmp	.LBB12_386
.LBB12_381:                             #   in Loop: Header=BB12_371 Depth=2
	movq	%r12, %r9
	subq	%r13, %r9
	subq	%rax, %r9
	cmpq	$32, %r9
	jae	.LBB12_383
# %bb.382:                              #   in Loop: Header=BB12_371 Depth=2
	movq	%r12, %rdx
	jmp	.LBB12_386
.LBB12_383:                             #   in Loop: Header=BB12_371 Depth=2
	movq	%rdi, 232(%rsp)                 # 8-byte Spill
	movq	%r8, 168(%rsp)                  # 8-byte Spill
	shrq	$3, %rsi
	incq	%rsi
	movq	%rsi, %rdi
	movabsq	$4611686018427387900, %rdx      # imm = 0x3FFFFFFFFFFFFFFC
	andq	%rdx, %rdi
	leaq	(,%rdi,8), %r8
	subq	%r8, %rcx
	movq	%r12, %rdx
	subq	%r8, %rdx
	leaq	(%rax,%r13), %r8
	addq	$-16, %r8
	movq	%rsi, %r9
	andq	$-4, %r9
	negq	%r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB12_384:                             #   Parent Loop BB12_339 Depth=1
                                        #     Parent Loop BB12_371 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movupd	-32(%r12,%r10,8), %xmm0
	movupd	-16(%r12,%r10,8), %xmm1
	movupd	%xmm1, (%r8,%r10,8)
	movupd	%xmm0, -16(%r8,%r10,8)
	addq	$-4, %r10
	cmpq	%r10, %r9
	jne	.LBB12_384
# %bb.385:                              #   in Loop: Header=BB12_371 Depth=2
	cmpq	%rdi, %rsi
	movq	168(%rsp), %r8                  # 8-byte Reload
	movq	232(%rsp), %rdi                 # 8-byte Reload
	je	.LBB12_387
	.p2align	4, 0x90
.LBB12_386:                             #   Parent Loop BB12_339 Depth=1
                                        #     Parent Loop BB12_371 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movsd	-8(%rdx), %xmm0                 # xmm0 = mem[0],zero
	addq	$-8, %rdx
	movsd	%xmm0, -8(%rcx)
	addq	$-8, %rcx
	cmpq	%r14, %rdx
	jne	.LBB12_386
.LBB12_387:                             #   in Loop: Header=BB12_371 Depth=2
	leaq	(%r11,%r8,8), %rdx
	addq	$16, %rdx
	leaq	(%rax,%rbx,8), %rsi
	leaq	8(%rax,%rbp,8), %r12
	movq	%rcx, (%rdi)
	movq	8(%rsp), %rbx                   # 8-byte Reload
	movq	%r12, (%rbx)
	movq	%rsi, (%rdx)
	testq	%r14, %r14
	je	.LBB12_389
# %bb.388:                              #   in Loop: Header=BB12_371 Depth=2
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
.LBB12_389:                             #   in Loop: Header=BB12_371 Depth=2
	movq	264(%rsp), %rbp                 # 8-byte Reload
	incq	%r15
	movq	%r12, (%rbx)
	cmpq	%rbp, %r15
	jne	.LBB12_371
.LBB12_390:                             #   in Loop: Header=BB12_339 Depth=1
	xorpd	%xmm0, %xmm0
	movapd	%xmm0, 16(%rsp)
	movq	$0, 32(%rsp)
	movq	336(%rsp), %r12
	movq	344(%rsp), %r13
	subq	%r12, %r13
	je	.LBB12_394
# %bb.391:                              #   in Loop: Header=BB12_339 Depth=1
	js	.LBB12_482
# %bb.392:                              #   in Loop: Header=BB12_339 Depth=1
.Ltmp191:
	movq	%r13, %rdi
	callq	_Znwm@PLT
.Ltmp192:
# %bb.393:                              #   in Loop: Header=BB12_339 Depth=1
	movq	%rax, %r14
	movq	%rax, %r15
	addq	%r13, %r15
	movq	%rax, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
	jmp	.LBB12_395
	.p2align	4, 0x90
.LBB12_394:                             #   in Loop: Header=BB12_339 Depth=1
	xorl	%r15d, %r15d
	xorl	%r14d, %r14d
.LBB12_395:                             #   in Loop: Header=BB12_339 Depth=1
.Ltmp197:
	movq	%r14, %rdi
	movq	%r15, %rsi
	leaq	328(%rsp), %rdx
	callq	_ZNSt3__16__sortIRNS_6__lessImmEEPmEEvT0_S5_T_@PLT
.Ltmp198:
	movq	64(%rsp), %r12                  # 8-byte Reload
# %bb.396:                              #   in Loop: Header=BB12_339 Depth=1
	movq	288(%rsp), %rax
	subq	%r14, %r15
	movq	320(%rsp), %rcx                 # 8-byte Reload
	movq	(%rax,%rcx,8), %rsi
	movq	8(%rax,%rcx,8), %rax
	subq	%rsi, %rax
	cmpq	%rax, %r15
	jne	.LBB12_404
# %bb.397:                              #   in Loop: Header=BB12_339 Depth=1
	movq	%r14, %rdi
	movq	%r15, %rdx
	callq	bcmp@PLT
	movb	$1, %bl
	testl	%eax, %eax
	jne	.LBB12_404
# %bb.398:                              #   in Loop: Header=BB12_339 Depth=1
	testq	%r14, %r14
	je	.LBB12_338
.LBB12_399:                             #   in Loop: Header=BB12_339 Depth=1
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_338
.LBB12_400:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 192(%rsp)
.Ltmp176:
	movq	%r15, %rdi
	callq	phase_sort
.Ltmp177:
# %bb.401:                              #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
	movq	%r15, %rdi
	callq	phase_unique
	jmp	.LBB12_364
.LBB12_402:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 192(%rsp)
	movq	%r15, %rdi
	leaq	608(%rsp), %r14
	movq	%r14, %rsi
	callq	phase_radix_count
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
	movq	%r15, %rdi
	movq	256(%rsp), %rsi                 # 8-byte Reload
	movq	%r14, %rdx
	callq	phase_radix_scatter
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r15, %rdi
	callq	phase_unique
.LBB12_403:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 216(%rsp)
	jmp	.LBB12_365
.LBB12_404:                             #   in Loop: Header=BB12_339 Depth=1
	testb	$1, 112(%rsp)
	leaq	113(%rsp), %rdx
	je	.LBB12_406
# %bb.405:                              #   in Loop: Header=BB12_339 Depth=1
	movq	128(%rsp), %rdx
.LBB12_406:                             #   in Loop: Header=BB12_339 Depth=1
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	xorl	%ebx, %ebx
	leaq	.L.str.21(%rip), %rsi
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$3, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	testq	%r14, %r14
	jne	.LBB12_399
	jmp	.LBB12_338
.LBB12_407:                             #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 192(%rsp)
.Ltmp171:
	movq	%r15, %rdi
	movq	248(%rsp), %rsi                 # 8-byte Reload
	callq	phase_uset_insert
.Ltmp172:
	movq	144(%rsp), %r12                 # 8-byte Reload
# %bb.408:                              #   in Loop: Header=BB12_339 Depth=1
	movq	%rax, %r14
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 200(%rsp)
.Ltmp173:
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	phase_uset_assign
.Ltmp174:
# %bb.409:                              #   in Loop: Header=BB12_339 Depth=1
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 208(%rsp)
	movq	%r14, %rdi
	callq	phase_uset_dtor
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	xorps	%xmm0, %xmm0
	cvtsi2sd	%rax, %xmm0
	movsd	%xmm0, 216(%rsp)
	jmp	.LBB12_366
.LBB12_410:
	cmpq	%rbx, 144(%rsp)                 # 8-byte Folded Reload
	jb	.LBB12_425
# %bb.411:
	shll	$3, %ebp
	leaq	(,%rbp,2), %rax
	addq	%rbp, %rax
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	leaq	80(%rsp), %r14
	xorl	%ebx, %ebx
	jmp	.LBB12_413
	.p2align	4, 0x90
.LBB12_412:                             #   in Loop: Header=BB12_413 Depth=1
	movq	(%r14), %rdx
	movq	16(%rsp), %r15
	movq	24(%rsp), %rax
	subq	%r15, %rax
	sarq	%rax
	andq	$-8, %rax
	movsd	(%r15,%rax), %xmm0              # xmm0 = mem[0],zero
	leaq	.L.str.22(%rip), %rdi
	movq	136(%rsp), %rcx                 # 8-byte Reload
	movq	72(%rsp), %r8                   # 8-byte Reload
	movb	$1, %al
	callq	printf@PLT
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	addq	$8, %r14
	addq	$24, %rbx
	cmpq	%rbx, 176(%rsp)                 # 8-byte Folded Reload
	je	.LBB12_424
.LBB12_413:                             # =>This Inner Loop Header: Depth=1
	movq	400(%rsp), %rax
	xorpd	%xmm0, %xmm0
	movapd	%xmm0, 16(%rsp)
	movq	$0, 32(%rsp)
	movq	(%rax,%rbx), %r13
	movq	8(%rax,%rbx), %rbp
	subq	%r13, %rbp
	je	.LBB12_417
# %bb.414:                              #   in Loop: Header=BB12_413 Depth=1
	js	.LBB12_480
# %bb.415:                              #   in Loop: Header=BB12_413 Depth=1
.Ltmp200:
	movq	%rbp, %rdi
	callq	_Znwm@PLT
.Ltmp201:
# %bb.416:                              #   in Loop: Header=BB12_413 Depth=1
	movq	%rax, %r15
	movq	%rax, 16(%rsp)
	movq	%rax, %r12
	addq	%rbp, %r12
	movq	%r12, 32(%rsp)
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
	movq	%r12, 24(%rsp)
	movq	%r12, %rax
	subq	%r15, %rax
	cmpq	$9, %rax
	jae	.LBB12_418
	jmp	.LBB12_421
	.p2align	4, 0x90
.LBB12_417:                             #   in Loop: Header=BB12_413 Depth=1
	xorl	%r15d, %r15d
	xorl	%r12d, %r12d
	movq	%r12, %rax
	subq	%r15, %rax
	cmpq	$9, %rax
	jb	.LBB12_421
.LBB12_418:                             #   in Loop: Header=BB12_413 Depth=1
	leaq	8(%r15), %rsi
	subq	%rsi, %r12
	je	.LBB12_420
# %bb.419:                              #   in Loop: Header=BB12_413 Depth=1
	movq	%r15, %rdi
	movq	%r12, %rdx
	callq	memmove@PLT
.LBB12_420:                             #   in Loop: Header=BB12_413 Depth=1
	addq	%r15, %r12
	movq	%r12, 24(%rsp)
.LBB12_421:                             #   in Loop: Header=BB12_413 Depth=1
.Ltmp206:
	movq	%r15, %rdi
	movq	%r12, %rsi
	leaq	192(%rsp), %rdx
	callq	_ZNSt3__16__sortIRNS_6__lessIddEEPdEEvT0_S5_T_@PLT
.Ltmp207:
# %bb.422:                              #   in Loop: Header=BB12_413 Depth=1
	testb	$1, 112(%rsp)
	leaq	113(%rsp), %rsi
	je	.LBB12_412
# %bb.423:                              #   in Loop: Header=BB12_413 Depth=1
	movq	128(%rsp), %rsi
	jmp	.LBB12_412
.LBB12_424:
	xorl	%eax, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
.LBB12_425:
	movq	256(%rsp), %rdi                 # 8-byte Reload
	callq	_ZdaPv@PLT
	movq	336(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_427
# %bb.426:
	movq	%rdi, 344(%rsp)
	callq	_ZdlPv@PLT
.LBB12_427:
	movq	400(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB12_434
# %bb.428:
	movq	408(%rsp), %r14
	movq	%rbx, %rdi
	cmpq	%rbx, %r14
	jne	.LBB12_430
	jmp	.LBB12_433
	.p2align	4, 0x90
.LBB12_429:                             #   in Loop: Header=BB12_430 Depth=1
	addq	$-24, %r14
	cmpq	%rbx, %r14
	je	.LBB12_432
.LBB12_430:                             # =>This Inner Loop Header: Depth=1
	movq	-24(%r14), %rdi
	testq	%rdi, %rdi
	je	.LBB12_429
# %bb.431:                              #   in Loop: Header=BB12_430 Depth=1
	movq	%rdi, -16(%r14)
	callq	_ZdlPv@PLT
	jmp	.LBB12_429
.LBB12_432:
	movq	400(%rsp), %rdi
.LBB12_433:
	movq	%rbx, 408(%rsp)
	callq	_ZdlPv@PLT
.LBB12_434:
	movq	288(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB12_441
.LBB12_435:
	movq	296(%rsp), %r14
	movq	%rbx, %rdi
	cmpq	%rbx, %r14
	jne	.LBB12_437
	jmp	.LBB12_440
	.p2align	4, 0x90
.LBB12_436:                             #   in Loop: Header=BB12_437 Depth=1
	addq	$-24, %r14
	cmpq	%rbx, %r14
	je	.LBB12_439
.LBB12_437:                             # =>This Inner Loop Header: Depth=1
	movq	-24(%r14), %rdi
	testq	%rdi, %rdi
	je	.LBB12_436
# %bb.438:                              #   in Loop: Header=BB12_437 Depth=1
	movq	%rdi, -16(%r14)
	callq	_ZdlPv@PLT
	jmp	.LBB12_436
.LBB12_439:
	movq	288(%rsp), %rdi
.LBB12_440:
	movq	%rbx, 296(%rsp)
	callq	_ZdlPv@PLT
.LBB12_441:
	movq	368(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB12_448
# %bb.442:
	movq	376(%rsp), %r14
	movq	%rbx, %rdi
	cmpq	%rbx, %r14
	jne	.LBB12_444
	jmp	.LBB12_447
	.p2align	4, 0x90
.LBB12_443:                             #   in Loop: Header=BB12_444 Depth=1
	addq	$-24, %r14
	cmpq	%rbx, %r14
	je	.LBB12_446
.LBB12_444:                             # =>This Inner Loop Header: Depth=1
	movq	-24(%r14), %rdi
	testq	%rdi, %rdi
	je	.LBB12_443
# %bb.445:                              #   in Loop: Header=BB12_444 Depth=1
	movq	%rdi, -16(%r14)
	callq	_ZdlPv@PLT
	jmp	.LBB12_443
.LBB12_446:
	movq	368(%rsp), %rdi
.LBB12_447:
	movq	%rbx, 376(%rsp)
	callq	_ZdlPv@PLT
.LBB12_448:
	testb	$1, 112(%rsp)
	je	.LBB12_450
# %bb.449:
	movq	128(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB12_450:
	movq	240(%rsp), %rax                 # 8-byte Reload
                                        # kill: def $eax killed $eax killed $rax
	addq	$8808, %rsp                     # imm = 0x2268
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
.LBB12_451:
	.cfi_def_cfa_offset 8864
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	leaq	.L.str.20(%rip), %rdi
	movl	$12, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$2, %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movq	288(%rsp), %rbx
	testq	%rbx, %rbx
	jne	.LBB12_435
	jmp	.LBB12_441
.LBB12_452:
.Ltmp188:
	callq	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
.Ltmp189:
# %bb.453:
.LBB12_454:
.Ltmp186:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Ltmp187:
# %bb.455:
.LBB12_456:
.Ltmp83:
	leaq	80(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp84:
# %bb.457:
.LBB12_458:
.Ltmp81:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Ltmp82:
# %bb.459:
.LBB12_460:
.Ltmp109:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp110:
# %bb.461:
.LBB12_462:
.Ltmp131:
	leaq	192(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp132:
# %bb.463:
.LBB12_464:
.Ltmp117:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp118:
# %bb.465:
.LBB12_466:
.Ltmp107:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Ltmp108:
# %bb.467:
.LBB12_468:
.Ltmp129:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Ltmp130:
# %bb.469:
.LBB12_470:
.Ltmp115:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Ltmp116:
# %bb.471:
.LBB12_472:
.Ltmp86:
	leaq	80(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp87:
# %bb.473:
.LBB12_474:
.Ltmp146:
	leaq	608(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp147:
# %bb.475:
.LBB12_476:
.Ltmp209:
	leaq	608(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp210:
# %bb.477:
.LBB12_478:
.Ltmp72:
	leaq	608(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp73:
# %bb.479:
.LBB12_480:
.Ltmp203:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
.Ltmp204:
# %bb.481:
.LBB12_482:
.Ltmp194:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp195:
# %bb.483:
.LBB12_484:
.Ltmp137:
	leaq	80(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp138:
# %bb.485:
.LBB12_486:
.Ltmp123:
	leaq	192(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp124:
# %bb.487:
.LBB12_488:
.Ltmp92:
	leaq	608(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp93:
# %bb.489:
.LBB12_490:
.Ltmp24:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp25:
# %bb.491:
.LBB12_492:
.Ltmp57:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp58:
# %bb.493:
.LBB12_494:
.Ltmp33:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp34:
# %bb.495:
.LBB12_496:
.Ltmp15:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp16:
# %bb.497:
.LBB12_498:
.Ltmp101:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp102:
# %bb.499:
.LBB12_500:
.Ltmp42:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp43:
# %bb.501:
.LBB12_502:
.Ltmp51:
	leaq	16(%rsp), %rdi
	callq	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
.Ltmp52:
# %bb.503:
.LBB12_504:
.Ltmp157:
	leaq	336(%rsp), %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Ltmp158:
# %bb.505:
.LBB12_506:
.Ltmp47:
	jmp	.LBB12_530
.LBB12_507:
.Ltmp65:
	movq	%rax, %rbx
	leaq	608(%rsp), %rdi
	callq	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	jmp	.LBB12_606
.LBB12_508:
.Ltmp62:
	movq	%rax, %rbx
	leaq	608(%rsp), %rdi
	callq	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	testb	$1, 112(%rsp)
	je	.LBB12_535
	jmp	.LBB12_607
.LBB12_509:
.Ltmp38:
	jmp	.LBB12_530
.LBB12_510:
.Ltmp53:
	jmp	.LBB12_530
.LBB12_511:
.Ltmp50:
	jmp	.LBB12_532
.LBB12_512:
.Ltmp162:
	movq	%rax, %rbx
	jmp	.LBB12_602
.LBB12_513:
.Ltmp154:
	movq	%rax, %rbx
	leaq	608(%rsp), %rdi
	callq	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	jmp	.LBB12_605
.LBB12_514:
.Ltmp56:
	jmp	.LBB12_530
.LBB12_515:
.Ltmp20:
	jmp	.LBB12_530
.LBB12_516:
.Ltmp11:
	jmp	.LBB12_530
.LBB12_517:
.Ltmp29:
	jmp	.LBB12_530
.LBB12_518:
.Ltmp159:
	movq	%rax, %rbx
	jmp	.LBB12_602
.LBB12_519:
.Ltmp44:
	jmp	.LBB12_530
.LBB12_520:
.Ltmp41:
	jmp	.LBB12_532
.LBB12_521:
.Ltmp170:
	jmp	.LBB12_600
.LBB12_522:
.Ltmp103:
	jmp	.LBB12_582
.LBB12_523:
.Ltmp100:
	movq	%rax, %rbx
	xorl	%edi, %edi
	jmp	.LBB12_584
.LBB12_524:
.Ltmp17:
	jmp	.LBB12_530
.LBB12_525:
.Ltmp14:
	jmp	.LBB12_532
.LBB12_526:
.Ltmp35:
	jmp	.LBB12_530
.LBB12_527:
.Ltmp32:
	jmp	.LBB12_532
.LBB12_528:
.Ltmp59:
	jmp	.LBB12_530
.LBB12_529:
.Ltmp26:
.LBB12_530:
	movq	%rax, %rbx
	testb	$1, 608(%rsp)
	je	.LBB12_534
.LBB12_537:
	movq	624(%rsp), %rdi
	callq	_ZdlPv@PLT
	testb	$1, 112(%rsp)
	je	.LBB12_535
	jmp	.LBB12_607
.LBB12_531:
.Ltmp23:
.LBB12_532:
	movq	%rax, %rbx
	testb	$1, 16(%rsp)
	jne	.LBB12_536
# %bb.533:
	testb	$1, 608(%rsp)
	jne	.LBB12_537
.LBB12_534:
	testb	$1, 112(%rsp)
	jne	.LBB12_607
.LBB12_535:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB12_536:
	movq	32(%rsp), %rdi
	callq	_ZdlPv@PLT
	testb	$1, 608(%rsp)
	je	.LBB12_534
	jmp	.LBB12_537
.LBB12_538:
.Ltmp175:
	jmp	.LBB12_600
.LBB12_539:
.Ltmp94:
	jmp	.LBB12_562
.LBB12_540:
.Ltmp91:
	movq	%rax, %rbx
	jmp	.LBB12_605
.LBB12_541:
.Ltmp125:
	jmp	.LBB12_578
.LBB12_542:
.Ltmp122:
	jmp	.LBB12_582
.LBB12_543:
.Ltmp139:
	jmp	.LBB12_547
.LBB12_544:
.Ltmp136:
	jmp	.LBB12_578
.LBB12_545:
.Ltmp97:
	movq	%rax, %rbx
	movq	8(%rsp), %rdi                   # 8-byte Reload
	jmp	.LBB12_587
.LBB12_546:
.Ltmp142:
.LBB12_547:
	movq	%rax, %rbx
	movq	80(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_579
# %bb.548:
	movq	%rdi, 88(%rsp)
	callq	_ZdlPv@PLT
	jmp	.LBB12_579
.LBB12_549:
.Ltmp8:
	movq	%rax, %rbx
	testb	$1, 112(%rsp)
	je	.LBB12_535
	jmp	.LBB12_607
.LBB12_550:
.Ltmp196:
	movq	%rax, %rbx
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_601
	jmp	.LBB12_551
.LBB12_552:
.Ltmp193:
	jmp	.LBB12_600
.LBB12_553:
.Ltmp202:
	jmp	.LBB12_600
.LBB12_554:
.Ltmp205:
	movq	%rax, %rbx
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_601
.LBB12_551:
	movq	%rdi, 24(%rsp)
	callq	_ZdlPv@PLT
	jmp	.LBB12_601
.LBB12_556:
.Ltmp71:
	movq	%rax, %rbx
	jmp	.LBB12_598
.LBB12_557:
.Ltmp74:
	jmp	.LBB12_562
.LBB12_558:
.Ltmp68:
	movq	%rax, %rbx
	jmp	.LBB12_605
.LBB12_559:
.Ltmp211:
	movq	%rax, %rbx
	testb	$1, 112(%rsp)
	je	.LBB12_535
	jmp	.LBB12_607
.LBB12_560:
.Ltmp145:
	movq	%rax, %rbx
	jmp	.LBB12_605
.LBB12_561:
.Ltmp148:
.LBB12_562:
	movq	%rax, %rbx
	jmp	.LBB12_586
.LBB12_563:
.Ltmp77:
	movq	%rax, %rbx
	jmp	.LBB12_593
.LBB12_564:
.Ltmp88:
	movq	%rax, %rbx
	jmp	.LBB12_593
.LBB12_565:
.Ltmp199:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB12_601
# %bb.566:
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_601
.LBB12_567:
.Ltmp165:
	jmp	.LBB12_600
.LBB12_568:
.Ltmp208:
	movq	%rax, %rbx
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_601
# %bb.569:
	callq	_ZdlPv@PLT
	jmp	.LBB12_601
.LBB12_570:
.Ltmp128:
	jmp	.LBB12_578
.LBB12_571:
.Ltmp106:
	jmp	.LBB12_582
.LBB12_572:
.Ltmp114:
	jmp	.LBB12_582
.LBB12_573:
.Ltmp151:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB12_605
# %bb.574:
	movq	%r14, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_605
.LBB12_575:
.Ltmp182:
	jmp	.LBB12_600
.LBB12_576:
.Ltmp119:
	jmp	.LBB12_582
.LBB12_577:
.Ltmp133:
.LBB12_578:
	movq	%rax, %rbx
.LBB12_579:
	movq	192(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_583
# %bb.580:
	movq	%rdi, 200(%rsp)
	callq	_ZdlPv@PLT
	jmp	.LBB12_583
.LBB12_581:
.Ltmp111:
.LBB12_582:
	movq	%rax, %rbx
.LBB12_583:
	movq	16(%rsp), %rdi
.LBB12_584:
	testq	%rdi, %rdi
	je	.LBB12_586
# %bb.585:
	movq	%rdi, 24(%rsp)
	callq	_ZdlPv@PLT
.LBB12_586:
	movq	608(%rsp), %rdi
.LBB12_587:
	testq	%rdi, %rdi
	je	.LBB12_605
# %bb.588:
	movq	%rdi, 616(%rsp)
	callq	_ZdlPv@PLT
	jmp	.LBB12_605
.LBB12_589:
.Ltmp80:
	jmp	.LBB12_592
.LBB12_590:
.Ltmp185:
	jmp	.LBB12_600
.LBB12_591:
.Ltmp85:
.LBB12_592:
	movq	%rax, %rbx
	movq	160(%rsp), %rbp                 # 8-byte Reload
	movq	176(%rsp), %r13                 # 8-byte Reload
.LBB12_593:
	movq	80(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.LBB12_596
# %bb.594:
	testq	%r13, %r13
	jne	.LBB12_597
.LBB12_595:
	testq	%rbp, %rbp
	jne	.LBB12_598
	jmp	.LBB12_605
.LBB12_596:
	movq	%rdi, 88(%rsp)
	callq	_ZdlPv@PLT
	testq	%r13, %r13
	je	.LBB12_595
.LBB12_597:
	movq	%r13, %rdi
	callq	_ZdlPv@PLT
	testq	%rbp, %rbp
	je	.LBB12_605
.LBB12_598:
	movq	%rbp, 616(%rsp)
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	jmp	.LBB12_605
.LBB12_599:
.Ltmp190:
.LBB12_600:
	movq	%rax, %rbx
.LBB12_601:
	movq	256(%rsp), %rdi                 # 8-byte Reload
	callq	_ZdaPv@PLT
.LBB12_602:
	movq	336(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB12_604
# %bb.603:
	movq	%rdi, 344(%rsp)
	callq	_ZdlPv@PLT
.LBB12_604:
	leaq	400(%rsp), %rdi
	callq	_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev
.LBB12_605:
	leaq	288(%rsp), %rdi
	callq	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
.LBB12_606:
	leaq	368(%rsp), %rdi
	callq	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
	testb	$1, 112(%rsp)
	je	.LBB12_535
.LBB12_607:
	movq	128(%rsp), %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end12:
	.size	main, .Lfunc_end12-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI12_0:
	.long	.LBB12_12-.LJTI12_0
	.long	.LBB12_56-.LJTI12_0
	.long	.LBB12_17-.LJTI12_0
	.long	.LBB12_56-.LJTI12_0
	.long	.LBB12_32-.LJTI12_0
	.long	.LBB12_28-.LJTI12_0
	.long	.LBB12_24-.LJTI12_0
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table12:
.Lexception2:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Ltmp6-.Lfunc_begin2           # >> Call Site 1 <<
	.uleb128 .Ltmp7-.Ltmp6                  #   Call between .Ltmp6 and .Ltmp7
	.uleb128 .Ltmp8-.Lfunc_begin2           #     jumps to .Ltmp8
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp7-.Lfunc_begin2           # >> Call Site 2 <<
	.uleb128 .Ltmp54-.Ltmp7                 #   Call between .Ltmp7 and .Ltmp54
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp54-.Lfunc_begin2          # >> Call Site 3 <<
	.uleb128 .Ltmp55-.Ltmp54                #   Call between .Ltmp54 and .Ltmp55
	.uleb128 .Ltmp56-.Lfunc_begin2          #     jumps to .Ltmp56
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp55-.Lfunc_begin2          # >> Call Site 4 <<
	.uleb128 .Ltmp27-.Ltmp55                #   Call between .Ltmp55 and .Ltmp27
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp27-.Lfunc_begin2          # >> Call Site 5 <<
	.uleb128 .Ltmp28-.Ltmp27                #   Call between .Ltmp27 and .Ltmp28
	.uleb128 .Ltmp29-.Lfunc_begin2          #     jumps to .Ltmp29
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp28-.Lfunc_begin2          # >> Call Site 6 <<
	.uleb128 .Ltmp30-.Ltmp28                #   Call between .Ltmp28 and .Ltmp30
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp30-.Lfunc_begin2          # >> Call Site 7 <<
	.uleb128 .Ltmp31-.Ltmp30                #   Call between .Ltmp30 and .Ltmp31
	.uleb128 .Ltmp32-.Lfunc_begin2          #     jumps to .Ltmp32
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp9-.Lfunc_begin2           # >> Call Site 8 <<
	.uleb128 .Ltmp10-.Ltmp9                 #   Call between .Ltmp9 and .Ltmp10
	.uleb128 .Ltmp11-.Lfunc_begin2          #     jumps to .Ltmp11
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp10-.Lfunc_begin2          # >> Call Site 9 <<
	.uleb128 .Ltmp12-.Ltmp10                #   Call between .Ltmp10 and .Ltmp12
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp12-.Lfunc_begin2          # >> Call Site 10 <<
	.uleb128 .Ltmp13-.Ltmp12                #   Call between .Ltmp12 and .Ltmp13
	.uleb128 .Ltmp14-.Lfunc_begin2          #     jumps to .Ltmp14
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp18-.Lfunc_begin2          # >> Call Site 11 <<
	.uleb128 .Ltmp19-.Ltmp18                #   Call between .Ltmp18 and .Ltmp19
	.uleb128 .Ltmp20-.Lfunc_begin2          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp19-.Lfunc_begin2          # >> Call Site 12 <<
	.uleb128 .Ltmp21-.Ltmp19                #   Call between .Ltmp19 and .Ltmp21
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp21-.Lfunc_begin2          # >> Call Site 13 <<
	.uleb128 .Ltmp22-.Ltmp21                #   Call between .Ltmp21 and .Ltmp22
	.uleb128 .Ltmp23-.Lfunc_begin2          #     jumps to .Ltmp23
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp36-.Lfunc_begin2          # >> Call Site 14 <<
	.uleb128 .Ltmp37-.Ltmp36                #   Call between .Ltmp36 and .Ltmp37
	.uleb128 .Ltmp38-.Lfunc_begin2          #     jumps to .Ltmp38
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp37-.Lfunc_begin2          # >> Call Site 15 <<
	.uleb128 .Ltmp39-.Ltmp37                #   Call between .Ltmp37 and .Ltmp39
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp39-.Lfunc_begin2          # >> Call Site 16 <<
	.uleb128 .Ltmp40-.Ltmp39                #   Call between .Ltmp39 and .Ltmp40
	.uleb128 .Ltmp41-.Lfunc_begin2          #     jumps to .Ltmp41
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp45-.Lfunc_begin2          # >> Call Site 17 <<
	.uleb128 .Ltmp46-.Ltmp45                #   Call between .Ltmp45 and .Ltmp46
	.uleb128 .Ltmp47-.Lfunc_begin2          #     jumps to .Ltmp47
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp46-.Lfunc_begin2          # >> Call Site 18 <<
	.uleb128 .Ltmp48-.Ltmp46                #   Call between .Ltmp46 and .Ltmp48
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp48-.Lfunc_begin2          # >> Call Site 19 <<
	.uleb128 .Ltmp49-.Ltmp48                #   Call between .Ltmp48 and .Ltmp49
	.uleb128 .Ltmp50-.Lfunc_begin2          #     jumps to .Ltmp50
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp60-.Lfunc_begin2          # >> Call Site 20 <<
	.uleb128 .Ltmp61-.Ltmp60                #   Call between .Ltmp60 and .Ltmp61
	.uleb128 .Ltmp62-.Lfunc_begin2          #     jumps to .Ltmp62
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp61-.Lfunc_begin2          # >> Call Site 21 <<
	.uleb128 .Ltmp63-.Ltmp61                #   Call between .Ltmp61 and .Ltmp63
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp63-.Lfunc_begin2          # >> Call Site 22 <<
	.uleb128 .Ltmp64-.Ltmp63                #   Call between .Ltmp63 and .Ltmp64
	.uleb128 .Ltmp65-.Lfunc_begin2          #     jumps to .Ltmp65
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp64-.Lfunc_begin2          # >> Call Site 23 <<
	.uleb128 .Ltmp66-.Ltmp64                #   Call between .Ltmp64 and .Ltmp66
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp66-.Lfunc_begin2          # >> Call Site 24 <<
	.uleb128 .Ltmp67-.Ltmp66                #   Call between .Ltmp66 and .Ltmp67
	.uleb128 .Ltmp68-.Lfunc_begin2          #     jumps to .Ltmp68
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp67-.Lfunc_begin2          # >> Call Site 25 <<
	.uleb128 .Ltmp69-.Ltmp67                #   Call between .Ltmp67 and .Ltmp69
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp69-.Lfunc_begin2          # >> Call Site 26 <<
	.uleb128 .Ltmp70-.Ltmp69                #   Call between .Ltmp69 and .Ltmp70
	.uleb128 .Ltmp71-.Lfunc_begin2          #     jumps to .Ltmp71
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp75-.Lfunc_begin2          # >> Call Site 27 <<
	.uleb128 .Ltmp76-.Ltmp75                #   Call between .Ltmp75 and .Ltmp76
	.uleb128 .Ltmp77-.Lfunc_begin2          #     jumps to .Ltmp77
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp78-.Lfunc_begin2          # >> Call Site 28 <<
	.uleb128 .Ltmp79-.Ltmp78                #   Call between .Ltmp78 and .Ltmp79
	.uleb128 .Ltmp80-.Lfunc_begin2          #     jumps to .Ltmp80
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp143-.Lfunc_begin2         # >> Call Site 29 <<
	.uleb128 .Ltmp144-.Ltmp143              #   Call between .Ltmp143 and .Ltmp144
	.uleb128 .Ltmp145-.Lfunc_begin2         #     jumps to .Ltmp145
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp144-.Lfunc_begin2         # >> Call Site 30 <<
	.uleb128 .Ltmp149-.Ltmp144              #   Call between .Ltmp144 and .Ltmp149
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp149-.Lfunc_begin2         # >> Call Site 31 <<
	.uleb128 .Ltmp150-.Ltmp149              #   Call between .Ltmp149 and .Ltmp150
	.uleb128 .Ltmp151-.Lfunc_begin2         #     jumps to .Ltmp151
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp150-.Lfunc_begin2         # >> Call Site 32 <<
	.uleb128 .Ltmp89-.Ltmp150               #   Call between .Ltmp150 and .Ltmp89
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp89-.Lfunc_begin2          # >> Call Site 33 <<
	.uleb128 .Ltmp90-.Ltmp89                #   Call between .Ltmp89 and .Ltmp90
	.uleb128 .Ltmp91-.Lfunc_begin2          #     jumps to .Ltmp91
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp90-.Lfunc_begin2          # >> Call Site 34 <<
	.uleb128 .Ltmp95-.Ltmp90                #   Call between .Ltmp90 and .Ltmp95
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp95-.Lfunc_begin2          # >> Call Site 35 <<
	.uleb128 .Ltmp96-.Ltmp95                #   Call between .Ltmp95 and .Ltmp96
	.uleb128 .Ltmp97-.Lfunc_begin2          #     jumps to .Ltmp97
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp96-.Lfunc_begin2          # >> Call Site 36 <<
	.uleb128 .Ltmp98-.Ltmp96                #   Call between .Ltmp96 and .Ltmp98
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp98-.Lfunc_begin2          # >> Call Site 37 <<
	.uleb128 .Ltmp99-.Ltmp98                #   Call between .Ltmp98 and .Ltmp99
	.uleb128 .Ltmp100-.Lfunc_begin2         #     jumps to .Ltmp100
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp104-.Lfunc_begin2         # >> Call Site 38 <<
	.uleb128 .Ltmp105-.Ltmp104              #   Call between .Ltmp104 and .Ltmp105
	.uleb128 .Ltmp106-.Lfunc_begin2         #     jumps to .Ltmp106
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp112-.Lfunc_begin2         # >> Call Site 39 <<
	.uleb128 .Ltmp113-.Ltmp112              #   Call between .Ltmp112 and .Ltmp113
	.uleb128 .Ltmp114-.Lfunc_begin2         #     jumps to .Ltmp114
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp120-.Lfunc_begin2         # >> Call Site 40 <<
	.uleb128 .Ltmp121-.Ltmp120              #   Call between .Ltmp120 and .Ltmp121
	.uleb128 .Ltmp122-.Lfunc_begin2         #     jumps to .Ltmp122
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp121-.Lfunc_begin2         # >> Call Site 41 <<
	.uleb128 .Ltmp134-.Ltmp121              #   Call between .Ltmp121 and .Ltmp134
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp134-.Lfunc_begin2         # >> Call Site 42 <<
	.uleb128 .Ltmp135-.Ltmp134              #   Call between .Ltmp134 and .Ltmp135
	.uleb128 .Ltmp136-.Lfunc_begin2         #     jumps to .Ltmp136
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp135-.Lfunc_begin2         # >> Call Site 43 <<
	.uleb128 .Ltmp126-.Ltmp135              #   Call between .Ltmp135 and .Ltmp126
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp126-.Lfunc_begin2         # >> Call Site 44 <<
	.uleb128 .Ltmp127-.Ltmp126              #   Call between .Ltmp126 and .Ltmp127
	.uleb128 .Ltmp128-.Lfunc_begin2         #     jumps to .Ltmp128
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp140-.Lfunc_begin2         # >> Call Site 45 <<
	.uleb128 .Ltmp141-.Ltmp140              #   Call between .Ltmp140 and .Ltmp141
	.uleb128 .Ltmp142-.Lfunc_begin2         #     jumps to .Ltmp142
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp152-.Lfunc_begin2         # >> Call Site 46 <<
	.uleb128 .Ltmp153-.Ltmp152              #   Call between .Ltmp152 and .Ltmp153
	.uleb128 .Ltmp154-.Lfunc_begin2         #     jumps to .Ltmp154
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp153-.Lfunc_begin2         # >> Call Site 47 <<
	.uleb128 .Ltmp155-.Ltmp153              #   Call between .Ltmp153 and .Ltmp155
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp155-.Lfunc_begin2         # >> Call Site 48 <<
	.uleb128 .Ltmp156-.Ltmp155              #   Call between .Ltmp155 and .Ltmp156
	.uleb128 .Ltmp159-.Lfunc_begin2         #     jumps to .Ltmp159
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp160-.Lfunc_begin2         # >> Call Site 49 <<
	.uleb128 .Ltmp161-.Ltmp160              #   Call between .Ltmp160 and .Ltmp161
	.uleb128 .Ltmp162-.Lfunc_begin2         #     jumps to .Ltmp162
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp163-.Lfunc_begin2         # >> Call Site 50 <<
	.uleb128 .Ltmp164-.Ltmp163              #   Call between .Ltmp163 and .Ltmp164
	.uleb128 .Ltmp165-.Lfunc_begin2         #     jumps to .Ltmp165
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp166-.Lfunc_begin2         # >> Call Site 51 <<
	.uleb128 .Ltmp169-.Ltmp166              #   Call between .Ltmp166 and .Ltmp169
	.uleb128 .Ltmp170-.Lfunc_begin2         #     jumps to .Ltmp170
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp178-.Lfunc_begin2         # >> Call Site 52 <<
	.uleb128 .Ltmp181-.Ltmp178              #   Call between .Ltmp178 and .Ltmp181
	.uleb128 .Ltmp182-.Lfunc_begin2         #     jumps to .Ltmp182
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp183-.Lfunc_begin2         # >> Call Site 53 <<
	.uleb128 .Ltmp184-.Ltmp183              #   Call between .Ltmp183 and .Ltmp184
	.uleb128 .Ltmp185-.Lfunc_begin2         #     jumps to .Ltmp185
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp191-.Lfunc_begin2         # >> Call Site 54 <<
	.uleb128 .Ltmp192-.Ltmp191              #   Call between .Ltmp191 and .Ltmp192
	.uleb128 .Ltmp193-.Lfunc_begin2         #     jumps to .Ltmp193
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp192-.Lfunc_begin2         # >> Call Site 55 <<
	.uleb128 .Ltmp197-.Ltmp192              #   Call between .Ltmp192 and .Ltmp197
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp197-.Lfunc_begin2         # >> Call Site 56 <<
	.uleb128 .Ltmp198-.Ltmp197              #   Call between .Ltmp197 and .Ltmp198
	.uleb128 .Ltmp199-.Lfunc_begin2         #     jumps to .Ltmp199
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp176-.Lfunc_begin2         # >> Call Site 57 <<
	.uleb128 .Ltmp177-.Ltmp176              #   Call between .Ltmp176 and .Ltmp177
	.uleb128 .Ltmp182-.Lfunc_begin2         #     jumps to .Ltmp182
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp171-.Lfunc_begin2         # >> Call Site 58 <<
	.uleb128 .Ltmp174-.Ltmp171              #   Call between .Ltmp171 and .Ltmp174
	.uleb128 .Ltmp175-.Lfunc_begin2         #     jumps to .Ltmp175
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp200-.Lfunc_begin2         # >> Call Site 59 <<
	.uleb128 .Ltmp201-.Ltmp200              #   Call between .Ltmp200 and .Ltmp201
	.uleb128 .Ltmp202-.Lfunc_begin2         #     jumps to .Ltmp202
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp201-.Lfunc_begin2         # >> Call Site 60 <<
	.uleb128 .Ltmp206-.Ltmp201              #   Call between .Ltmp201 and .Ltmp206
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp206-.Lfunc_begin2         # >> Call Site 61 <<
	.uleb128 .Ltmp207-.Ltmp206              #   Call between .Ltmp206 and .Ltmp207
	.uleb128 .Ltmp208-.Lfunc_begin2         #     jumps to .Ltmp208
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp188-.Lfunc_begin2         # >> Call Site 62 <<
	.uleb128 .Ltmp187-.Ltmp188              #   Call between .Ltmp188 and .Ltmp187
	.uleb128 .Ltmp190-.Lfunc_begin2         #     jumps to .Ltmp190
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp83-.Lfunc_begin2          # >> Call Site 63 <<
	.uleb128 .Ltmp82-.Ltmp83                #   Call between .Ltmp83 and .Ltmp82
	.uleb128 .Ltmp85-.Lfunc_begin2          #     jumps to .Ltmp85
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp109-.Lfunc_begin2         # >> Call Site 64 <<
	.uleb128 .Ltmp110-.Ltmp109              #   Call between .Ltmp109 and .Ltmp110
	.uleb128 .Ltmp111-.Lfunc_begin2         #     jumps to .Ltmp111
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp131-.Lfunc_begin2         # >> Call Site 65 <<
	.uleb128 .Ltmp132-.Ltmp131              #   Call between .Ltmp131 and .Ltmp132
	.uleb128 .Ltmp133-.Lfunc_begin2         #     jumps to .Ltmp133
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp117-.Lfunc_begin2         # >> Call Site 66 <<
	.uleb128 .Ltmp118-.Ltmp117              #   Call between .Ltmp117 and .Ltmp118
	.uleb128 .Ltmp119-.Lfunc_begin2         #     jumps to .Ltmp119
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp107-.Lfunc_begin2         # >> Call Site 67 <<
	.uleb128 .Ltmp108-.Ltmp107              #   Call between .Ltmp107 and .Ltmp108
	.uleb128 .Ltmp111-.Lfunc_begin2         #     jumps to .Ltmp111
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp129-.Lfunc_begin2         # >> Call Site 68 <<
	.uleb128 .Ltmp130-.Ltmp129              #   Call between .Ltmp129 and .Ltmp130
	.uleb128 .Ltmp133-.Lfunc_begin2         #     jumps to .Ltmp133
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp115-.Lfunc_begin2         # >> Call Site 69 <<
	.uleb128 .Ltmp116-.Ltmp115              #   Call between .Ltmp115 and .Ltmp116
	.uleb128 .Ltmp119-.Lfunc_begin2         #     jumps to .Ltmp119
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp86-.Lfunc_begin2          # >> Call Site 70 <<
	.uleb128 .Ltmp87-.Ltmp86                #   Call between .Ltmp86 and .Ltmp87
	.uleb128 .Ltmp88-.Lfunc_begin2          #     jumps to .Ltmp88
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp146-.Lfunc_begin2         # >> Call Site 71 <<
	.uleb128 .Ltmp147-.Ltmp146              #   Call between .Ltmp146 and .Ltmp147
	.uleb128 .Ltmp148-.Lfunc_begin2         #     jumps to .Ltmp148
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp209-.Lfunc_begin2         # >> Call Site 72 <<
	.uleb128 .Ltmp210-.Ltmp209              #   Call between .Ltmp209 and .Ltmp210
	.uleb128 .Ltmp211-.Lfunc_begin2         #     jumps to .Ltmp211
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp72-.Lfunc_begin2          # >> Call Site 73 <<
	.uleb128 .Ltmp73-.Ltmp72                #   Call between .Ltmp72 and .Ltmp73
	.uleb128 .Ltmp74-.Lfunc_begin2          #     jumps to .Ltmp74
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp203-.Lfunc_begin2         # >> Call Site 74 <<
	.uleb128 .Ltmp204-.Ltmp203              #   Call between .Ltmp203 and .Ltmp204
	.uleb128 .Ltmp205-.Lfunc_begin2         #     jumps to .Ltmp205
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp194-.Lfunc_begin2         # >> Call Site 75 <<
	.uleb128 .Ltmp195-.Ltmp194              #   Call between .Ltmp194 and .Ltmp195
	.uleb128 .Ltmp196-.Lfunc_begin2         #     jumps to .Ltmp196
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp137-.Lfunc_begin2         # >> Call Site 76 <<
	.uleb128 .Ltmp138-.Ltmp137              #   Call between .Ltmp137 and .Ltmp138
	.uleb128 .Ltmp139-.Lfunc_begin2         #     jumps to .Ltmp139
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp123-.Lfunc_begin2         # >> Call Site 77 <<
	.uleb128 .Ltmp124-.Ltmp123              #   Call between .Ltmp123 and .Ltmp124
	.uleb128 .Ltmp125-.Lfunc_begin2         #     jumps to .Ltmp125
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp92-.Lfunc_begin2          # >> Call Site 78 <<
	.uleb128 .Ltmp93-.Ltmp92                #   Call between .Ltmp92 and .Ltmp93
	.uleb128 .Ltmp94-.Lfunc_begin2          #     jumps to .Ltmp94
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp24-.Lfunc_begin2          # >> Call Site 79 <<
	.uleb128 .Ltmp25-.Ltmp24                #   Call between .Ltmp24 and .Ltmp25
	.uleb128 .Ltmp26-.Lfunc_begin2          #     jumps to .Ltmp26
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp57-.Lfunc_begin2          # >> Call Site 80 <<
	.uleb128 .Ltmp58-.Ltmp57                #   Call between .Ltmp57 and .Ltmp58
	.uleb128 .Ltmp59-.Lfunc_begin2          #     jumps to .Ltmp59
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp33-.Lfunc_begin2          # >> Call Site 81 <<
	.uleb128 .Ltmp34-.Ltmp33                #   Call between .Ltmp33 and .Ltmp34
	.uleb128 .Ltmp35-.Lfunc_begin2          #     jumps to .Ltmp35
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp15-.Lfunc_begin2          # >> Call Site 82 <<
	.uleb128 .Ltmp16-.Ltmp15                #   Call between .Ltmp15 and .Ltmp16
	.uleb128 .Ltmp17-.Lfunc_begin2          #     jumps to .Ltmp17
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp101-.Lfunc_begin2         # >> Call Site 83 <<
	.uleb128 .Ltmp102-.Ltmp101              #   Call between .Ltmp101 and .Ltmp102
	.uleb128 .Ltmp103-.Lfunc_begin2         #     jumps to .Ltmp103
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp42-.Lfunc_begin2          # >> Call Site 84 <<
	.uleb128 .Ltmp43-.Ltmp42                #   Call between .Ltmp42 and .Ltmp43
	.uleb128 .Ltmp44-.Lfunc_begin2          #     jumps to .Ltmp44
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp51-.Lfunc_begin2          # >> Call Site 85 <<
	.uleb128 .Ltmp52-.Ltmp51                #   Call between .Ltmp51 and .Ltmp52
	.uleb128 .Ltmp53-.Lfunc_begin2          #     jumps to .Ltmp53
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp157-.Lfunc_begin2         # >> Call Site 86 <<
	.uleb128 .Ltmp158-.Ltmp157              #   Call between .Ltmp157 and .Ltmp158
	.uleb128 .Ltmp159-.Lfunc_begin2         #     jumps to .Ltmp159
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp158-.Lfunc_begin2         # >> Call Site 87 <<
	.uleb128 .Lfunc_end12-.Ltmp158          #   Call between .Ltmp158 and .Lfunc_end12
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end2:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev,"axG",@progbits,_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev,comdat
	.hidden	_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev # -- Begin function _ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev
	.weak	_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev,@function
_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev: # @_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev
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
	movq	(%rdi), %r14
	testq	%r14, %r14
	je	.LBB13_7
# %bb.1:
	movq	%rdi, %rbx
	movq	8(%rdi), %r15
	movq	%r14, %rdi
	cmpq	%r14, %r15
	jne	.LBB13_2
	jmp	.LBB13_6
	.p2align	4, 0x90
.LBB13_4:                               #   in Loop: Header=BB13_2 Depth=1
	addq	$-24, %r15
	cmpq	%r14, %r15
	je	.LBB13_5
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
	movq	-24(%r15), %rdi
	testq	%rdi, %rdi
	je	.LBB13_4
# %bb.3:                                #   in Loop: Header=BB13_2 Depth=1
	movq	%rdi, -16(%r15)
	callq	_ZdlPv@PLT
	jmp	.LBB13_4
.LBB13_5:
	movq	(%rbx), %rdi
.LBB13_6:
	movq	%r14, 8(%rbx)
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
	.size	_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev, .Lfunc_end13-_ZNSt3__16vectorINS0_IdNS_9allocatorIdEEEENS1_IS3_EEED2B8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev,"axG",@progbits,_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev,comdat
	.hidden	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev # -- Begin function _ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
	.weak	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev,@function
_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev: # @_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
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
	movq	(%rdi), %r14
	testq	%r14, %r14
	je	.LBB14_7
# %bb.1:
	movq	%rdi, %rbx
	movq	8(%rdi), %r15
	movq	%r14, %rdi
	cmpq	%r14, %r15
	jne	.LBB14_2
	jmp	.LBB14_6
	.p2align	4, 0x90
.LBB14_4:                               #   in Loop: Header=BB14_2 Depth=1
	addq	$-24, %r15
	cmpq	%r14, %r15
	je	.LBB14_5
.LBB14_2:                               # =>This Inner Loop Header: Depth=1
	movq	-24(%r15), %rdi
	testq	%rdi, %rdi
	je	.LBB14_4
# %bb.3:                                #   in Loop: Header=BB14_2 Depth=1
	movq	%rdi, -16(%r15)
	callq	_ZdlPv@PLT
	jmp	.LBB14_4
.LBB14_5:
	movq	(%rbx), %rdi
.LBB14_6:
	movq	%r14, 8(%rbx)
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
	.size	_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev, .Lfunc_end14-_ZNSt3__16vectorINS0_ImNS_9allocatorImEEEENS1_IS3_EEED2B8ne180100Ev
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
.Lfunc_end15:
	.size	__clang_call_terminate, .Lfunc_end15-__clang_call_terminate
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l,"axG",@progbits,_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l,comdat
	.weak	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l # -- Begin function _ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l,@function
_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l: # @_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l
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
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	16(%rbx), %rax
	movq	%rax, %rdx
	subq	%rdi, %rdx
	sarq	$3, %rdx
	cmpq	%rcx, %rdx
	jae	.LBB16_7
# %bb.1:
	testq	%rdi, %rdi
	je	.LBB16_3
# %bb.2:
	movq	%rdi, 8(%rbx)
	movq	%rcx, %r12
	callq	_ZdlPv@PLT
	movq	%r12, %rcx
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	xorl	%eax, %eax
.LBB16_3:
	movq	%rcx, %rdx
	shrq	$61, %rdx
	jne	.LBB16_30
# %bb.4:
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	movq	%rax, %r12
	sarq	$2, %r12
	cmpq	%rcx, %r12
	cmovbeq	%rcx, %r12
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %r12
	cmpq	%rdx, %r12
	ja	.LBB16_30
# %bb.5:
	leaq	(,%r12,8), %rdi
	callq	_Znwm@PLT
	movq	%rax, (%rbx)
	leaq	(%rax,%r12,8), %rcx
	movq	%rcx, 16(%rbx)
	cmpq	%r14, %r15
	je	.LBB16_17
	.p2align	4, 0x90
.LBB16_6:                               # =>This Inner Loop Header: Depth=1
	movq	16(%r15), %rcx
	movq	%rcx, (%rax)
	movq	(%r15), %r15
	addq	$8, %rax
	cmpq	%r14, %r15
	jne	.LBB16_6
	jmp	.LBB16_17
.LBB16_7:
	movq	8(%rbx), %rax
	movq	%rax, %rdx
	subq	%rdi, %rdx
	sarq	$3, %rdx
	cmpq	%rcx, %rdx
	jae	.LBB16_13
# %bb.8:
	testq	%rdx, %rdx
	jle	.LBB16_25
# %bb.9:
	movq	%rdx, %rsi
	andq	$7, %rsi
	je	.LBB16_19
# %bb.10:
	xorl	%r8d, %r8d
	movq	%r15, %rcx
	.p2align	4, 0x90
.LBB16_11:                              # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rcx
	incq	%r8
	cmpq	%r8, %rsi
	jne	.LBB16_11
# %bb.12:
	movq	%rdx, %rsi
	subq	%r8, %rsi
	cmpq	$8, %rdx
	jae	.LBB16_20
	jmp	.LBB16_22
.LBB16_13:
	cmpq	%r14, %r15
	je	.LBB16_16
# %bb.14:
	movq	%rdi, %rax
	.p2align	4, 0x90
.LBB16_15:                              # =>This Inner Loop Header: Depth=1
	movq	16(%r15), %rcx
	movq	%rcx, (%rdi)
	movq	(%r15), %r15
	addq	$8, %rdi
	addq	$8, %rax
	cmpq	%r14, %r15
	jne	.LBB16_15
	jmp	.LBB16_17
.LBB16_16:
	movq	%rdi, %rax
	jmp	.LBB16_17
.LBB16_19:
	movq	%rdx, %rsi
	movq	%r15, %rcx
	cmpq	$8, %rdx
	jb	.LBB16_22
.LBB16_20:
	decq	%rsi
	.p2align	4, 0x90
.LBB16_21:                              # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	addq	$-8, %rsi
	cmpq	$-2, %rsi
	jb	.LBB16_21
.LBB16_22:
	cmpq	%r15, %rcx
	je	.LBB16_25
	.p2align	4, 0x90
.LBB16_23:                              # =>This Inner Loop Header: Depth=1
	movq	16(%r15), %rdx
	movq	%rdx, (%rdi)
	movq	(%r15), %r15
	addq	$8, %rdi
	cmpq	%rcx, %r15
	jne	.LBB16_23
# %bb.24:
	movq	%rcx, %r15
.LBB16_25:
	cmpq	%r14, %r15
	je	.LBB16_29
# %bb.26:
	movq	%rax, %rcx
	.p2align	4, 0x90
.LBB16_27:                              # =>This Inner Loop Header: Depth=1
	movq	16(%r15), %rdx
	movq	%rdx, (%rax)
	movq	(%r15), %r15
	addq	$8, %rax
	addq	$8, %rcx
	cmpq	%r14, %r15
	jne	.LBB16_27
# %bb.28:
	movq	%rcx, 8(%rbx)
	jmp	.LBB16_18
.LBB16_29:
	movq	%rax, %rcx
.LBB16_17:
	movq	%rax, 8(%rbx)
.LBB16_18:
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
.LBB16_30:
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Lfunc_end16:
	.size	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l, .Lfunc_end16-_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_21__hash_const_iteratorIPNS_11__hash_nodeImPvEEEESA_EEvT_T0_l
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev,"axG",@progbits,_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev,comdat
	.hidden	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev # -- Begin function _ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
	.weak	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev,@function
_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev: # @_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.L.str.23(%rip), %rdi
	callq	_ZNSt3__120__throw_length_errorB8ne180100EPKc
.Lfunc_end17:
	.size	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev, .Lfunc_end17-_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__120__throw_length_errorB8ne180100EPKc,"axG",@progbits,_ZNSt3__120__throw_length_errorB8ne180100EPKc,comdat
	.hidden	_ZNSt3__120__throw_length_errorB8ne180100EPKc # -- Begin function _ZNSt3__120__throw_length_errorB8ne180100EPKc
	.weak	_ZNSt3__120__throw_length_errorB8ne180100EPKc
	.p2align	4, 0x90
	.type	_ZNSt3__120__throw_length_errorB8ne180100EPKc,@function
_ZNSt3__120__throw_length_errorB8ne180100EPKc: # @_ZNSt3__120__throw_length_errorB8ne180100EPKc
.Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception3
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %r14
	movl	$16, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
.Ltmp212:
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	_ZNSt12length_errorC2B8ne180100EPKc
.Ltmp213:
# %bb.1:
	movq	_ZTISt12length_error@GOTPCREL(%rip), %rsi
	movq	_ZNSt12length_errorD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.LBB18_2:
.Ltmp214:
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	__cxa_free_exception@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end18:
	.size	_ZNSt3__120__throw_length_errorB8ne180100EPKc, .Lfunc_end18-_ZNSt3__120__throw_length_errorB8ne180100EPKc
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__120__throw_length_errorB8ne180100EPKc,"aG",@progbits,_ZNSt3__120__throw_length_errorB8ne180100EPKc,comdat
	.p2align	2, 0x0
GCC_except_table18:
.Lexception3:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end3-.Lcst_begin3
.Lcst_begin3:
	.uleb128 .Lfunc_begin3-.Lfunc_begin3    # >> Call Site 1 <<
	.uleb128 .Ltmp212-.Lfunc_begin3         #   Call between .Lfunc_begin3 and .Ltmp212
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp212-.Lfunc_begin3         # >> Call Site 2 <<
	.uleb128 .Ltmp213-.Ltmp212              #   Call between .Ltmp212 and .Ltmp213
	.uleb128 .Ltmp214-.Lfunc_begin3         #     jumps to .Ltmp214
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp213-.Lfunc_begin3         # >> Call Site 3 <<
	.uleb128 .Lfunc_end18-.Ltmp213          #   Call between .Ltmp213 and .Lfunc_end18
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end3:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt12length_errorC2B8ne180100EPKc,"axG",@progbits,_ZNSt12length_errorC2B8ne180100EPKc,comdat
	.hidden	_ZNSt12length_errorC2B8ne180100EPKc # -- Begin function _ZNSt12length_errorC2B8ne180100EPKc
	.weak	_ZNSt12length_errorC2B8ne180100EPKc
	.p2align	4, 0x90
	.type	_ZNSt12length_errorC2B8ne180100EPKc,@function
_ZNSt12length_errorC2B8ne180100EPKc:    # @_ZNSt12length_errorC2B8ne180100EPKc
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	callq	_ZNSt11logic_errorC2EPKc@PLT
	movq	_ZTVSt12length_error@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, (%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end19:
	.size	_ZNSt12length_errorC2B8ne180100EPKc, .Lfunc_end19-_ZNSt12length_errorC2B8ne180100EPKc
	.cfi_endproc
                                        # -- End function
	.section	.text._ZSt28__throw_bad_array_new_lengthB8ne180100v,"axG",@progbits,_ZSt28__throw_bad_array_new_lengthB8ne180100v,comdat
	.hidden	_ZSt28__throw_bad_array_new_lengthB8ne180100v # -- Begin function _ZSt28__throw_bad_array_new_lengthB8ne180100v
	.weak	_ZSt28__throw_bad_array_new_lengthB8ne180100v
	.p2align	4, 0x90
	.type	_ZSt28__throw_bad_array_new_lengthB8ne180100v,@function
_ZSt28__throw_bad_array_new_lengthB8ne180100v: # @_ZSt28__throw_bad_array_new_lengthB8ne180100v
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movl	$8, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	_ZNSt20bad_array_new_lengthC1Ev@PLT
	movq	_ZTISt20bad_array_new_length@GOTPCREL(%rip), %rsi
	movq	_ZNSt20bad_array_new_lengthD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.Lfunc_end20:
	.size	_ZSt28__throw_bad_array_new_lengthB8ne180100v, .Lfunc_end20-_ZSt28__throw_bad_array_new_lengthB8ne180100v
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l,"axG",@progbits,_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l,comdat
	.weak	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l # -- Begin function _ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l,@function
_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l: # @_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l
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
	movq	%r8, %r14
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	16(%rbx), %rax
	movq	%rax, %rcx
	subq	%rdi, %rcx
	sarq	$3, %rcx
	cmpq	%r9, %rcx
	jae	.LBB21_1
# %bb.41:
	testq	%rdi, %rdi
	je	.LBB21_43
# %bb.42:
	movq	%rdi, 8(%rbx)
	movq	%r9, %r13
	callq	_ZdlPv@PLT
	movq	%r13, %r9
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	xorl	%eax, %eax
.LBB21_43:
	movq	%r9, %rcx
	shrq	$61, %rcx
	jne	.LBB21_54
# %bb.44:
	movabsq	$2305843009213693951, %rcx      # imm = 0x1FFFFFFFFFFFFFFF
	movq	%rax, %r13
	sarq	$2, %r13
	cmpq	%r9, %r13
	cmovbeq	%r9, %r13
	movabsq	$9223372036854775800, %rdx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rdx, %rax
	cmovaeq	%rcx, %r13
	cmpq	%rcx, %r13
	ja	.LBB21_54
# %bb.45:
	leaq	(,%r13,8), %rdi
	callq	_Znwm@PLT
	movq	%rax, (%rbx)
	leaq	(%rax,%r13,8), %rcx
	movq	%rcx, 16(%rbx)
	cmpq	%r14, %r12
	je	.LBB21_52
	.p2align	4, 0x90
.LBB21_47:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_48 Depth 2
	movq	(%r12), %rcx
	movq	%rcx, (%rax)
	addq	$8, %r12
	movzbl	1(%r15), %ecx
	incq	%r15
	cmpb	$-2, %cl
	jg	.LBB21_49
	.p2align	4, 0x90
.LBB21_48:                              #   Parent Loop BB21_47 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %r12
	movzbl	1(%r15), %ecx
	incq	%r15
	cmpb	$-1, %cl
	jl	.LBB21_48
.LBB21_49:                              #   in Loop: Header=BB21_47 Depth=1
	cmpb	$-1, %cl
	je	.LBB21_50
.LBB21_51:                              #   in Loop: Header=BB21_47 Depth=1
	addq	$8, %rax
	cmpq	%r14, %r12
	jne	.LBB21_47
	jmp	.LBB21_52
.LBB21_50:                              #   in Loop: Header=BB21_47 Depth=1
	xorl	%r12d, %r12d
	jmp	.LBB21_51
.LBB21_1:
	movq	8(%rbx), %rax
	movq	%rax, %r8
	subq	%rdi, %r8
	movq	%r8, %rsi
	sarq	$3, %rsi
	cmpq	%r9, %rsi
	jae	.LBB21_34
# %bb.2:
	testq	%rsi, %rsi
	jle	.LBB21_28
# %bb.3:
	testb	$8, %r8b
	jne	.LBB21_5
# %bb.4:
	movq	%r12, %rdx
	movq	%r15, %rcx
	cmpq	$8, %r8
	jne	.LBB21_11
	jmp	.LBB21_20
	.p2align	4, 0x90
.LBB21_34:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_36 Depth 2
	cmpq	%r14, %r12
	je	.LBB21_40
# %bb.35:                               #   in Loop: Header=BB21_34 Depth=1
	movq	(%r12), %rax
	movq	%rax, (%rdi)
	addq	$8, %r12
	movzbl	1(%r15), %eax
	incq	%r15
	cmpb	$-2, %al
	jg	.LBB21_37
	.p2align	4, 0x90
.LBB21_36:                              #   Parent Loop BB21_34 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %r12
	movzbl	1(%r15), %eax
	incq	%r15
	cmpb	$-1, %al
	jl	.LBB21_36
.LBB21_37:                              #   in Loop: Header=BB21_34 Depth=1
	cmpb	$-1, %al
	je	.LBB21_38
.LBB21_39:                              #   in Loop: Header=BB21_34 Depth=1
	addq	$8, %rdi
	jmp	.LBB21_34
.LBB21_38:                              #   in Loop: Header=BB21_34 Depth=1
	xorl	%r12d, %r12d
	jmp	.LBB21_39
.LBB21_40:
	movq	%rdi, 8(%rbx)
	jmp	.LBB21_53
.LBB21_5:
	leaq	1(%r15), %rcx
	leaq	8(%r12), %rdx
	movzbl	1(%r15), %r9d
	cmpb	$-2, %r9b
	jg	.LBB21_7
	.p2align	4, 0x90
.LBB21_6:                               # =>This Inner Loop Header: Depth=1
	addq	$8, %rdx
	movzbl	1(%rcx), %r9d
	incq	%rcx
	cmpb	$-1, %r9b
	jl	.LBB21_6
.LBB21_7:
	cmpb	$-1, %r9b
	je	.LBB21_8
# %bb.9:
	decq	%rsi
	cmpq	$8, %r8
	je	.LBB21_20
	.p2align	4, 0x90
.LBB21_11:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_12 Depth 2
                                        #     Child Loop BB21_16 Depth 2
	addq	$8, %rdx
	movzbl	1(%rcx), %r8d
	cmpb	$-2, %r8b
	jg	.LBB21_13
	.p2align	4, 0x90
.LBB21_12:                              #   Parent Loop BB21_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rdx
	movzbl	2(%rcx), %r8d
	incq	%rcx
	cmpb	$-1, %r8b
	jl	.LBB21_12
.LBB21_13:                              #   in Loop: Header=BB21_11 Depth=1
	cmpb	$-1, %r8b
	je	.LBB21_14
.LBB21_15:                              #   in Loop: Header=BB21_11 Depth=1
	addq	$8, %rdx
	movzbl	2(%rcx), %r8d
	addq	$2, %rcx
	cmpb	$-2, %r8b
	jg	.LBB21_17
	.p2align	4, 0x90
.LBB21_16:                              #   Parent Loop BB21_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %rdx
	movzbl	1(%rcx), %r8d
	incq	%rcx
	cmpb	$-1, %r8b
	jl	.LBB21_16
.LBB21_17:                              #   in Loop: Header=BB21_11 Depth=1
	cmpb	$-1, %r8b
	je	.LBB21_18
# %bb.19:                               #   in Loop: Header=BB21_11 Depth=1
	leaq	-2(%rsi), %r8
	cmpq	$2, %rsi
	movq	%r8, %rsi
	jg	.LBB21_11
	jmp	.LBB21_20
.LBB21_14:                              #   in Loop: Header=BB21_11 Depth=1
	xorl	%edx, %edx
	jmp	.LBB21_15
.LBB21_18:                              #   in Loop: Header=BB21_11 Depth=1
	xorl	%edx, %edx
	leaq	-2(%rsi), %r8
	cmpq	$2, %rsi
	movq	%r8, %rsi
	jg	.LBB21_11
	jmp	.LBB21_20
.LBB21_8:
	xorl	%edx, %edx
	decq	%rsi
	cmpq	$8, %r8
	jne	.LBB21_11
.LBB21_20:
	cmpq	%r12, %rdx
	je	.LBB21_21
	.p2align	4, 0x90
.LBB21_22:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_23 Depth 2
	movq	(%r12), %rsi
	movq	%rsi, (%rdi)
	addq	$8, %r12
	movzbl	1(%r15), %esi
	incq	%r15
	cmpb	$-2, %sil
	jg	.LBB21_24
	.p2align	4, 0x90
.LBB21_23:                              #   Parent Loop BB21_22 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %r12
	movzbl	1(%r15), %esi
	incq	%r15
	cmpb	$-1, %sil
	jl	.LBB21_23
.LBB21_24:                              #   in Loop: Header=BB21_22 Depth=1
	cmpb	$-1, %sil
	je	.LBB21_25
# %bb.26:                               #   in Loop: Header=BB21_22 Depth=1
	addq	$8, %rdi
	cmpq	%rdx, %r12
	jne	.LBB21_22
	jmp	.LBB21_27
.LBB21_25:                              #   in Loop: Header=BB21_22 Depth=1
	xorl	%r12d, %r12d
	addq	$8, %rdi
	cmpq	%rdx, %r12
	jne	.LBB21_22
.LBB21_27:
	movq	%rcx, %r15
	movq	%rdx, %r12
	cmpq	%r14, %r12
	jne	.LBB21_29
	jmp	.LBB21_52
.LBB21_21:
	movq	%rcx, %r15
	.p2align	4, 0x90
.LBB21_28:
	cmpq	%r14, %r12
	je	.LBB21_52
.LBB21_29:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_30 Depth 2
	movq	(%r12), %rcx
	movq	%rcx, (%rax)
	addq	$8, %r12
	movzbl	1(%r15), %ecx
	incq	%r15
	cmpb	$-2, %cl
	jg	.LBB21_31
	.p2align	4, 0x90
.LBB21_30:                              #   Parent Loop BB21_29 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	addq	$8, %r12
	movzbl	1(%r15), %ecx
	incq	%r15
	cmpb	$-1, %cl
	jl	.LBB21_30
.LBB21_31:                              #   in Loop: Header=BB21_29 Depth=1
	cmpb	$-1, %cl
	je	.LBB21_32
.LBB21_33:                              #   in Loop: Header=BB21_29 Depth=1
	addq	$8, %rax
	cmpq	%r14, %r12
	jne	.LBB21_29
	jmp	.LBB21_52
.LBB21_32:                              #   in Loop: Header=BB21_29 Depth=1
	xorl	%r12d, %r12d
	jmp	.LBB21_33
.LBB21_52:
	movq	%rax, 8(%rbx)
.LBB21_53:
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
.LBB21_54:
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Lfunc_end21:
	.size	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l, .Lfunc_end21-_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100IN4absl12lts_2026081718container_internal12raw_hash_setINS7_17FlatHashSetPolicyImEEJEE8iteratorESC_EEvT_T0_l
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev,"axG",@progbits,_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev,comdat
	.hidden	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev # -- Begin function _ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
	.weak	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev,@function
_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev: # @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.L.str.26(%rip), %rdi
	callq	_ZNSt3__120__throw_length_errorB8ne180100EPKc
.Lfunc_end22:
	.size	_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev, .Lfunc_end22-_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,"axG",@progbits,_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,comdat
	.hidden	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev # -- Begin function _ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.weak	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,@function
_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev: # @_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
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
	cmpb	$0, 8(%rdi)
	je	.LBB23_1
.LBB23_8:
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
.LBB23_1:
	.cfi_def_cfa_offset 48
	movq	%rdi, %rbx
	movq	(%rdi), %r14
	movq	(%r14), %r15
	testq	%r15, %r15
	je	.LBB23_8
# %bb.2:
	movq	8(%r14), %r12
	movq	%r15, %rdi
	cmpq	%r15, %r12
	jne	.LBB23_3
	jmp	.LBB23_7
	.p2align	4, 0x90
.LBB23_5:                               #   in Loop: Header=BB23_3 Depth=1
	addq	$-24, %r12
	cmpq	%r15, %r12
	je	.LBB23_6
.LBB23_3:                               # =>This Inner Loop Header: Depth=1
	movq	-24(%r12), %rdi
	testq	%rdi, %rdi
	je	.LBB23_5
# %bb.4:                                #   in Loop: Header=BB23_3 Depth=1
	movq	%rdi, -16(%r12)
	callq	_ZdlPv@PLT
	jmp	.LBB23_5
.LBB23_6:
	movq	(%rbx), %rax
	movq	(%rax), %rdi
.LBB23_7:
	movq	%r15, 8(%r14)
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
	jmp	_ZdlPv@PLT                      # TAILCALL
.Lfunc_end23:
	.size	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev, .Lfunc_end23-_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_ImNS_9allocatorImEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l,"axG",@progbits,_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l,comdat
	.weak	_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l # -- Begin function _ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l,@function
_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l: # @_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r12
	testq	%r8, %r8
	jle	.LBB24_37
# %bb.1:
	movq	%rdx, %r10
	movq	8(%rdi), %r15
	movq	16(%rdi), %rax
	movq	%rax, %rdx
	subq	%r15, %rdx
	sarq	$3, %rdx
	cmpq	%r8, %rdx
	jge	.LBB24_2
# %bb.20:
	movq	(%rdi), %rbp
	movq	%r15, %rcx
	subq	%rbp, %rcx
	sarq	$3, %rcx
	addq	%r8, %rcx
	movq	%rcx, %rdx
	shrq	$61, %rdx
	jne	.LBB24_38
# %bb.21:
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	subq	%rbp, %rax
	movq	%rax, %r14
	sarq	$2, %r14
	cmpq	%rcx, %r14
	cmovbeq	%rcx, %r14
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %r14
	testq	%r14, %r14
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movq	%r10, (%rsp)                    # 8-byte Spill
	je	.LBB24_22
# %bb.23:
	cmpq	%rdx, %r14
	ja	.LBB24_39
# %bb.24:
	movq	%r8, %r13
	leaq	(,%r14,8), %rdi
	callq	_Znwm@PLT
	movq	%r13, %r8
	jmp	.LBB24_25
.LBB24_2:
	movq	%r15, %rbp
	subq	%r12, %rbp
	movq	%rbp, %rbx
	sarq	$3, %rbx
	cmpq	%r8, %rbx
	jge	.LBB24_3
# %bb.4:
	addq	%r10, %rbp
	subq	%rbp, %rcx
	je	.LBB24_6
# %bb.5:
	movq	%r10, (%rsp)                    # 8-byte Spill
	movq	%rdi, 8(%rsp)                   # 8-byte Spill
	movq	%r15, %rdi
	movq	%rbp, %rsi
	movq	%rcx, %rdx
	movq	%rcx, %r14
	movq	%r8, %r13
	callq	memmove@PLT
	movq	%r13, %r8
	movq	8(%rsp), %rdi                   # 8-byte Reload
	movq	(%rsp), %r10                    # 8-byte Reload
	movq	%r14, %rcx
.LBB24_6:
	addq	%r15, %rcx
	movq	%rcx, 8(%rdi)
	testq	%rbx, %rbx
	jle	.LBB24_37
# %bb.7:
	movq	%rdi, %r11
	jmp	.LBB24_8
.LBB24_3:
	movq	%rdi, %r11
	leaq	(%r10,%r8,8), %rbp
	movq	%r15, %rcx
.LBB24_8:
	leaq	(%r12,%r8,8), %rax
	leaq	(,%r8,8), %r9
	movq	%rcx, %rdx
	subq	%r9, %rdx
	movq	%rcx, %rsi
	cmpq	%r15, %rdx
	jae	.LBB24_16
# %bb.9:
	movq	%rcx, %rdi
	subq	%r9, %rdi
	leaq	8(%rdi), %rsi
	cmpq	%rsi, %r15
	cmovaq	%r15, %rsi
	leaq	(%rsi,%r8,8), %rsi
	movq	%rcx, %rbx
	notq	%rbx
	addq	%rsi, %rbx
	cmpq	$104, %rbx
	jb	.LBB24_10
# %bb.12:
	leaq	(%rcx,%r8,8), %rsi
	subq	%rcx, %rsi
	cmpq	$32, %rsi
	jae	.LBB24_13
.LBB24_10:
	movq	%rcx, %rsi
	.p2align	4, 0x90
.LBB24_11:                              # =>This Inner Loop Header: Depth=1
	movq	(%rdx), %rdi
	movq	%rdi, (%rsi)
	addq	$8, %rdx
	addq	$8, %rsi
	cmpq	%r15, %rdx
	jb	.LBB24_11
.LBB24_16:
	movq	%rsi, 8(%r11)
	cmpq	%rax, %rcx
	je	.LBB24_18
# %bb.17:
	movq	%rcx, %rdx
	subq	%rax, %rdx
	subq	%rdx, %rcx
	movq	%rcx, %rdi
	movq	%r12, %rsi
	movq	%r10, %rbx
	callq	memmove@PLT
	movq	%rbx, %r10
.LBB24_18:
	subq	%r10, %rbp
	je	.LBB24_37
# %bb.19:
	movq	%r12, %rdi
	movq	%r10, %rsi
	movq	%rbp, %rdx
	callq	memmove@PLT
	jmp	.LBB24_37
.LBB24_22:
	xorl	%eax, %eax
.LBB24_25:
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r12, %r13
	subq	%rbp, %r12
	movq	%r12, %rcx
	sarq	$3, %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	leaq	(%rax,%rcx,8), %rbx
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	leaq	(,%r8,8), %rdx
	movq	%rbx, %rdi
	movq	(%rsp), %rsi                    # 8-byte Reload
	callq	memcpy@PLT
	movq	16(%rsp), %r8                   # 8-byte Reload
	movq	%rbx, %r11
	movq	%r13, %r10
	cmpq	%r13, %rbp
	je	.LBB24_32
# %bb.26:
	leaq	-8(%r12), %rcx
	movq	%r11, %rbx
	movq	%r10, %rax
	cmpq	$104, %rcx
	jb	.LBB24_31
# %bb.27:
	addq	%r8, %r12
	movq	%r10, %rax
	movq	%r10, %rdx
	subq	%r12, %rdx
	movq	%r11, %rbx
	cmpq	$32, %rdx
	jb	.LBB24_31
# %bb.28:
	shrq	$3, %rcx
	incq	%rcx
	movq	%rcx, %rdx
	andq	$-4, %rdx
	leaq	(,%rdx,8), %rsi
	movq	%r11, %rbx
	subq	%rsi, %rbx
	movq	%r10, %rdi
	movq	%r10, %rax
	subq	%rsi, %rax
	leaq	-16(%r10), %rsi
	movq	24(%rsp), %rdi                  # 8-byte Reload
	leaq	(%r8,%rdi,8), %rdi
	addq	$-16, %rdi
	movq	%rdx, %r8
	negq	%r8
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB24_29:                              # =>This Inner Loop Header: Depth=1
	movups	-16(%rsi,%r9,8), %xmm0
	movups	(%rsi,%r9,8), %xmm1
	movups	%xmm1, (%rdi,%r9,8)
	movups	%xmm0, -16(%rdi,%r9,8)
	addq	$-4, %r9
	cmpq	%r9, %r8
	jne	.LBB24_29
# %bb.30:
	cmpq	%rdx, %rcx
	movq	16(%rsp), %r8                   # 8-byte Reload
	je	.LBB24_32
	.p2align	4, 0x90
.LBB24_31:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rax), %rcx
	addq	$-8, %rax
	movq	%rcx, -8(%rbx)
	addq	$-8, %rbx
	cmpq	%rbp, %rax
	jne	.LBB24_31
.LBB24_32:
	leaq	(%r8,%r14,8), %r14
	movq	32(%rsp), %rax                  # 8-byte Reload
	leaq	(%r11,%rax,8), %r13
	subq	%r10, %r15
	je	.LBB24_34
# %bb.33:
	movq	%r10, %rsi
	movq	%r13, %rdi
	movq	%r15, %rdx
	movq	%r11, %r12
	callq	memmove@PLT
	movq	%r12, %r11
.LBB24_34:
	addq	%r15, %r13
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rbx, (%rax)
	movq	%r13, 8(%rax)
	movq	%r14, 16(%rax)
	testq	%rbp, %rbp
	je	.LBB24_35
# %bb.36:
	movq	%rbp, %rdi
	movq	%r11, %r12
	callq	_ZdlPv@PLT
	jmp	.LBB24_37
.LBB24_35:
	movq	%r11, %r12
.LBB24_37:
	movq	%r12, %rax
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
.LBB24_13:
	.cfi_def_cfa_offset 96
	movq	%r10, %r8
	shrq	$3, %rbx
	incq	%rbx
	movq	%rbx, %r9
	andq	$-4, %r9
	leaq	(%rdx,%r9,8), %rdx
	leaq	(%rcx,%r9,8), %rsi
	addq	$16, %rdi
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB24_14:                              # =>This Inner Loop Header: Depth=1
	movups	-16(%rdi,%r10,8), %xmm0
	movups	(%rdi,%r10,8), %xmm1
	movups	%xmm0, (%rcx,%r10,8)
	movups	%xmm1, 16(%rcx,%r10,8)
	addq	$4, %r10
	cmpq	%r10, %r9
	jne	.LBB24_14
# %bb.15:
	cmpq	%r9, %rbx
	movq	%r8, %r10
	jne	.LBB24_11
	jmp	.LBB24_16
.LBB24_38:
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.LBB24_39:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Lfunc_end24:
	.size	_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l, .Lfunc_end24-_ZNSt3__16vectorImNS_9allocatorImEEE18__insert_with_sizeB8ne180100INS_11__wrap_iterIPmEES7_EES7_NS5_IPKmEET_T0_l
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,"axG",@progbits,_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,comdat
	.hidden	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev # -- Begin function _ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.weak	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev,@function
_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev: # @_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
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
	cmpb	$0, 8(%rdi)
	je	.LBB25_1
.LBB25_8:
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
.LBB25_1:
	.cfi_def_cfa_offset 48
	movq	%rdi, %rbx
	movq	(%rdi), %r14
	movq	(%r14), %r15
	testq	%r15, %r15
	je	.LBB25_8
# %bb.2:
	movq	8(%r14), %r12
	movq	%r15, %rdi
	cmpq	%r15, %r12
	jne	.LBB25_3
	jmp	.LBB25_7
	.p2align	4, 0x90
.LBB25_5:                               #   in Loop: Header=BB25_3 Depth=1
	addq	$-24, %r12
	cmpq	%r15, %r12
	je	.LBB25_6
.LBB25_3:                               # =>This Inner Loop Header: Depth=1
	movq	-24(%r12), %rdi
	testq	%rdi, %rdi
	je	.LBB25_5
# %bb.4:                                #   in Loop: Header=BB25_3 Depth=1
	movq	%rdi, -16(%r12)
	callq	_ZdlPv@PLT
	jmp	.LBB25_5
.LBB25_6:
	movq	(%rbx), %rax
	movq	(%rax), %rdi
.LBB25_7:
	movq	%r15, 8(%r14)
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
	jmp	_ZdlPv@PLT                      # TAILCALL
.Lfunc_end25:
	.size	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev, .Lfunc_end25-_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS1_IdNS_9allocatorIdEEEENS2_IS4_EEE16__destroy_vectorEED2B8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l,"axG",@progbits,_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l,comdat
	.weak	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l # -- Begin function _ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l
	.p2align	4, 0x90
	.type	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l,@function
_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l: # @_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l
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
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	(%rdi), %r12
	movq	16(%rdi), %rax
	movq	%rax, %rdx
	subq	%r12, %rdx
	sarq	$3, %rdx
	cmpq	%rcx, %rdx
	jae	.LBB26_1
# %bb.9:
	testq	%r12, %r12
	je	.LBB26_11
# %bb.10:
	movq	%r12, 8(%rbx)
	movq	%r12, %rdi
	movq	%rcx, %r12
	callq	_ZdlPv@PLT
	movq	%r12, %rcx
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	xorl	%eax, %eax
.LBB26_11:
	movq	%rcx, %rdx
	shrq	$61, %rdx
	jne	.LBB26_16
# %bb.12:
	movabsq	$2305843009213693951, %rdx      # imm = 0x1FFFFFFFFFFFFFFF
	movq	%rax, %r13
	sarq	$2, %r13
	cmpq	%rcx, %r13
	cmovbeq	%rcx, %r13
	movabsq	$9223372036854775800, %rcx      # imm = 0x7FFFFFFFFFFFFFF8
	cmpq	%rcx, %rax
	cmovaeq	%rdx, %r13
	cmpq	%rdx, %r13
	ja	.LBB26_16
# %bb.13:
	leaq	(,%r13,8), %rdi
	callq	_Znwm@PLT
	movq	%rax, %r12
	movq	%rax, (%rbx)
	movq	%rax, 8(%rbx)
	leaq	(%rax,%r13,8), %rax
	movq	%rax, 16(%rbx)
	subq	%r15, %r14
	je	.LBB26_15
# %bb.14:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	jmp	.LBB26_15
.LBB26_1:
	movq	8(%rbx), %rax
	movq	%rax, %rdx
	subq	%r12, %rdx
	movq	%rdx, %rsi
	sarq	$3, %rsi
	cmpq	%rcx, %rsi
	jae	.LBB26_7
# %bb.2:
	leaq	(%r15,%rdx), %r13
	cmpq	%r12, %rax
	je	.LBB26_4
# %bb.3:
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	memmove@PLT
	movq	8(%rbx), %r12
.LBB26_4:
	subq	%r13, %r14
	je	.LBB26_15
# %bb.5:
	movq	%r12, %rdi
	movq	%r13, %rsi
	jmp	.LBB26_6
.LBB26_7:
	subq	%r15, %r14
	je	.LBB26_15
# %bb.8:
	movq	%r12, %rdi
	movq	%r15, %rsi
.LBB26_6:
	movq	%r14, %rdx
	callq	memmove@PLT
.LBB26_15:
	addq	%r14, %r12
	movq	%r12, 8(%rbx)
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
.LBB26_16:
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	callq	_ZNKSt3__16vectorImNS_9allocatorImEEE20__throw_length_errorB8ne180100Ev
.Lfunc_end26:
	.size	_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l, .Lfunc_end26-_ZNSt3__16vectorImNS_9allocatorImEEE18__assign_with_sizeB8ne180100INS_11__wrap_iterIPKmEES8_EEvT_T0_l
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev,"axG",@progbits,_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev,comdat
	.hidden	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev # -- Begin function _ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
	.weak	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
	.p2align	4, 0x90
	.type	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev,@function
_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev: # @_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.L.str.23(%rip), %rdi
	callq	_ZNSt3__120__throw_length_errorB8ne180100EPKc
.Lfunc_end27:
	.size	_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev, .Lfunc_end27-_ZNKSt3__16vectorIdNS_9allocatorIdEEE20__throw_length_errorB8ne180100Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm,"axG",@progbits,_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm,comdat
	.weak	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm # -- Begin function _ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm
	.p2align	4, 0x90
	.type	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm,@function
_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm: # @_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm
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
	movq	%rdi, %rbx
	testq	%rsi, %rsi
	je	.LBB28_36
# %bb.1:
	movq	%rsi, %r14
	movabsq	$2305843009213693948, %r15      # imm = 0x1FFFFFFFFFFFFFFC
	leaq	3(%r15), %rax
	cmpq	%rax, %rsi
	ja	.LBB28_40
# %bb.2:
	leaq	(,%r14,8), %rdi
	callq	_Znwm@PLT
	movq	(%rbx), %rdi
	movq	%rax, (%rbx)
	testq	%rdi, %rdi
	je	.LBB28_4
# %bb.3:
	callq	_ZdlPv@PLT
.LBB28_4:
	movq	%r14, 8(%rbx)
	movl	%r14d, %eax
	andl	$3, %eax
	cmpq	$4, %r14
	jae	.LBB28_13
# %bb.5:
	xorl	%ecx, %ecx
	jmp	.LBB28_6
.LBB28_36:
	movq	(%rbx), %rdi
	movq	$0, (%rbx)
	testq	%rdi, %rdi
	je	.LBB28_38
# %bb.37:
	callq	_ZdlPv@PLT
.LBB28_38:
	movq	$0, 8(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB28_13:
	.cfi_def_cfa_offset 32
	andq	%r14, %r15
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB28_14:                              # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdx
	movq	$0, (%rdx,%rcx,8)
	movq	(%rbx), %rdx
	movq	$0, 8(%rdx,%rcx,8)
	movq	(%rbx), %rdx
	movq	$0, 16(%rdx,%rcx,8)
	movq	(%rbx), %rdx
	movq	$0, 24(%rdx,%rcx,8)
	addq	$4, %rcx
	cmpq	%rcx, %r15
	jne	.LBB28_14
.LBB28_6:
	testq	%rax, %rax
	je	.LBB28_8
	.p2align	4, 0x90
.LBB28_7:                               # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdx
	movq	$0, (%rdx,%rcx,8)
	incq	%rcx
	decq	%rax
	jne	.LBB28_7
.LBB28_8:
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	je	.LBB28_39
# %bb.9:
	leaq	16(%rbx), %rdi
	movq	8(%rsi), %rcx
	movq	%r14, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rdx      # imm = 0x5555555555555555
	andq	%rax, %rdx
	movq	%r14, %rax
	subq	%rdx, %rax
	movabsq	$3689348814741910323, %rdx      # imm = 0x3333333333333333
	movq	%rax, %r8
	andq	%rdx, %r8
	shrq	$2, %rax
	andq	%rdx, %rax
	addq	%r8, %rax
	movq	%rax, %rdx
	shrq	$4, %rdx
	addq	%rax, %rdx
	movabsq	$1085102592571150095, %rax      # imm = 0xF0F0F0F0F0F0F0F
	andq	%rdx, %rax
	movabsq	$72340172838076673, %r8         # imm = 0x101010101010101
	imulq	%rax, %r8
	shrq	$56, %r8
	cmpq	$2, %r8
	jae	.LBB28_10
# %bb.21:
	leaq	-1(%r14), %rax
	andq	%rax, %rcx
	movq	(%rbx), %rax
	movq	%rdi, (%rax,%rcx,8)
	movq	(%rsi), %rdi
	testq	%rdi, %rdi
	jne	.LBB28_22
.LBB28_39:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB28_10:
	.cfi_def_cfa_offset 32
	cmpq	%r14, %rcx
	jb	.LBB28_16
# %bb.11:
	movq	%rcx, %rax
	orq	%r14, %rax
	shrq	$32, %rax
	je	.LBB28_12
# %bb.15:
	movq	%rcx, %rax
	xorl	%edx, %edx
	divq	%r14
	movq	%rdx, %rcx
	jmp	.LBB28_16
.LBB28_12:
	movl	%ecx, %eax
	xorl	%edx, %edx
	divl	%r14d
	movl	%edx, %ecx
.LBB28_16:
	movq	(%rbx), %rax
	movq	%rdi, (%rax,%rcx,8)
	movq	(%rsi), %rdi
	testq	%rdi, %rdi
	je	.LBB28_39
# %bb.17:
	cmpl	$2, %r8d
	jae	.LBB28_18
.LBB28_22:
	decq	%r14
	jmp	.LBB28_23
	.p2align	4, 0x90
.LBB28_24:                              #   in Loop: Header=BB28_23 Depth=1
	movq	%rdi, %rsi
.LBB28_28:                              #   in Loop: Header=BB28_23 Depth=1
	movq	(%rsi), %rdi
	testq	%rdi, %rdi
	je	.LBB28_39
.LBB28_23:                              # =>This Inner Loop Header: Depth=1
	movq	8(%rdi), %rax
	andq	%r14, %rax
	cmpq	%rcx, %rax
	je	.LBB28_24
# %bb.25:                               #   in Loop: Header=BB28_23 Depth=1
	movq	(%rbx), %rdx
	cmpq	$0, (%rdx,%rax,8)
	je	.LBB28_27
# %bb.26:                               #   in Loop: Header=BB28_23 Depth=1
	movq	(%rdi), %rdx
	movq	%rdx, (%rsi)
	movq	(%rbx), %rdx
	movq	(%rdx,%rax,8), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rdi)
	movq	(%rbx), %rdx
	movq	(%rdx,%rax,8), %rax
	movq	%rdi, (%rax)
	jmp	.LBB28_28
.LBB28_27:                              #   in Loop: Header=BB28_23 Depth=1
	movq	%rsi, (%rdx,%rax,8)
	movq	%rdi, %rsi
	movq	%rax, %rcx
	jmp	.LBB28_28
	.p2align	4, 0x90
.LBB28_33:                              #   in Loop: Header=BB28_18 Depth=1
	movq	(%rdi), %rdx
	movq	%rdx, (%rsi)
	movq	(%rbx), %rdx
	movq	(%rdx,%rax,8), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rdi)
	movq	(%rbx), %rdx
	movq	(%rdx,%rax,8), %rax
	movq	%rdi, (%rax)
	movq	%rsi, %rdi
.LBB28_34:                              #   in Loop: Header=BB28_18 Depth=1
	movq	%rcx, %rax
.LBB28_35:                              #   in Loop: Header=BB28_18 Depth=1
	movq	%rdi, %rsi
	movq	(%rdi), %rdi
	movq	%rax, %rcx
	testq	%rdi, %rdi
	je	.LBB28_39
.LBB28_18:                              # =>This Inner Loop Header: Depth=1
	movq	8(%rdi), %rax
	cmpq	%r14, %rax
	jb	.LBB28_30
# %bb.19:                               #   in Loop: Header=BB28_18 Depth=1
	movq	%rax, %rdx
	orq	%r14, %rdx
	shrq	$32, %rdx
	je	.LBB28_20
# %bb.29:                               #   in Loop: Header=BB28_18 Depth=1
	xorl	%edx, %edx
	divq	%r14
	movq	%rdx, %rax
.LBB28_30:                              #   in Loop: Header=BB28_18 Depth=1
	cmpq	%rcx, %rax
	je	.LBB28_34
.LBB28_31:                              #   in Loop: Header=BB28_18 Depth=1
	movq	(%rbx), %rdx
	cmpq	$0, (%rdx,%rax,8)
	jne	.LBB28_33
# %bb.32:                               #   in Loop: Header=BB28_18 Depth=1
	movq	%rsi, (%rdx,%rax,8)
	jmp	.LBB28_35
.LBB28_20:                              #   in Loop: Header=BB28_18 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%r14d
	movl	%edx, %eax
	cmpq	%rcx, %rax
	je	.LBB28_34
	jmp	.LBB28_31
.LBB28_40:
	callq	_ZSt28__throw_bad_array_new_lengthB8ne180100v
.Lfunc_end28:
	.size	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm, .Lfunc_end28-_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_
.LCPI29_0:
	.long	0x5f000000                      # float 9.22337203E+18
	.section	.text._ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_,"axG",@progbits,_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_,comdat
	.weak	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_
	.p2align	4, 0x90
	.type	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_,@function
_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_: # @_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_
.Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception4
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
	movq	%rdx, %r12
	movq	%rdi, %rbx
	movq	(%rsi), %r14
	movq	8(%rdi), %rbp
	testq	%rbp, %rbp
	je	.LBB29_3
# %bb.1:
	movq	%rbp, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rcx      # imm = 0x5555555555555555
	andq	%rax, %rcx
	movq	%rbp, %rax
	subq	%rcx, %rax
	movabsq	$3689348814741910323, %rcx      # imm = 0x3333333333333333
	movq	%rax, %rdx
	andq	%rcx, %rdx
	shrq	$2, %rax
	andq	%rcx, %rax
	addq	%rdx, %rax
	movq	%rax, %rcx
	shrq	$4, %rcx
	addq	%rax, %rcx
	movabsq	$1085102592571150095, %rax      # imm = 0xF0F0F0F0F0F0F0F
	andq	%rcx, %rax
	movabsq	$72340172838076673, %rcx        # imm = 0x101010101010101
	imulq	%rax, %rcx
	shrq	$56, %rcx
	cmpq	$1, %rcx
	ja	.LBB29_4
# %bb.2:
	leaq	-1(%rbp), %r13
	andq	%r14, %r13
	movq	(%rbx), %rax
	movq	(%rax,%r13,8), %rax
	testq	%rax, %rax
	jne	.LBB29_8
	jmp	.LBB29_25
.LBB29_3:
                                        # implicit-def: $r13
	jmp	.LBB29_25
.LBB29_4:
	movq	%r14, %r13
	cmpq	%rbp, %r14
	jb	.LBB29_7
# %bb.5:
	movq	%r14, %rax
	orq	%rbp, %rax
	shrq	$32, %rax
	je	.LBB29_24
# %bb.6:
	movq	%r14, %rax
	xorl	%edx, %edx
	divq	%rbp
	movq	%rdx, %r13
.LBB29_7:
	movq	(%rbx), %rax
	movq	(%rax,%r13,8), %rax
	testq	%rax, %rax
	je	.LBB29_25
.LBB29_8:
	movq	(%rax), %r15
	testq	%r15, %r15
	je	.LBB29_25
# %bb.9:
	cmpl	$2, %ecx
	jae	.LBB29_19
# %bb.10:
	leaq	-1(%rbp), %rax
	jmp	.LBB29_13
	.p2align	4, 0x90
.LBB29_11:                              #   in Loop: Header=BB29_13 Depth=1
	andq	%rax, %rcx
	cmpq	%r13, %rcx
	jne	.LBB29_25
.LBB29_12:                              #   in Loop: Header=BB29_13 Depth=1
	movq	(%r15), %r15
	testq	%r15, %r15
	je	.LBB29_25
.LBB29_13:                              # =>This Inner Loop Header: Depth=1
	movq	8(%r15), %rcx
	cmpq	%r14, %rcx
	jne	.LBB29_11
# %bb.14:                               #   in Loop: Header=BB29_13 Depth=1
	cmpq	%r14, 16(%r15)
	jne	.LBB29_12
.LBB29_15:
	xorl	%edx, %edx
	jmp	.LBB29_70
.LBB29_16:                              #   in Loop: Header=BB29_19 Depth=1
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%ebp
	movl	%edx, %eax
	.p2align	4, 0x90
.LBB29_17:                              #   in Loop: Header=BB29_19 Depth=1
	cmpq	%r13, %rax
	jne	.LBB29_25
.LBB29_18:                              #   in Loop: Header=BB29_19 Depth=1
	movq	(%r15), %r15
	testq	%r15, %r15
	je	.LBB29_25
.LBB29_19:                              # =>This Inner Loop Header: Depth=1
	movq	8(%r15), %rax
	cmpq	%r14, %rax
	jne	.LBB29_21
# %bb.20:                               #   in Loop: Header=BB29_19 Depth=1
	cmpq	%r14, 16(%r15)
	jne	.LBB29_18
	jmp	.LBB29_15
	.p2align	4, 0x90
.LBB29_21:                              #   in Loop: Header=BB29_19 Depth=1
	cmpq	%rbp, %rax
	jb	.LBB29_17
# %bb.22:                               #   in Loop: Header=BB29_19 Depth=1
	movq	%rax, %rcx
	orq	%rbp, %rcx
	shrq	$32, %rcx
	je	.LBB29_16
# %bb.23:                               #   in Loop: Header=BB29_19 Depth=1
	xorl	%edx, %edx
	divq	%rbp
	movq	%rdx, %rax
	jmp	.LBB29_17
.LBB29_24:
	movl	%r14d, %eax
	xorl	%edx, %edx
	divl	%ebp
	movl	%edx, %r13d
	movq	(%rbx), %rax
	movq	(%rax,%r13,8), %rax
	testq	%rax, %rax
	jne	.LBB29_8
.LBB29_25:
	movl	$24, %edi
	callq	_Znwm@PLT
	movq	%rax, %r15
	movq	$0, (%rax)
	movq	%r14, 8(%rax)
	movq	(%r12), %rax
	movq	%rax, 16(%r15)
	movq	24(%rbx), %rax
	incq	%rax
	js	.LBB29_27
# %bb.26:
	cvtsi2ss	%rax, %xmm0
	jmp	.LBB29_28
.LBB29_27:
	movq	%rax, %rcx
	shrq	%rcx
	andl	$1, %eax
	orq	%rcx, %rax
	cvtsi2ss	%rax, %xmm0
	addss	%xmm0, %xmm0
.LBB29_28:
	movq	%rbp, %rcx
	shrq	%rcx
	movl	%ebp, %eax
	andl	$1, %eax
	orq	%rcx, %rax
	testq	%rbp, %rbp
	js	.LBB29_30
# %bb.29:
	cvtsi2ss	%rbp, %xmm2
	movss	32(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	jne	.LBB29_31
	jmp	.LBB29_33
.LBB29_30:
	cvtsi2ss	%rax, %xmm2
	addss	%xmm2, %xmm2
	movss	32(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	je	.LBB29_33
.LBB29_31:
	mulss	%xmm1, %xmm2
	ucomiss	%xmm2, %xmm0
	ja	.LBB29_33
# %bb.32:
	movq	%r13, %r14
	movq	(%rbx), %rcx
	movq	(%rcx,%r14,8), %rax
	testq	%rax, %rax
	jne	.LBB29_57
.LBB29_59:
	leaq	16(%rbx), %rax
	movq	16(%rbx), %rdx
	movq	%rdx, (%r15)
	movq	%r15, 16(%rbx)
	movq	%rax, (%rcx,%r14,8)
	movq	(%r15), %rax
	testq	%rax, %rax
	je	.LBB29_69
# %bb.60:
	movq	8(%rax), %rax
	leaq	-1(%rbp), %rcx
	testq	%rcx, %rbp
	jne	.LBB29_62
# %bb.61:
	andq	%rcx, %rax
	jmp	.LBB29_67
.LBB29_33:
	leaq	(,%rbp,2), %rax
	movl	$1, %r12d
	cmpq	$3, %rbp
	jb	.LBB29_35
# %bb.34:
	leaq	-1(%rbp), %rcx
	xorl	%r12d, %r12d
	testq	%rcx, %rbp
	setne	%r12b
.LBB29_35:
	orq	%rax, %r12
	divss	%xmm1, %xmm0
	callq	ceilf@PLT
	cvttss2si	%xmm0, %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	subss	.LCPI29_0(%rip), %xmm0
	cvttss2si	%xmm0, %rdi
	andq	%rcx, %rdi
	orq	%rax, %rdi
	cmpq	%rdi, %r12
	cmovaq	%r12, %rdi
	movl	$2, %r12d
	cmpq	$1, %rdi
	je	.LBB29_38
# %bb.36:
	leaq	-1(%rdi), %rax
	testq	%rax, %rdi
	jne	.LBB29_40
# %bb.37:
	movq	%rdi, %r12
.LBB29_38:
	cmpq	%rbp, %r12
	jbe	.LBB29_42
.LBB29_39:
.Ltmp219:
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE11__do_rehashILb1EEEvm
.Ltmp220:
	jmp	.LBB29_51
.LBB29_40:
.Ltmp215:
	callq	_ZNSt3__112__next_primeEm@PLT
.Ltmp216:
# %bb.41:
	movq	%rax, %r12
	movq	8(%rbx), %rbp
	cmpq	%rbp, %r12
	ja	.LBB29_39
.LBB29_42:
	jae	.LBB29_51
# %bb.43:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	js	.LBB29_45
# %bb.44:
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rax, %xmm0
	jmp	.LBB29_46
.LBB29_62:
	cmpq	%rbp, %rax
	jb	.LBB29_67
# %bb.63:
	movq	%rax, %rcx
	orq	%rbp, %rcx
	shrq	$32, %rcx
	je	.LBB29_66
# %bb.64:
	xorl	%edx, %edx
	divq	%rbp
	movq	%rdx, %rax
	jmp	.LBB29_67
.LBB29_45:
	movq	%rax, %rcx
	shrq	%rcx
	andl	$1, %eax
	orq	%rcx, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ss	%rax, %xmm0
	addss	%xmm0, %xmm0
.LBB29_46:
	divss	32(%rbx), %xmm0
	callq	ceilf@PLT
	cvttss2si	%xmm0, %rax
	movq	%rax, %rcx
	subss	.LCPI29_0(%rip), %xmm0
	cvttss2si	%xmm0, %rdi
	sarq	$63, %rcx
	andq	%rcx, %rdi
	orq	%rax, %rdi
	cmpq	$3, %rbp
	jb	.LBB29_49
# %bb.47:
	movq	%rbp, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rcx      # imm = 0x5555555555555555
	andq	%rax, %rcx
	movq	%rbp, %rax
	subq	%rcx, %rax
	movabsq	$3689348814741910323, %rcx      # imm = 0x3333333333333333
	movq	%rax, %rdx
	shrq	$2, %rdx
	andq	%rcx, %rax
	andq	%rcx, %rdx
	addq	%rax, %rdx
	movq	%rdx, %rax
	shrq	$4, %rax
	addq	%rdx, %rax
	movabsq	$1085102592571150095, %rcx      # imm = 0xF0F0F0F0F0F0F0F
	andq	%rax, %rcx
	movabsq	$72340172838076673, %rax        # imm = 0x101010101010101
	imulq	%rcx, %rax
	shrq	$56, %rax
	cmpl	$1, %eax
	ja	.LBB29_49
# %bb.48:
	leaq	-1(%rdi), %rax
	bsrq	%rax, %rcx
	xorl	$63, %ecx
	negb	%cl
	movl	$1, %eax
                                        # kill: def $cl killed $cl killed $rcx
	shlq	%cl, %rax
	cmpq	$2, %rdi
	cmovbq	%rdi, %rax
	jmp	.LBB29_50
.LBB29_49:
.Ltmp217:
	callq	_ZNSt3__112__next_primeEm@PLT
.Ltmp218:
.LBB29_50:
	cmpq	%rax, %r12
	cmovbeq	%rax, %r12
	cmpq	%rbp, %r12
	jb	.LBB29_39
.LBB29_51:
	movq	8(%rbx), %rbp
	leaq	-1(%rbp), %rax
	testq	%rax, %rbp
	jne	.LBB29_53
# %bb.52:
	andq	%rax, %r14
	movq	(%rbx), %rcx
	movq	(%rcx,%r14,8), %rax
	testq	%rax, %rax
	jne	.LBB29_57
	jmp	.LBB29_59
.LBB29_53:
	cmpq	%rbp, %r14
	jb	.LBB29_56
# %bb.54:
	movq	%r14, %rax
	orq	%rbp, %rax
	shrq	$32, %rax
	je	.LBB29_58
# %bb.55:
	movq	%r14, %rax
	xorl	%edx, %edx
	divq	%rbp
	movq	%rdx, %r14
.LBB29_56:
	movq	(%rbx), %rcx
	movq	(%rcx,%r14,8), %rax
	testq	%rax, %rax
	je	.LBB29_59
.LBB29_57:
	movq	(%rax), %rcx
	movq	%rcx, (%r15)
	jmp	.LBB29_68
.LBB29_58:
	movl	%r14d, %eax
	xorl	%edx, %edx
	divl	%ebp
	movl	%edx, %r14d
	movq	(%rbx), %rcx
	movq	(%rcx,%r14,8), %rax
	testq	%rax, %rax
	jne	.LBB29_57
	jmp	.LBB29_59
.LBB29_66:
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%ebp
	movl	%edx, %eax
.LBB29_67:
	shlq	$3, %rax
	addq	(%rbx), %rax
.LBB29_68:
	movq	%r15, (%rax)
.LBB29_69:
	incq	24(%rbx)
	movb	$1, %dl
.LBB29_70:
	movq	%r15, %rax
                                        # kill: def $dl killed $dl killed $edx
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
.LBB29_71:
	.cfi_def_cfa_offset 64
.Ltmp221:
	movq	%rax, %rbx
	movq	%r15, %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end29:
	.size	_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_, .Lfunc_end29-_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_,"aG",@progbits,_ZNSt3__112__hash_tableImNS_4hashImEENS_8equal_toImEENS_9allocatorImEEE25__emplace_unique_key_argsImJRKmEEENS_4pairINS_15__hash_iteratorIPNS_11__hash_nodeImPvEEEEbEERKT_DpOT0_,comdat
	.p2align	2, 0x0
GCC_except_table29:
.Lexception4:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end4-.Lcst_begin4
.Lcst_begin4:
	.uleb128 .Lfunc_begin4-.Lfunc_begin4    # >> Call Site 1 <<
	.uleb128 .Ltmp219-.Lfunc_begin4         #   Call between .Lfunc_begin4 and .Ltmp219
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp219-.Lfunc_begin4         # >> Call Site 2 <<
	.uleb128 .Ltmp216-.Ltmp219              #   Call between .Ltmp219 and .Ltmp216
	.uleb128 .Ltmp221-.Lfunc_begin4         #     jumps to .Ltmp221
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp216-.Lfunc_begin4         # >> Call Site 3 <<
	.uleb128 .Ltmp217-.Ltmp216              #   Call between .Ltmp216 and .Ltmp217
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp217-.Lfunc_begin4         # >> Call Site 4 <<
	.uleb128 .Ltmp218-.Ltmp217              #   Call between .Ltmp217 and .Ltmp218
	.uleb128 .Ltmp221-.Lfunc_begin4         #     jumps to .Ltmp221
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp218-.Lfunc_begin4         # >> Call Site 5 <<
	.uleb128 .Lfunc_end29-.Ltmp218          #   Call between .Ltmp218 and .Lfunc_end29
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end4:
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
	.section	.text._ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl,"axG",@progbits,_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl,comdat
	.weak	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl # -- Begin function _ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
	.p2align	4, 0x90
	.type	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl,@function
_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl: # @_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	testq	%r9, %r9
	je	.LBB34_75
# %bb.1:
	movq	%rdx, %r13
	movq	136(%rsp), %r14
	movq	128(%rsp), %r12
.LBB34_2:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB34_6 Depth 2
                                        #     Child Loop BB34_47 Depth 2
                                        #     Child Loop BB34_40 Depth 2
                                        #     Child Loop BB34_61 Depth 2
                                        #     Child Loop BB34_66 Depth 2
                                        #       Child Loop BB34_67 Depth 3
                                        #     Child Loop BB34_58 Depth 2
	cmpq	%r14, %r9
	jle	.LBB34_8
# %bb.3:                                #   in Loop: Header=BB34_2 Depth=1
	cmpq	%r14, %r8
	jle	.LBB34_8
# %bb.4:                                #   in Loop: Header=BB34_2 Depth=1
	testq	%r8, %r8
	je	.LBB34_75
# %bb.5:                                #   in Loop: Header=BB34_2 Depth=1
	movq	(%rsi), %rcx
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB34_6:                               #   Parent Loop BB34_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rdi,%rbx,8), %rdx
	cmpq	%rdx, %rcx
	jb	.LBB34_36
# %bb.7:                                #   in Loop: Header=BB34_6 Depth=2
	incq	%rbx
	addq	$-8, %rax
	cmpq	%rbx, %r8
	jne	.LBB34_6
	jmp	.LBB34_75
	.p2align	4, 0x90
.LBB34_36:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r8, %r10
	subq	%rbx, %r10
	movq	%rdi, %r15
	subq	%rax, %r15
	cmpq	%r9, %r10
	movq	%r12, 56(%rsp)                  # 8-byte Spill
	movq	%r13, 48(%rsp)                  # 8-byte Spill
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	movq	%r15, 40(%rsp)                  # 8-byte Spill
	jge	.LBB34_43
# %bb.37:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%r9, %r10
	shrq	$63, %r10
	addq	%r9, %r10
	sarq	%r10
	leaq	(%rsi,%r10,8), %r14
	cmpq	%rsi, %r15
	je	.LBB34_38
# %bb.39:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%r10, %rbp
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	subq	%rax, %rdi
	addq	%rax, %rcx
	sarq	$3, %rcx
	movq	(%r14), %rax
	movq	%r15, %r13
	.p2align	4, 0x90
.LBB34_40:                              #   Parent Loop BB34_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r13, %rdx
	movq	%rcx, %r10
	shrq	%r10
	movq	%r10, %r11
	notq	%r11
	addq	%rcx, %r11
	cmpq	(%r13,%r10,8), %rax
	leaq	8(%r13,%r10,8), %r13
	cmovbq	%rdx, %r13
	cmovbq	%r10, %r11
	movq	%r11, %rcx
	testq	%r11, %r11
	jne	.LBB34_40
# %bb.41:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%rbp, %r10
	jmp	.LBB34_42
	.p2align	4, 0x90
.LBB34_43:                              #   in Loop: Header=BB34_2 Depth=1
	leaq	-1(%r8), %r11
	cmpq	%rbx, %r11
	je	.LBB34_44
# %bb.45:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%r10, %r12
	shrq	$63, %r12
	addq	%r10, %r12
	sarq	%r12
	movq	%r13, %r14
	leaq	(%rdi,%r12,8), %r13
	movq	%r14, %rdx
	subq	%rsi, %rdx
	je	.LBB34_48
# %bb.46:                               #   in Loop: Header=BB34_2 Depth=1
	sarq	$3, %rdx
	movq	(%r13,%rbx,8), %rcx
	movq	%rsi, %r14
	.p2align	4, 0x90
.LBB34_47:                              #   Parent Loop BB34_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdx, %rdi
	shrq	%rdi
	movq	%rdi, %r10
	notq	%r10
	addq	%rdx, %r10
	cmpq	%rcx, (%r14,%rdi,8)
	leaq	8(%r14,%rdi,8), %rdx
	cmovaeq	%rdi, %r10
	cmovbq	%rdx, %r14
	movq	%r10, %rdx
	testq	%r10, %r10
	jne	.LBB34_47
.LBB34_48:                              #   in Loop: Header=BB34_2 Depth=1
	subq	%rax, %r13
	movq	%r14, %r10
	subq	%rsi, %r10
	sarq	$3, %r10
	movq	%r14, %rcx
	cmpq	%rsi, %r13
	jne	.LBB34_50
	jmp	.LBB34_71
.LBB34_38:                              #   in Loop: Header=BB34_2 Depth=1
	subq	%rax, %rdi
	movq	%rsi, %r13
.LBB34_42:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r13, %r12
	subq	%rdi, %r12
	sarq	$3, %r12
	movq	%r14, %rcx
	cmpq	%rsi, %r13
	je	.LBB34_71
.LBB34_50:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r13, %rcx
	cmpq	%r14, %rsi
	je	.LBB34_71
# %bb.51:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%r10, 8(%rsp)                   # 8-byte Spill
	leaq	8(%r13), %r10
	cmpq	%rsi, %r10
	je	.LBB34_52
# %bb.53:                               #   in Loop: Header=BB34_2 Depth=1
	leaq	8(%rsi), %r11
	cmpq	%r14, %r11
	je	.LBB34_54
# %bb.57:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%rsi, %rcx
	subq	%r13, %rcx
	movq	%rcx, %rdi
	sarq	$3, %rdi
	movq	%r14, %rdx
	subq	%rsi, %rdx
	movq	%rdx, %rbp
	sarq	$3, %rdx
	movq	%rdi, %rax
	cmpq	%rdx, %rdi
	jne	.LBB34_61
	.p2align	4, 0x90
.LBB34_58:                              #   Parent Loop BB34_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%r10), %rax
	movq	-8(%r11), %rcx
	movq	%rcx, -8(%r10)
	movq	%rax, -8(%r11)
	cmpq	%rsi, %r10
	je	.LBB34_59
# %bb.60:                               #   in Loop: Header=BB34_58 Depth=2
	addq	$8, %r10
	leaq	8(%r11), %rax
	cmpq	%r14, %r11
	movq	%rax, %r11
	jne	.LBB34_58
.LBB34_59:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%rsi, %rcx
	jmp	.LBB34_70
	.p2align	4, 0x90
.LBB34_63:                              #   in Loop: Header=BB34_61 Depth=2
	cqto
	idivq	%rsi
	movq	%rsi, %rax
	testq	%rdx, %rdx
	je	.LBB34_65
.LBB34_61:                              #   Parent Loop BB34_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdx, %rsi
	movq	%rax, %rdx
	orq	%rsi, %rdx
	shrq	$32, %rdx
	jne	.LBB34_63
# %bb.62:                               #   in Loop: Header=BB34_61 Depth=2
                                        # kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%esi
                                        # kill: def $edx killed $edx def $rdx
	movq	%rsi, %rax
	testq	%rdx, %rdx
	jne	.LBB34_61
.LBB34_65:                              #   in Loop: Header=BB34_2 Depth=1
	leaq	(,%rsi,8), %rax
	addq	%r13, %rax
	.p2align	4, 0x90
.LBB34_66:                              #   Parent Loop BB34_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB34_67 Depth 3
	movq	-8(%rax), %rdx
	leaq	(%rax,%rcx), %r10
	addq	$-8, %r10
	addq	$-8, %rax
	movq	%rax, %r11
	.p2align	4, 0x90
.LBB34_67:                              #   Parent Loop BB34_2 Depth=1
                                        #     Parent Loop BB34_66 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%r10, %rsi
	movq	(%r10), %r10
	movq	%r10, (%r11)
	movq	%r14, %r10
	subq	%rsi, %r10
	sarq	$3, %r10
	movq	%rdi, %r11
	subq	%r10, %r11
	leaq	(%rsi,%rdi,8), %r15
	leaq	(%r13,%r11,8), %r10
	cmovlq	%r15, %r10
	movq	%rsi, %r11
	cmpq	%rax, %r10
	jne	.LBB34_67
# %bb.68:                               #   in Loop: Header=BB34_66 Depth=2
	movq	%rdx, (%rsi)
	cmpq	%r13, %rax
	jne	.LBB34_66
# %bb.69:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%rbp, %rcx
	addq	%r13, %rcx
	jmp	.LBB34_70
.LBB34_52:                              #   in Loop: Header=BB34_2 Depth=1
	movq	(%r13), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r14, %r15
	subq	%rsi, %r15
	movq	%r13, %rdi
	movq	%r15, %rdx
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	movq	%r8, %rbp
	callq	memmove@PLT
	movq	%rbp, %r8
	movq	24(%rsp), %r9                   # 8-byte Reload
	leaq	(%r15,%r13), %rcx
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, (%r13,%r15)
	jmp	.LBB34_70
.LBB34_54:                              #   in Loop: Header=BB34_2 Depth=1
	leaq	-8(%r14), %rdx
	movq	%rdx, %rax
	subq	%r13, %rax
	movq	%r14, %rcx
	subq	%rax, %rcx
	movq	-8(%r14), %r15
	subq	%r13, %rdx
	je	.LBB34_56
# %bb.55:                               #   in Loop: Header=BB34_2 Depth=1
	movq	%rcx, %rdi
	movq	%r13, %rsi
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	movq	%r8, %rbp
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	callq	memmove@PLT
	movq	16(%rsp), %rcx                  # 8-byte Reload
	movq	%rbp, %r8
	movq	24(%rsp), %r9                   # 8-byte Reload
.LBB34_56:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r15, (%r13)
.LBB34_70:                              #   in Loop: Header=BB34_2 Depth=1
	movq	8(%rsp), %r10                   # 8-byte Reload
.LBB34_71:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r8, %r15
	subq	%r12, %r15
	subq	%rbx, %r15
	movq	%r9, %rbp
	subq	%r10, %rbp
	leaq	(%r12,%r10), %rax
	addq	%r8, %r9
	subq	%rax, %r9
	subq	%rbx, %r9
	cmpq	%r9, %rax
	jge	.LBB34_73
# %bb.72:                               #   in Loop: Header=BB34_2 Depth=1
	movq	40(%rsp), %rdi                  # 8-byte Reload
	movq	%r13, %rsi
	movq	%rcx, %rdx
	movq	%rcx, %rbx
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movq	%r12, %r8
	movq	%r10, %r9
	pushq	32(%rsp)                        # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	movq	64(%rsp), %r12                  # 8-byte Reload
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	callq	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movq	%rbx, %rdi
	movq	48(%rsp), %r13                  # 8-byte Reload
	jmp	.LBB34_74
	.p2align	4, 0x90
.LBB34_73:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%rcx, %rdi
	movq	%r14, %rsi
	movq	48(%rsp), %rdx                  # 8-byte Reload
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movq	%r15, %r8
	movq	%rbp, %r9
	pushq	32(%rsp)                        # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	movq	64(%rsp), %rbx                  # 8-byte Reload
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	movq	%r10, %rbp
	callq	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movq	%r13, %r14
	movq	%r12, %r15
	movq	%rbx, %r12
	movq	16(%rsp), %r13                  # 8-byte Reload
	movq	40(%rsp), %rdi                  # 8-byte Reload
.LBB34_74:                              #   in Loop: Header=BB34_2 Depth=1
	movq	%r15, %r8
	movq	%rbp, %r9
	movq	%r14, %rsi
	testq	%rbp, %rbp
	movq	32(%rsp), %r14                  # 8-byte Reload
	jne	.LBB34_2
	jmp	.LBB34_75
.LBB34_8:
	cmpq	%r9, %r8
	jle	.LBB34_9
# %bb.18:
	cmpq	%r13, %rsi
	je	.LBB34_75
# %bb.19:
	movq	%r13, %rdx
	subq	%rsi, %rdx
	addq	$-8, %rdx
	movq	%r12, %rax
	movq	%rsi, %rcx
	cmpq	$56, %rdx
	jb	.LBB34_35
# %bb.20:
	movq	%r12, %r8
	subq	%rsi, %r8
	movq	%r12, %rax
	movq	%rsi, %rcx
	cmpq	$32, %r8
	jb	.LBB34_35
# %bb.21:
	shrq	$3, %rdx
	incq	%rdx
	movq	%rdx, %r8
	andq	$-4, %r8
	leaq	(%r12,%r8,8), %rax
	leaq	(%rsi,%r8,8), %rcx
	xorl	%r9d, %r9d
.LBB34_22:                              # =>This Inner Loop Header: Depth=1
	movups	(%rsi,%r9,8), %xmm0
	movups	16(%rsi,%r9,8), %xmm1
	movups	%xmm0, (%r12,%r9,8)
	movups	%xmm1, 16(%r12,%r9,8)
	addq	$4, %r9
	cmpq	%r9, %r8
	jne	.LBB34_22
# %bb.23:
	cmpq	%r8, %rdx
	je	.LBB34_24
	.p2align	4, 0x90
.LBB34_35:                              # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rdx
	movq	%rdx, (%rax)
	addq	$8, %rcx
	addq	$8, %rax
	cmpq	%r13, %rcx
	jne	.LBB34_35
.LBB34_24:
	xorl	%edx, %edx
	movq	%r13, %rcx
.LBB34_25:                              # =>This Inner Loop Header: Depth=1
	cmpq	%rdi, %rsi
	je	.LBB34_26
# %bb.34:                               #   in Loop: Header=BB34_25 Depth=1
	leaq	-8(%rsi), %r8
	leaq	-8(%rax), %r9
	movq	-8(%rax), %r10
	movq	-8(%rsi), %r11
	cmpq	%r11, %r10
	cmovaq	%r10, %r11
	cmovbq	%r8, %rsi
	cmovaeq	%r9, %rax
	movq	%r11, -8(%rcx)
	addq	$-8, %rcx
	incq	%rdx
	cmpq	%r12, %rax
	jne	.LBB34_25
	jmp	.LBB34_75
.LBB34_9:
	cmpq	%rsi, %rdi
	je	.LBB34_75
# %bb.10:
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	addq	$-8, %rcx
	movq	%r12, %rdx
	movq	%rdi, %rax
	cmpq	$56, %rcx
	jb	.LBB34_15
# %bb.11:
	movq	%r12, %r8
	subq	%rdi, %r8
	movq	%r12, %rdx
	movq	%rdi, %rax
	cmpq	$32, %r8
	jb	.LBB34_15
# %bb.12:
	shrq	$3, %rcx
	incq	%rcx
	movq	%rcx, %r8
	andq	$-4, %r8
	leaq	(%r12,%r8,8), %rdx
	leaq	(%rdi,%r8,8), %rax
	xorl	%r9d, %r9d
.LBB34_13:                              # =>This Inner Loop Header: Depth=1
	movups	(%rdi,%r9,8), %xmm0
	movups	16(%rdi,%r9,8), %xmm1
	movups	%xmm0, (%r12,%r9,8)
	movups	%xmm1, 16(%r12,%r9,8)
	addq	$4, %r9
	cmpq	%r9, %r8
	jne	.LBB34_13
# %bb.14:
	cmpq	%r8, %rcx
	je	.LBB34_16
	.p2align	4, 0x90
.LBB34_15:                              # =>This Inner Loop Header: Depth=1
	movq	(%rax), %rcx
	movq	%rcx, (%rdx)
	addq	$8, %rax
	addq	$8, %rdx
	cmpq	%rsi, %rax
	jne	.LBB34_15
.LBB34_16:                              # =>This Inner Loop Header: Depth=1
	cmpq	%r13, %rsi
	je	.LBB34_76
# %bb.17:                               #   in Loop: Header=BB34_16 Depth=1
	movq	(%rsi), %rax
	movq	(%r12), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	cmpq	%rcx, %rax
	setae	%r8b
	setb	%r9b
	cmovbq	%rax, %rcx
	leaq	(%rsi,%r9,8), %rsi
	leaq	(%r12,%r8,8), %r12
	movq	%rcx, (%rdi)
	addq	$8, %rdi
	cmpq	%rdx, %r12
	jne	.LBB34_16
	jmp	.LBB34_75
.LBB34_44:
	movq	%rcx, (%rdi,%rbx,8)
	movq	%rdx, (%rsi)
	jmp	.LBB34_75
.LBB34_26:
	movq	%rax, %rdi
	subq	%r12, %rdi
	addq	$-8, %rdi
	cmpq	$152, %rdi
	jb	.LBB34_27
# %bb.28:
	shlq	$3, %rdx
	subq	%r13, %rdx
	addq	%rax, %rdx
	cmpq	$32, %rdx
	jae	.LBB34_29
.LBB34_27:
	movq	%rcx, %rdx
	movq	%rax, %rsi
.LBB34_32:
	addq	$-8, %rdx
.LBB34_33:                              # =>This Inner Loop Header: Depth=1
	movq	-8(%rsi), %rax
	addq	$-8, %rsi
	movq	%rax, (%rdx)
	addq	$-8, %rdx
	cmpq	%r12, %rsi
	jne	.LBB34_33
.LBB34_75:
	addq	$72, %rsp
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
.LBB34_76:
	.cfi_def_cfa_offset 128
	subq	%r12, %rdx
	movq	%r12, %rsi
	addq	$72, %rsp
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
.LBB34_29:
	.cfi_def_cfa_offset 128
	shrq	$3, %rdi
	incq	%rdi
	movq	%rdi, %r8
	andq	$-4, %r8
	leaq	(,%r8,8), %r9
	movq	%rcx, %rdx
	subq	%r9, %rdx
	movq	%rax, %rsi
	subq	%r9, %rsi
	movq	%r8, %r9
	negq	%r9
	xorl	%r10d, %r10d
.LBB34_30:                              # =>This Inner Loop Header: Depth=1
	movups	-32(%rax,%r10,8), %xmm0
	movups	-16(%rax,%r10,8), %xmm1
	movups	%xmm1, -16(%rcx,%r10,8)
	movups	%xmm0, -32(%rcx,%r10,8)
	addq	$-4, %r10
	cmpq	%r10, %r9
	jne	.LBB34_30
# %bb.31:
	cmpq	%r8, %rdi
	jne	.LBB34_32
	jmp	.LBB34_75
.Lfunc_end34:
	.size	_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl, .Lfunc_end34-_ZNSt3__115__inplace_mergeINS_17_ClassicAlgPolicyERNS_6__lessIvvEENS_11__wrap_iterIPmEEEEvT1_S8_S8_OT0_NS_15iterator_traitsIS8_E15difference_typeESD_PNSC_10value_typeEl
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
	.asciz	"vector"
	.size	.L.str.23, 7

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"basic_string"
	.size	.L.str.26, 13

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
	.quad	_ZN4absl12lts_2026081718container_internal20AllocateBackingArrayILm8ENSt3__19allocatorIcEEEEPvS6_m
	.quad	_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ENSt3__19allocatorIcEEEEvPvmPNS1_6ctrl_tEmmbm
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
	.addrsig_sym _ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ENSt3__19allocatorIcEEEEvPvmPNS1_6ctrl_tEmmbm
	.addrsig_sym _ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.addrsig_sym _ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.addrsig_sym _ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.addrsig_sym _ZN4absl12lts_2026081718container_internal20AllocateBackingArrayILm8ENSt3__19allocatorIcEEEEPvS6_m
	.addrsig_sym _ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.addrsig_sym _ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.addrsig_sym _Unwind_Resume
	.addrsig_sym _ZTISt12length_error
	.addrsig_sym _ZTISt20bad_array_new_length
	.addrsig_sym _ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.addrsig_sym _ZN4absl12lts_2026081718container_internal11kSooControlE
	.addrsig_sym _ZSt7nothrow
