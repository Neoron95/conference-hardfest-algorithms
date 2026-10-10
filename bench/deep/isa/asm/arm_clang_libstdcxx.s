	.text
	.file	"isa_bench.cpp"
                                        // Start of file scope inline assembly
	.globl	_ZSt21ios_base_library_initv

                                        // End of file scope inline assembly
	.globl	phase_sort                      // -- Begin function phase_sort
	.p2align	2
	.type	phase_sort,@function
phase_sort:                             // @phase_sort
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	ldp	x19, x20, [x0]
	cmp	x19, x20
	b.eq	.LBB0_2
// %bb.1:
	sub	x8, x20, x19
	asr	x8, x8, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
	mov	x0, x19
	mov	x1, x20
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	mov	x0, x19
	mov	x1, x20
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	b	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.LBB0_2:
	.cfi_restore_state
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end0:
	.size	phase_sort, .Lfunc_end0-phase_sort
	.cfi_endproc
                                        // -- End function
	.globl	phase_unique                    // -- Begin function phase_unique
	.p2align	2
	.type	phase_unique,@function
phase_unique:                           // @phase_unique
	.cfi_startproc
// %bb.0:
	ldp	x9, x8, [x0]
	cmp	x9, x8
	b.eq	.LBB1_11
// %bb.1:
	add	x9, x9, #8
.LBB1_2:                                // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB1_11
// %bb.3:                               //   in Loop: Header=BB1_2 Depth=1
	ldp	x10, x11, [x9, #-8]
	add	x9, x9, #8
	cmp	x10, x11
	b.ne	.LBB1_2
// %bb.4:
	sub	x11, x9, #16
	b	.LBB1_6
.LBB1_5:                                //   in Loop: Header=BB1_6 Depth=1
	add	x9, x9, #8
.LBB1_6:                                // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB1_9
// %bb.7:                               //   in Loop: Header=BB1_6 Depth=1
	mov	x12, x10
	ldr	x10, [x9]
	cmp	x12, x10
	b.eq	.LBB1_5
// %bb.8:                               //   in Loop: Header=BB1_6 Depth=1
	str	x10, [x11, #8]!
	b	.LBB1_5
.LBB1_9:
	add	x9, x11, #8
	cmp	x9, x8
	b.eq	.LBB1_11
// %bb.10:
	str	x9, [x0, #8]
.LBB1_11:
	ret
.Lfunc_end1:
	.size	phase_unique, .Lfunc_end1-phase_unique
	.cfi_endproc
                                        // -- End function
	.globl	phase_uset_insert               // -- Begin function phase_uset_insert
	.p2align	2
	.type	phase_uset_insert,@function
phase_uset_insert:                      // @phase_uset_insert
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	str	x21, [sp, #32]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x20, x1
	mov	x21, x0
	mov	w0, #56                         // =0x38
	bl	_Znwm
	mov	x19, x0
	mov	x8, x0
	str	xzr, [x8, #48]!
	mov	w9, #1                          // =0x1
	stp	x8, x9, [x0]
	stp	xzr, xzr, [x0, #16]
	mov	w8, #1065353216                 // =0x3f800000
	str	w8, [x0, #32]
	str	xzr, [x0, #40]
	ucvtf	d0, x20
	fcvtzu	x1, d0
	bl	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	ldp	x20, x21, [x21]
	cmp	x20, x21
	b.eq	.LBB2_2
.LBB2_1:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x20], #8
	str	x8, [sp, #8]
	str	x19, [x29, #24]
	add	x1, sp, #8
	add	x2, sp, #8
	add	x3, x29, #24
	mov	x0, x19
	bl	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	cmp	x20, x21
	b.ne	.LBB2_1
.LBB2_2:
	mov	x0, x19
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldr	x21, [sp, #32]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #64
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end2:
	.size	phase_uset_insert, .Lfunc_end2-phase_uset_insert
	.cfi_endproc
                                        // -- End function
	.globl	phase_uset_assign               // -- Begin function phase_uset_assign
	.p2align	2
	.type	phase_uset_assign,@function
phase_uset_assign:                      // @phase_uset_assign
	.cfi_startproc
// %bb.0:
	ldr	x1, [x1, #16]
	mov	x2, #0                          // =0x0
	b	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
.Lfunc_end3:
	.size	phase_uset_assign, .Lfunc_end3-phase_uset_assign
	.cfi_endproc
                                        // -- End function
	.globl	phase_uset_dtor                 // -- Begin function phase_uset_dtor
	.p2align	2
	.type	phase_uset_dtor,@function
phase_uset_dtor:                        // @phase_uset_dtor
	.cfi_startproc
// %bb.0:
	cbz	x0, .LBB4_6
// %bb.1:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x19, x0
	mov	x20, x0
	ldr	x0, [x20, #16]!
	cbz	x0, .LBB4_3
.LBB4_2:                                // =>This Inner Loop Header: Depth=1
	ldr	x21, [x0]
	bl	_ZdlPv
	mov	x0, x21
	cbnz	x21, .LBB4_2
.LBB4_3:
	ldp	x0, x8, [x19]
	lsl	x2, x8, #3
	mov	w1, #0                          // =0x0
	bl	memset
	stp	xzr, xzr, [x20]
	ldr	x0, [x19]
	add	x8, x19, #48
	cmp	x8, x0
	b.eq	.LBB4_5
// %bb.4:
	bl	_ZdlPv
.LBB4_5:
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	b	_ZdlPv
.LBB4_6:
	ret
.Lfunc_end4:
	.size	phase_uset_dtor, .Lfunc_end4-phase_uset_dtor
	.cfi_endproc
                                        // -- End function
	.globl	phase_flat_insert               // -- Begin function phase_flat_insert
	.p2align	2
	.type	phase_flat_insert,@function
phase_flat_insert:                      // @phase_flat_insert
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	str	d8, [sp, #16]                   // 8-byte Folded Spill
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	.cfi_offset b8, -112
	mov	x21, x1
	mov	x20, x0
	mov	w0, #16                         // =0x10
	bl	_Znwm
	mov	x19, x0
	mov	w8, #1                          // =0x1
	str	x8, [x0]
	cmp	x21, #2
	b.lo	.LBB5_2
// %bb.1:
	adrp	x1, _ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	add	x1, x1, :lo12:_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	mov	x0, x19
	mov	x2, x21
	bl	_ZN4absl12lts_2026081718container_internal24ReserveTableToFitNewSizeERNS1_12CommonFieldsERKNS1_15PolicyFunctionsEm
.LBB5_2:
	ldp	x22, x23, [x20]
	cmp	x22, x23
	b.eq	.LBB5_18
// %bb.3:
	add	x24, x19, #8
	adrp	x20, _ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	add	x20, x20, :lo12:_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	mov	w25, #32832                     // =0x8040
	sub	x26, x29, #8
	mov	x27, #-1                        // =0xffffffffffffffff
	mov	x28, #36085                     // =0x8cf5
	movk	x28, #56862, lsl #16
	movk	x28, #63968, lsl #32
	movk	x28, #31189, lsl #48
	movi	v8.8b, #128
	adrp	x21, _ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	add	x21, x21, :lo12:_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	b	.LBB5_10
.LBB5_4:                                //   Parent Loop BB5_10 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB5_5 Depth 3
	and	x4, x12, x10
	add	x12, x11, x4, lsl #3
	prfm	pldl1keep, [x12]
	ldr	d1, [x9, x4]
	cmeq	v2.8b, v1.8b, v0.8b
	fmov	x12, d2
	cbz	x12, .LBB5_7
.LBB5_5:                                //   Parent Loop BB5_10 Depth=1
                                        //     Parent Loop BB5_4 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	rbit	x13, x12
	clz	x13, x13
	add	x13, x4, x13, lsr #3
	and	x13, x13, x10
	ldr	x13, [x11, x13, lsl #3]
	cmp	x13, x8
	b.eq	.LBB5_17
// %bb.6:                               //   in Loop: Header=BB5_5 Depth=3
	and	x12, x12, #0x8080808080808080
	sub	x13, x12, #1
	ands	x12, x13, x12
	b.ne	.LBB5_5
.LBB5_7:                                //   in Loop: Header=BB5_4 Depth=2
	cmeq	v1.8b, v1.8b, v8.8b
	fmov	x3, d1
	cbnz	x3, .LBB5_9
// %bb.8:                               //   in Loop: Header=BB5_4 Depth=2
	add	x5, x5, #8
	add	x12, x5, x4
	b	.LBB5_4
.LBB5_9:                                //   in Loop: Header=BB5_10 Depth=1
	mov	x0, x19
	mov	x1, x21
	bl	_ZN4absl12lts_2026081718container_internal18PrepareInsertLargeERNS1_12CommonFieldsERKNS1_15PolicyFunctionsEmNS1_18NonIterableBitMaskImLi8ELi3EEENS1_8FindInfoE
	b	.LBB5_16
.LBB5_10:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB5_4 Depth 2
                                        //       Child Loop BB5_5 Depth 3
	ldr	x8, [x22]
	stur	x8, [x29, #-8]
	ldr	x11, [x19]
	tst	x11, #0x3e
	b.eq	.LBB5_12
// %bb.11:                              //   in Loop: Header=BB5_10 Depth=1
	mov	x5, #0                          // =0x0
	ldr	x9, [x24]
	lsl	x12, x27, x11
	prfm	pldl3keep, [x9]
	mvn	x10, x12
	and	x11, x11, #0x7c0
	eor	x11, x11, x8
	mul	x13, x11, x28
	umulh	x11, x11, x28
	eor	x2, x11, x13
	lsr	x13, x2, #57
	sub	x11, x9, x12
	add	x11, x11, #7
	dup	v0.8b, w13
	mov	x12, x2
	b	.LBB5_4
.LBB5_12:                               //   in Loop: Header=BB5_10 Depth=1
	lsr	x9, x11, #15
	cbnz	x9, .LBB5_14
// %bb.13:                              //   in Loop: Header=BB5_10 Depth=1
	orr	x8, x11, x25
	str	x8, [x19]
	mov	x0, x24
	b	.LBB5_16
.LBB5_14:                               //   in Loop: Header=BB5_10 Depth=1
	ldr	x9, [x24]
	cmp	x9, x8
	b.eq	.LBB5_17
// %bb.15:                              //   in Loop: Header=BB5_10 Depth=1
	stp	x19, x26, [sp]
	mov	x2, sp
	mov	x0, x19
	mov	x1, x21
	mov	x3, x20
	mov	w4, #0                          // =0x0
	bl	_ZN4absl12lts_2026081718container_internal42GrowSooTableToNextCapacityAndPrepareInsertILm8ELb1EEEPvRNS1_12CommonFieldsERKNS1_15PolicyFunctionsENS0_11FunctionRefIFmmEEEb
.LBB5_16:                               //   in Loop: Header=BB5_10 Depth=1
	ldur	x8, [x29, #-8]
	str	x8, [x0]
.LBB5_17:                               //   in Loop: Header=BB5_10 Depth=1
	add	x22, x22, #8
	cmp	x22, x23
	b.ne	.LBB5_10
.LBB5_18:
	mov	x0, x19
	.cfi_def_cfa wsp, 128
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	ldr	d8, [sp, #16]                   // 8-byte Folded Reload
	add	sp, sp, #128
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	ret
.Lfunc_end5:
	.size	phase_flat_insert, .Lfunc_end5-phase_flat_insert
	.cfi_endproc
                                        // -- End function
	.globl	phase_flat_assign               // -- Begin function phase_flat_assign
	.p2align	2
	.type	phase_flat_assign,@function
phase_flat_assign:                      // @phase_flat_assign
	.cfi_startproc
// %bb.0:
	ldr	x8, [x1]
	cmp	x8, #8, lsl #12                 // =32768
	b.lo	.LBB6_6
// %bb.1:
	add	x2, x1, #8
	tst	x8, #0x3e
	b.eq	.LBB6_5
// %bb.2:
	ldr	x1, [x2]
	and	x9, x8, #0x3f
	mov	x10, #-1                        // =0xffffffffffffffff
	lsl	x8, x10, x8
	mov	w10, #7                         // =0x7
	sub	x8, x10, x8
	cmp	x9, #1
	csel	x8, xzr, x8, eq
	add	x2, x1, x8
	ldrsb	w8, [x1]
	cmn	w8, #2
	b.gt	.LBB6_4
.LBB6_3:                                // =>This Inner Loop Header: Depth=1
	ldrsb	w8, [x1, #1]!
	add	x2, x2, #8
	cmn	w8, #1
	b.lt	.LBB6_3
.LBB6_4:
	mov	x4, #0                          // =0x0
	b	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
.LBB6_5:
	adrp	x1, :got:_ZN4absl12lts_2026081718container_internal11kSooControlE
	ldr	x1, [x1, :got_lo12:_ZN4absl12lts_2026081718container_internal11kSooControlE]
	mov	x4, #0                          // =0x0
	b	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
.LBB6_6:
	mov	x2, #0                          // =0x0
                                        // implicit-def: $x1
	mov	x4, #0                          // =0x0
	b	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
.Lfunc_end6:
	.size	phase_flat_assign, .Lfunc_end6-phase_flat_assign
	.cfi_endproc
                                        // -- End function
	.globl	phase_flat_dtor                 // -- Begin function phase_flat_dtor
	.p2align	2
	.type	phase_flat_dtor,@function
phase_flat_dtor:                        // @phase_flat_dtor
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception0
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	str	x19, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	cbz	x0, .LBB7_4
// %bb.1:
	ldrb	w8, [x0]
	tst	w8, #0x3e
	b.eq	.LBB7_3
// %bb.2:
.Ltmp0:
	adrp	x4, :got:_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm
	ldr	x4, [x4, :got_lo12:_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm]
	mov	x19, x0
	mov	w1, #8                          // =0x8
	mov	w2, #8                          // =0x8
	mov	x3, #0                          // =0x0
	mov	x5, x0
	bl	_ZN4absl12lts_2026081718container_internal11DestructSooERNS1_12CommonFieldsEmmPFvPvS4_EPFvS4_mPNS1_6ctrl_tEmmbmES4_
	mov	x0, x19
.Ltmp1:
.LBB7_3:
	.cfi_def_cfa wsp, 32
	ldr	x19, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w30
	.cfi_restore w29
	b	_ZdlPv
.LBB7_4:
	.cfi_restore_state
	.cfi_remember_state
	.cfi_def_cfa wsp, 32
	ldr	x19, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB7_5:
	.cfi_restore_state
.Ltmp2:
	bl	__clang_call_terminate
.Lfunc_end7:
	.size	phase_flat_dtor, .Lfunc_end7-phase_flat_dtor
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table7:
.Lexception0:
	.byte	255                             // @LPStart Encoding = omit
	.byte	156                             // @TType Encoding = indirect pcrel sdata8
	.uleb128 .Lttbase0-.Lttbaseref0
.Lttbaseref0:
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Ltmp0-.Lfunc_begin0           // >> Call Site 1 <<
	.uleb128 .Ltmp1-.Ltmp0                  //   Call between .Ltmp0 and .Ltmp1
	.uleb128 .Ltmp2-.Lfunc_begin0           //     jumps to .Ltmp2
	.byte	1                               //   On action: 1
.Lcst_end0:
	.byte	1                               // >> Action Record 1 <<
                                        //   Catch TypeInfo 1
	.byte	0                               //   No further actions
	.p2align	2, 0x0
                                        // >> Catch TypeInfos <<
	.xword	0                               // TypeInfo 1
.Lttbase0:
	.p2align	2, 0x0
                                        // -- End function
	.text
	.globl	phase_radix_count               // -- Begin function phase_radix_count
	.p2align	2
	.type	phase_radix_count,@function
phase_radix_count:                      // @phase_radix_count
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	mov	x19, x1
	mov	x20, x0
	mov	x0, x1
	mov	w1, #0                          // =0x0
	mov	w2, #8192                       // =0x2000
	bl	memset
	ldp	x8, x9, [x20]
	cmp	x8, x9
	b.eq	.LBB8_2
.LBB8_1:                                // =>This Inner Loop Header: Depth=1
	ldr	x10, [x8], #8
	and	x11, x10, #0xff
	lsl	x11, x11, #2
	ldr	w12, [x19, x11]
	add	w12, w12, #1
	str	w12, [x19, x11]
	lsr	x11, x10, #8
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #1024]
	add	w12, w12, #1
	str	w12, [x11, #1024]
	lsr	x11, x10, #16
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #2048]
	add	w12, w12, #1
	str	w12, [x11, #2048]
	lsr	x11, x10, #24
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #3072]
	add	w12, w12, #1
	str	w12, [x11, #3072]
	lsr	x11, x10, #32
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #4096]
	add	w12, w12, #1
	str	w12, [x11, #4096]
	lsr	x11, x10, #40
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #5120]
	add	w12, w12, #1
	str	w12, [x11, #5120]
	lsr	x11, x10, #48
	add	x11, x19, w11, uxtb #2
	ldr	w12, [x11, #6144]
	add	w12, w12, #1
	str	w12, [x11, #6144]
	lsr	x10, x10, #56
	add	x10, x19, x10, lsl #2
	ldr	w11, [x10, #7168]
	add	w11, w11, #1
	str	w11, [x10, #7168]
	cmp	x8, x9
	b.ne	.LBB8_1
.LBB8_2:
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end8:
	.size	phase_radix_count, .Lfunc_end8-phase_radix_count
	.cfi_endproc
                                        // -- End function
	.globl	phase_radix_scatter             // -- Begin function phase_radix_scatter
	.p2align	2
	.type	phase_radix_scatter,@function
phase_radix_scatter:                    // @phase_radix_scatter
	.cfi_startproc
// %bb.0:
	str	x29, [sp, #-16]!                // 8-byte Folded Spill
	.cfi_def_cfa_offset 16
	.cfi_offset w29, -16
	sub	sp, sp, #2048
	.cfi_def_cfa_offset 2064
	.cfi_remember_state
	mov	x8, x2
	ldp	x0, x9, [x0]
	subs	x2, x9, x0
	asr	x9, x2, #3
	b.eq	.LBB9_37
// %bb.1:
	cmp	x9, #1
	csinc	x10, x9, xzr, hi
	ldr	x11, [x0]
	and	x12, x11, #0xff
	ldr	w12, [x8, x12, lsl #2]
	cmp	x9, x12
	b.ne	.LBB9_57
// %bb.2:
	mov	x12, x0
	lsr	x13, x11, #8
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #1024]
	cmp	x9, x13
	b.eq	.LBB9_62
.LBB9_3:
	mov	x11, #0                         // =0x0
	mov	x13, #0                         // =0x0
	add	x14, x8, #1024
	mov	x15, sp
.LBB9_4:                                // =>This Inner Loop Header: Depth=1
	str	x13, [x15, x11, lsl #3]
	ldr	w16, [x14, x11, lsl #2]
	add	x13, x13, x16
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_4
// %bb.5:
	mov	x11, #0                         // =0x0
	mov	x13, sp
.LBB9_6:                                // =>This Inner Loop Header: Depth=1
	ldr	x14, [x12, x11, lsl #3]
	ubfx	x15, x14, #8, #8
	lsl	x15, x15, #3
	ldr	x16, [x13, x15]
	add	x17, x16, #1
	str	x17, [x13, x15]
	str	x14, [x1, x16, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_6
// %bb.7:
	ldr	x11, [x1]
	mov	x14, x1
	lsr	x13, x11, #16
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #2048]
	cmp	x9, x13
	b.eq	.LBB9_63
.LBB9_8:
	mov	x11, #0                         // =0x0
	mov	x13, #0                         // =0x0
	add	x15, x8, #2048
	mov	x16, sp
.LBB9_9:                                // =>This Inner Loop Header: Depth=1
	str	x13, [x16, x11, lsl #3]
	ldr	w17, [x15, x11, lsl #2]
	add	x13, x13, x17
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_9
// %bb.10:
	mov	x11, #0                         // =0x0
	mov	x13, sp
.LBB9_11:                               // =>This Inner Loop Header: Depth=1
	ldr	x15, [x14, x11, lsl #3]
	ubfx	x16, x15, #16, #8
	lsl	x16, x16, #3
	ldr	x17, [x13, x16]
	add	x18, x17, #1
	str	x18, [x13, x16]
	str	x15, [x12, x17, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_11
// %bb.12:
	ldr	x11, [x12]
	mov	x15, x12
	lsr	x12, x11, #24
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #3072]
	cmp	x9, x12
	b.eq	.LBB9_64
.LBB9_13:
	mov	x11, #0                         // =0x0
	mov	x12, #0                         // =0x0
	add	x13, x8, #3072
	mov	x16, sp
.LBB9_14:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x16, x11, lsl #3]
	ldr	w17, [x13, x11, lsl #2]
	add	x12, x12, x17
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_14
// %bb.15:
	mov	x11, #0                         // =0x0
	mov	x12, sp
.LBB9_16:                               // =>This Inner Loop Header: Depth=1
	ldr	x13, [x15, x11, lsl #3]
	ubfx	x16, x13, #24, #8
	lsl	x16, x16, #3
	ldr	x17, [x12, x16]
	add	x18, x17, #1
	str	x18, [x12, x16]
	str	x13, [x14, x17, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_16
// %bb.17:
	ldr	x11, [x14]
	mov	x13, x14
	lsr	x12, x11, #32
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #4096]
	cmp	x9, x12
	b.eq	.LBB9_65
.LBB9_18:
	mov	x11, #0                         // =0x0
	mov	x12, #0                         // =0x0
	add	x14, x8, #1, lsl #12            // =4096
	mov	x16, sp
.LBB9_19:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x16, x11, lsl #3]
	ldr	w17, [x14, x11, lsl #2]
	add	x12, x12, x17
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_19
// %bb.20:
	mov	x11, #0                         // =0x0
	mov	x12, sp
.LBB9_21:                               // =>This Inner Loop Header: Depth=1
	ldr	x14, [x13, x11, lsl #3]
	ubfx	x16, x14, #32, #8
	lsl	x16, x16, #3
	ldr	x17, [x12, x16]
	add	x18, x17, #1
	str	x18, [x12, x16]
	str	x14, [x15, x17, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_21
// %bb.22:
	ldr	x11, [x15]
	mov	x12, x15
	lsr	x14, x11, #40
	add	x14, x8, w14, uxtb #2
	ldr	w14, [x14, #5120]
	cmp	x9, x14
	b.eq	.LBB9_66
.LBB9_23:
	mov	x11, #0                         // =0x0
	mov	x14, #0                         // =0x0
	mov	w15, #5120                      // =0x1400
	add	x15, x8, x15
	mov	x16, sp
.LBB9_24:                               // =>This Inner Loop Header: Depth=1
	str	x14, [x16, x11, lsl #3]
	ldr	w17, [x15, x11, lsl #2]
	add	x14, x14, x17
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_24
// %bb.25:
	mov	x11, #0                         // =0x0
	mov	x14, sp
.LBB9_26:                               // =>This Inner Loop Header: Depth=1
	ldr	x15, [x12, x11, lsl #3]
	ubfx	x16, x15, #40, #8
	lsl	x16, x16, #3
	ldr	x17, [x14, x16]
	add	x18, x17, #1
	str	x18, [x14, x16]
	str	x15, [x13, x17, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_26
// %bb.27:
	ldr	x11, [x13]
	mov	x1, x13
	lsr	x13, x11, #48
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #6144]
	cmp	x9, x13
	b.eq	.LBB9_67
.LBB9_28:
	mov	x11, #0                         // =0x0
	mov	x13, #0                         // =0x0
	mov	w14, #6144                      // =0x1800
	add	x14, x8, x14
	mov	x15, sp
.LBB9_29:                               // =>This Inner Loop Header: Depth=1
	str	x13, [x15, x11, lsl #3]
	ldr	w16, [x14, x11, lsl #2]
	add	x13, x13, x16
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_29
// %bb.30:
	mov	x11, #0                         // =0x0
	mov	x13, sp
.LBB9_31:                               // =>This Inner Loop Header: Depth=1
	ldr	x14, [x1, x11, lsl #3]
	ubfx	x15, x14, #48, #8
	lsl	x15, x15, #3
	ldr	x16, [x13, x15]
	add	x17, x16, #1
	str	x17, [x13, x15]
	str	x14, [x12, x16, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_31
// %bb.32:
	ldr	x11, [x12]
	mov	x13, x12
	lsr	x11, x11, #56
	add	x11, x8, x11, lsl #2
	ldr	w11, [x11, #7168]
	cmp	x9, x11
	b.eq	.LBB9_68
.LBB9_33:
	mov	x9, #0                          // =0x0
	mov	x11, #0                         // =0x0
	mov	w12, #7168                      // =0x1c00
	add	x8, x8, x12
	mov	x12, sp
.LBB9_34:                               // =>This Inner Loop Header: Depth=1
	str	x11, [x12, x9, lsl #3]
	ldr	w14, [x8, x9, lsl #2]
	add	x11, x11, x14
	add	x9, x9, #1
	cmp	x9, #256
	b.ne	.LBB9_34
// %bb.35:
	mov	x8, sp
.LBB9_36:                               // =>This Inner Loop Header: Depth=1
	ldr	x9, [x13], #8
	lsr	x11, x9, #53
	and	x11, x11, #0x7f8
	ldr	x12, [x8, x11]
	add	x14, x12, #1
	str	x14, [x8, x11]
	str	x9, [x1, x12, lsl #3]
	subs	x10, x10, #1
	b.ne	.LBB9_36
	b	.LBB9_81
.LBB9_37:
	ldr	x10, [x0]
	and	x11, x10, #0xff
	ldr	w11, [x8, x11, lsl #2]
	cmp	x9, x11
	b.ne	.LBB9_69
// %bb.38:
	mov	x11, x0
	lsr	x12, x10, #8
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #1024]
	cmp	x9, x12
	b.eq	.LBB9_72
.LBB9_39:
	mov	x10, #0                         // =0x0
	mov	x12, #0                         // =0x0
	add	x13, x8, #1024
	mov	x14, sp
.LBB9_40:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x14, x10, lsl #3]
	ldr	w15, [x13, x10, lsl #2]
	add	x12, x12, x15
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_40
// %bb.41:
	ldr	x10, [x1]
	mov	x13, x1
	lsr	x12, x10, #16
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #2048]
	cmp	x9, x12
	b.eq	.LBB9_73
.LBB9_42:
	mov	x10, #0                         // =0x0
	mov	x12, #0                         // =0x0
	add	x14, x8, #2048
	mov	x15, sp
.LBB9_43:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x15, x10, lsl #3]
	ldr	w16, [x14, x10, lsl #2]
	add	x12, x12, x16
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_43
// %bb.44:
	ldr	x10, [x11]
	mov	x14, x11
	lsr	x11, x10, #24
	add	x11, x8, w11, uxtb #2
	ldr	w11, [x11, #3072]
	cmp	x9, x11
	b.eq	.LBB9_74
.LBB9_45:
	mov	x10, #0                         // =0x0
	mov	x11, #0                         // =0x0
	add	x12, x8, #3072
	mov	x15, sp
.LBB9_46:                               // =>This Inner Loop Header: Depth=1
	str	x11, [x15, x10, lsl #3]
	ldr	w16, [x12, x10, lsl #2]
	add	x11, x11, x16
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_46
// %bb.47:
	ldr	x10, [x13]
	mov	x12, x13
	lsr	x11, x10, #32
	add	x11, x8, w11, uxtb #2
	ldr	w11, [x11, #4096]
	cmp	x9, x11
	b.eq	.LBB9_75
.LBB9_48:
	mov	x10, #0                         // =0x0
	mov	x11, #0                         // =0x0
	add	x13, x8, #1, lsl #12            // =4096
	mov	x15, sp
.LBB9_49:                               // =>This Inner Loop Header: Depth=1
	str	x11, [x15, x10, lsl #3]
	ldr	w16, [x13, x10, lsl #2]
	add	x11, x11, x16
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_49
// %bb.50:
	ldr	x10, [x14]
	mov	x11, x14
	lsr	x13, x10, #40
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #5120]
	cmp	x9, x13
	b.eq	.LBB9_76
.LBB9_51:
	mov	x10, #0                         // =0x0
	mov	x13, #0                         // =0x0
	mov	w14, #5120                      // =0x1400
	add	x14, x8, x14
	mov	x15, sp
.LBB9_52:                               // =>This Inner Loop Header: Depth=1
	str	x13, [x15, x10, lsl #3]
	ldr	w16, [x14, x10, lsl #2]
	add	x13, x13, x16
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_52
// %bb.53:
	ldr	x10, [x12]
	mov	x3, x12
	lsr	x12, x10, #48
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #6144]
	cmp	x9, x12
	b.eq	.LBB9_77
.LBB9_54:
	mov	x10, #0                         // =0x0
	mov	x12, #0                         // =0x0
	mov	w13, #6144                      // =0x1800
	add	x13, x8, x13
	mov	x14, sp
.LBB9_55:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x14, x10, lsl #3]
	ldr	w15, [x13, x10, lsl #2]
	add	x12, x12, x15
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_55
// %bb.56:
	ldr	x10, [x11]
	mov	x1, x11
	lsr	x10, x10, #56
	add	x10, x8, x10, lsl #2
	ldr	w10, [x10, #7168]
	cmp	x9, x10
	b.ne	.LBB9_78
	b	.LBB9_81
.LBB9_57:
	mov	x11, #0                         // =0x0
	mov	x12, #0                         // =0x0
	mov	x13, sp
.LBB9_58:                               // =>This Inner Loop Header: Depth=1
	str	x12, [x13, x11, lsl #3]
	ldr	w14, [x8, x11, lsl #2]
	add	x12, x12, x14
	add	x11, x11, #1
	cmp	x11, #256
	b.ne	.LBB9_58
// %bb.59:
	mov	x11, #0                         // =0x0
	mov	x12, sp
.LBB9_60:                               // =>This Inner Loop Header: Depth=1
	ldr	x13, [x0, x11, lsl #3]
	and	x14, x13, #0xff
	lsl	x14, x14, #3
	ldr	x15, [x12, x14]
	add	x16, x15, #1
	str	x16, [x12, x14]
	str	x13, [x1, x15, lsl #3]
	add	x11, x11, #1
	cmp	x10, x11
	b.ne	.LBB9_60
// %bb.61:
	ldr	x11, [x1]
	mov	x12, x1
	mov	x1, x0
	lsr	x13, x11, #8
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #1024]
	cmp	x9, x13
	b.ne	.LBB9_3
.LBB9_62:
	mov	x14, x12
	mov	x12, x1
	lsr	x13, x11, #16
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #2048]
	cmp	x9, x13
	b.ne	.LBB9_8
.LBB9_63:
	mov	x15, x14
	mov	x14, x12
	lsr	x12, x11, #24
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #3072]
	cmp	x9, x12
	b.ne	.LBB9_13
.LBB9_64:
	mov	x13, x15
	mov	x15, x14
	lsr	x12, x11, #32
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #4096]
	cmp	x9, x12
	b.ne	.LBB9_18
.LBB9_65:
	mov	x12, x13
	mov	x13, x15
	lsr	x14, x11, #40
	add	x14, x8, w14, uxtb #2
	ldr	w14, [x14, #5120]
	cmp	x9, x14
	b.ne	.LBB9_23
.LBB9_66:
	mov	x1, x12
	mov	x12, x13
	lsr	x13, x11, #48
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #6144]
	cmp	x9, x13
	b.ne	.LBB9_28
.LBB9_67:
	mov	x13, x1
	mov	x1, x12
	lsr	x11, x11, #56
	add	x11, x8, x11, lsl #2
	ldr	w11, [x11, #7168]
	cmp	x9, x11
	b.ne	.LBB9_33
.LBB9_68:
	mov	x1, x13
	b	.LBB9_81
.LBB9_69:
	mov	x10, #0                         // =0x0
	mov	x11, #0                         // =0x0
	mov	x12, sp
.LBB9_70:                               // =>This Inner Loop Header: Depth=1
	str	x11, [x12, x10, lsl #3]
	ldr	w13, [x8, x10, lsl #2]
	add	x11, x11, x13
	add	x10, x10, #1
	cmp	x10, #256
	b.ne	.LBB9_70
// %bb.71:
	ldr	x10, [x1]
	mov	x11, x1
	mov	x1, x0
	lsr	x12, x10, #8
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #1024]
	cmp	x9, x12
	b.ne	.LBB9_39
.LBB9_72:
	mov	x13, x11
	mov	x11, x1
	lsr	x12, x10, #16
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #2048]
	cmp	x9, x12
	b.ne	.LBB9_42
.LBB9_73:
	mov	x14, x13
	mov	x13, x11
	lsr	x11, x10, #24
	add	x11, x8, w11, uxtb #2
	ldr	w11, [x11, #3072]
	cmp	x9, x11
	b.ne	.LBB9_45
.LBB9_74:
	mov	x12, x14
	mov	x14, x13
	lsr	x11, x10, #32
	add	x11, x8, w11, uxtb #2
	ldr	w11, [x11, #4096]
	cmp	x9, x11
	b.ne	.LBB9_48
.LBB9_75:
	mov	x11, x12
	mov	x12, x14
	lsr	x13, x10, #40
	add	x13, x8, w13, uxtb #2
	ldr	w13, [x13, #5120]
	cmp	x9, x13
	b.ne	.LBB9_51
.LBB9_76:
	mov	x3, x11
	mov	x11, x12
	lsr	x12, x10, #48
	add	x12, x8, w12, uxtb #2
	ldr	w12, [x12, #6144]
	cmp	x9, x12
	b.ne	.LBB9_54
.LBB9_77:
	mov	x1, x3
	mov	x3, x11
	lsr	x10, x10, #56
	add	x10, x8, x10, lsl #2
	ldr	w10, [x10, #7168]
	cmp	x9, x10
	b.eq	.LBB9_81
.LBB9_78:
	mov	x9, #0                          // =0x0
	mov	x10, #0                         // =0x0
	mov	w11, #7168                      // =0x1c00
	add	x8, x8, x11
	mov	x11, sp
.LBB9_79:                               // =>This Inner Loop Header: Depth=1
	str	x10, [x11, x9, lsl #3]
	ldr	w12, [x8, x9, lsl #2]
	add	x10, x10, x12
	add	x9, x9, #1
	cmp	x9, #256
	b.ne	.LBB9_79
// %bb.80:
	mov	x1, x3
.LBB9_81:
	add	sp, sp, #2048
	cmp	x1, x0
	b.eq	.LBB9_83
// %bb.82:
	.cfi_def_cfa_offset 16
	ldr	x29, [sp], #16                  // 8-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w29
	b	memcpy
.LBB9_83:
	.cfi_restore_state
	.cfi_def_cfa_offset 16
	ldr	x29, [sp], #16                  // 8-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w29
	ret
.Lfunc_end9:
	.size	phase_radix_scatter, .Lfunc_end9-phase_radix_scatter
	.cfi_endproc
                                        // -- End function
	.globl	phase_merge_sortdelta           // -- Begin function phase_merge_sortdelta
	.p2align	2
	.type	phase_merge_sortdelta,@function
phase_merge_sortdelta:                  // @phase_merge_sortdelta
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	ldp	x8, x21, [x0]
	add	x20, x8, x1, lsl #3
	cmp	x20, x21
	b.eq	.LBB10_12
// %bb.1:
	mov	x19, x0
	sub	x8, x21, x20
	asr	x8, x8, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
	mov	x0, x20
	mov	x1, x21
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	mov	x0, x20
	mov	x1, x21
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	ldr	x8, [x19, #8]
	cmp	x20, x8
	b.eq	.LBB10_12
// %bb.2:
	add	x9, x20, #8
.LBB10_3:                               // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB10_12
// %bb.4:                               //   in Loop: Header=BB10_3 Depth=1
	ldp	x10, x11, [x9, #-8]
	add	x9, x9, #8
	cmp	x10, x11
	b.ne	.LBB10_3
// %bb.5:
	sub	x11, x9, #16
	b	.LBB10_7
.LBB10_6:                               //   in Loop: Header=BB10_7 Depth=1
	add	x9, x9, #8
.LBB10_7:                               // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB10_10
// %bb.8:                               //   in Loop: Header=BB10_7 Depth=1
	mov	x12, x10
	ldr	x10, [x9]
	cmp	x12, x10
	b.eq	.LBB10_6
// %bb.9:                               //   in Loop: Header=BB10_7 Depth=1
	str	x10, [x11, #8]!
	b	.LBB10_6
.LBB10_10:
	add	x9, x11, #8
	cmp	x9, x8
	b.eq	.LBB10_12
// %bb.11:
	str	x9, [x19, #8]
.LBB10_12:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end10:
	.size	phase_merge_sortdelta, .Lfunc_end10-phase_merge_sortdelta
	.cfi_endproc
                                        // -- End function
	.globl	phase_merge_inplace             // -- Begin function phase_merge_inplace
	.p2align	2
	.type	phase_merge_inplace,@function
phase_merge_inplace:                    // @phase_merge_inplace
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	str	x19, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	mov	x19, x0
	ldr	x0, [x0]
	ldr	x2, [x19, #8]
	add	x1, x0, x1, lsl #3
	bl	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	ldp	x9, x8, [x19]
	cmp	x9, x8
	b.eq	.LBB11_11
// %bb.1:
	add	x9, x9, #8
.LBB11_2:                               // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB11_11
// %bb.3:                               //   in Loop: Header=BB11_2 Depth=1
	ldp	x10, x11, [x9, #-8]
	add	x9, x9, #8
	cmp	x10, x11
	b.ne	.LBB11_2
// %bb.4:
	sub	x11, x9, #16
	b	.LBB11_6
.LBB11_5:                               //   in Loop: Header=BB11_6 Depth=1
	add	x9, x9, #8
.LBB11_6:                               // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB11_9
// %bb.7:                               //   in Loop: Header=BB11_6 Depth=1
	mov	x12, x10
	ldr	x10, [x9]
	cmp	x12, x10
	b.eq	.LBB11_5
// %bb.8:                               //   in Loop: Header=BB11_6 Depth=1
	str	x10, [x11, #8]!
	b	.LBB11_5
.LBB11_9:
	add	x9, x11, #8
	cmp	x9, x8
	b.eq	.LBB11_11
// %bb.10:
	str	x9, [x19, #8]
.LBB11_11:
	.cfi_def_cfa wsp, 32
	ldr	x19, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end11:
	.size	phase_merge_inplace, .Lfunc_end11-phase_merge_inplace
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception1
// %bb.0:
	str	d10, [sp, #-128]!               // 8-byte Folded Spill
	.cfi_def_cfa_offset 128
	stp	d9, d8, [sp, #16]               // 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
	.cfi_offset b10, -128
	.cfi_remember_state
	sub	sp, sp, #2, lsl #12             // =8192
	sub	sp, sp, #496
	sub	x11, x29, #160
	mov	w10, #28531                     // =0x6f73
	movk	w10, #29810, lsl #16
	sub	x8, x29, #80
	add	x9, x8, #16
	stur	w10, [x29, #-64]
	mov	w8, #4                          // =0x4
	str	x9, [sp, #48]                   // 8-byte Folded Spill
	stp	x9, x8, [x29, #-80]
	strb	wzr, [x11, #100]
	cmp	w0, #1
	b.le	.LBB12_124
// %bb.1:
	mov	x24, x1
	mov	x25, x0
	str	wzr, [sp, #60]                  // 4-byte Folded Spill
	str	xzr, [sp, #240]                 // 8-byte Folded Spill
	str	xzr, [sp, #208]                 // 8-byte Folded Spill
	add	x8, sp, #320
	add	x28, x8, #16
	add	x8, sp, #256
	add	x21, x8, #16
	mov	w19, #1                         // =0x1
	mov	w8, #1048576                    // =0x100000
	str	x8, [sp, #192]                  // 8-byte Folded Spill
	mov	w8, #1048576                    // =0x100000
	stur	x8, [x29, #-24]                 // 8-byte Folded Spill
	mov	w8, #1                          // =0x1
	str	x8, [sp, #184]                  // 8-byte Folded Spill
                                        // kill: def $w19 killed $w19 killed $x19 def $x19
.LBB12_2:                               // =>This Inner Loop Header: Depth=1
	ldr	x27, [x24, w19, sxtw #3]
	str	x28, [sp, #320]
	cbz	x27, .LBB12_536
// %bb.3:                               //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x27
	bl	strlen
	mov	x23, x0
	mov	x26, x28
	cmp	x0, #16
	b.lo	.LBB12_8
// %bb.4:                               //   in Loop: Header=BB12_2 Depth=1
	tbnz	x23, #63, .LBB12_538
// %bb.5:                               //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x23, #1
	b.mi	.LBB12_489
// %bb.6:                               //   in Loop: Header=BB12_2 Depth=1
.Ltmp3:
	bl	_Znwm
.Ltmp4:
// %bb.7:                               //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #320]
	str	x23, [sp, #336]
.LBB12_8:                               //   in Loop: Header=BB12_2 Depth=1
	cbz	x23, .LBB12_11
// %bb.9:                               //   in Loop: Header=BB12_2 Depth=1
	cmp	x23, #1
	b.ne	.LBB12_25
// %bb.10:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x27]
	strb	w8, [x26]
.LBB12_11:                              //   in Loop: Header=BB12_2 Depth=1
	sxtw	x20, w19
	str	x23, [sp, #328]
	strb	wzr, [x26, x23]
	ldp	x23, x2, [sp, #320]
	cmp	x2, #6
	b.le	.LBB12_26
.LBB12_12:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #7
	b.eq	.LBB12_42
// %bb.13:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #8
	b.eq	.LBB12_63
// %bb.14:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #9
	b.ne	.LBB12_82
// %bb.15:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	adrp	x1, .L.str.4
	add	x1, x1, :lo12:.L.str.4
	bl	bcmp
	cbnz	w0, .LBB12_82
// %bb.16:                              //   in Loop: Header=BB12_2 Depth=1
	add	x19, x20, #1
	ldr	x23, [x24, x19, lsl #3]
	str	x21, [sp, #256]
	cbz	x23, .LBB12_542
// %bb.17:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	bl	strlen
	mov	x27, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_22
// %bb.18:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x27, #63, .LBB12_562
// %bb.19:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x27, #1
	b.mi	.LBB12_495
// %bb.20:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp36:
	bl	_Znwm
.Ltmp37:
// %bb.21:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x27, [sp, #272]
.LBB12_22:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x27, .LBB12_95
// %bb.23:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x27, #1
	b.ne	.LBB12_94
// %bb.24:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x23]
	strb	w8, [x26]
	b	.LBB12_95
.LBB12_25:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x27
	mov	x2, x23
	bl	memcpy
	sxtw	x20, w19
	str	x23, [sp, #328]
	strb	wzr, [x26, x23]
	ldp	x23, x2, [sp, #320]
	cmp	x2, #6
	b.gt	.LBB12_12
.LBB12_26:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #3
	b.eq	.LBB12_52
// %bb.27:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #5
	b.ne	.LBB12_82
// %bb.28:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	ldrb	w9, [x23, #4]
	mov	w10, #11565                     // =0x2d2d
	movk	w10, #27745, lsl #16
	cmp	w8, w10
	mov	w8, #103                        // =0x67
	ccmp	w9, w8, #0, eq
	b.ne	.LBB12_82
// %bb.29:                              //   in Loop: Header=BB12_2 Depth=1
	add	x19, x20, #1
	ldr	x23, [x24, x19, lsl #3]
	str	x21, [sp, #256]
	cbz	x23, .LBB12_544
// %bb.30:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	bl	strlen
	mov	x27, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_35
// %bb.31:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x27, #63, .LBB12_564
// %bb.32:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x27, #1
	b.mi	.LBB12_497
// %bb.33:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp81:
	bl	_Znwm
.Ltmp82:
// %bb.34:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x27, [sp, #272]
.LBB12_35:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x27, .LBB12_38
// %bb.36:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x27, #1
	b.ne	.LBB12_83
// %bb.37:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x23]
	strb	w8, [x26]
.LBB12_38:                              //   in Loop: Header=BB12_2 Depth=1
	str	x27, [sp, #264]
	strb	wzr, [x26, x27]
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.eq	.LBB12_84
.LBB12_39:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	x9, [sp, #256]
	cmp	x9, x21
	b.eq	.LBB12_87
// %bb.40:                              //   in Loop: Header=BB12_2 Depth=1
	ldur	x8, [x29, #-64]
	stur	x9, [x29, #-80]
	add	x9, sp, #9
	ldur	q0, [x9, #255]
	sub	x9, x29, #160
	stur	q0, [x9, #88]
	cbz	x0, .LBB12_86
// %bb.41:                              //   in Loop: Header=BB12_2 Depth=1
	str	x0, [sp, #256]
	str	x8, [sp, #272]
	b	.LBB12_123
.LBB12_42:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	adrp	x1, .L.str.5
	add	x1, x1, :lo12:.L.str.5
	bl	bcmp
	cbnz	w0, .LBB12_82
// %bb.43:                              //   in Loop: Header=BB12_2 Depth=1
	add	x19, x20, #1
	ldr	x23, [x24, x19, lsl #3]
	str	x21, [sp, #256]
	cbz	x23, .LBB12_546
// %bb.44:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	bl	strlen
	mov	x27, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_49
// %bb.45:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x27, #63, .LBB12_560
// %bb.46:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x27, #1
	b.mi	.LBB12_499
// %bb.47:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp21:
	bl	_Znwm
.Ltmp22:
// %bb.48:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x27, [sp, #272]
.LBB12_49:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x27, .LBB12_91
// %bb.50:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x27, #1
	b.ne	.LBB12_90
// %bb.51:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x23]
	strb	w8, [x26]
	b	.LBB12_91
.LBB12_52:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	adrp	x1, .L.str.2
	add	x1, x1, :lo12:.L.str.2
	bl	bcmp
	cbz	w0, .LBB12_73
// %bb.53:                              //   in Loop: Header=BB12_2 Depth=1
	ldrh	w8, [x23]
	ldrb	w9, [x23, #2]
	mov	w10, #11565                     // =0x2d2d
	cmp	w8, w10
	mov	w8, #117                        // =0x75
	ccmp	w9, w8, #0, eq
	b.ne	.LBB12_82
// %bb.54:                              //   in Loop: Header=BB12_2 Depth=1
	add	x19, x20, #1
	ldr	x20, [x24, x19, lsl #3]
	str	x21, [sp, #256]
	cbz	x20, .LBB12_556
// %bb.55:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x20
	bl	strlen
	mov	x23, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_60
// %bb.56:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x23, #63, .LBB12_580
// %bb.57:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x23, #1
	b.mi	.LBB12_505
// %bb.58:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp51:
	bl	_Znwm
.Ltmp52:
// %bb.59:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x23, [sp, #272]
.LBB12_60:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x23, .LBB12_103
// %bb.61:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x23, #1
	b.ne	.LBB12_102
// %bb.62:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x20]
	strb	w8, [x26]
	b	.LBB12_103
.LBB12_63:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x23
	adrp	x1, .L.str.6
	add	x1, x1, :lo12:.L.str.6
	bl	bcmp
	cbnz	w0, .LBB12_82
// %bb.64:                              //   in Loop: Header=BB12_2 Depth=1
	add	x19, x20, #1
	ldr	x22, [x24, x19, lsl #3]
	str	x21, [sp, #256]
	cbz	x22, .LBB12_548
// %bb.65:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x22
	bl	strlen
	mov	x23, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_70
// %bb.66:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x23, #63, .LBB12_566
// %bb.67:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x23, #1
	b.mi	.LBB12_501
// %bb.68:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp6:
	bl	_Znwm
.Ltmp7:
// %bb.69:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x23, [sp, #272]
.LBB12_70:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x23, .LBB12_99
// %bb.71:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x23, #1
	b.ne	.LBB12_98
// %bb.72:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x22]
	strb	w8, [x26]
	b	.LBB12_99
.LBB12_73:                              //   in Loop: Header=BB12_2 Depth=1
	add	x20, x20, #1
	ldr	x19, [x24, x20, lsl #3]
	str	x21, [sp, #256]
	cbz	x19, .LBB12_576
// %bb.74:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x19
	bl	strlen
	mov	x23, x0
	mov	x26, x21
	cmp	x0, #16
	b.lo	.LBB12_79
// %bb.75:                              //   in Loop: Header=BB12_2 Depth=1
	tbnz	x23, #63, .LBB12_584
// %bb.76:                              //   in Loop: Header=BB12_2 Depth=1
	adds	x0, x23, #1
	b.mi	.LBB12_507
// %bb.77:                              //   in Loop: Header=BB12_2 Depth=1
.Ltmp66:
	bl	_Znwm
.Ltmp67:
// %bb.78:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x26, x0
	str	x0, [sp, #256]
	str	x23, [sp, #272]
.LBB12_79:                              //   in Loop: Header=BB12_2 Depth=1
	cbz	x23, .LBB12_114
// %bb.80:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x23, #1
	b.ne	.LBB12_113
// %bb.81:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [x19]
	strb	w8, [x26]
	b	.LBB12_114
.LBB12_82:                              //   in Loop: Header=BB12_2 Depth=1
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x0, [x8]
	adrp	x1, .L.str.7
	add	x1, x1, :lo12:.L.str.7
	mov	x2, x23
	bl	fprintf
	mov	w22, #0                         // =0x0
	mov	w8, #2                          // =0x2
	str	w8, [sp, #60]                   // 4-byte Folded Spill
	ldr	x0, [sp, #320]
	cmp	x0, x28
	b.ne	.LBB12_110
	b	.LBB12_111
.LBB12_83:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x23
	mov	x2, x27
	bl	memcpy
	str	x27, [sp, #264]
	strb	wzr, [x26, x27]
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.ne	.LBB12_39
.LBB12_84:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	x8, [sp, #256]
	cmp	x8, x21
	b.eq	.LBB12_87
// %bb.85:                              //   in Loop: Header=BB12_2 Depth=1
	stur	x8, [x29, #-80]
	add	x8, sp, #9
	ldur	q0, [x8, #255]
	sub	x8, x29, #160
	stur	q0, [x8, #88]
.LBB12_86:                              //   in Loop: Header=BB12_2 Depth=1
	str	x21, [sp, #256]
	mov	x0, x21
	b	.LBB12_123
.LBB12_87:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	x2, [sp, #264]
	cbz	x2, .LBB12_122
// %bb.88:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	x2, #1
	b.ne	.LBB12_121
// %bb.89:                              //   in Loop: Header=BB12_2 Depth=1
	ldrb	w8, [sp, #272]
	strb	w8, [x0]
	b	.LBB12_122
.LBB12_90:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x23
	mov	x2, x27
	bl	memcpy
.LBB12_91:                              //   in Loop: Header=BB12_2 Depth=1
	str	x27, [sp, #264]
	strb	wzr, [x26, x27]
	ldr	x22, [sp, #256]
	bl	__errno_location
	mov	x23, x0
	ldr	w20, [x0]
	str	wzr, [x0]
	sub	x1, x29, #160
	mov	x0, x22
	mov	w2, #10                         // =0xa
	bl	__isoc23_strtoull
	str	x0, [sp, #184]                  // 8-byte Folded Spill
	ldur	x8, [x29, #-160]
	cmp	x8, x22
	b.eq	.LBB12_554
// %bb.92:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	cbz	w8, .LBB12_106
// %bb.93:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	w8, #34
	b.ne	.LBB12_107
	b	.LBB12_570
.LBB12_94:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x23
	mov	x2, x27
	bl	memcpy
.LBB12_95:                              //   in Loop: Header=BB12_2 Depth=1
	str	x27, [sp, #264]
	strb	wzr, [x26, x27]
	ldr	x22, [sp, #256]
	bl	__errno_location
	mov	x23, x0
	ldr	w20, [x0]
	str	wzr, [x0]
	sub	x1, x29, #160
	mov	x0, x22
	mov	w2, #10                         // =0xa
	bl	__isoc23_strtoull
	ldur	x8, [x29, #-160]
	cmp	x8, x22
	b.eq	.LBB12_552
// %bb.96:                              //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	str	x0, [sp, #240]                  // 8-byte Folded Spill
	cbz	w8, .LBB12_106
// %bb.97:                              //   in Loop: Header=BB12_2 Depth=1
	cmp	w8, #34
	b.ne	.LBB12_107
	b	.LBB12_572
.LBB12_98:                              //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x22
	mov	x2, x23
	bl	memcpy
.LBB12_99:                              //   in Loop: Header=BB12_2 Depth=1
	str	x23, [sp, #264]
	strb	wzr, [x26, x23]
	ldr	x22, [sp, #256]
	bl	__errno_location
	mov	x23, x0
	ldr	w20, [x0]
	str	wzr, [x0]
	sub	x1, x29, #160
	mov	x0, x22
	mov	w2, #10                         // =0xa
	bl	__isoc23_strtoull
	str	x0, [sp, #208]                  // 8-byte Folded Spill
	ldur	x8, [x29, #-160]
	cmp	x8, x22
	b.eq	.LBB12_550
// %bb.100:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	cbz	w8, .LBB12_106
// %bb.101:                             //   in Loop: Header=BB12_2 Depth=1
	cmp	w8, #34
	b.ne	.LBB12_107
	b	.LBB12_568
.LBB12_102:                             //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x20
	mov	x2, x23
	bl	memcpy
.LBB12_103:                             //   in Loop: Header=BB12_2 Depth=1
	str	x23, [sp, #264]
	strb	wzr, [x26, x23]
	ldr	x22, [sp, #256]
	bl	__errno_location
	mov	x23, x0
	ldr	w20, [x0]
	str	wzr, [x0]
	sub	x1, x29, #160
	mov	x0, x22
	mov	w2, #10                         // =0xa
	bl	__isoc23_strtoull
	stur	x0, [x29, #-24]                 // 8-byte Folded Spill
	ldur	x8, [x29, #-160]
	cmp	x8, x22
	b.eq	.LBB12_558
// %bb.104:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	cbz	w8, .LBB12_106
// %bb.105:                             //   in Loop: Header=BB12_2 Depth=1
	cmp	w8, #34
	b.ne	.LBB12_107
	b	.LBB12_582
.LBB12_106:                             //   in Loop: Header=BB12_2 Depth=1
	str	w20, [x23]
.LBB12_107:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	x0, [sp, #256]
	cmp	x0, x21
	b.eq	.LBB12_109
.LBB12_108:                             //   in Loop: Header=BB12_2 Depth=1
	bl	_ZdlPv
.LBB12_109:                             //   in Loop: Header=BB12_2 Depth=1
	mov	w22, #1                         // =0x1
                                        // kill: def $w19 killed $w19 killed $x19 def $x19
	ldr	x0, [sp, #320]
	cmp	x0, x28
	b.eq	.LBB12_111
.LBB12_110:                             //   in Loop: Header=BB12_2 Depth=1
	bl	_ZdlPv
.LBB12_111:                             //   in Loop: Header=BB12_2 Depth=1
	tbz	w22, #0, .LBB12_125
// %bb.112:                             //   in Loop: Header=BB12_2 Depth=1
	add	w19, w19, #1
	cmp	w19, w25
	b.lt	.LBB12_2
	b	.LBB12_126
.LBB12_113:                             //   in Loop: Header=BB12_2 Depth=1
	mov	x0, x26
	mov	x1, x19
	mov	x2, x23
	bl	memcpy
.LBB12_114:                             //   in Loop: Header=BB12_2 Depth=1
	str	x23, [sp, #264]
	strb	wzr, [x26, x23]
	ldr	x22, [sp, #256]
	bl	__errno_location
	mov	x23, x0
	ldr	w26, [x0]
	str	wzr, [x0]
	sub	x1, x29, #160
	mov	x0, x22
	mov	w2, #10                         // =0xa
	bl	__isoc23_strtoull
	str	x0, [sp, #192]                  // 8-byte Folded Spill
	ldur	x8, [x29, #-160]
	cmp	x8, x22
	b.eq	.LBB12_578
// %bb.115:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	w8, [x23]
	cbz	w8, .LBB12_120
// %bb.116:                             //   in Loop: Header=BB12_2 Depth=1
	cmp	w8, #34
	b.eq	.LBB12_586
// %bb.117:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	x0, [sp, #256]
	cmp	x0, x21
	b.eq	.LBB12_119
.LBB12_118:                             //   in Loop: Header=BB12_2 Depth=1
	bl	_ZdlPv
.LBB12_119:                             //   in Loop: Header=BB12_2 Depth=1
	mov	w22, #1                         // =0x1
	mov	x19, x20
	ldr	x0, [sp, #320]
	cmp	x0, x28
	b.ne	.LBB12_110
	b	.LBB12_111
.LBB12_120:                             //   in Loop: Header=BB12_2 Depth=1
	str	w26, [x23]
	ldr	x0, [sp, #256]
	cmp	x0, x21
	b.ne	.LBB12_118
	b	.LBB12_119
.LBB12_121:                             //   in Loop: Header=BB12_2 Depth=1
	mov	x1, x21
	bl	memcpy
.LBB12_122:                             //   in Loop: Header=BB12_2 Depth=1
	ldr	x8, [sp, #264]
	stur	x8, [x29, #-72]
	ldur	x9, [x29, #-80]
	strb	wzr, [x9, x8]
	ldr	x0, [sp, #256]
.LBB12_123:                             //   in Loop: Header=BB12_2 Depth=1
	str	xzr, [sp, #264]
	strb	wzr, [x0]
	ldr	x0, [sp, #256]
	cmp	x0, x21
	b.ne	.LBB12_108
	b	.LBB12_109
.LBB12_124:
	str	xzr, [sp, #208]                 // 8-byte Folded Spill
	str	wzr, [sp, #60]                  // 4-byte Folded Spill
	mov	w8, #1048576                    // =0x100000
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	mov	w27, #1                         // =0x1
	mov	w8, #1                          // =0x1
	str	x8, [sp, #184]                  // 8-byte Folded Spill
	mov	w28, #1048576                   // =0x100000
	mov	w20, #1048576                   // =0x100000
	b	.LBB12_128
.LBB12_125:
	ldr	w22, [sp, #60]                  // 4-byte Folded Reload
	b	.LBB12_482
.LBB12_126:
	ldr	x8, [sp, #240]                  // 8-byte Folded Reload
	cmp	x8, #0
	ldp	x9, x20, [sp, #184]             // 16-byte Folded Reload
	csel	x8, x20, x8, eq
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	mov	w8, #4                          // =0x4
	cmp	x9, #4
	csel	x27, x9, x8, lo
	cbz	x9, .LBB12_318
// %bb.127:
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
.LBB12_128:
	add	x8, x27, x27, lsl #1
	lsl	x21, x8, #3
.Ltmp91:
	mov	x0, x21
	bl	_Znwm
.Ltmp92:
// %bb.129:
	mov	x22, x0
	stur	x0, [x29, #-104]
	mov	w8, #24                         // =0x18
	madd	x19, x27, x8, x0
	mov	w1, #0                          // =0x0
	mov	x2, x21
	bl	memset
	add	x8, x22, x21
	stp	x8, x19, [x29, #-96]
.Ltmp94:
	mov	x0, x21
	bl	_Znwm
.Ltmp95:
// %bb.130:
	mov	x22, x0
	ldr	x23, [sp, #208]                 // 8-byte Folded Reload
	subs	x8, x20, x23
	lsr	x8, x8, #1
	cmp	x8, #1
	csinc	x24, x8, xzr, hi
	subs	x8, x20, x23
	str	x8, [sp, #224]                  // 8-byte Folded Spill
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
	stur	x0, [x29, #-128]
	mov	w8, #24                         // =0x18
	madd	x19, x27, x8, x0
	csel	x26, xzr, x24, eq
	mov	w1, #0                          // =0x0
	mov	x2, x21
	bl	memset
	str	xzr, [sp, #240]                 // 8-byte Folded Spill
	add	x8, x22, x21
	stp	x8, x19, [x29, #-120]
	lsl	x8, x20, #1
	str	x8, [sp, #176]                  // 8-byte Folded Spill
	lsl	x8, x28, #3
	str	x8, [sp, #152]                  // 8-byte Folded Spill
	sub	x9, x8, #8
	lsl	x10, x28, #2
	lsl	x11, x20, #3
	lsl	x8, x23, #3
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	sub	x8, x8, #8
	str	x8, [sp]                        // 8-byte Folded Spill
	lsl	x8, x24, #3
	str	x8, [sp, #32]                   // 8-byte Folded Spill
	str	x26, [sp, #216]                 // 8-byte Folded Spill
	lsr	x8, x26, #1
	stp	x24, x8, [sp, #16]              // 16-byte Folded Spill
	sub	x8, x28, #1
	and	x8, x8, #0x3fffffffffffffff
	stp	x8, x10, [sp, #136]             // 16-byte Folded Spill
	add	x8, x8, #1
	stp	x8, x9, [sp, #72]               // 16-byte Folded Spill
	and	x8, x8, #0x7ffffffffffffff0
	stp	x11, x8, [sp, #120]             // 16-byte Folded Spill
	lsl	x8, x8, #2
	str	x8, [sp, #64]                   // 8-byte Folded Spill
	str	x20, [sp, #192]                 // 8-byte Folded Spill
	sub	x8, x20, x28
	str	x8, [sp, #160]                  // 8-byte Folded Spill
	stur	x28, [x29, #-24]                // 8-byte Folded Spill
	str	x27, [sp, #168]                 // 8-byte Folded Spill
	b	.LBB12_132
.LBB12_131:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #240]                  // 8-byte Folded Reload
	add	x8, x8, #1
	str	x8, [sp, #240]                  // 8-byte Folded Spill
	cmp	x8, x27
	b.eq	.LBB12_319
.LBB12_132:                             // =>This Loop Header: Depth=1
                                        //     Child Loop BB12_141 Depth 2
                                        //     Child Loop BB12_144 Depth 2
                                        //     Child Loop BB12_148 Depth 2
                                        //     Child Loop BB12_151 Depth 2
                                        //     Child Loop BB12_153 Depth 2
                                        //     Child Loop BB12_262 Depth 2
                                        //       Child Loop BB12_271 Depth 3
                                        //       Child Loop BB12_273 Depth 3
                                        //       Child Loop BB12_278 Depth 3
                                        //       Child Loop BB12_280 Depth 3
                                        //     Child Loop BB12_288 Depth 2
                                        //     Child Loop BB12_169 Depth 2
                                        //     Child Loop BB12_172 Depth 2
                                        //     Child Loop BB12_176 Depth 2
                                        //     Child Loop BB12_180 Depth 2
                                        //     Child Loop BB12_208 Depth 2
                                        //     Child Loop BB12_196 Depth 2
                                        //     Child Loop BB12_227 Depth 2
                                        //     Child Loop BB12_240 Depth 2
                                        //     Child Loop BB12_305 Depth 2
                                        //     Child Loop BB12_310 Depth 2
	ldur	x8, [x29, #-72]
	cmp	x8, #5
	b.ne	.LBB12_134
// %bb.133:                             //   in Loop: Header=BB12_132 Depth=1
	ldur	x8, [x29, #-80]
	ldr	w9, [x8]
	ldrb	w8, [x8, #4]
	mov	w10, #25965                     // =0x656d
	movk	w10, #26482, lsl #16
	cmp	w9, w10
	mov	w9, #101                        // =0x65
	ccmp	w8, w9, #0, eq
	b.eq	.LBB12_162
.LBB12_134:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x8, x28, #60
	mov	x24, #31765                     // =0x7c15
	movk	x24, #32586, lsl #16
	movk	x24, #31161, lsl #32
	movk	x24, #40503, lsl #48
	mov	x26, #4587                      // =0x11eb
	movk	x26, #4913, lsl #16
	movk	x26, #18875, lsl #32
	movk	x26, #38096, lsl #48
	mov	x21, #61524                     // =0xf054
	movk	x21, #64809, lsl #16
	movk	x21, #59109, lsl #32
	movk	x21, #30941, lsl #48
	mov	w27, #1                         // =0x1
	cbnz	x8, .LBB12_530
// %bb.135:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #240]                  // 8-byte Folded Reload
	add	x8, x8, #1
	eor	x8, x8, x8, lsr #30
	mul	x8, x8, x25
	eor	x8, x8, x8, lsr #27
	mul	x8, x8, x26
	ldr	x9, [sp, #176]                  // 8-byte Folded Reload
	eor	x9, x9, x8
	extr	x8, x28, x8, #31
	mov	x10, #7395                      // =0x1ce3
	movk	x10, #4352, lsl #32
	eor	x9, x9, x10
	eor	x8, x8, x9
	eor	x8, x8, x8, lsr #30
	mul	x8, x8, x25
	eor	x8, x8, x8, lsr #27
	mul	x8, x8, x26
	eor	x22, x8, x8, lsr #31
	ldr	x19, [sp, #192]                 // 8-byte Folded Reload
	cbz	x28, .LBB12_159
// %bb.136:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp97:
	ldr	x0, [sp, #152]                  // 8-byte Folded Reload
	bl	_Znwm
.Ltmp98:
// %bb.137:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x23, x0
	str	xzr, [x0], #8
	cmp	x28, #1
	b.eq	.LBB12_139
// %bb.138:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x20, x19
	add	x19, x23, x28, lsl #3
	mov	w1, #0                          // =0x0
	ldr	x2, [sp, #80]                   // 8-byte Folded Reload
	bl	memset
	mov	x0, x19
	mov	x19, x20
.LBB12_139:                             //   in Loop: Header=BB12_132 Depth=1
	sub	x8, x0, x23
	sub	x9, x8, #8
	mov	x20, x23
	mov	x8, x23
	cmp	x9, #24
	b.lo	.LBB12_143
// %bb.140:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x8, x9, #3
	add	x9, x8, #1
	and	x10, x9, #0x3ffffffffffffffc
	madd	x23, x10, x24, x22
	mov	x14, x20
	add	x8, x20, x10, lsl #3
	add	x11, x22, x24
	mov	x12, #63530                     // =0xf82a
	movk	x12, #65172, lsl #16
	movk	x12, #62322, lsl #32
	movk	x12, #15470, lsl #48
	add	x12, x22, x12
	mov	x13, #29759                     // =0x743f
	movk	x13, #32223, lsl #16
	movk	x13, #27948, lsl #32
	movk	x13, #55974, lsl #48
	add	x13, x22, x13
	add	x14, x20, #16
	add	x15, x22, x21
	mov	x16, x10
.LBB12_141:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	eor	x17, x11, x11, lsr #30
	eor	x18, x12, x12, lsr #30
	eor	x1, x13, x13, lsr #30
	eor	x2, x15, x15, lsr #30
	mul	x17, x17, x25
	mul	x18, x18, x25
	mul	x1, x1, x25
	mul	x2, x2, x25
	eor	x17, x17, x17, lsr #27
	eor	x18, x18, x18, lsr #27
	eor	x1, x1, x1, lsr #27
	eor	x2, x2, x2, lsr #27
	mul	x17, x17, x26
	mul	x18, x18, x26
	mul	x1, x1, x26
	eor	x17, x17, x17, lsr #31
	mul	x2, x2, x26
	eor	x18, x18, x18, lsr #31
	eor	x1, x1, x1, lsr #31
	eor	x2, x2, x2, lsr #31
	stp	x17, x18, [x14, #-16]
	add	x11, x11, x21
	add	x12, x12, x21
	stp	x1, x2, [x14], #32
	add	x13, x13, x21
	add	x15, x15, x21
	subs	x16, x16, #4
	b.ne	.LBB12_141
// %bb.142:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x22, x23
	cmp	x9, x10
	b.eq	.LBB12_145
.LBB12_143:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x23, x22
.LBB12_144:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x23, x23, x24
	eor	x9, x23, x23, lsr #30
	mul	x9, x9, x25
	eor	x9, x9, x9, lsr #27
	mul	x9, x9, x26
	eor	x9, x9, x9, lsr #31
	str	x9, [x8], #8
	cmp	x8, x0
	b.ne	.LBB12_144
.LBB12_145:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp99:
	ldr	x0, [sp, #144]                  // 8-byte Folded Reload
	bl	_Znwm
.Ltmp100:
// %bb.146:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x21, x0
	mov	x8, x0
	ldr	x9, [sp, #136]                  // 8-byte Folded Reload
	cmp	x9, #15
	b.lo	.LBB12_150
// %bb.147:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #64]                   // 8-byte Folded Reload
	add	x8, x21, x8
	add	x9, x21, #32
	ldr	x10, [sp, #128]                 // 8-byte Folded Reload
	movi	v0.4s, #1
.LBB12_148:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	stp	q0, q0, [x9, #-32]
	stp	q0, q0, [x9], #64
	subs	x10, x10, #16
	b.ne	.LBB12_148
// %bb.149:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x9, [sp, #72]                   // 8-byte Folded Reload
	ldr	x10, [sp, #128]                 // 8-byte Folded Reload
	cmp	x9, x10
	b.eq	.LBB12_152
.LBB12_150:                             //   in Loop: Header=BB12_132 Depth=1
	add	x9, x21, x28, lsl #2
.LBB12_151:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	w27, [x8], #4
	cmp	x8, x9
	b.ne	.LBB12_151
.LBB12_152:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x22, x23
	ldr	x8, [sp, #160]                  // 8-byte Folded Reload
	cmp	x19, x28
	b.ls	.LBB12_154
.LBB12_153:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x22, x22, x24
	eor	x9, x22, x22, lsr #30
	mul	x9, x9, x25
	eor	x9, x9, x9, lsr #27
	mul	x9, x9, x26
	eor	x9, x9, x9, lsr #31
	umulh	x9, x9, x28
	lsl	x9, x9, #2
	ldr	w10, [x21, x9]
	add	w10, w10, #1
	str	w10, [x21, x9]
	subs	x8, x8, #1
	b.ne	.LBB12_153
.LBB12_154:                             //   in Loop: Header=BB12_132 Depth=1
	stp	xzr, xzr, [sp, #320]
	lsr	x8, x19, #60
	str	xzr, [sp, #336]
	cbnz	x8, .LBB12_532
// %bb.155:                             //   in Loop: Header=BB12_132 Depth=1
	cbz	x19, .LBB12_160
// %bb.156:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp102:
	ldr	x0, [sp, #120]                  // 8-byte Folded Reload
	bl	_Znwm
.Ltmp103:
// %bb.157:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x24, x0
	stp	x0, x0, [sp, #320]
	add	x8, x0, x19, lsl #3
	str	x8, [sp, #336]
	cbz	x28, .LBB12_161
.LBB12_158:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x25, #0                         // =0x0
	mov	x27, x24
	b	.LBB12_262
.LBB12_159:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x20, #0                         // =0x0
	mov	x21, #0                         // =0x0
	ldr	x8, [sp, #160]                  // 8-byte Folded Reload
	cmp	x19, x28
	b.hi	.LBB12_153
	b	.LBB12_154
.LBB12_160:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x8, #0                          // =0x0
	mov	x24, #0                         // =0x0
	cbnz	x28, .LBB12_158
.LBB12_161:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x27, x24
	b	.LBB12_286
.LBB12_162:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #208]                  // 8-byte Folded Reload
	lsr	x8, x8, #60
	mov	x20, #31765                     // =0x7c15
	movk	x20, #32586, lsl #16
	movk	x20, #31161, lsl #32
	movk	x20, #40503, lsl #48
	mov	x23, #4587                      // =0x11eb
	movk	x23, #4913, lsl #16
	movk	x23, #18875, lsl #32
	movk	x23, #38096, lsl #48
	mov	x26, #61524                     // =0xf054
	movk	x26, #64809, lsl #16
	movk	x26, #59109, lsl #32
	movk	x26, #30941, lsl #48
	cbnz	x8, .LBB12_530
// %bb.163:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #240]                  // 8-byte Folded Reload
	add	x8, x8, #1
	eor	x8, x8, x8, lsr #30
	mul	x8, x8, x25
	eor	x8, x8, x8, lsr #27
	mul	x8, x8, x23
	ldr	x9, [sp, #176]                  // 8-byte Folded Reload
	eor	x9, x9, x8, lsr #31
	mov	x10, #7395                      // =0x1ce3
	movk	x10, #4352, lsl #32
	eor	x8, x8, x10
	eor	x8, x9, x8
	eor	x8, x8, x8, lsr #30
	mul	x8, x8, x25
	eor	x8, x8, x8, lsr #27
	mul	x8, x8, x23
	eor	x21, x8, x8, lsr #31
	ldr	x8, [sp, #208]                  // 8-byte Folded Reload
	cbz	x8, .LBB12_183
// %bb.164:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp114:
	ldr	x0, [sp, #40]                   // 8-byte Folded Reload
	bl	_Znwm
.Ltmp115:
	ldr	x19, [sp, #192]                 // 8-byte Folded Reload
// %bb.165:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x24, x0
	str	xzr, [x24], #8
	mov	x27, x24
	ldr	x8, [sp, #208]                  // 8-byte Folded Reload
	cmp	x8, #1
	mov	x28, x0
	b.eq	.LBB12_167
// %bb.166:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #208]                  // 8-byte Folded Reload
	add	x27, x28, x8, lsl #3
	mov	x0, x24
	mov	w1, #0                          // =0x0
	ldr	x2, [sp]                        // 8-byte Folded Reload
	bl	memset
.LBB12_167:                             //   in Loop: Header=BB12_132 Depth=1
	sub	x8, x27, x28
	sub	x10, x8, #8
	mov	x9, x28
	cmp	x10, #24
	b.lo	.LBB12_171
// %bb.168:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x9, x10, #3
	add	x10, x9, #1
	and	x11, x10, #0x3ffffffffffffffc
	madd	x22, x11, x20, x21
	add	x9, x28, x11, lsl #3
	add	x12, x21, x20
	mov	x13, #63530                     // =0xf82a
	movk	x13, #65172, lsl #16
	movk	x13, #62322, lsl #32
	movk	x13, #15470, lsl #48
	add	x13, x21, x13
	mov	x14, #29759                     // =0x743f
	movk	x14, #32223, lsl #16
	movk	x14, #27948, lsl #32
	movk	x14, #55974, lsl #48
	add	x14, x21, x14
	add	x15, x28, #16
	add	x16, x21, x26
	mov	x17, x11
.LBB12_169:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	eor	x18, x12, x12, lsr #30
	eor	x0, x13, x13, lsr #30
	eor	x1, x14, x14, lsr #30
	eor	x2, x16, x16, lsr #30
	mul	x18, x18, x25
	mul	x0, x0, x25
	mul	x1, x1, x25
	mul	x2, x2, x25
	eor	x18, x18, x18, lsr #27
	eor	x0, x0, x0, lsr #27
	eor	x1, x1, x1, lsr #27
	eor	x2, x2, x2, lsr #27
	mul	x18, x18, x23
	mul	x0, x0, x23
	mul	x1, x1, x23
	eor	x18, x18, x18, lsr #31
	mul	x2, x2, x23
	eor	x0, x0, x0, lsr #31
	eor	x1, x1, x1, lsr #31
	eor	x2, x2, x2, lsr #31
	stp	x18, x0, [x15, #-16]
	add	x12, x12, x26
	add	x13, x13, x26
	stp	x1, x2, [x15], #32
	add	x14, x14, x26
	add	x16, x16, x26
	subs	x17, x17, #4
	b.ne	.LBB12_169
// %bb.170:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x21, x22
	cmp	x10, x11
	b.eq	.LBB12_173
.LBB12_171:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x22, x21
.LBB12_172:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x22, x22, x20
	eor	x10, x22, x22, lsr #30
	mul	x10, x10, x25
	eor	x10, x10, x10, lsr #27
	mul	x10, x10, x23
	eor	x10, x10, x10, lsr #31
	str	x10, [x9], #8
	cmp	x9, x27
	b.ne	.LBB12_172
.LBB12_173:                             //   in Loop: Header=BB12_132 Depth=1
	asr	x8, x8, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp117:
	mov	x0, x28
	mov	x1, x27
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp118:
// %bb.174:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp119:
	mov	x0, x28
	mov	x1, x27
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp120:
// %bb.175:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x11, [sp, #208]                 // 8-byte Folded Reload
.LBB12_176:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	cmp	x24, x27
	b.eq	.LBB12_184
// %bb.177:                             //   in Loop: Header=BB12_176 Depth=2
	ldp	x8, x9, [x24, #-8]
	add	x24, x24, #8
	cmp	x8, x9
	b.ne	.LBB12_176
// %bb.178:                             //   in Loop: Header=BB12_132 Depth=1
	sub	x9, x24, #16
	b	.LBB12_180
.LBB12_179:                             //   in Loop: Header=BB12_180 Depth=2
	add	x24, x24, #8
.LBB12_180:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	cmp	x24, x27
	b.eq	.LBB12_185
// %bb.181:                             //   in Loop: Header=BB12_180 Depth=2
	mov	x10, x8
	ldr	x8, [x24]
	cmp	x10, x8
	b.eq	.LBB12_179
// %bb.182:                             //   in Loop: Header=BB12_180 Depth=2
	str	x8, [x9, #8]!
	b	.LBB12_179
.LBB12_183:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x28, #0                         // =0x0
	mov	x27, #0                         // =0x0
	mov	x22, x21
	ldr	x19, [sp, #192]                 // 8-byte Folded Reload
	ldr	x11, [sp, #208]                 // 8-byte Folded Reload
.LBB12_184:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #216]                  // 8-byte Folded Reload
	lsr	x8, x8, #60
	cbz	x8, .LBB12_186
	b	.LBB12_540
.LBB12_185:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x9, #8
	cmp	x8, x27
	csel	x27, x27, x8, eq
	ldr	x8, [sp, #216]                  // 8-byte Folded Reload
	lsr	x8, x8, #60
	cbnz	x8, .LBB12_540
.LBB12_186:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x19, x11
	str	x22, [sp, #112]                 // 8-byte Folded Spill
	b.ne	.LBB12_188
// %bb.187:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, #0                          // =0x0
	mov	x8, #0                          // =0x0
	b	.LBB12_190
.LBB12_188:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp122:
	ldr	x0, [sp, #32]                   // 8-byte Folded Reload
	bl	_Znwm
.Ltmp123:
// %bb.189:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #16]                   // 8-byte Folded Reload
	add	x8, x0, x8, lsl #3
.LBB12_190:                             //   in Loop: Header=BB12_132 Depth=1
	str	x28, [sp, #232]                 // 8-byte Folded Spill
	sub	x9, x27, x28
	stp	x9, x27, [sp, #96]              // 16-byte Folded Spill
	asr	x26, x9, #3
	mov	x9, #63530                      // =0xf82a
	movk	x9, #65172, lsl #16
	movk	x9, #62322, lsl #32
	movk	x9, #15470, lsl #48
	ldr	x10, [sp, #112]                 // 8-byte Folded Reload
	add	x21, x10, x9
	ldr	x9, [sp, #216]                  // 8-byte Folded Reload
	cmp	x9, #2
	b.hs	.LBB12_206
// %bb.191:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x24, x0
	ldr	x20, [sp, #216]                 // 8-byte Folded Reload
.LBB12_192:                             //   in Loop: Header=BB12_132 Depth=1
	str	x26, [sp, #88]                  // 8-byte Folded Spill
	sub	x26, x0, x24
	asr	x25, x26, #3
	cmp	x25, x20
	b.hs	.LBB12_218
// %bb.193:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x9, #29759                      // =0x743f
	movk	x9, #32223, lsl #16
	movk	x9, #27948, lsl #32
	movk	x9, #55974, lsl #48
	ldr	x10, [sp, #112]                 // 8-byte Folded Reload
	add	x22, x10, x9
	mov	x28, #1152921504606846975       // =0xfffffffffffffff
	b	.LBB12_196
.LBB12_194:                             //   in Loop: Header=BB12_196 Depth=2
	str	x23, [x0]
	mov	x27, x24
.LBB12_195:                             //   in Loop: Header=BB12_196 Depth=2
	add	x0, x0, #8
	sub	x26, x0, x27
	asr	x25, x26, #3
	mov	x9, #31765                      // =0x7c15
	movk	x9, #32586, lsl #16
	movk	x9, #31161, lsl #32
	movk	x9, #40503, lsl #48
	add	x22, x22, x9
	add	x21, x21, x9
	cmp	x25, x20
	b.hs	.LBB12_219
.LBB12_196:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	eor	x9, x22, x22, lsr #30
	mov	x10, #58809                     // =0xe5b9
	movk	x10, #7396, lsl #16
	movk	x10, #18285, lsl #32
	movk	x10, #48984, lsl #48
	mul	x9, x9, x10
	eor	x9, x9, x9, lsr #27
	mov	x10, #4587                      // =0x11eb
	movk	x10, #4913, lsl #16
	movk	x10, #18875, lsl #32
	movk	x10, #38096, lsl #48
	mul	x9, x9, x10
	eor	x23, x9, x9, lsr #31
	cmp	x0, x8
	b.ne	.LBB12_194
// %bb.197:                             //   in Loop: Header=BB12_196 Depth=2
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x26, x8
	b.eq	.LBB12_525
// %bb.198:                             //   in Loop: Header=BB12_196 Depth=2
	cmp	x25, #1
	csinc	x8, x25, xzr, hi
	adds	x9, x8, x25
	cmp	x9, x28
	csel	x9, x9, x28, lo
	cmn	x8, x25
	csel	x19, x28, x9, hs
	cbz	x19, .LBB12_205
// %bb.199:                             //   in Loop: Header=BB12_196 Depth=2
	lsl	x0, x19, #3
.Ltmp131:
	bl	_Znwm
.Ltmp132:
// %bb.200:                             //   in Loop: Header=BB12_196 Depth=2
	mov	x27, x0
	str	x23, [x0, x25, lsl #3]
	cmp	x26, #1
	b.lt	.LBB12_202
.LBB12_201:                             //   in Loop: Header=BB12_196 Depth=2
	mov	x0, x27
	mov	x1, x24
	mov	x2, x26
	bl	memmove
.LBB12_202:                             //   in Loop: Header=BB12_196 Depth=2
	cbz	x24, .LBB12_204
// %bb.203:                             //   in Loop: Header=BB12_196 Depth=2
	mov	x0, x24
	bl	_ZdlPv
.LBB12_204:                             //   in Loop: Header=BB12_196 Depth=2
	add	x0, x27, x26
	add	x8, x27, x19, lsl #3
	mov	x24, x27
	b	.LBB12_195
.LBB12_205:                             //   in Loop: Header=BB12_196 Depth=2
	mov	x27, #0                         // =0x0
	str	x23, [x27, x25, lsl #3]
	cmp	x26, #1
	b.ge	.LBB12_201
	b	.LBB12_202
.LBB12_206:                             //   in Loop: Header=BB12_132 Depth=1
	add	x9, x10, x20
	eor	x9, x9, x9, lsr #30
	mul	x9, x9, x25
	eor	x9, x9, x9, lsr #27
	mul	x9, x9, x23
	eor	x9, x9, x9, lsr #31
	mov	x10, x25
	umulh	x25, x9, x26
	eor	x9, x21, x21, lsr #30
	mul	x9, x9, x10
	eor	x9, x9, x9, lsr #27
	mul	x9, x9, x23
	eor	x9, x9, x9, lsr #31
	orr	x10, x9, #0x1
	ldr	x28, [sp, #24]                  // 8-byte Folded Reload
	mov	x27, x0
	ldr	x20, [sp, #216]                 // 8-byte Folded Reload
	str	x10, [sp, #200]                 // 8-byte Folded Spill
	b	.LBB12_208
.LBB12_207:                             //   in Loop: Header=BB12_208 Depth=2
	ldr	x9, [sp, #232]                  // 8-byte Folded Reload
	ldr	x9, [x9, x26, lsl #3]
	str	x9, [x0], #8
	mov	x24, x27
	mov	x26, x22
	add	x25, x25, x10
	subs	x28, x28, #1
	b.eq	.LBB12_192
.LBB12_208:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	udiv	x9, x25, x26
	mov	x22, x26
	msub	x26, x9, x26, x25
	cmp	x0, x8
	b.ne	.LBB12_207
// %bb.209:                             //   in Loop: Header=BB12_208 Depth=2
	sub	x23, x8, x27
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.eq	.LBB12_523
// %bb.210:                             //   in Loop: Header=BB12_208 Depth=2
	asr	x20, x23, #3
	cmp	x20, #1
	csinc	x8, x20, xzr, hi
	adds	x9, x8, x20
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cmn	x8, x20
	csel	x19, x10, x9, hs
	cbz	x19, .LBB12_217
// %bb.211:                             //   in Loop: Header=BB12_208 Depth=2
	lsl	x0, x19, #3
.Ltmp125:
	bl	_Znwm
.Ltmp126:
// %bb.212:                             //   in Loop: Header=BB12_208 Depth=2
	mov	x24, x0
	ldr	x8, [sp, #232]                  // 8-byte Folded Reload
	ldr	x8, [x8, x26, lsl #3]
	str	x8, [x0, x20, lsl #3]
	cmp	x23, #1
	b.lt	.LBB12_214
.LBB12_213:                             //   in Loop: Header=BB12_208 Depth=2
	mov	x0, x24
	mov	x1, x27
	mov	x2, x23
	bl	memmove
.LBB12_214:                             //   in Loop: Header=BB12_208 Depth=2
	mov	x26, x22
	cbz	x27, .LBB12_216
// %bb.215:                             //   in Loop: Header=BB12_208 Depth=2
	mov	x0, x27
	bl	_ZdlPv
.LBB12_216:                             //   in Loop: Header=BB12_208 Depth=2
	add	x0, x24, x23
	add	x8, x24, x19, lsl #3
	mov	x27, x24
	ldr	x20, [sp, #216]                 // 8-byte Folded Reload
	ldr	x10, [sp, #200]                 // 8-byte Folded Reload
	add	x0, x0, #8
	add	x25, x25, x10
	subs	x28, x28, #1
	b.ne	.LBB12_208
	b	.LBB12_192
.LBB12_217:                             //   in Loop: Header=BB12_208 Depth=2
	mov	x24, #0                         // =0x0
	ldr	x8, [sp, #232]                  // 8-byte Folded Reload
	ldr	x8, [x8, x26, lsl #3]
	str	x8, [x24, x20, lsl #3]
	cmp	x23, #1
	b.ge	.LBB12_213
	b	.LBB12_214
.LBB12_218:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x27, x24
.LBB12_219:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x0, x27
	b.eq	.LBB12_252
// %bb.220:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x8, x25, #60
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbnz	x8, .LBB12_491
// %bb.221:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp134:
	mov	x0, x26
	bl	_Znwm
.Ltmp135:
// %bb.222:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x22, x0
	cmp	x26, #9
	b.lt	.LBB12_253
.LBB12_223:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x22
	mov	x1, x27
	mov	x2, x26
	bl	memmove
.LBB12_224:                             //   in Loop: Header=BB12_132 Depth=1
	add	x23, x22, x26
	asr	x28, x26, #3
	ldr	x8, [sp, #224]                  // 8-byte Folded Reload
	cmp	x28, x8
	b.hs	.LBB12_237
// %bb.225:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x22, x25, lsl #3
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
	b	.LBB12_227
.LBB12_226:                             //   in Loop: Header=BB12_227 Depth=2
	ldr	x9, [x27, x25, lsl #3]
	str	x9, [x23], #8
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
	sub	x26, x23, x22
	asr	x28, x26, #3
	ldr	x9, [sp, #224]                  // 8-byte Folded Reload
	cmp	x28, x9
	b.hs	.LBB12_238
.LBB12_227:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x9, #31765                      // =0x7c15
	movk	x9, #32586, lsl #16
	movk	x9, #31161, lsl #32
	movk	x9, #40503, lsl #48
	add	x21, x21, x9
	eor	x9, x21, x21, lsr #30
	mul	x9, x9, x25
	eor	x9, x9, x9, lsr #27
	mov	x10, #4587                      // =0x11eb
	movk	x10, #4913, lsl #16
	movk	x10, #18875, lsl #32
	movk	x10, #38096, lsl #48
	mul	x9, x9, x10
	eor	x9, x9, x9, lsr #31
	umulh	x25, x9, x20
	cmp	x23, x8
	b.ne	.LBB12_226
// %bb.228:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x26, x8
	b.eq	.LBB12_527
// %bb.229:                             //   in Loop: Header=BB12_227 Depth=2
	cmp	x28, #1
	csinc	x8, x28, xzr, hi
	adds	x9, x8, x28
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cmn	x8, x28
	csel	x19, x10, x9, hs
	cbz	x19, .LBB12_236
// %bb.230:                             //   in Loop: Header=BB12_227 Depth=2
	lsl	x0, x19, #3
.Ltmp140:
	bl	_Znwm
.Ltmp141:
// %bb.231:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x24, x0
	ldr	x8, [x27, x25, lsl #3]
	str	x8, [x0, x28, lsl #3]
	cmp	x26, #1
	b.lt	.LBB12_233
.LBB12_232:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x0, x24
	mov	x1, x22
	mov	x2, x26
	bl	memmove
.LBB12_233:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
	cbz	x22, .LBB12_235
// %bb.234:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x0, x22
	bl	_ZdlPv
.LBB12_235:                             //   in Loop: Header=BB12_227 Depth=2
	add	x23, x24, x26
	add	x8, x24, x19, lsl #3
	mov	x22, x24
	add	x23, x23, #8
	sub	x26, x23, x24
	asr	x28, x26, #3
	ldr	x9, [sp, #224]                  // 8-byte Folded Reload
	cmp	x28, x9
	b.lo	.LBB12_227
	b	.LBB12_238
.LBB12_236:                             //   in Loop: Header=BB12_227 Depth=2
	mov	x24, #0                         // =0x0
	ldr	x8, [x27, x25, lsl #3]
	str	x8, [x24, x28, lsl #3]
	cmp	x26, #1
	b.ge	.LBB12_232
	b	.LBB12_233
.LBB12_237:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
.LBB12_238:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x28, #2
	mov	x14, #31765                     // =0x7c15
	movk	x14, #32586, lsl #16
	movk	x14, #31161, lsl #32
	movk	x14, #40503, lsl #48
	mov	x15, #4587                      // =0x11eb
	movk	x15, #4913, lsl #16
	movk	x15, #18875, lsl #32
	movk	x15, #38096, lsl #48
	ldp	x20, x19, [sp, #88]             // 16-byte Folded Reload
	b.lo	.LBB12_241
// %bb.239:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x21, x14
	sub	x9, x22, #8
.LBB12_240:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x10, x28, #3
	eor	x11, x8, x8, lsr #30
	mul	x11, x11, x25
	eor	x11, x11, x11, lsr #27
	mul	x11, x11, x15
	eor	x11, x11, x11, lsr #31
	umulh	x11, x11, x28
	lsl	x11, x11, #3
	ldr	x12, [x9, x10]
	ldr	x13, [x22, x11]
	str	x13, [x9, x10]
	sub	x10, x28, #1
	str	x12, [x22, x11]
	add	x8, x8, x14
	mov	x28, x10
	cmp	x10, #1
	b.hi	.LBB12_240
.LBB12_241:                             //   in Loop: Header=BB12_132 Depth=1
	stp	xzr, xzr, [sp, #320]
	str	xzr, [sp, #336]
	ldr	x8, [sp, #232]                  // 8-byte Folded Reload
	ldr	x9, [sp, #104]                  // 8-byte Folded Reload
	cmp	x9, x8
	b.eq	.LBB12_255
// %bb.242:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x8, x20, #60
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	cbnz	x8, .LBB12_493
// %bb.243:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp143:
	mov	x0, x19
	bl	_Znwm
.Ltmp144:
// %bb.244:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x21, x0
	add	x8, x0, x20, lsl #3
	str	x0, [sp, #320]
	str	x8, [sp, #336]
	cmp	x19, #9
	b.lt	.LBB12_256
.LBB12_245:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x21
	ldr	x1, [sp, #232]                  // 8-byte Folded Reload
	mov	x2, x19
	bl	memcpy
.LBB12_246:                             //   in Loop: Header=BB12_132 Depth=1
	add	x1, x21, x19
	str	x1, [sp, #328]
.Ltmp148:
	add	x0, sp, #320
	mov	x2, x22
	mov	x3, x23
	bl	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
.Ltmp149:
// %bb.247:                             //   in Loop: Header=BB12_132 Depth=1
	cbz	x22, .LBB12_249
// %bb.248:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x22
	bl	_ZdlPv
.LBB12_249:                             //   in Loop: Header=BB12_132 Depth=1
	cbz	x27, .LBB12_251
// %bb.250:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x27
	bl	_ZdlPv
.LBB12_251:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x27, [sp, #168]                 // 8-byte Folded Reload
	ldr	x20, [sp, #232]                 // 8-byte Folded Reload
	cbnz	x20, .LBB12_292
	b	.LBB12_293
.LBB12_252:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x22, #0                         // =0x0
	cmp	x26, #9
	b.ge	.LBB12_223
.LBB12_253:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x26, #8
	b.ne	.LBB12_224
// %bb.254:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [x27]
	str	x8, [x22]
	b	.LBB12_224
.LBB12_255:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x21, #0                         // =0x0
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	add	x8, x21, x20, lsl #3
	str	x21, [sp, #320]
	str	x8, [sp, #336]
	cmp	x19, #9
	b.ge	.LBB12_245
.LBB12_256:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x19, #8
	b.ne	.LBB12_246
// %bb.257:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [sp, #232]                  // 8-byte Folded Reload
	ldr	x8, [x8]
	str	x8, [x21]
	b	.LBB12_246
.LBB12_258:                             //   in Loop: Header=BB12_262 Depth=2
	ldr	x8, [x24]
	str	x8, [x23]
.LBB12_259:                             //   in Loop: Header=BB12_262 Depth=2
	mov	x0, x24
	bl	_ZdlPv
.LBB12_260:                             //   in Loop: Header=BB12_262 Depth=2
	stp	x23, x27, [sp, #320]
	add	x8, x23, x28, lsl #3
	str	x8, [sp, #336]
	mov	x24, x23
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
.LBB12_261:                             //   in Loop: Header=BB12_262 Depth=2
	add	x25, x25, #1
	cmp	x25, x28
	b.eq	.LBB12_285
.LBB12_262:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB12_271 Depth 3
                                        //       Child Loop BB12_273 Depth 3
                                        //       Child Loop BB12_278 Depth 3
                                        //       Child Loop BB12_280 Depth 3
	ldr	w19, [x21, x25, lsl #2]
	cbz	w19, .LBB12_261
// %bb.263:                             //   in Loop: Header=BB12_262 Depth=2
	sub	x9, x8, x27
	cmp	x19, x9, asr #3
	b.ls	.LBB12_268
// %bb.264:                             //   in Loop: Header=BB12_262 Depth=2
	sub	x26, x27, x24
	asr	x8, x26, #3
	mov	x11, #1152921504606846975       // =0xfffffffffffffff
	sub	x9, x11, x8
	cmp	x9, x19
	b.lo	.LBB12_513
// %bb.265:                             //   in Loop: Header=BB12_262 Depth=2
	cmp	x8, x19
	csel	x9, x8, x19, hi
	adds	x10, x9, x8
	cmp	x10, x11
	csel	x10, x10, x11, lo
	cmn	x9, x8
	mov	x8, #1152921504606846975        // =0xfffffffffffffff
	csel	x28, x8, x10, hs
	cbz	x28, .LBB12_275
// %bb.266:                             //   in Loop: Header=BB12_262 Depth=2
	lsl	x0, x28, #3
.Ltmp105:
	bl	_Znwm
.Ltmp106:
// %bb.267:                             //   in Loop: Header=BB12_262 Depth=2
	mov	x23, x0
	b	.LBB12_276
.LBB12_268:                             //   in Loop: Header=BB12_262 Depth=2
	ldr	x10, [x20, x25, lsl #3]
	add	x9, x27, x19, lsl #3
	sub	x11, x19, #1
	and	x11, x11, #0x1fffffffffffffff
	cmp	x11, #7
	b.hs	.LBB12_270
// %bb.269:                             //   in Loop: Header=BB12_262 Depth=2
	mov	x11, x27
	b	.LBB12_273
.LBB12_270:                             //   in Loop: Header=BB12_262 Depth=2
	add	x12, x11, #1
	and	x13, x12, #0x3ffffffffffffff8
	add	x11, x27, x13, lsl #3
	dup	v0.2d, x10
	add	x14, x27, #32
	mov	x15, x13
.LBB12_271:                             //   Parent Loop BB12_132 Depth=1
                                        //     Parent Loop BB12_262 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	stp	q0, q0, [x14, #-32]
	stp	q0, q0, [x14], #64
	subs	x15, x15, #8
	b.ne	.LBB12_271
// %bb.272:                             //   in Loop: Header=BB12_262 Depth=2
	cmp	x12, x13
	b.eq	.LBB12_274
.LBB12_273:                             //   Parent Loop BB12_132 Depth=1
                                        //     Parent Loop BB12_262 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	str	x10, [x11], #8
	cmp	x11, x9
	b.ne	.LBB12_273
.LBB12_274:                             //   in Loop: Header=BB12_262 Depth=2
	str	x9, [sp, #328]
	mov	x27, x9
	b	.LBB12_261
.LBB12_275:                             //   in Loop: Header=BB12_262 Depth=2
	mov	x23, #0                         // =0x0
.LBB12_276:                             //   in Loop: Header=BB12_262 Depth=2
	add	x12, x23, x26
	add	x27, x12, x19, lsl #3
	ldr	x8, [x20, x25, lsl #3]
	sub	x9, x19, #1
	and	x10, x9, #0x1fffffffffffffff
	mov	x9, x12
	cmp	x10, #7
	b.lo	.LBB12_280
// %bb.277:                             //   in Loop: Header=BB12_262 Depth=2
	add	x10, x10, #1
	and	x11, x10, #0x3ffffffffffffff8
	add	x9, x12, x11, lsl #3
	dup	v0.2d, x8
	add	x12, x12, #32
	mov	x13, x11
.LBB12_278:                             //   Parent Loop BB12_132 Depth=1
                                        //     Parent Loop BB12_262 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	stp	q0, q0, [x12, #-32]
	stp	q0, q0, [x12], #64
	subs	x13, x13, #8
	b.ne	.LBB12_278
// %bb.279:                             //   in Loop: Header=BB12_262 Depth=2
	cmp	x10, x11
	b.eq	.LBB12_281
.LBB12_280:                             //   Parent Loop BB12_132 Depth=1
                                        //     Parent Loop BB12_262 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	str	x8, [x9], #8
	cmp	x9, x27
	b.ne	.LBB12_280
.LBB12_281:                             //   in Loop: Header=BB12_262 Depth=2
	cmp	x26, #9
	b.lt	.LBB12_284
// %bb.282:                             //   in Loop: Header=BB12_262 Depth=2
	mov	x0, x23
	mov	x1, x24
	mov	x2, x26
	bl	memmove
.LBB12_283:                             //   in Loop: Header=BB12_262 Depth=2
	cbnz	x24, .LBB12_259
	b	.LBB12_260
.LBB12_284:                             //   in Loop: Header=BB12_262 Depth=2
	cmp	x26, #8
	b.ne	.LBB12_283
	b	.LBB12_258
.LBB12_285:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x24, [sp, #320]
.LBB12_286:                             //   in Loop: Header=BB12_132 Depth=1
	sub	x8, x27, x24
	asr	x9, x8, #3
	cmp	x9, #2
	mov	x25, #58809                     // =0xe5b9
	movk	x25, #7396, lsl #16
	movk	x25, #18285, lsl #32
	movk	x25, #48984, lsl #48
	mov	x15, #31765                     // =0x7c15
	movk	x15, #32586, lsl #16
	movk	x15, #31161, lsl #32
	movk	x15, #40503, lsl #48
	mov	x16, #4587                      // =0x11eb
	movk	x16, #4913, lsl #16
	movk	x16, #18875, lsl #32
	movk	x16, #38096, lsl #48
	b.lo	.LBB12_289
// %bb.287:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x22, x15
	sub	x10, x24, #8
.LBB12_288:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x11, x9, #3
	eor	x12, x8, x8, lsr #30
	mul	x12, x12, x25
	eor	x12, x12, x12, lsr #27
	mul	x12, x12, x16
	eor	x12, x12, x12, lsr #31
	umulh	x12, x12, x9
	lsl	x12, x12, #3
	ldr	x13, [x10, x11]
	ldr	x14, [x24, x12]
	str	x14, [x10, x11]
	sub	x11, x9, #1
	str	x13, [x24, x12]
	add	x8, x8, x15
	mov	x9, x11
	cmp	x11, #1
	b.hi	.LBB12_288
.LBB12_289:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x27, [sp, #168]                 // 8-byte Folded Reload
	cbz	x21, .LBB12_291
// %bb.290:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x21
	bl	_ZdlPv
.LBB12_291:                             //   in Loop: Header=BB12_132 Depth=1
	cbz	x20, .LBB12_293
.LBB12_292:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x20
	bl	_ZdlPv
.LBB12_293:                             //   in Loop: Header=BB12_132 Depth=1
	ldur	x20, [x29, #-104]
	mov	w8, #24                         // =0x18
	ldr	x9, [sp, #240]                  // 8-byte Folded Reload
	madd	x19, x9, x8, x20
	ldr	x0, [x19]
	ldr	q0, [sp, #320]
	str	q0, [x19]
	ldr	x8, [sp, #336]
	str	x8, [x19, #16]
	stp	xzr, xzr, [sp, #320]
	str	xzr, [sp, #336]
	cbz	x0, .LBB12_296
// %bb.294:                             //   in Loop: Header=BB12_132 Depth=1
	bl	_ZdlPv
	ldr	x0, [sp, #320]
	cbz	x0, .LBB12_296
// %bb.295:                             //   in Loop: Header=BB12_132 Depth=1
	bl	_ZdlPv
.LBB12_296:                             //   in Loop: Header=BB12_132 Depth=1
	ldp	x26, x19, [x19]
	subs	x21, x19, x26
	asr	x22, x21, #3
	b.eq	.LBB12_312
// %bb.297:                             //   in Loop: Header=BB12_132 Depth=1
	lsr	x8, x22, #60
	cbnz	x8, .LBB12_485
// %bb.298:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp151:
	mov	x0, x21
	bl	_Znwm
.Ltmp152:
// %bb.299:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x23, x0
	cmp	x21, #9
	b.lt	.LBB12_313
.LBB12_300:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x0, x23
	mov	x1, x26
	mov	x2, x21
	bl	memcpy
.LBB12_301:                             //   in Loop: Header=BB12_132 Depth=1
	add	x24, x23, x21
	subs	x19, x19, x26
	b.eq	.LBB12_316
// %bb.302:                             //   in Loop: Header=BB12_132 Depth=1
	clz	x8, x22
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp157:
	mov	x0, x23
	mov	x1, x24
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp158:
// %bb.303:                             //   in Loop: Header=BB12_132 Depth=1
.Ltmp159:
	mov	x0, x23
	mov	x1, x24
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp160:
// %bb.304:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x23, #8
	sub	x9, x19, #8
.LBB12_305:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	cbz	x9, .LBB12_316
// %bb.306:                             //   in Loop: Header=BB12_305 Depth=2
	ldp	x10, x11, [x8, #-8]
	add	x8, x8, #8
	sub	x9, x9, #8
	cmp	x10, x11
	b.ne	.LBB12_305
// %bb.307:                             //   in Loop: Header=BB12_132 Depth=1
	sub	x11, x8, #16
	cbz	x9, .LBB12_315
// %bb.308:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x12, #0                         // =0x0
	b	.LBB12_310
.LBB12_309:                             //   in Loop: Header=BB12_310 Depth=2
	add	x12, x12, #8
	cmp	x9, x12
	b.eq	.LBB12_315
.LBB12_310:                             //   Parent Loop BB12_132 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x13, x10
	ldr	x10, [x8, x12]
	cmp	x13, x10
	b.eq	.LBB12_309
// %bb.311:                             //   in Loop: Header=BB12_310 Depth=2
	str	x10, [x11, #8]!
	b	.LBB12_309
.LBB12_312:                             //   in Loop: Header=BB12_132 Depth=1
	mov	x23, #0                         // =0x0
	cmp	x21, #9
	b.ge	.LBB12_300
.LBB12_313:                             //   in Loop: Header=BB12_132 Depth=1
	cmp	x21, #8
	b.ne	.LBB12_301
// %bb.314:                             //   in Loop: Header=BB12_132 Depth=1
	ldr	x8, [x26]
	str	x8, [x23]
	b	.LBB12_301
.LBB12_315:                             //   in Loop: Header=BB12_132 Depth=1
	add	x8, x11, #8
	sub	x9, x8, x23
	cmp	x21, x9
	csel	x9, x24, x8, eq
	cmp	x8, x24
	csel	x24, x24, x9, eq
.LBB12_316:                             //   in Loop: Header=BB12_132 Depth=1
	ldur	x21, [x29, #-128]
	mov	w8, #24                         // =0x18
	ldr	x9, [sp, #240]                  // 8-byte Folded Reload
	madd	x8, x9, x8, x21
	ldr	x0, [x8]
	add	x9, x23, x22, lsl #3
	stp	x23, x24, [x8]
	str	x9, [x8, #16]
	cbz	x0, .LBB12_131
// %bb.317:                             //   in Loop: Header=BB12_132 Depth=1
	bl	_ZdlPv
	b	.LBB12_131
.LBB12_318:
	str	xzr, [sp, #184]                 // 8-byte Folded Spill
	mov	x21, #0                         // =0x0
	mov	x20, #0                         // =0x0
	stp	xzr, xzr, [x29, #-104]
	stur	xzr, [x29, #-88]
	stp	xzr, xzr, [x29, #-128]
	stur	xzr, [x29, #-112]
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
.LBB12_319:
	movi	v0.2d, #0000000000000000
	sub	x8, x29, #160
	stp	q0, q0, [x8]
	ldur	x2, [x29, #-72]
	cmp	x2, #4
	str	x20, [sp, #240]                 // 8-byte Folded Spill
	b.eq	.LBB12_324
// %bb.320:
	cmp	x2, #5
	b.ne	.LBB12_472
// %bb.321:
	ldur	x22, [x29, #-80]
	adrp	x1, .L.str.15
	add	x1, x1, :lo12:.L.str.15
	mov	x0, x22
	bl	bcmp
	cbz	w0, .LBB12_328
// %bb.322:
	ldr	w8, [x22]
	ldrb	w9, [x22, #4]
	mov	w10, #25965                     // =0x656d
	movk	w10, #26482, lsl #16
	cmp	w8, w10
	mov	w8, #101                        // =0x65
	ccmp	w9, w8, #0, eq
	b.ne	.LBB12_472
// %bb.323:
	adrp	x8, .L.str.18
	add	x8, x8, :lo12:.L.str.18
	stur	x8, [x29, #-160]
	mov	w9, #1                          // =0x1
	adrp	x8, .L.str.19
	add	x8, x8, :lo12:.L.str.19
	b	.LBB12_331
.LBB12_324:
	ldur	x8, [x29, #-80]
	ldr	w9, [x8]
	mov	w10, #28531                     // =0x6f73
	movk	w10, #29810, lsl #16
	cmp	w9, w10
	b.eq	.LBB12_330
// %bb.325:
	ldr	w9, [x8]
	mov	w10, #29557                     // =0x7375
	movk	w10, #29797, lsl #16
	cmp	w9, w10
	b.eq	.LBB12_327
// %bb.326:
	ldr	w8, [x8]
	mov	w9, #27750                      // =0x6c66
	movk	w9, #29793, lsl #16
	cmp	w8, w9
	b.ne	.LBB12_472
.LBB12_327:
	str	wzr, [sp, #232]                 // 4-byte Folded Spill
	adrp	x8, .L.str.12
	add	x8, x8, :lo12:.L.str.12
	adrp	x9, .L.str.13
	add	x9, x9, :lo12:.L.str.13
	stp	x8, x9, [x29, #-160]
	adrp	x8, .L.str.14
	add	x8, x8, :lo12:.L.str.14
	b	.LBB12_329
.LBB12_328:
	str	wzr, [sp, #232]                 // 4-byte Folded Spill
	adrp	x8, .L.str.16
	add	x8, x8, :lo12:.L.str.16
	adrp	x9, .L.str.17
	add	x9, x9, :lo12:.L.str.17
	stp	x8, x9, [x29, #-160]
	adrp	x8, .L.str.9
	add	x8, x8, :lo12:.L.str.9
.LBB12_329:
	mov	w19, #3                         // =0x3
	mov	w9, #2                          // =0x2
	b	.LBB12_332
.LBB12_330:
	adrp	x8, .L.str
	add	x8, x8, :lo12:.L.str
	stur	x8, [x29, #-160]
	mov	w9, #1                          // =0x1
	adrp	x8, .L.str.9
	add	x8, x8, :lo12:.L.str.9
.LBB12_331:
	mov	w19, #2                         // =0x2
	mov	w10, #1                         // =0x1
	str	w10, [sp, #232]                 // 4-byte Folded Spill
.LBB12_332:
	sub	x10, x29, #160
	str	x8, [x10, x9, lsl #3]
	add	x8, x19, x19, lsl #1
	lsl	x22, x8, #3
.Ltmp174:
	mov	x0, x22
	bl	_Znwm
.Ltmp175:
// %bb.333:
	mov	x26, x0
	stur	x0, [x29, #-184]
	mov	w8, #24                         // =0x18
	umaddl	x19, w19, w8, x0
	mov	w1, #0                          // =0x0
	mov	x2, x22
	bl	memset
	add	x8, x26, x22
	stp	x8, x19, [x29, #-176]
	str	x8, [sp, #200]                  // 8-byte Folded Spill
	stp	xzr, xzr, [x29, #-208]
	ldr	x19, [sp, #192]                 // 8-byte Folded Reload
	lsr	x8, x19, #60
	stur	xzr, [x29, #-192]
	cbnz	x8, .LBB12_574
// %bb.334:
	cbz	x19, .LBB12_337
// %bb.335:
	lsl	x22, x19, #3
.Ltmp177:
	mov	x0, x22
	bl	_Znwm
.Ltmp178:
// %bb.336:
	stp	x0, x0, [x29, #-208]
	add	x8, x0, x19, lsl #3
	stur	x8, [x29, #-192]
	b	.LBB12_338
.LBB12_337:
	mov	x22, #0                         // =0x0
.LBB12_338:
.Ltmp179:
	mov	x0, x22
	bl	_Znam
	str	x0, [sp, #216]                  // 8-byte Folded Spill
.Ltmp180:
// %bb.339:
	mov	x8, #0                          // =0x0
	ldp	x9, x10, [sp, #184]             // 16-byte Folded Reload
	ucvtf	d8, x10
	sub	x9, x9, #1
	str	x9, [sp, #224]                  // 8-byte Folded Spill
	stur	x28, [x29, #-24]                // 8-byte Folded Spill
	b	.LBB12_343
.LBB12_340:                             //   in Loop: Header=BB12_343 Depth=1
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x0, [x8]
	ldur	x2, [x29, #-80]
	adrp	x1, .L.str.21
	add	x1, x1, :lo12:.L.str.21
	bl	fprintf
	mov	w22, #0                         // =0x0
	mov	w8, #3                          // =0x3
	str	w8, [sp, #60]                   // 4-byte Folded Spill
	mov	x27, x25
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	cbz	x23, .LBB12_342
.LBB12_341:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x23
	bl	_ZdlPv
.LBB12_342:                             //   in Loop: Header=BB12_343 Depth=1
	add	x8, x19, #1
	tbz	w22, #0, .LBB12_415
.LBB12_343:                             // =>This Inner Loop Header: Depth=1
	mov	x19, x8
	ldr	x8, [sp, #184]                  // 8-byte Folded Reload
	cmp	x8, x19
	b.eq	.LBB12_415
// %bb.344:                             //   in Loop: Header=BB12_343 Depth=1
	udiv	x8, x19, x27
	mov	x25, x27
	msub	x27, x8, x27, x19
	mov	w8, #24                         // =0x18
	madd	x8, x27, x8, x20
	ldp	x1, x2, [x8]
.Ltmp182:
	sub	x0, x29, #208
	bl	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
.Ltmp183:
// %bb.345:                             //   in Loop: Header=BB12_343 Depth=1
	cmp	x19, #1
	b.eq	.LBB12_355
// %bb.346:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x8, [sp, #184]                  // 8-byte Folded Reload
	cmp	x8, #1
	b.eq	.LBB12_355
// %bb.347:                             //   in Loop: Header=BB12_343 Depth=1
	ldur	x2, [x29, #-72]
	cmp	x2, #5
	b.eq	.LBB12_356
.LBB12_348:                             //   in Loop: Header=BB12_343 Depth=1
	cmp	x2, #4
	b.ne	.LBB12_357
// %bb.349:                             //   in Loop: Header=BB12_343 Depth=1
	ldur	x8, [x29, #-80]
	ldr	w9, [x8]
	mov	w10, #28531                     // =0x6f73
	movk	w10, #29810, lsl #16
	cmp	w9, w10
	b.eq	.LBB12_408
// %bb.350:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	w9, [x8]
	mov	w10, #29557                     // =0x7375
	movk	w10, #29797, lsl #16
	cmp	w9, w10
	b.eq	.LBB12_411
// %bb.351:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	w8, [x8]
	mov	w9, #27750                      // =0x6c66
	movk	w9, #29793, lsl #16
	cmp	w8, w9
	b.ne	.LBB12_357
// %bb.352:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x28, x0
.Ltmp185:
	sub	x0, x29, #208
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	bl	phase_flat_insert
.Ltmp186:
// %bb.353:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x22, x0
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x23, x0
.Ltmp187:
	sub	x0, x29, #208
	mov	x1, x22
	bl	phase_flat_assign
.Ltmp188:
// %bb.354:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	scvtf	d0, x0
	str	d0, [sp, #312]
	mov	x0, x22
	bl	phase_flat_dtor
	add	x22, sp, #304
	b	.LBB12_360
.LBB12_355:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x8, #0                          // =0x0
	mov	w9, #2                          // =0x2
	movk	w9, #17236, lsl #16
	str	x9, [sp, #256]
	str	xzr, [sp, #264]
	str	xzr, [sp, #272]
	str	xzr, [sp, #280]
	str	xzr, [sp, #288]
	str	xzr, [sp, #296]
	add	x9, sp, #256
	//APP
	mov	x3, x8
	mov	x4, x9
	ror	x12, x12, #3
	ror	x12, x12, #13
	ror	x12, x12, #51
	ror	x12, x12, #61
	orr	x10, x10, x10
	mov	x8, x3
	//NO_APP
	str	x8, [sp, #248]
	ldr	x8, [sp, #248]
	ldur	x2, [x29, #-72]
	cmp	x2, #5
	b.ne	.LBB12_348
.LBB12_356:                             //   in Loop: Header=BB12_343 Depth=1
	ldur	x0, [x29, #-80]
	adrp	x1, .L.str.15
	add	x1, x1, :lo12:.L.str.15
	bl	bcmp
	cbz	w0, .LBB12_410
.LBB12_357:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x28, x0
.Ltmp197:
	sub	x0, x29, #208
	ldr	x20, [sp, #208]                 // 8-byte Folded Reload
	mov	x1, x20
	bl	phase_merge_sortdelta
.Ltmp198:
// %bb.358:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x23, x0
.Ltmp199:
	sub	x0, x29, #208
	mov	x1, x20
	bl	phase_merge_inplace
.Ltmp200:
.LBB12_359:                             //   in Loop: Header=BB12_343 Depth=1
	add	x22, sp, #312
	ldr	x20, [sp, #240]                 // 8-byte Folded Reload
.LBB12_360:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	scvtf	d0, x0
	str	d0, [x22]
	ldr	x8, [sp, #224]                  // 8-byte Folded Reload
	cmp	x8, x19
	b.ne	.LBB12_362
// %bb.361:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x8, #0                          // =0x0
	mov	w9, #2                          // =0x2
	movk	w9, #17236, lsl #16
	str	x9, [sp, #256]
	str	xzr, [sp, #264]
	str	xzr, [sp, #272]
	str	xzr, [sp, #280]
	str	xzr, [sp, #288]
	str	xzr, [sp, #296]
	add	x9, sp, #256
	//APP
	mov	x3, x8
	mov	x4, x9
	ror	x12, x12, #3
	ror	x12, x12, #13
	ror	x12, x12, #51
	ror	x12, x12, #61
	orr	x10, x10, x10
	mov	x8, x3
	//NO_APP
	str	x8, [sp, #248]
	ldr	x8, [sp, #248]
.LBB12_362:                             //   in Loop: Header=BB12_343 Depth=1
	scvtf	d0, x28
	scvtf	d10, x23
	fsub	d0, d10, d0
	fdiv	d9, d0, d8
	ldp	x8, x9, [x26, #8]
	cmp	x8, x9
	b.eq	.LBB12_375
// %bb.363:                             //   in Loop: Header=BB12_343 Depth=1
	str	d9, [x8], #8
	str	x8, [x26, #8]
	ldr	d9, [sp, #312]
	fsub	d0, d9, d10
	fdiv	d10, d0, d8
	ldp	x8, x9, [x26, #32]
	cmp	x8, x9
	b.eq	.LBB12_383
.LBB12_364:                             //   in Loop: Header=BB12_343 Depth=1
	str	d10, [x8], #8
	str	x8, [x26, #32]
	ldr	w8, [sp, #232]                  // 4-byte Folded Reload
	tbz	w8, #0, .LBB12_391
.LBB12_365:                             //   in Loop: Header=BB12_343 Depth=1
	ldp	x24, x22, [x29, #-208]
	subs	x28, x22, x24
	b.eq	.LBB12_393
.LBB12_366:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x8, #-7                         // =0xfffffffffffffff9
	movk	x8, #32767, lsl #48
	cmp	x28, x8
	b.hs	.LBB12_487
// %bb.367:                             //   in Loop: Header=BB12_343 Depth=1
.Ltmp209:
	mov	x0, x28
	bl	_Znwm
.Ltmp210:
// %bb.368:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x23, x0
	cmp	x28, #9
	b.lt	.LBB12_394
.LBB12_369:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x23
	mov	x1, x24
	mov	x2, x28
	bl	memmove
.LBB12_370:                             //   in Loop: Header=BB12_343 Depth=1
	cmp	x22, x24
	b.eq	.LBB12_396
// %bb.371:                             //   in Loop: Header=BB12_343 Depth=1
	asr	x8, x28, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp215:
	add	x1, x23, x28
	mov	x0, x23
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp216:
// %bb.372:                             //   in Loop: Header=BB12_343 Depth=1
.Ltmp217:
	add	x1, x23, x28
	mov	x0, x23
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp218:
// %bb.373:                             //   in Loop: Header=BB12_343 Depth=1
	mov	w8, #24                         // =0x18
	madd	x8, x27, x8, x21
	ldp	x1, x9, [x8]
	sub	x8, x9, x1
	cmp	x28, x8
	b.ne	.LBB12_340
// %bb.374:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x23
	mov	x2, x28
	bl	bcmp
	cbz	w0, .LBB12_397
	b	.LBB12_340
.LBB12_375:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x28, [x26]
	sub	x23, x8, x28
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.eq	.LBB12_534
// %bb.376:                             //   in Loop: Header=BB12_343 Depth=1
	asr	x20, x23, #3
	cmp	x20, #1
	csinc	x8, x20, xzr, hi
	adds	x9, x8, x20
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cmn	x8, x20
	csel	x22, x10, x9, hs
	cbz	x22, .LBB12_406
// %bb.377:                             //   in Loop: Header=BB12_343 Depth=1
	lsl	x0, x22, #3
.Ltmp202:
	bl	_Znwm
.Ltmp203:
// %bb.378:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, x0
	str	d9, [x0, x20, lsl #3]
	cmp	x23, #1
	b.lt	.LBB12_380
.LBB12_379:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x24
	mov	x1, x28
	mov	x2, x23
	bl	memmove
.LBB12_380:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x20, [sp, #240]                 // 8-byte Folded Reload
	cbz	x28, .LBB12_382
// %bb.381:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x28
	bl	_ZdlPv
.LBB12_382:                             //   in Loop: Header=BB12_343 Depth=1
	add	x8, x24, x23
	add	x8, x8, #8
	stp	x24, x8, [x26]
	add	x8, x24, x22, lsl #3
	str	x8, [x26, #16]
	ldr	d9, [sp, #312]
	fsub	d0, d9, d10
	fdiv	d10, d0, d8
	ldp	x8, x9, [x26, #32]
	cmp	x8, x9
	b.ne	.LBB12_364
.LBB12_383:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x28, [x26, #24]
	sub	x23, x8, x28
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.eq	.LBB12_534
// %bb.384:                             //   in Loop: Header=BB12_343 Depth=1
	asr	x20, x23, #3
	cmp	x20, #1
	csinc	x8, x20, xzr, hi
	adds	x9, x8, x20
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cmn	x8, x20
	csel	x22, x10, x9, hs
	cbz	x22, .LBB12_407
// %bb.385:                             //   in Loop: Header=BB12_343 Depth=1
	lsl	x0, x22, #3
.Ltmp204:
	bl	_Znwm
.Ltmp205:
// %bb.386:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, x0
	str	d10, [x0, x20, lsl #3]
	cmp	x23, #1
	b.lt	.LBB12_388
.LBB12_387:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x24
	mov	x1, x28
	mov	x2, x23
	bl	memmove
.LBB12_388:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x20, [sp, #240]                 // 8-byte Folded Reload
	cbz	x28, .LBB12_390
// %bb.389:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x28
	bl	_ZdlPv
.LBB12_390:                             //   in Loop: Header=BB12_343 Depth=1
	add	x8, x24, x23
	add	x8, x8, #8
	stp	x24, x8, [x26, #24]
	add	x8, x24, x22, lsl #3
	str	x8, [x26, #40]
	ldr	w8, [sp, #232]                  // 4-byte Folded Reload
	tbnz	w8, #0, .LBB12_365
.LBB12_391:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	d0, [sp, #304]
	fsub	d0, d0, d9
	fdiv	d9, d0, d8
	ldp	x8, x9, [x26, #56]
	cmp	x8, x9
	b.eq	.LBB12_398
// %bb.392:                             //   in Loop: Header=BB12_343 Depth=1
	str	d9, [x8], #8
	str	x8, [x26, #56]
	ldp	x24, x22, [x29, #-208]
	subs	x28, x22, x24
	b.ne	.LBB12_366
.LBB12_393:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x23, #0                         // =0x0
	cmp	x28, #9
	b.ge	.LBB12_369
.LBB12_394:                             //   in Loop: Header=BB12_343 Depth=1
	cmp	x28, #8
	b.ne	.LBB12_370
// %bb.395:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x8, [x24]
	str	x8, [x23]
	b	.LBB12_370
.LBB12_396:                             //   in Loop: Header=BB12_343 Depth=1
	mov	w8, #24                         // =0x18
	madd	x8, x27, x8, x21
	ldp	x8, x9, [x8]
	sub	x8, x9, x8
	cmp	x28, x8
	b.ne	.LBB12_340
.LBB12_397:                             //   in Loop: Header=BB12_343 Depth=1
	mov	w22, #1                         // =0x1
	mov	x27, x25
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	cbnz	x23, .LBB12_341
	b	.LBB12_342
.LBB12_398:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x28, [x26, #48]
	sub	x23, x8, x28
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.eq	.LBB12_534
// %bb.399:                             //   in Loop: Header=BB12_343 Depth=1
	asr	x20, x23, #3
	cmp	x20, #1
	csinc	x8, x20, xzr, hi
	adds	x9, x8, x20
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cmn	x8, x20
	csel	x22, x10, x9, hs
	cbz	x22, .LBB12_414
// %bb.400:                             //   in Loop: Header=BB12_343 Depth=1
	lsl	x0, x22, #3
.Ltmp206:
	bl	_Znwm
.Ltmp207:
// %bb.401:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, x0
	str	d9, [x0, x20, lsl #3]
	cmp	x23, #1
	b.lt	.LBB12_403
.LBB12_402:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x24
	mov	x1, x28
	mov	x2, x23
	bl	memmove
.LBB12_403:                             //   in Loop: Header=BB12_343 Depth=1
	ldr	x20, [sp, #240]                 // 8-byte Folded Reload
	cbz	x28, .LBB12_405
// %bb.404:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x0, x28
	bl	_ZdlPv
.LBB12_405:                             //   in Loop: Header=BB12_343 Depth=1
	add	x8, x24, x23
	add	x8, x8, #8
	stp	x24, x8, [x26, #48]
	add	x8, x24, x22, lsl #3
	str	x8, [x26, #64]
	ldp	x24, x22, [x29, #-208]
	subs	x28, x22, x24
	b.ne	.LBB12_366
	b	.LBB12_393
.LBB12_406:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, #0                         // =0x0
	str	d9, [x24, x20, lsl #3]
	cmp	x23, #1
	b.ge	.LBB12_379
	b	.LBB12_380
.LBB12_407:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, #0                         // =0x0
	str	d10, [x24, x20, lsl #3]
	cmp	x23, #1
	b.ge	.LBB12_387
	b	.LBB12_388
.LBB12_408:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x28, x0
.Ltmp195:
	sub	x0, x29, #208
	bl	phase_sort
.Ltmp196:
// %bb.409:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x23, x0
	sub	x0, x29, #208
	bl	phase_unique
	b	.LBB12_359
.LBB12_410:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x28, x0
	sub	x0, x29, #208
	add	x1, sp, #320
	bl	phase_radix_count
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x23, x0
	sub	x0, x29, #208
	add	x2, sp, #320
	ldr	x1, [sp, #216]                  // 8-byte Folded Reload
	bl	phase_radix_scatter
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	scvtf	d0, x0
	str	d0, [sp, #312]
	sub	x0, x29, #208
	bl	phase_unique
	add	x22, sp, #304
	b	.LBB12_360
.LBB12_411:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x28, x0
.Ltmp190:
	sub	x0, x29, #208
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	bl	phase_uset_insert
.Ltmp191:
// %bb.412:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x22, x0
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	mov	x23, x0
.Ltmp192:
	sub	x0, x29, #208
	mov	x1, x22
	bl	phase_uset_assign
.Ltmp193:
// %bb.413:                             //   in Loop: Header=BB12_343 Depth=1
	bl	_ZNSt6chrono3_V212steady_clock3nowEv
	scvtf	d0, x0
	str	d0, [sp, #312]
	mov	x0, x22
	bl	phase_uset_dtor
	add	x22, sp, #304
	b	.LBB12_360
.LBB12_414:                             //   in Loop: Header=BB12_343 Depth=1
	mov	x24, #0                         // =0x0
	str	d9, [x24, x20, lsl #3]
	cmp	x23, #1
	b.ge	.LBB12_402
	b	.LBB12_403
.LBB12_415:
	ldr	x8, [sp, #184]                  // 8-byte Folded Reload
	cmp	x19, x8
	b.lo	.LBB12_448
// %bb.416:
	ldp	x24, x8, [x26]
	subs	x23, x8, x24
	b.eq	.LBB12_463
// %bb.417:
	mov	x8, #-7                         // =0xfffffffffffffff9
	movk	x8, #32767, lsl #48
	cmp	x23, x8
	b.hs	.LBB12_503
// %bb.418:
.Ltmp223:
	mov	x0, x23
	bl	_Znwm
.Ltmp224:
// %bb.419:
	mov	x22, x0
	subs	x27, x23, #8
	b.le	.LBB12_464
.LBB12_420:
	mov	x0, x22
	mov	x1, x24
	mov	x2, x23
	bl	memmove
	cmp	x23, #17
	b.lo	.LBB12_509
// %bb.421:
	add	x1, x22, #8
	mov	x0, x22
	mov	x2, x27
	bl	memmove
.LBB12_422:
	add	x8, x22, x23
	sub	x23, x8, #8
	sub	x8, x23, x22
	asr	x19, x8, #3
	cmp	x22, x23
	b.eq	.LBB12_425
.LBB12_423:
	clz	x8, x19
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp225:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp226:
// %bb.424:
.Ltmp227:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp228:
.LBB12_425:
	ldur	x1, [x29, #-80]
	ldur	x2, [x29, #-160]
	lsl	x8, x19, #2
	and	x8, x8, #0xfffffffffffffff8
	ldr	d0, [x22, x8]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	ldr	x3, [sp, #192]                  // 8-byte Folded Reload
	mov	x4, x28
	bl	printf
	mov	x0, x22
	bl	_ZdlPv
	ldp	x24, x8, [x26, #24]
	subs	x23, x8, x24
	b.eq	.LBB12_466
// %bb.426:
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.hi	.LBB12_503
// %bb.427:
.Ltmp229:
	mov	x0, x23
	bl	_Znwm
.Ltmp230:
// %bb.428:
	mov	x22, x0
	subs	x27, x23, #8
	b.le	.LBB12_467
.LBB12_429:
	mov	x0, x22
	mov	x1, x24
	mov	x2, x23
	bl	memmove
	cmp	x23, #16
	b.ls	.LBB12_511
// %bb.430:
	add	x1, x22, #8
	mov	x0, x22
	mov	x2, x27
	bl	memmove
.LBB12_431:
	add	x8, x22, x23
	sub	x23, x8, #8
.LBB12_432:
	sub	x8, x23, x22
	asr	x19, x8, #3
	cmp	x22, x23
	b.eq	.LBB12_435
// %bb.433:
	clz	x8, x19
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp231:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp232:
// %bb.434:
.Ltmp233:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp234:
.LBB12_435:
	ldur	x1, [x29, #-80]
	ldur	x2, [x29, #-152]
	lsl	x8, x19, #2
	and	x8, x8, #0xfffffffffffffff8
	ldr	d0, [x22, x8]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	ldr	x3, [sp, #192]                  // 8-byte Folded Reload
	mov	x4, x28
	bl	printf
	mov	x0, x22
	bl	_ZdlPv
	ldr	w8, [sp, #232]                  // 4-byte Folded Reload
	tbnz	w8, #0, .LBB12_447
// %bb.436:
	ldp	x24, x8, [x26, #48]
	subs	x23, x8, x24
	b.eq	.LBB12_469
// %bb.437:
	mov	x8, #9223372036854775800        // =0x7ffffffffffffff8
	cmp	x23, x8
	b.hi	.LBB12_503
// %bb.438:
.Ltmp235:
	mov	x0, x23
	bl	_Znwm
.Ltmp236:
// %bb.439:
	mov	x22, x0
	subs	x27, x23, #8
	b.le	.LBB12_470
.LBB12_440:
	mov	x0, x22
	mov	x1, x24
	mov	x2, x23
	bl	memmove
	cmp	x23, #16
	b.ls	.LBB12_519
// %bb.441:
	add	x1, x22, #8
	mov	x0, x22
	mov	x2, x27
	bl	memmove
.LBB12_442:
	add	x8, x22, x23
	sub	x23, x8, #8
.LBB12_443:
	sub	x8, x23, x22
	asr	x19, x8, #3
	cmp	x22, x23
	b.eq	.LBB12_446
// %bb.444:
	clz	x8, x19
	mov	w9, #126                        // =0x7e
	sub	x2, x9, x8, lsl #1
.Ltmp241:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
.Ltmp242:
// %bb.445:
.Ltmp243:
	mov	x0, x22
	mov	x1, x23
	bl	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
.Ltmp244:
.LBB12_446:
	ldur	x1, [x29, #-80]
	ldur	x2, [x29, #-144]
	lsl	x8, x19, #2
	and	x8, x8, #0xfffffffffffffff8
	ldr	d0, [x22, x8]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	ldr	x3, [sp, #192]                  // 8-byte Folded Reload
	mov	x4, x28
	bl	printf
	mov	x0, x22
	bl	_ZdlPv
.LBB12_447:
	str	wzr, [sp, #60]                  // 4-byte Folded Spill
.LBB12_448:
	ldr	x0, [sp, #216]                  // 8-byte Folded Reload
	bl	_ZdaPv
	ldur	x0, [x29, #-208]
	cbz	x0, .LBB12_450
// %bb.449:
	bl	_ZdlPv
.LBB12_450:
	ldr	x0, [x26]
	ldr	x19, [sp, #200]                 // 8-byte Folded Reload
	cbz	x0, .LBB12_452
// %bb.451:
	bl	_ZdlPv
.LBB12_452:
	add	x8, x26, #24
	cmp	x8, x19
	ldr	w22, [sp, #60]                  // 4-byte Folded Reload
	b.eq	.LBB12_458
// %bb.453:
	ldr	x0, [x8]
	cbz	x0, .LBB12_455
// %bb.454:
	bl	_ZdlPv
.LBB12_455:
	add	x8, x26, #48
	cmp	x8, x19
	b.eq	.LBB12_458
// %bb.456:
	ldr	x0, [x8]
	cbz	x0, .LBB12_458
// %bb.457:
	bl	_ZdlPv
.LBB12_458:
	mov	x0, x26
	bl	_ZdlPv
	ldur	x19, [x29, #-120]
	cmp	x21, x19
	b.eq	.LBB12_473
.LBB12_459:
	mov	x20, x21
	b	.LBB12_461
.LBB12_460:                             //   in Loop: Header=BB12_461 Depth=1
	add	x20, x20, #24
	cmp	x20, x19
	b.eq	.LBB12_473
.LBB12_461:                             // =>This Inner Loop Header: Depth=1
	ldr	x0, [x20]
	cbz	x0, .LBB12_460
// %bb.462:                             //   in Loop: Header=BB12_461 Depth=1
	bl	_ZdlPv
	b	.LBB12_460
.LBB12_463:
	mov	x22, #0                         // =0x0
	subs	x27, x23, #8
	b.gt	.LBB12_420
.LBB12_464:
	b.ne	.LBB12_515
// %bb.465:
	ldr	d0, [x24]
	str	d0, [x22]
	b	.LBB12_516
.LBB12_466:
	mov	x22, #0                         // =0x0
	subs	x27, x23, #8
	b.gt	.LBB12_429
.LBB12_467:
	b.ne	.LBB12_517
// %bb.468:
	ldr	d0, [x24]
	str	d0, [x22]
	add	x23, x22, x23
	b	.LBB12_432
.LBB12_469:
	mov	x22, #0                         // =0x0
	subs	x27, x23, #8
	b.gt	.LBB12_440
.LBB12_470:
	b.ne	.LBB12_521
// %bb.471:
	ldr	d0, [x24]
	str	d0, [x22]
	add	x23, x22, x23
	b	.LBB12_443
.LBB12_472:
	adrp	x8, :got:stderr
	ldr	x8, [x8, :got_lo12:stderr]
	ldr	x3, [x8]
	adrp	x0, .L.str.20
	add	x0, x0, :lo12:.L.str.20
	mov	w1, #12                         // =0xc
	mov	w2, #1                          // =0x1
	bl	fwrite
	mov	w22, #2                         // =0x2
	ldur	x19, [x29, #-120]
	cmp	x21, x19
	b.ne	.LBB12_459
.LBB12_473:
	ldr	x8, [sp, #240]                  // 8-byte Folded Reload
	cbz	x21, .LBB12_475
// %bb.474:
	mov	x0, x21
	bl	_ZdlPv
	ldur	x8, [x29, #-104]
.LBB12_475:
	ldur	x19, [x29, #-96]
	mov	x21, x8
	cmp	x8, x19
	b.eq	.LBB12_480
// %bb.476:
	mov	x20, x21
	b	.LBB12_478
.LBB12_477:                             //   in Loop: Header=BB12_478 Depth=1
	add	x20, x20, #24
	cmp	x20, x19
	b.eq	.LBB12_480
.LBB12_478:                             // =>This Inner Loop Header: Depth=1
	ldr	x0, [x20]
	cbz	x0, .LBB12_477
// %bb.479:                             //   in Loop: Header=BB12_478 Depth=1
	bl	_ZdlPv
	b	.LBB12_477
.LBB12_480:
	cbz	x21, .LBB12_482
// %bb.481:
	mov	x0, x21
	bl	_ZdlPv
.LBB12_482:
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.eq	.LBB12_484
// %bb.483:
	bl	_ZdlPv
.LBB12_484:
	mov	x0, x22
	add	sp, sp, #2, lsl #12             // =8192
	add	sp, sp, #496
	.cfi_def_cfa wsp, 128
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	ldp	d9, d8, [sp, #16]               // 16-byte Folded Reload
	ldr	d10, [sp], #128                 // 8-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	.cfi_restore b9
	.cfi_restore b10
	ret
.LBB12_485:
	.cfi_restore_state
.Ltmp154:
	bl	_ZSt28__throw_bad_array_new_lengthv
.Ltmp155:
// %bb.486:
.LBB12_487:
.Ltmp212:
	bl	_ZSt28__throw_bad_array_new_lengthv
.Ltmp213:
// %bb.488:
.LBB12_489:
.Ltmp249:
	bl	_ZSt17__throw_bad_allocv
.Ltmp250:
// %bb.490:
.LBB12_491:
.Ltmp137:
	bl	_ZSt28__throw_bad_array_new_lengthv
.Ltmp138:
// %bb.492:
.LBB12_493:
.Ltmp146:
	bl	_ZSt28__throw_bad_array_new_lengthv
.Ltmp147:
// %bb.494:
.LBB12_495:
.Ltmp44:
	bl	_ZSt17__throw_bad_allocv
.Ltmp45:
// %bb.496:
.LBB12_497:
.Ltmp84:
	bl	_ZSt17__throw_bad_allocv
.Ltmp85:
// %bb.498:
.LBB12_499:
.Ltmp29:
	bl	_ZSt17__throw_bad_allocv
.Ltmp30:
// %bb.500:
.LBB12_501:
.Ltmp14:
	bl	_ZSt17__throw_bad_allocv
.Ltmp15:
// %bb.502:
.LBB12_503:
.Ltmp238:
	bl	_ZSt28__throw_bad_array_new_lengthv
.Ltmp239:
// %bb.504:
.LBB12_505:
.Ltmp59:
	bl	_ZSt17__throw_bad_allocv
.Ltmp60:
// %bb.506:
.LBB12_507:
.Ltmp74:
	bl	_ZSt17__throw_bad_allocv
.Ltmp75:
// %bb.508:
.LBB12_509:
	cmp	x27, #8
	b.ne	.LBB12_422
// %bb.510:
	ldr	d0, [x22, #8]
	str	d0, [x22]
	b	.LBB12_422
.LBB12_511:
	cmp	x27, #8
	b.ne	.LBB12_431
// %bb.512:
	ldr	d0, [x22, #8]
	str	d0, [x22]
	b	.LBB12_431
.LBB12_513:
.Ltmp108:
	adrp	x0, .L.str.31
	add	x0, x0, :lo12:.L.str.31
	bl	_ZSt20__throw_length_errorPKc
.Ltmp109:
// %bb.514:
.LBB12_515:
	cmp	x23, #8
	b.hi	.LBB12_422
.LBB12_516:
	add	x23, x22, x23
	sub	x8, x23, x22
	asr	x19, x8, #3
	cmp	x22, x23
	b.ne	.LBB12_423
	b	.LBB12_425
.LBB12_517:
	cmp	x23, #8
	b.hi	.LBB12_431
// %bb.518:
	add	x23, x22, x23
	b	.LBB12_432
.LBB12_519:
	cmp	x27, #8
	b.ne	.LBB12_442
// %bb.520:
	ldr	d0, [x22, #8]
	str	d0, [x22]
	b	.LBB12_442
.LBB12_521:
	cmp	x23, #8
	b.ls	.LBB12_529
// %bb.522:
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	b	.LBB12_442
.LBB12_523:
.Ltmp128:
	adrp	x0, .L.str.29
	add	x0, x0, :lo12:.L.str.29
	bl	_ZSt20__throw_length_errorPKc
.Ltmp129:
// %bb.524:
.LBB12_525:
.Ltmp165:
	adrp	x0, .L.str.29
	add	x0, x0, :lo12:.L.str.29
	bl	_ZSt20__throw_length_errorPKc
.Ltmp166:
// %bb.526:
.LBB12_527:
.Ltmp162:
	adrp	x0, .L.str.29
	add	x0, x0, :lo12:.L.str.29
	bl	_ZSt20__throw_length_errorPKc
.Ltmp163:
// %bb.528:
.LBB12_529:
	add	x23, x22, x23
	ldur	x28, [x29, #-24]                // 8-byte Folded Reload
	b	.LBB12_443
.LBB12_530:
.Ltmp171:
	adrp	x0, .L.str.23
	add	x0, x0, :lo12:.L.str.23
	bl	_ZSt20__throw_length_errorPKc
.Ltmp172:
// %bb.531:
.LBB12_532:
.Ltmp111:
	adrp	x0, .L.str.32
	add	x0, x0, :lo12:.L.str.32
	bl	_ZSt20__throw_length_errorPKc
.Ltmp112:
// %bb.533:
.LBB12_534:
.Ltmp220:
	adrp	x0, .L.str.29
	add	x0, x0, :lo12:.L.str.29
	bl	_ZSt20__throw_length_errorPKc
.Ltmp221:
// %bb.535:
.LBB12_536:
.Ltmp253:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp254:
// %bb.537:
.LBB12_538:
.Ltmp251:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp252:
// %bb.539:
.LBB12_540:
.Ltmp168:
	adrp	x0, .L.str.32
	add	x0, x0, :lo12:.L.str.32
	bl	_ZSt20__throw_length_errorPKc
.Ltmp169:
// %bb.541:
.LBB12_542:
.Ltmp48:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp49:
// %bb.543:
.LBB12_544:
.Ltmp88:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp89:
// %bb.545:
.LBB12_546:
.Ltmp33:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp34:
// %bb.547:
.LBB12_548:
.Ltmp18:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp19:
// %bb.549:
.LBB12_550:
.Ltmp11:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt24__throw_invalid_argumentPKc
.Ltmp12:
// %bb.551:
.LBB12_552:
.Ltmp41:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt24__throw_invalid_argumentPKc
.Ltmp42:
// %bb.553:
.LBB12_554:
.Ltmp26:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt24__throw_invalid_argumentPKc
.Ltmp27:
// %bb.555:
.LBB12_556:
.Ltmp63:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp64:
// %bb.557:
.LBB12_558:
.Ltmp56:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt24__throw_invalid_argumentPKc
.Ltmp57:
// %bb.559:
.LBB12_560:
.Ltmp31:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp32:
// %bb.561:
.LBB12_562:
.Ltmp46:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp47:
// %bb.563:
.LBB12_564:
.Ltmp86:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp87:
// %bb.565:
.LBB12_566:
.Ltmp16:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp17:
// %bb.567:
.LBB12_568:
.Ltmp9:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt20__throw_out_of_rangePKc
.Ltmp10:
// %bb.569:
.LBB12_570:
.Ltmp24:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt20__throw_out_of_rangePKc
.Ltmp25:
// %bb.571:
.LBB12_572:
.Ltmp39:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt20__throw_out_of_rangePKc
.Ltmp40:
// %bb.573:
.LBB12_574:
.Ltmp246:
	adrp	x0, .L.str.32
	add	x0, x0, :lo12:.L.str.32
	bl	_ZSt20__throw_length_errorPKc
.Ltmp247:
// %bb.575:
.LBB12_576:
.Ltmp78:
	adrp	x0, .L.str.26
	add	x0, x0, :lo12:.L.str.26
	bl	_ZSt19__throw_logic_errorPKc
.Ltmp79:
// %bb.577:
.LBB12_578:
.Ltmp71:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt24__throw_invalid_argumentPKc
.Ltmp72:
// %bb.579:
.LBB12_580:
.Ltmp61:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp62:
// %bb.581:
.LBB12_582:
.Ltmp54:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt20__throw_out_of_rangePKc
.Ltmp55:
// %bb.583:
.LBB12_584:
.Ltmp76:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	bl	_ZSt20__throw_length_errorPKc
.Ltmp77:
// %bb.585:
.LBB12_586:
.Ltmp69:
	adrp	x0, .L.str.28
	add	x0, x0, :lo12:.L.str.28
	bl	_ZSt20__throw_out_of_rangePKc
.Ltmp70:
// %bb.587:
.LBB12_588:
.Ltmp68:
	b	.LBB12_661
.LBB12_589:
.Ltmp53:
	b	.LBB12_661
.LBB12_590:
.Ltmp237:
	b	.LBB12_674
.LBB12_591:
.Ltmp96:
	mov	x19, x0
	b	.LBB12_682
.LBB12_592:
.Ltmp93:
	b	.LBB12_672
.LBB12_593:
.Ltmp181:
	mov	x19, x0
	b	.LBB12_676
.LBB12_594:
.Ltmp176:
	b	.LBB12_680
.LBB12_595:
.Ltmp38:
	b	.LBB12_661
.LBB12_596:
.Ltmp23:
	b	.LBB12_661
.LBB12_597:
.Ltmp8:
	b	.LBB12_661
.LBB12_598:
.Ltmp83:
	b	.LBB12_661
.LBB12_599:
.Ltmp73:
	mov	x19, x0
	ldr	w8, [x23]
	cbnz	w8, .LBB12_612
// %bb.600:
	str	w26, [x23]
	b	.LBB12_612
.LBB12_601:
.Ltmp189:
	b	.LBB12_674
.LBB12_602:
.Ltmp245:
	mov	x19, x0
	cbz	x22, .LBB12_675
// %bb.603:
	mov	x0, x22
	bl	_ZdlPv
	b	.LBB12_675
.LBB12_604:
.Ltmp248:
	mov	x19, x0
	b	.LBB12_676
.LBB12_605:
.Ltmp58:
	mov	x19, x0
	ldr	w8, [x23]
	cbnz	w8, .LBB12_612
	b	.LBB12_611
.LBB12_606:
.Ltmp194:
	b	.LBB12_674
.LBB12_607:
.Ltmp124:
	mov	x19, x0
	cbnz	x28, .LBB12_668
	b	.LBB12_681
.LBB12_608:
.Ltmp28:
	mov	x19, x0
	ldr	w8, [x23]
	cbnz	w8, .LBB12_612
	b	.LBB12_611
.LBB12_609:
.Ltmp43:
	mov	x19, x0
	ldr	w8, [x23]
	cbnz	w8, .LBB12_612
	b	.LBB12_611
.LBB12_610:
.Ltmp13:
	mov	x19, x0
	ldr	w8, [x23]
	cbnz	w8, .LBB12_612
.LBB12_611:
	str	w20, [x23]
.LBB12_612:
	ldr	x0, [sp, #256]
	cmp	x0, x21
	b.eq	.LBB12_662
// %bb.613:
	bl	_ZdlPv
	b	.LBB12_662
.LBB12_614:
.Ltmp145:
	mov	x19, x0
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x22, .LBB12_618
	b	.LBB12_670
.LBB12_615:
.Ltmp136:
	mov	x19, x0
	cbz	x27, .LBB12_619
	b	.LBB12_667
.LBB12_616:
.Ltmp150:
	mov	x19, x0
	ldr	x0, [sp, #320]
	cbnz	x0, .LBB12_620
// %bb.617:
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbnz	x22, .LBB12_670
.LBB12_618:
	cbnz	x27, .LBB12_667
.LBB12_619:
	cbnz	x28, .LBB12_668
	b	.LBB12_681
.LBB12_620:
	bl	_ZdlPv
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x22, .LBB12_618
	b	.LBB12_670
.LBB12_621:
.Ltmp170:
	mov	x19, x0
	cbnz	x28, .LBB12_668
	b	.LBB12_681
.LBB12_622:
.Ltmp5:
	b	.LBB12_672
.LBB12_623:
.Ltmp121:
	mov	x19, x0
	b	.LBB12_668
.LBB12_624:
.Ltmp208:
	b	.LBB12_674
.LBB12_625:
.Ltmp211:
	b	.LBB12_674
.LBB12_626:
.Ltmp222:
	b	.LBB12_674
.LBB12_627:
.Ltmp104:
	b	.LBB12_639
.LBB12_628:
.Ltmp101:
	mov	x19, x0
	b	.LBB12_653
.LBB12_629:
.Ltmp184:
	b	.LBB12_674
.LBB12_630:
.Ltmp153:
	b	.LBB12_680
.LBB12_631:
.Ltmp116:
	b	.LBB12_680
.LBB12_632:
.Ltmp219:
	mov	x19, x0
	cbz	x23, .LBB12_675
// %bb.633:
	mov	x0, x23
	bl	_ZdlPv
	b	.LBB12_675
.LBB12_634:
.Ltmp142:
	mov	x19, x0
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x22, .LBB12_618
	b	.LBB12_670
.LBB12_635:
.Ltmp127:
	b	.LBB12_644
.LBB12_636:
.Ltmp133:
	b	.LBB12_642
.LBB12_637:
.Ltmp201:
	b	.LBB12_674
.LBB12_638:
.Ltmp113:
.LBB12_639:
	mov	x19, x0
	cbnz	x21, .LBB12_651
	b	.LBB12_652
.LBB12_640:
.Ltmp173:
	b	.LBB12_680
.LBB12_641:
.Ltmp167:
.LBB12_642:
	mov	x19, x0
	mov	x27, x24
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x24, .LBB12_619
	b	.LBB12_667
.LBB12_643:
.Ltmp130:
.LBB12_644:
	mov	x19, x0
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x27, .LBB12_619
	b	.LBB12_667
.LBB12_645:
.Ltmp161:
	mov	x19, x0
	cbz	x23, .LBB12_681
// %bb.646:
	mov	x0, x23
	bl	_ZdlPv
	b	.LBB12_681
.LBB12_647:
.Ltmp107:
	b	.LBB12_649
.LBB12_648:
.Ltmp110:
.LBB12_649:
	mov	x19, x0
	ldr	x0, [sp, #320]
	cbz	x0, .LBB12_651
// %bb.650:
	bl	_ZdlPv
.LBB12_651:
	mov	x0, x21
	bl	_ZdlPv
.LBB12_652:
	cbz	x20, .LBB12_681
.LBB12_653:
	mov	x0, x20
	bl	_ZdlPv
	b	.LBB12_681
.LBB12_654:
.Ltmp80:
	b	.LBB12_661
.LBB12_655:
.Ltmp65:
	b	.LBB12_661
.LBB12_656:
.Ltmp240:
	b	.LBB12_674
.LBB12_657:
.Ltmp20:
	b	.LBB12_661
.LBB12_658:
.Ltmp35:
	b	.LBB12_661
.LBB12_659:
.Ltmp90:
	b	.LBB12_661
.LBB12_660:
.Ltmp50:
.LBB12_661:
	mov	x19, x0
.LBB12_662:
	ldr	x0, [sp, #320]
	cmp	x0, x28
	b.ne	.LBB12_665
// %bb.663:
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.ne	.LBB12_683
.LBB12_664:
	mov	x0, x19
	bl	_Unwind_Resume
.LBB12_665:
	bl	_ZdlPv
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.eq	.LBB12_664
	b	.LBB12_683
.LBB12_666:
.Ltmp139:
	mov	x19, x0
	cbz	x27, .LBB12_619
.LBB12_667:
	mov	x0, x27
	bl	_ZdlPv
	cbz	x28, .LBB12_681
.LBB12_668:
	mov	x0, x28
	bl	_ZdlPv
	b	.LBB12_681
.LBB12_669:
.Ltmp164:
	mov	x19, x0
	ldr	x28, [sp, #232]                 // 8-byte Folded Reload
	cbz	x22, .LBB12_618
.LBB12_670:
	mov	x0, x22
	bl	_ZdlPv
	cbz	x27, .LBB12_619
	b	.LBB12_667
.LBB12_671:
.Ltmp255:
.LBB12_672:
	mov	x19, x0
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.eq	.LBB12_664
	b	.LBB12_683
.LBB12_673:
.Ltmp214:
.LBB12_674:
	mov	x19, x0
.LBB12_675:
	ldr	x0, [sp, #216]                  // 8-byte Folded Reload
	bl	_ZdaPv
.LBB12_676:
	ldur	x0, [x29, #-208]
	cbz	x0, .LBB12_678
// %bb.677:
	bl	_ZdlPv
.LBB12_678:
	sub	x0, x29, #184
	bl	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	b	.LBB12_681
.LBB12_679:
.Ltmp156:
.LBB12_680:
	mov	x19, x0
.LBB12_681:
	sub	x0, x29, #128
	bl	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
.LBB12_682:
	sub	x0, x29, #104
	bl	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	ldur	x0, [x29, #-80]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	cmp	x0, x8
	b.eq	.LBB12_664
.LBB12_683:
	bl	_ZdlPv
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end12:
	.size	main, .Lfunc_end12-main
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table12:
.Lexception1:
	.byte	255                             // @LPStart Encoding = omit
	.byte	255                             // @TType Encoding = omit
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Ltmp3-.Lfunc_begin1           // >> Call Site 1 <<
	.uleb128 .Ltmp4-.Ltmp3                  //   Call between .Ltmp3 and .Ltmp4
	.uleb128 .Ltmp5-.Lfunc_begin1           //     jumps to .Ltmp5
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp36-.Lfunc_begin1          // >> Call Site 2 <<
	.uleb128 .Ltmp37-.Ltmp36                //   Call between .Ltmp36 and .Ltmp37
	.uleb128 .Ltmp38-.Lfunc_begin1          //     jumps to .Ltmp38
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp37-.Lfunc_begin1          // >> Call Site 3 <<
	.uleb128 .Ltmp81-.Ltmp37                //   Call between .Ltmp37 and .Ltmp81
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp81-.Lfunc_begin1          // >> Call Site 4 <<
	.uleb128 .Ltmp82-.Ltmp81                //   Call between .Ltmp81 and .Ltmp82
	.uleb128 .Ltmp83-.Lfunc_begin1          //     jumps to .Ltmp83
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp21-.Lfunc_begin1          // >> Call Site 5 <<
	.uleb128 .Ltmp22-.Ltmp21                //   Call between .Ltmp21 and .Ltmp22
	.uleb128 .Ltmp23-.Lfunc_begin1          //     jumps to .Ltmp23
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp51-.Lfunc_begin1          // >> Call Site 6 <<
	.uleb128 .Ltmp52-.Ltmp51                //   Call between .Ltmp51 and .Ltmp52
	.uleb128 .Ltmp53-.Lfunc_begin1          //     jumps to .Ltmp53
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp6-.Lfunc_begin1           // >> Call Site 7 <<
	.uleb128 .Ltmp7-.Ltmp6                  //   Call between .Ltmp6 and .Ltmp7
	.uleb128 .Ltmp8-.Lfunc_begin1           //     jumps to .Ltmp8
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp66-.Lfunc_begin1          // >> Call Site 8 <<
	.uleb128 .Ltmp67-.Ltmp66                //   Call between .Ltmp66 and .Ltmp67
	.uleb128 .Ltmp68-.Lfunc_begin1          //     jumps to .Ltmp68
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp67-.Lfunc_begin1          // >> Call Site 9 <<
	.uleb128 .Ltmp91-.Ltmp67                //   Call between .Ltmp67 and .Ltmp91
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp91-.Lfunc_begin1          // >> Call Site 10 <<
	.uleb128 .Ltmp92-.Ltmp91                //   Call between .Ltmp91 and .Ltmp92
	.uleb128 .Ltmp93-.Lfunc_begin1          //     jumps to .Ltmp93
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp92-.Lfunc_begin1          // >> Call Site 11 <<
	.uleb128 .Ltmp94-.Ltmp92                //   Call between .Ltmp92 and .Ltmp94
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp94-.Lfunc_begin1          // >> Call Site 12 <<
	.uleb128 .Ltmp95-.Ltmp94                //   Call between .Ltmp94 and .Ltmp95
	.uleb128 .Ltmp96-.Lfunc_begin1          //     jumps to .Ltmp96
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp95-.Lfunc_begin1          // >> Call Site 13 <<
	.uleb128 .Ltmp97-.Ltmp95                //   Call between .Ltmp95 and .Ltmp97
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp97-.Lfunc_begin1          // >> Call Site 14 <<
	.uleb128 .Ltmp98-.Ltmp97                //   Call between .Ltmp97 and .Ltmp98
	.uleb128 .Ltmp116-.Lfunc_begin1         //     jumps to .Ltmp116
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp98-.Lfunc_begin1          // >> Call Site 15 <<
	.uleb128 .Ltmp99-.Ltmp98                //   Call between .Ltmp98 and .Ltmp99
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp99-.Lfunc_begin1          // >> Call Site 16 <<
	.uleb128 .Ltmp100-.Ltmp99               //   Call between .Ltmp99 and .Ltmp100
	.uleb128 .Ltmp101-.Lfunc_begin1         //     jumps to .Ltmp101
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp102-.Lfunc_begin1         // >> Call Site 17 <<
	.uleb128 .Ltmp103-.Ltmp102              //   Call between .Ltmp102 and .Ltmp103
	.uleb128 .Ltmp104-.Lfunc_begin1         //     jumps to .Ltmp104
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp114-.Lfunc_begin1         // >> Call Site 18 <<
	.uleb128 .Ltmp115-.Ltmp114              //   Call between .Ltmp114 and .Ltmp115
	.uleb128 .Ltmp116-.Lfunc_begin1         //     jumps to .Ltmp116
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp115-.Lfunc_begin1         // >> Call Site 19 <<
	.uleb128 .Ltmp117-.Ltmp115              //   Call between .Ltmp115 and .Ltmp117
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp117-.Lfunc_begin1         // >> Call Site 20 <<
	.uleb128 .Ltmp120-.Ltmp117              //   Call between .Ltmp117 and .Ltmp120
	.uleb128 .Ltmp121-.Lfunc_begin1         //     jumps to .Ltmp121
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp122-.Lfunc_begin1         // >> Call Site 21 <<
	.uleb128 .Ltmp123-.Ltmp122              //   Call between .Ltmp122 and .Ltmp123
	.uleb128 .Ltmp124-.Lfunc_begin1         //     jumps to .Ltmp124
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp131-.Lfunc_begin1         // >> Call Site 22 <<
	.uleb128 .Ltmp132-.Ltmp131              //   Call between .Ltmp131 and .Ltmp132
	.uleb128 .Ltmp133-.Lfunc_begin1         //     jumps to .Ltmp133
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp132-.Lfunc_begin1         // >> Call Site 23 <<
	.uleb128 .Ltmp125-.Ltmp132              //   Call between .Ltmp132 and .Ltmp125
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp125-.Lfunc_begin1         // >> Call Site 24 <<
	.uleb128 .Ltmp126-.Ltmp125              //   Call between .Ltmp125 and .Ltmp126
	.uleb128 .Ltmp127-.Lfunc_begin1         //     jumps to .Ltmp127
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp126-.Lfunc_begin1         // >> Call Site 25 <<
	.uleb128 .Ltmp134-.Ltmp126              //   Call between .Ltmp126 and .Ltmp134
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp134-.Lfunc_begin1         // >> Call Site 26 <<
	.uleb128 .Ltmp135-.Ltmp134              //   Call between .Ltmp134 and .Ltmp135
	.uleb128 .Ltmp136-.Lfunc_begin1         //     jumps to .Ltmp136
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp135-.Lfunc_begin1         // >> Call Site 27 <<
	.uleb128 .Ltmp140-.Ltmp135              //   Call between .Ltmp135 and .Ltmp140
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp140-.Lfunc_begin1         // >> Call Site 28 <<
	.uleb128 .Ltmp141-.Ltmp140              //   Call between .Ltmp140 and .Ltmp141
	.uleb128 .Ltmp142-.Lfunc_begin1         //     jumps to .Ltmp142
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp141-.Lfunc_begin1         // >> Call Site 29 <<
	.uleb128 .Ltmp143-.Ltmp141              //   Call between .Ltmp141 and .Ltmp143
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp143-.Lfunc_begin1         // >> Call Site 30 <<
	.uleb128 .Ltmp144-.Ltmp143              //   Call between .Ltmp143 and .Ltmp144
	.uleb128 .Ltmp145-.Lfunc_begin1         //     jumps to .Ltmp145
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp144-.Lfunc_begin1         // >> Call Site 31 <<
	.uleb128 .Ltmp148-.Ltmp144              //   Call between .Ltmp144 and .Ltmp148
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp148-.Lfunc_begin1         // >> Call Site 32 <<
	.uleb128 .Ltmp149-.Ltmp148              //   Call between .Ltmp148 and .Ltmp149
	.uleb128 .Ltmp150-.Lfunc_begin1         //     jumps to .Ltmp150
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp105-.Lfunc_begin1         // >> Call Site 33 <<
	.uleb128 .Ltmp106-.Ltmp105              //   Call between .Ltmp105 and .Ltmp106
	.uleb128 .Ltmp107-.Lfunc_begin1         //     jumps to .Ltmp107
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp106-.Lfunc_begin1         // >> Call Site 34 <<
	.uleb128 .Ltmp151-.Ltmp106              //   Call between .Ltmp106 and .Ltmp151
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp151-.Lfunc_begin1         // >> Call Site 35 <<
	.uleb128 .Ltmp152-.Ltmp151              //   Call between .Ltmp151 and .Ltmp152
	.uleb128 .Ltmp153-.Lfunc_begin1         //     jumps to .Ltmp153
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp152-.Lfunc_begin1         // >> Call Site 36 <<
	.uleb128 .Ltmp157-.Ltmp152              //   Call between .Ltmp152 and .Ltmp157
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp157-.Lfunc_begin1         // >> Call Site 37 <<
	.uleb128 .Ltmp160-.Ltmp157              //   Call between .Ltmp157 and .Ltmp160
	.uleb128 .Ltmp161-.Lfunc_begin1         //     jumps to .Ltmp161
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp174-.Lfunc_begin1         // >> Call Site 38 <<
	.uleb128 .Ltmp175-.Ltmp174              //   Call between .Ltmp174 and .Ltmp175
	.uleb128 .Ltmp176-.Lfunc_begin1         //     jumps to .Ltmp176
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp175-.Lfunc_begin1         // >> Call Site 39 <<
	.uleb128 .Ltmp177-.Ltmp175              //   Call between .Ltmp175 and .Ltmp177
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp177-.Lfunc_begin1         // >> Call Site 40 <<
	.uleb128 .Ltmp178-.Ltmp177              //   Call between .Ltmp177 and .Ltmp178
	.uleb128 .Ltmp248-.Lfunc_begin1         //     jumps to .Ltmp248
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp179-.Lfunc_begin1         // >> Call Site 41 <<
	.uleb128 .Ltmp180-.Ltmp179              //   Call between .Ltmp179 and .Ltmp180
	.uleb128 .Ltmp181-.Lfunc_begin1         //     jumps to .Ltmp181
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp182-.Lfunc_begin1         // >> Call Site 42 <<
	.uleb128 .Ltmp183-.Ltmp182              //   Call between .Ltmp182 and .Ltmp183
	.uleb128 .Ltmp184-.Lfunc_begin1         //     jumps to .Ltmp184
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp185-.Lfunc_begin1         // >> Call Site 43 <<
	.uleb128 .Ltmp188-.Ltmp185              //   Call between .Ltmp185 and .Ltmp188
	.uleb128 .Ltmp189-.Lfunc_begin1         //     jumps to .Ltmp189
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp197-.Lfunc_begin1         // >> Call Site 44 <<
	.uleb128 .Ltmp200-.Ltmp197              //   Call between .Ltmp197 and .Ltmp200
	.uleb128 .Ltmp201-.Lfunc_begin1         //     jumps to .Ltmp201
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp209-.Lfunc_begin1         // >> Call Site 45 <<
	.uleb128 .Ltmp210-.Ltmp209              //   Call between .Ltmp209 and .Ltmp210
	.uleb128 .Ltmp211-.Lfunc_begin1         //     jumps to .Ltmp211
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp210-.Lfunc_begin1         // >> Call Site 46 <<
	.uleb128 .Ltmp215-.Ltmp210              //   Call between .Ltmp210 and .Ltmp215
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp215-.Lfunc_begin1         // >> Call Site 47 <<
	.uleb128 .Ltmp218-.Ltmp215              //   Call between .Ltmp215 and .Ltmp218
	.uleb128 .Ltmp219-.Lfunc_begin1         //     jumps to .Ltmp219
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp202-.Lfunc_begin1         // >> Call Site 48 <<
	.uleb128 .Ltmp203-.Ltmp202              //   Call between .Ltmp202 and .Ltmp203
	.uleb128 .Ltmp208-.Lfunc_begin1         //     jumps to .Ltmp208
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp203-.Lfunc_begin1         // >> Call Site 49 <<
	.uleb128 .Ltmp204-.Ltmp203              //   Call between .Ltmp203 and .Ltmp204
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp204-.Lfunc_begin1         // >> Call Site 50 <<
	.uleb128 .Ltmp205-.Ltmp204              //   Call between .Ltmp204 and .Ltmp205
	.uleb128 .Ltmp208-.Lfunc_begin1         //     jumps to .Ltmp208
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp205-.Lfunc_begin1         // >> Call Site 51 <<
	.uleb128 .Ltmp206-.Ltmp205              //   Call between .Ltmp205 and .Ltmp206
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp206-.Lfunc_begin1         // >> Call Site 52 <<
	.uleb128 .Ltmp207-.Ltmp206              //   Call between .Ltmp206 and .Ltmp207
	.uleb128 .Ltmp208-.Lfunc_begin1         //     jumps to .Ltmp208
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp207-.Lfunc_begin1         // >> Call Site 53 <<
	.uleb128 .Ltmp195-.Ltmp207              //   Call between .Ltmp207 and .Ltmp195
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp195-.Lfunc_begin1         // >> Call Site 54 <<
	.uleb128 .Ltmp196-.Ltmp195              //   Call between .Ltmp195 and .Ltmp196
	.uleb128 .Ltmp201-.Lfunc_begin1         //     jumps to .Ltmp201
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp190-.Lfunc_begin1         // >> Call Site 55 <<
	.uleb128 .Ltmp193-.Ltmp190              //   Call between .Ltmp190 and .Ltmp193
	.uleb128 .Ltmp194-.Lfunc_begin1         //     jumps to .Ltmp194
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp223-.Lfunc_begin1         // >> Call Site 56 <<
	.uleb128 .Ltmp224-.Ltmp223              //   Call between .Ltmp223 and .Ltmp224
	.uleb128 .Ltmp237-.Lfunc_begin1         //     jumps to .Ltmp237
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp224-.Lfunc_begin1         // >> Call Site 57 <<
	.uleb128 .Ltmp225-.Ltmp224              //   Call between .Ltmp224 and .Ltmp225
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp225-.Lfunc_begin1         // >> Call Site 58 <<
	.uleb128 .Ltmp228-.Ltmp225              //   Call between .Ltmp225 and .Ltmp228
	.uleb128 .Ltmp245-.Lfunc_begin1         //     jumps to .Ltmp245
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp229-.Lfunc_begin1         // >> Call Site 59 <<
	.uleb128 .Ltmp230-.Ltmp229              //   Call between .Ltmp229 and .Ltmp230
	.uleb128 .Ltmp237-.Lfunc_begin1         //     jumps to .Ltmp237
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp230-.Lfunc_begin1         // >> Call Site 60 <<
	.uleb128 .Ltmp231-.Ltmp230              //   Call between .Ltmp230 and .Ltmp231
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp231-.Lfunc_begin1         // >> Call Site 61 <<
	.uleb128 .Ltmp234-.Ltmp231              //   Call between .Ltmp231 and .Ltmp234
	.uleb128 .Ltmp245-.Lfunc_begin1         //     jumps to .Ltmp245
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp235-.Lfunc_begin1         // >> Call Site 62 <<
	.uleb128 .Ltmp236-.Ltmp235              //   Call between .Ltmp235 and .Ltmp236
	.uleb128 .Ltmp237-.Lfunc_begin1         //     jumps to .Ltmp237
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp236-.Lfunc_begin1         // >> Call Site 63 <<
	.uleb128 .Ltmp241-.Ltmp236              //   Call between .Ltmp236 and .Ltmp241
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp241-.Lfunc_begin1         // >> Call Site 64 <<
	.uleb128 .Ltmp244-.Ltmp241              //   Call between .Ltmp241 and .Ltmp244
	.uleb128 .Ltmp245-.Lfunc_begin1         //     jumps to .Ltmp245
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp154-.Lfunc_begin1         // >> Call Site 65 <<
	.uleb128 .Ltmp155-.Ltmp154              //   Call between .Ltmp154 and .Ltmp155
	.uleb128 .Ltmp156-.Lfunc_begin1         //     jumps to .Ltmp156
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp212-.Lfunc_begin1         // >> Call Site 66 <<
	.uleb128 .Ltmp213-.Ltmp212              //   Call between .Ltmp212 and .Ltmp213
	.uleb128 .Ltmp214-.Lfunc_begin1         //     jumps to .Ltmp214
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp249-.Lfunc_begin1         // >> Call Site 67 <<
	.uleb128 .Ltmp250-.Ltmp249              //   Call between .Ltmp249 and .Ltmp250
	.uleb128 .Ltmp255-.Lfunc_begin1         //     jumps to .Ltmp255
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp137-.Lfunc_begin1         // >> Call Site 68 <<
	.uleb128 .Ltmp138-.Ltmp137              //   Call between .Ltmp137 and .Ltmp138
	.uleb128 .Ltmp139-.Lfunc_begin1         //     jumps to .Ltmp139
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp146-.Lfunc_begin1         // >> Call Site 69 <<
	.uleb128 .Ltmp147-.Ltmp146              //   Call between .Ltmp146 and .Ltmp147
	.uleb128 .Ltmp164-.Lfunc_begin1         //     jumps to .Ltmp164
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp44-.Lfunc_begin1          // >> Call Site 70 <<
	.uleb128 .Ltmp45-.Ltmp44                //   Call between .Ltmp44 and .Ltmp45
	.uleb128 .Ltmp50-.Lfunc_begin1          //     jumps to .Ltmp50
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp84-.Lfunc_begin1          // >> Call Site 71 <<
	.uleb128 .Ltmp85-.Ltmp84                //   Call between .Ltmp84 and .Ltmp85
	.uleb128 .Ltmp90-.Lfunc_begin1          //     jumps to .Ltmp90
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp29-.Lfunc_begin1          // >> Call Site 72 <<
	.uleb128 .Ltmp30-.Ltmp29                //   Call between .Ltmp29 and .Ltmp30
	.uleb128 .Ltmp35-.Lfunc_begin1          //     jumps to .Ltmp35
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp14-.Lfunc_begin1          // >> Call Site 73 <<
	.uleb128 .Ltmp15-.Ltmp14                //   Call between .Ltmp14 and .Ltmp15
	.uleb128 .Ltmp20-.Lfunc_begin1          //     jumps to .Ltmp20
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp238-.Lfunc_begin1         // >> Call Site 74 <<
	.uleb128 .Ltmp239-.Ltmp238              //   Call between .Ltmp238 and .Ltmp239
	.uleb128 .Ltmp240-.Lfunc_begin1         //     jumps to .Ltmp240
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp59-.Lfunc_begin1          // >> Call Site 75 <<
	.uleb128 .Ltmp60-.Ltmp59                //   Call between .Ltmp59 and .Ltmp60
	.uleb128 .Ltmp65-.Lfunc_begin1          //     jumps to .Ltmp65
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp74-.Lfunc_begin1          // >> Call Site 76 <<
	.uleb128 .Ltmp75-.Ltmp74                //   Call between .Ltmp74 and .Ltmp75
	.uleb128 .Ltmp80-.Lfunc_begin1          //     jumps to .Ltmp80
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp108-.Lfunc_begin1         // >> Call Site 77 <<
	.uleb128 .Ltmp109-.Ltmp108              //   Call between .Ltmp108 and .Ltmp109
	.uleb128 .Ltmp110-.Lfunc_begin1         //     jumps to .Ltmp110
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp128-.Lfunc_begin1         // >> Call Site 78 <<
	.uleb128 .Ltmp129-.Ltmp128              //   Call between .Ltmp128 and .Ltmp129
	.uleb128 .Ltmp130-.Lfunc_begin1         //     jumps to .Ltmp130
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp165-.Lfunc_begin1         // >> Call Site 79 <<
	.uleb128 .Ltmp166-.Ltmp165              //   Call between .Ltmp165 and .Ltmp166
	.uleb128 .Ltmp167-.Lfunc_begin1         //     jumps to .Ltmp167
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp162-.Lfunc_begin1         // >> Call Site 80 <<
	.uleb128 .Ltmp163-.Ltmp162              //   Call between .Ltmp162 and .Ltmp163
	.uleb128 .Ltmp164-.Lfunc_begin1         //     jumps to .Ltmp164
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp171-.Lfunc_begin1         // >> Call Site 81 <<
	.uleb128 .Ltmp172-.Ltmp171              //   Call between .Ltmp171 and .Ltmp172
	.uleb128 .Ltmp173-.Lfunc_begin1         //     jumps to .Ltmp173
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp111-.Lfunc_begin1         // >> Call Site 82 <<
	.uleb128 .Ltmp112-.Ltmp111              //   Call between .Ltmp111 and .Ltmp112
	.uleb128 .Ltmp113-.Lfunc_begin1         //     jumps to .Ltmp113
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp220-.Lfunc_begin1         // >> Call Site 83 <<
	.uleb128 .Ltmp221-.Ltmp220              //   Call between .Ltmp220 and .Ltmp221
	.uleb128 .Ltmp222-.Lfunc_begin1         //     jumps to .Ltmp222
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp253-.Lfunc_begin1         // >> Call Site 84 <<
	.uleb128 .Ltmp252-.Ltmp253              //   Call between .Ltmp253 and .Ltmp252
	.uleb128 .Ltmp255-.Lfunc_begin1         //     jumps to .Ltmp255
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp168-.Lfunc_begin1         // >> Call Site 85 <<
	.uleb128 .Ltmp169-.Ltmp168              //   Call between .Ltmp168 and .Ltmp169
	.uleb128 .Ltmp170-.Lfunc_begin1         //     jumps to .Ltmp170
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp48-.Lfunc_begin1          // >> Call Site 86 <<
	.uleb128 .Ltmp49-.Ltmp48                //   Call between .Ltmp48 and .Ltmp49
	.uleb128 .Ltmp50-.Lfunc_begin1          //     jumps to .Ltmp50
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp88-.Lfunc_begin1          // >> Call Site 87 <<
	.uleb128 .Ltmp89-.Ltmp88                //   Call between .Ltmp88 and .Ltmp89
	.uleb128 .Ltmp90-.Lfunc_begin1          //     jumps to .Ltmp90
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp33-.Lfunc_begin1          // >> Call Site 88 <<
	.uleb128 .Ltmp34-.Ltmp33                //   Call between .Ltmp33 and .Ltmp34
	.uleb128 .Ltmp35-.Lfunc_begin1          //     jumps to .Ltmp35
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp18-.Lfunc_begin1          // >> Call Site 89 <<
	.uleb128 .Ltmp19-.Ltmp18                //   Call between .Ltmp18 and .Ltmp19
	.uleb128 .Ltmp20-.Lfunc_begin1          //     jumps to .Ltmp20
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp11-.Lfunc_begin1          // >> Call Site 90 <<
	.uleb128 .Ltmp12-.Ltmp11                //   Call between .Ltmp11 and .Ltmp12
	.uleb128 .Ltmp13-.Lfunc_begin1          //     jumps to .Ltmp13
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp41-.Lfunc_begin1          // >> Call Site 91 <<
	.uleb128 .Ltmp42-.Ltmp41                //   Call between .Ltmp41 and .Ltmp42
	.uleb128 .Ltmp43-.Lfunc_begin1          //     jumps to .Ltmp43
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp26-.Lfunc_begin1          // >> Call Site 92 <<
	.uleb128 .Ltmp27-.Ltmp26                //   Call between .Ltmp26 and .Ltmp27
	.uleb128 .Ltmp28-.Lfunc_begin1          //     jumps to .Ltmp28
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp63-.Lfunc_begin1          // >> Call Site 93 <<
	.uleb128 .Ltmp64-.Ltmp63                //   Call between .Ltmp63 and .Ltmp64
	.uleb128 .Ltmp65-.Lfunc_begin1          //     jumps to .Ltmp65
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp56-.Lfunc_begin1          // >> Call Site 94 <<
	.uleb128 .Ltmp57-.Ltmp56                //   Call between .Ltmp56 and .Ltmp57
	.uleb128 .Ltmp58-.Lfunc_begin1          //     jumps to .Ltmp58
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp31-.Lfunc_begin1          // >> Call Site 95 <<
	.uleb128 .Ltmp32-.Ltmp31                //   Call between .Ltmp31 and .Ltmp32
	.uleb128 .Ltmp35-.Lfunc_begin1          //     jumps to .Ltmp35
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp46-.Lfunc_begin1          // >> Call Site 96 <<
	.uleb128 .Ltmp47-.Ltmp46                //   Call between .Ltmp46 and .Ltmp47
	.uleb128 .Ltmp50-.Lfunc_begin1          //     jumps to .Ltmp50
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp86-.Lfunc_begin1          // >> Call Site 97 <<
	.uleb128 .Ltmp87-.Ltmp86                //   Call between .Ltmp86 and .Ltmp87
	.uleb128 .Ltmp90-.Lfunc_begin1          //     jumps to .Ltmp90
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp16-.Lfunc_begin1          // >> Call Site 98 <<
	.uleb128 .Ltmp17-.Ltmp16                //   Call between .Ltmp16 and .Ltmp17
	.uleb128 .Ltmp20-.Lfunc_begin1          //     jumps to .Ltmp20
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp9-.Lfunc_begin1           // >> Call Site 99 <<
	.uleb128 .Ltmp10-.Ltmp9                 //   Call between .Ltmp9 and .Ltmp10
	.uleb128 .Ltmp13-.Lfunc_begin1          //     jumps to .Ltmp13
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp24-.Lfunc_begin1          // >> Call Site 100 <<
	.uleb128 .Ltmp25-.Ltmp24                //   Call between .Ltmp24 and .Ltmp25
	.uleb128 .Ltmp28-.Lfunc_begin1          //     jumps to .Ltmp28
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp39-.Lfunc_begin1          // >> Call Site 101 <<
	.uleb128 .Ltmp40-.Ltmp39                //   Call between .Ltmp39 and .Ltmp40
	.uleb128 .Ltmp43-.Lfunc_begin1          //     jumps to .Ltmp43
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp246-.Lfunc_begin1         // >> Call Site 102 <<
	.uleb128 .Ltmp247-.Ltmp246              //   Call between .Ltmp246 and .Ltmp247
	.uleb128 .Ltmp248-.Lfunc_begin1         //     jumps to .Ltmp248
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp78-.Lfunc_begin1          // >> Call Site 103 <<
	.uleb128 .Ltmp79-.Ltmp78                //   Call between .Ltmp78 and .Ltmp79
	.uleb128 .Ltmp80-.Lfunc_begin1          //     jumps to .Ltmp80
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp71-.Lfunc_begin1          // >> Call Site 104 <<
	.uleb128 .Ltmp72-.Ltmp71                //   Call between .Ltmp71 and .Ltmp72
	.uleb128 .Ltmp73-.Lfunc_begin1          //     jumps to .Ltmp73
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp61-.Lfunc_begin1          // >> Call Site 105 <<
	.uleb128 .Ltmp62-.Ltmp61                //   Call between .Ltmp61 and .Ltmp62
	.uleb128 .Ltmp65-.Lfunc_begin1          //     jumps to .Ltmp65
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp54-.Lfunc_begin1          // >> Call Site 106 <<
	.uleb128 .Ltmp55-.Ltmp54                //   Call between .Ltmp54 and .Ltmp55
	.uleb128 .Ltmp58-.Lfunc_begin1          //     jumps to .Ltmp58
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp76-.Lfunc_begin1          // >> Call Site 107 <<
	.uleb128 .Ltmp77-.Ltmp76                //   Call between .Ltmp76 and .Ltmp77
	.uleb128 .Ltmp80-.Lfunc_begin1          //     jumps to .Ltmp80
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp69-.Lfunc_begin1          // >> Call Site 108 <<
	.uleb128 .Ltmp70-.Ltmp69                //   Call between .Ltmp69 and .Ltmp70
	.uleb128 .Ltmp73-.Lfunc_begin1          //     jumps to .Ltmp73
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp70-.Lfunc_begin1          // >> Call Site 109 <<
	.uleb128 .Lfunc_end12-.Ltmp70           //   Call between .Ltmp70 and .Lfunc_end12
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
.Lcst_end1:
	.p2align	2, 0x0
                                        // -- End function
	.section	.text._ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,comdat
	.weak	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev // -- Begin function _ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.p2align	2
	.type	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev,@function
_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev:    // @_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	ldp	x19, x21, [x0]
	cmp	x19, x21
	b.eq	.LBB13_6
// %bb.1:
	mov	x20, x0
	b	.LBB13_3
.LBB13_2:                               //   in Loop: Header=BB13_3 Depth=1
	add	x19, x19, #24
	cmp	x19, x21
	b.eq	.LBB13_5
.LBB13_3:                               // =>This Inner Loop Header: Depth=1
	ldr	x0, [x19]
	cbz	x0, .LBB13_2
// %bb.4:                               //   in Loop: Header=BB13_3 Depth=1
	bl	_ZdlPv
	b	.LBB13_2
.LBB13_5:
	ldr	x19, [x20]
.LBB13_6:
	cbz	x19, .LBB13_8
// %bb.7:
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	b	_ZdlPv
.LBB13_8:
	.cfi_restore_state
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end13:
	.size	_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev, .Lfunc_end13-_ZNSt6vectorIS_IdSaIdEESaIS1_EED2Ev
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,comdat
	.weak	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev // -- Begin function _ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.p2align	2
	.type	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev,@function
_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev:    // @_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	ldp	x19, x21, [x0]
	cmp	x19, x21
	b.eq	.LBB14_6
// %bb.1:
	mov	x20, x0
	b	.LBB14_3
.LBB14_2:                               //   in Loop: Header=BB14_3 Depth=1
	add	x19, x19, #24
	cmp	x19, x21
	b.eq	.LBB14_5
.LBB14_3:                               // =>This Inner Loop Header: Depth=1
	ldr	x0, [x19]
	cbz	x0, .LBB14_2
// %bb.4:                               //   in Loop: Header=BB14_3 Depth=1
	bl	_ZdlPv
	b	.LBB14_2
.LBB14_5:
	ldr	x19, [x20]
.LBB14_6:
	cbz	x19, .LBB14_8
// %bb.7:
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	b	_ZdlPv
.LBB14_8:
	.cfi_restore_state
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end14:
	.size	_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev, .Lfunc_end14-_ZNSt6vectorIS_ImSaImEESaIS1_EED2Ev
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,"axG",@progbits,_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,comdat
	.weak	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_ // -- Begin function _ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.p2align	2
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,@function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_: // @_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_startproc
// %bb.0:
	sub	x8, x1, x0
	asr	x8, x8, #3
	cmp	x8, #17
	b.lt	.LBB15_36
// %bb.1:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	mov	x20, x2
	mov	x19, x0
	add	x22, x0, #8
	neg	x23, x0
	b	.LBB15_3
.LBB15_2:                               //   in Loop: Header=BB15_3 Depth=1
	mov	x0, x21
	mov	x2, x20
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	add	x8, x23, x21
	asr	x8, x8, #3
	mov	x1, x21
	cmp	x8, #16
	b.le	.LBB15_35
.LBB15_3:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB15_16 Depth 2
                                        //       Child Loop BB15_17 Depth 3
                                        //       Child Loop BB15_19 Depth 3
	cbz	x20, .LBB15_22
// %bb.4:                               //   in Loop: Header=BB15_3 Depth=1
	lsr	x8, x8, #1
	ldr	x9, [x19, #8]
	ldr	x11, [x19, x8, lsl #3]
	ldur	x10, [x1, #-8]
	cmp	x9, x11
	b.hs	.LBB15_7
// %bb.5:                               //   in Loop: Header=BB15_3 Depth=1
	cmp	x11, x10
	b.hs	.LBB15_9
// %bb.6:                               //   in Loop: Header=BB15_3 Depth=1
	ldr	x9, [x19]
	b	.LBB15_14
.LBB15_7:                               //   in Loop: Header=BB15_3 Depth=1
	cmp	x9, x10
	b.hs	.LBB15_12
// %bb.8:                               //   in Loop: Header=BB15_3 Depth=1
	ldr	x8, [x19]
	b	.LBB15_11
.LBB15_9:                               //   in Loop: Header=BB15_3 Depth=1
	ldr	x8, [x19]
	cmp	x9, x10
	b.hs	.LBB15_11
// %bb.10:                              //   in Loop: Header=BB15_3 Depth=1
	str	x10, [x19]
	stur	x8, [x1, #-8]
	b	.LBB15_15
.LBB15_11:                              //   in Loop: Header=BB15_3 Depth=1
	stp	x9, x8, [x19]
	b	.LBB15_15
.LBB15_12:                              //   in Loop: Header=BB15_3 Depth=1
	ldr	x9, [x19]
	cmp	x11, x10
	b.hs	.LBB15_14
// %bb.13:                              //   in Loop: Header=BB15_3 Depth=1
	str	x10, [x19]
	stur	x9, [x1, #-8]
	b	.LBB15_15
.LBB15_14:                              //   in Loop: Header=BB15_3 Depth=1
	str	x11, [x19]
	str	x9, [x19, x8, lsl #3]
.LBB15_15:                              //   in Loop: Header=BB15_3 Depth=1
	sub	x20, x20, #1
	mov	x8, x1
	mov	x9, x22
.LBB15_16:                              //   Parent Loop BB15_3 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB15_17 Depth 3
                                        //       Child Loop BB15_19 Depth 3
	ldr	x10, [x19]
	sub	x21, x9, #8
.LBB15_17:                              //   Parent Loop BB15_3 Depth=1
                                        //     Parent Loop BB15_16 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x11, [x9], #8
	add	x21, x21, #8
	cmp	x11, x10
	b.lo	.LBB15_17
// %bb.18:                              //   in Loop: Header=BB15_16 Depth=2
	sub	x12, x9, #8
.LBB15_19:                              //   Parent Loop BB15_3 Depth=1
                                        //     Parent Loop BB15_16 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x13, [x8, #-8]!
	cmp	x10, x13
	b.lo	.LBB15_19
// %bb.20:                              //   in Loop: Header=BB15_16 Depth=2
	cmp	x12, x8
	b.hs	.LBB15_2
// %bb.21:                              //   in Loop: Header=BB15_16 Depth=2
	str	x13, [x12]
	str	x11, [x8]
	b	.LBB15_16
.LBB15_22:
	mov	x0, x19
	mov	x20, x1
	mov	x2, x1
	bl	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	mov	w8, #1                          // =0x1
	b	.LBB15_25
.LBB15_23:                              //   in Loop: Header=BB15_25 Depth=1
	mov	x11, #0                         // =0x0
.LBB15_24:                              //   in Loop: Header=BB15_25 Depth=1
	str	x9, [x19, x11, lsl #3]
	cmp	x10, #8
	b.le	.LBB15_35
.LBB15_25:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB15_27 Depth 2
                                        //     Child Loop BB15_33 Depth 2
	ldr	x9, [x20, #-8]!
	ldr	x10, [x19]
	str	x10, [x20]
	sub	x10, x20, x19
	asr	x12, x10, #3
	subs	x11, x12, #1
	csel	x11, x12, x11, lt
	cmp	x12, #3
	b.lt	.LBB15_29
// %bb.26:                              //   in Loop: Header=BB15_25 Depth=1
	mov	x14, #0                         // =0x0
	asr	x13, x11, #1
.LBB15_27:                              //   Parent Loop BB15_25 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x11, x14, #1
	add	x11, x11, #2
	mov	w15, #1                         // =0x1
	bfi	x15, x14, #1, #63
	ldr	x16, [x19, x11, lsl #3]
	ldr	x17, [x19, x15, lsl #3]
	cmp	x16, x17
	csel	x11, x15, x11, lo
	ldr	x15, [x19, x11, lsl #3]
	str	x15, [x19, x14, lsl #3]
	mov	x14, x11
	cmp	x11, x13
	b.lt	.LBB15_27
// %bb.28:                              //   in Loop: Header=BB15_25 Depth=1
	tbz	w10, #3, .LBB15_30
	b	.LBB15_32
.LBB15_29:                              //   in Loop: Header=BB15_25 Depth=1
	mov	x11, #0                         // =0x0
	tbnz	w10, #3, .LBB15_32
.LBB15_30:                              //   in Loop: Header=BB15_25 Depth=1
	sub	x12, x12, #2
	cmp	x11, x12, asr #1
	b.ne	.LBB15_32
// %bb.31:                              //   in Loop: Header=BB15_25 Depth=1
	orr	x12, x8, x11, lsl #1
	ldr	x13, [x19, x12, lsl #3]
	str	x13, [x19, x11, lsl #3]
	mov	x11, x12
.LBB15_32:                              //   in Loop: Header=BB15_25 Depth=1
	cmp	x11, #1
	b.lt	.LBB15_24
.LBB15_33:                              //   Parent Loop BB15_25 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x12, x11, #1
	lsr	x13, x12, #1
	ldr	x14, [x19, x13, lsl #3]
	cmp	x14, x9
	b.hs	.LBB15_24
// %bb.34:                              //   in Loop: Header=BB15_33 Depth=2
	str	x14, [x19, x11, lsl #3]
	mov	x11, x13
	cmp	x12, #1
	b.hi	.LBB15_33
	b	.LBB15_23
.LBB15_35:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
.LBB15_36:
	ret
.Lfunc_end15:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_, .Lfunc_end15-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,"axG",@progbits,_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,comdat
	.weak	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_ // -- Begin function _ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.p2align	2
	.type	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,@function
_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_: // @_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	mov	x19, x1
	mov	x20, x0
	sub	x8, x1, x0
	cmp	x8, #129
	b.lt	.LBB16_12
// %bb.1:
	add	x21, x20, #8
	mov	w22, #8                         // =0x8
	mov	x23, x20
	b	.LBB16_6
.LBB16_2:                               //   in Loop: Header=BB16_6 Depth=1
	sub	x2, x23, x20
	asr	x8, x2, #3
	cmp	x8, #2
	b.lt	.LBB16_10
// %bb.3:                               //   in Loop: Header=BB16_6 Depth=1
	sub	x8, x9, x8, lsl #3
	add	x0, x8, #16
	mov	x1, x20
	bl	memmove
.LBB16_4:                               //   in Loop: Header=BB16_6 Depth=1
	mov	x8, x20
.LBB16_5:                               //   in Loop: Header=BB16_6 Depth=1
	str	x24, [x8]
	add	x22, x22, #8
	add	x21, x21, #8
	cmp	x22, #128
	b.eq	.LBB16_25
.LBB16_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB16_9 Depth 2
	mov	x9, x23
	add	x23, x20, x22
	ldr	x24, [x23]
	ldr	x10, [x20]
	cmp	x24, x10
	b.lo	.LBB16_2
// %bb.7:                               //   in Loop: Header=BB16_6 Depth=1
	ldr	x9, [x9]
	mov	x8, x23
	cmp	x24, x9
	b.hs	.LBB16_5
// %bb.8:                               //   in Loop: Header=BB16_6 Depth=1
	mov	x8, x21
.LBB16_9:                               //   Parent Loop BB16_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x9, [x8]
	ldur	x9, [x8, #-16]
	sub	x8, x8, #8
	cmp	x24, x9
	b.lo	.LBB16_9
	b	.LBB16_5
.LBB16_10:                              //   in Loop: Header=BB16_6 Depth=1
	mov	x8, x20
	cmp	x2, #8
	b.ne	.LBB16_5
// %bb.11:                              //   in Loop: Header=BB16_6 Depth=1
	str	x10, [x9, #8]
	b	.LBB16_4
.LBB16_12:
	cmp	x20, x19
	b.eq	.LBB16_31
// %bb.13:
	add	x8, x20, #8
	cmp	x8, x19
	b.eq	.LBB16_31
// %bb.14:
	mov	x21, x20
	b	.LBB16_19
.LBB16_15:                              //   in Loop: Header=BB16_19 Depth=1
	sub	x2, x21, x20
	asr	x8, x2, #3
	cmp	x8, #2
	b.lt	.LBB16_23
// %bb.16:                              //   in Loop: Header=BB16_19 Depth=1
	sub	x8, x9, x8, lsl #3
	add	x0, x8, #16
	mov	x1, x20
	bl	memmove
.LBB16_17:                              //   in Loop: Header=BB16_19 Depth=1
	mov	x8, x20
.LBB16_18:                              //   in Loop: Header=BB16_19 Depth=1
	str	x22, [x8]
	add	x8, x21, #8
	cmp	x8, x19
	b.eq	.LBB16_31
.LBB16_19:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB16_22 Depth 2
	mov	x9, x21
	mov	x21, x8
	ldr	x22, [x8]
	ldr	x10, [x20]
	cmp	x22, x10
	b.lo	.LBB16_15
// %bb.20:                              //   in Loop: Header=BB16_19 Depth=1
	ldr	x9, [x9]
	mov	x8, x21
	cmp	x22, x9
	b.hs	.LBB16_18
// %bb.21:                              //   in Loop: Header=BB16_19 Depth=1
	mov	x8, x21
.LBB16_22:                              //   Parent Loop BB16_19 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x9, [x8]
	ldur	x9, [x8, #-16]
	sub	x8, x8, #8
	cmp	x22, x9
	b.lo	.LBB16_22
	b	.LBB16_18
.LBB16_23:                              //   in Loop: Header=BB16_19 Depth=1
	mov	x8, x20
	cmp	x2, #8
	b.ne	.LBB16_18
// %bb.24:                              //   in Loop: Header=BB16_19 Depth=1
	str	x10, [x9, #8]
	b	.LBB16_17
.LBB16_25:
	add	x8, x20, #128
	b	.LBB16_27
.LBB16_26:                              //   in Loop: Header=BB16_27 Depth=1
	str	x9, [x11]
	add	x8, x8, #8
.LBB16_27:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB16_30 Depth 2
	cmp	x8, x19
	b.eq	.LBB16_31
// %bb.28:                              //   in Loop: Header=BB16_27 Depth=1
	ldp	x10, x9, [x8, #-8]
	mov	x11, x8
	cmp	x9, x10
	b.hs	.LBB16_26
// %bb.29:                              //   in Loop: Header=BB16_27 Depth=1
	mov	x11, x8
.LBB16_30:                              //   Parent Loop BB16_27 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x10, [x11]
	ldur	x10, [x11, #-16]
	sub	x11, x11, #8
	cmp	x9, x10
	b.lo	.LBB16_30
	b	.LBB16_26
.LBB16_31:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end16:
	.size	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_, .Lfunc_end16-_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"axG",@progbits,_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.weak	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_ // -- Begin function _ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.p2align	2
	.type	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,@function
_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_: // @_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
	strb	w3, [x29, #28]
	add	x2, x29, #28
	bl	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	cmp	x20, x19
	b.hs	.LBB17_28
// %bb.1:
	sub	x8, x20, x21
	asr	x10, x8, #3
	subs	x9, x10, #1
	csel	x9, x10, x9, lt
	sub	x11, x10, #2
	cmp	x10, #3
	b.lt	.LBB17_15
// %bb.2:
	asr	x9, x9, #1
	asr	x10, x11, #1
	orr	x11, x11, #0x1
	b	.LBB17_6
.LBB17_3:                               //   in Loop: Header=BB17_6 Depth=1
	mov	x13, #0                         // =0x0
.LBB17_4:                               //   in Loop: Header=BB17_6 Depth=1
	str	x12, [x21, x13, lsl #3]
.LBB17_5:                               //   in Loop: Header=BB17_6 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB17_28
.LBB17_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB17_8 Depth 2
                                        //     Child Loop BB17_13 Depth 2
	ldr	x12, [x20]
	ldr	x14, [x21]
	cmp	x12, x14
	b.hs	.LBB17_5
// %bb.7:                               //   in Loop: Header=BB17_6 Depth=1
	mov	x13, #0                         // =0x0
	str	x14, [x20]
.LBB17_8:                               //   Parent Loop BB17_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x14, x13
	lsl	x13, x13, #1
	add	x13, x13, #2
	mov	w15, #1                         // =0x1
	bfi	x15, x14, #1, #63
	ldr	x16, [x21, x13, lsl #3]
	ldr	x17, [x21, x15, lsl #3]
	cmp	x16, x17
	csel	x13, x15, x13, lo
	ldr	x15, [x21, x13, lsl #3]
	str	x15, [x21, x14, lsl #3]
	cmp	x13, x9
	b.lt	.LBB17_8
// %bb.9:                               //   in Loop: Header=BB17_6 Depth=1
	tbnz	w8, #3, .LBB17_12
// %bb.10:                              //   in Loop: Header=BB17_6 Depth=1
	cmp	x13, x10
	b.ne	.LBB17_12
// %bb.11:                              //   in Loop: Header=BB17_6 Depth=1
	ldr	x13, [x21, x11, lsl #3]
	str	x13, [x21, x10, lsl #3]
	mov	x13, x11
.LBB17_12:                              //   in Loop: Header=BB17_6 Depth=1
	cmp	x13, #1
	b.lt	.LBB17_4
.LBB17_13:                              //   Parent Loop BB17_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x14, x13, #1
	lsr	x15, x14, #1
	ldr	x16, [x21, x15, lsl #3]
	cmp	x16, x12
	b.hs	.LBB17_4
// %bb.14:                              //   in Loop: Header=BB17_13 Depth=2
	str	x16, [x21, x13, lsl #3]
	mov	x13, x15
	cmp	x14, #1
	b.hi	.LBB17_13
	b	.LBB17_3
.LBB17_15:
	tbnz	w8, #3, .LBB17_24
// %bb.16:
	cbz	x11, .LBB17_22
// %bb.17:
	ldr	x8, [x21]
	b	.LBB17_19
.LBB17_18:                              //   in Loop: Header=BB17_19 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB17_28
.LBB17_19:                              // =>This Inner Loop Header: Depth=1
	ldr	x9, [x20]
	cmp	x9, x8
	b.hs	.LBB17_18
// %bb.20:                              //   in Loop: Header=BB17_19 Depth=1
	str	x8, [x20]
	str	x9, [x21]
	mov	x8, x9
	b	.LBB17_18
.LBB17_21:                              //   in Loop: Header=BB17_22 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB17_28
.LBB17_22:                              // =>This Inner Loop Header: Depth=1
	ldr	x8, [x20]
	ldr	x9, [x21]
	cmp	x8, x9
	b.hs	.LBB17_21
// %bb.23:                              //   in Loop: Header=BB17_22 Depth=1
	str	x9, [x20]
	ldr	x9, [x21, #8]
	str	x9, [x21]
	cmp	x9, x8
	cset	w9, hs
	str	x8, [x21, w9, uxtw #3]
	b	.LBB17_21
.LBB17_24:
	ldr	x8, [x21]
	b	.LBB17_26
.LBB17_25:                              //   in Loop: Header=BB17_26 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB17_28
.LBB17_26:                              // =>This Inner Loop Header: Depth=1
	ldr	x9, [x20]
	cmp	x9, x8
	b.hs	.LBB17_25
// %bb.27:                              //   in Loop: Header=BB17_26 Depth=1
	str	x8, [x20]
	str	x9, [x21]
	mov	x8, x9
	b	.LBB17_25
.LBB17_28:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end17:
	.size	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_, .Lfunc_end17-_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,"axG",@progbits,_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,comdat
	.weak	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_ // -- Begin function _ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.p2align	2
	.type	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,@function
_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_: // @_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_startproc
// %bb.0:
	sub	x11, x1, x0
	asr	x8, x11, #3
	subs	x10, x8, #2
	b.ge	.LBB18_2
.LBB18_1:
	ret
.LBB18_2:
	lsr	x9, x10, #1
	sub	x8, x8, #1
	lsr	x8, x8, #1
	tbnz	w11, #3, .LBB18_16
// %bb.3:
	orr	x10, x10, #0x1
	mov	x12, x9
	b	.LBB18_6
.LBB18_4:                               //   in Loop: Header=BB18_6 Depth=1
	mov	x14, x13
.LBB18_5:                               //   in Loop: Header=BB18_6 Depth=1
	str	x12, [x0, x14, lsl #3]
	sub	x12, x11, #1
	cbz	x11, .LBB18_1
.LBB18_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB18_8 Depth 2
                                        //     Child Loop BB18_12 Depth 2
	mov	x11, x12
	ldr	x12, [x0, x12, lsl #3]
	mov	x13, x11
	cmp	x8, x11
	b.le	.LBB18_9
// %bb.7:                               //   in Loop: Header=BB18_6 Depth=1
	mov	x14, x11
.LBB18_8:                               //   Parent Loop BB18_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x13, x14, #1
	add	x13, x13, #2
	mov	w15, #1                         // =0x1
	bfi	x15, x14, #1, #63
	ldr	x16, [x0, x13, lsl #3]
	ldr	x17, [x0, x15, lsl #3]
	cmp	x16, x17
	csel	x13, x15, x13, lo
	ldr	x15, [x0, x13, lsl #3]
	str	x15, [x0, x14, lsl #3]
	mov	x14, x13
	cmp	x13, x8
	b.lt	.LBB18_8
.LBB18_9:                               //   in Loop: Header=BB18_6 Depth=1
	cmp	x13, x9
	b.ne	.LBB18_11
// %bb.10:                              //   in Loop: Header=BB18_6 Depth=1
	ldr	x13, [x0, x10, lsl #3]
	str	x13, [x0, x9, lsl #3]
	mov	x13, x10
.LBB18_11:                              //   in Loop: Header=BB18_6 Depth=1
	cmp	x13, x11
	b.le	.LBB18_4
.LBB18_12:                              //   Parent Loop BB18_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	subs	x14, x13, #1
	csel	x14, x13, x14, lt
	asr	x14, x14, #1
	ldr	x15, [x0, x14, lsl #3]
	cmp	x15, x12
	b.hs	.LBB18_4
// %bb.13:                              //   in Loop: Header=BB18_12 Depth=2
	str	x15, [x0, x13, lsl #3]
	mov	x13, x14
	cmp	x14, x11
	b.gt	.LBB18_12
	b	.LBB18_5
.LBB18_14:                              //   in Loop: Header=BB18_16 Depth=1
	mov	x12, x11
.LBB18_15:                              //   in Loop: Header=BB18_16 Depth=1
	str	x9, [x0, x12, lsl #3]
	sub	x9, x10, #1
	cbz	x10, .LBB18_1
.LBB18_16:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB18_18 Depth 2
                                        //     Child Loop BB18_20 Depth 2
	mov	x10, x9
	ldr	x9, [x0, x9, lsl #3]
	mov	x12, x10
	cmp	x8, x10
	b.le	.LBB18_15
// %bb.17:                              //   in Loop: Header=BB18_16 Depth=1
	mov	x11, x10
.LBB18_18:                              //   Parent Loop BB18_16 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x12, x11
	lsl	x11, x11, #1
	add	x11, x11, #2
	mov	w13, #1                         // =0x1
	bfi	x13, x12, #1, #63
	ldr	x14, [x0, x11, lsl #3]
	ldr	x15, [x0, x13, lsl #3]
	cmp	x14, x15
	csel	x11, x13, x11, lo
	ldr	x13, [x0, x11, lsl #3]
	str	x13, [x0, x12, lsl #3]
	cmp	x11, x8
	b.lt	.LBB18_18
// %bb.19:                              //   in Loop: Header=BB18_16 Depth=1
	cmp	x11, x10
	b.le	.LBB18_14
.LBB18_20:                              //   Parent Loop BB18_16 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	subs	x12, x11, #1
	csel	x12, x11, x12, lt
	asr	x12, x12, #1
	ldr	x13, [x0, x12, lsl #3]
	cmp	x13, x9
	b.hs	.LBB18_14
// %bb.21:                              //   in Loop: Header=BB18_20 Depth=2
	str	x13, [x0, x11, lsl #3]
	mov	x11, x12
	cmp	x12, x10
	b.gt	.LBB18_20
	b	.LBB18_15
.Lfunc_end18:
	.size	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_, .Lfunc_end18-_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_endproc
                                        // -- End function
	.section	.text.__clang_call_terminate,"axG",@progbits,__clang_call_terminate,comdat
	.hidden	__clang_call_terminate          // -- Begin function __clang_call_terminate
	.weak	__clang_call_terminate
	.p2align	2
	.type	__clang_call_terminate,@function
__clang_call_terminate:                 // @__clang_call_terminate
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-16]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__cxa_begin_catch
	bl	_ZSt9terminatev
.Lfunc_end19:
	.size	__clang_call_terminate, .Lfunc_end19-__clang_call_terminate
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag // -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
	.p2align	2
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag: // @_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	cmp	x1, x2
	b.eq	.LBB20_8
// %bb.1:
	mov	x20, #0                         // =0x0
	mov	x9, #-1                         // =0xffffffffffffffff
	mov	x8, x1
.LBB20_2:                               // =>This Inner Loop Header: Depth=1
	ldr	x8, [x8]
	add	x9, x9, #1
	add	x20, x20, #8
	cmp	x8, x2
	b.ne	.LBB20_2
// %bb.3:
	ldr	x8, [x0, #16]
	ldr	x19, [x0]
	sub	x8, x8, x19
	cmp	x9, x8, asr #3
	b.hs	.LBB20_10
// %bb.4:
	ldr	x8, [x0, #8]!
	sub	x10, x8, x19
	asr	x10, x10, #3
	cmp	x10, x9
	b.ls	.LBB20_16
.LBB20_5:                               // =>This Inner Loop Header: Depth=1
	ldr	x9, [x1, #8]
	str	x9, [x19], #8
	ldr	x1, [x1]
	cmp	x1, x2
	b.ne	.LBB20_5
// %bb.6:
	cmp	x8, x19
	b.ne	.LBB20_9
.LBB20_7:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB20_8:
	.cfi_restore_state
	.cfi_remember_state
	ldr	x19, [x0]
	ldr	x8, [x0, #8]!
	cmp	x8, x19
	b.eq	.LBB20_7
.LBB20_9:
	str	x19, [x0]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB20_10:
	.cfi_restore_state
	.cfi_remember_state
	mov	x8, #1152921504606846975        // =0xfffffffffffffff
	cmp	x9, x8
	b.hs	.LBB20_26
// %bb.11:
	mov	x24, x1
	mov	x23, x2
	mov	x22, x0
	mov	x0, x20
	bl	_Znwm
	mov	x21, x0
	mov	x8, x0
	mov	x9, x23
.LBB20_12:                              // =>This Inner Loop Header: Depth=1
	ldr	x10, [x24, #8]
	str	x10, [x8], #8
	ldr	x24, [x24]
	cmp	x24, x9
	b.ne	.LBB20_12
// %bb.13:
	cbz	x19, .LBB20_15
// %bb.14:
	mov	x0, x19
	bl	_ZdlPv
.LBB20_15:
	add	x8, x21, x20
	stp	x21, x8, [x22]
	str	x8, [x22, #16]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB20_16:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x8, x19
	b.eq	.LBB20_21
// %bb.17:
	mov	x9, x1
.LBB20_18:                              // =>This Inner Loop Header: Depth=1
	ldr	x9, [x9]
	subs	x10, x10, #1
	b.ne	.LBB20_18
// %bb.19:
	cmp	x9, x1
	b.eq	.LBB20_22
.LBB20_20:                              // =>This Inner Loop Header: Depth=1
	ldr	x10, [x1, #8]
	str	x10, [x19], #8
	ldr	x1, [x1]
	cmp	x1, x9
	b.ne	.LBB20_20
	b	.LBB20_24
.LBB20_21:
	mov	x9, x1
	b	.LBB20_24
.LBB20_22:
	mov	x9, x1
	b	.LBB20_24
.LBB20_23:                              //   in Loop: Header=BB20_24 Depth=1
	ldr	x10, [x9, #8]
	str	x10, [x8], #8
	ldr	x9, [x9]
.LBB20_24:                              // =>This Inner Loop Header: Depth=1
	cmp	x9, x2
	b.ne	.LBB20_23
// %bb.25:
	str	x8, [x0]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB20_26:
	.cfi_restore_state
	adrp	x0, .L.str.23
	add	x0, x0, :lo12:.L.str.23
	bl	_ZSt20__throw_length_errorPKc
.Lfunc_end20:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag, .Lfunc_end20-_ZNSt6vectorImSaImEE13_M_assign_auxINSt8__detail14_Node_iteratorImLb1ELb0EEEEEvT_S6_St20forward_iterator_tag
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag // -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
	.p2align	2
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag: // @_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-80]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	str	x25, [sp, #16]                  // 8-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 80
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
	.cfi_remember_state
	mov	x19, x0
	cmp	x2, x4
	b.eq	.LBB21_12
// %bb.1:
	mov	x22, #0                         // =0x0
	mov	x10, x2
	mov	x8, x1
	b	.LBB21_3
.LBB21_2:                               //   in Loop: Header=BB21_3 Depth=1
	and	w11, w11, #0xff
	cmp	w11, #255
	csel	x10, x10, xzr, ne
	add	x22, x9, #1
	cmp	x10, x4
	b.eq	.LBB21_5
.LBB21_3:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_4 Depth 2
	mov	x9, x22
	ldrsb	w11, [x8, #1]!
	add	x10, x10, #8
	cmn	w11, #2
	b.gt	.LBB21_2
.LBB21_4:                               //   Parent Loop BB21_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w11, [x8, #1]!
	add	x10, x10, #8
	cmn	w11, #1
	b.lt	.LBB21_4
	b	.LBB21_2
.LBB21_5:
	ldr	x8, [x19, #16]
	ldr	x20, [x19]
	sub	x8, x8, x20
	cmp	x9, x8, asr #3
	b.hs	.LBB21_16
// %bb.6:
	ldr	x8, [x19, #8]!
	sub	x10, x8, x20
	asr	x11, x10, #3
	cmp	x11, x9
	b.ls	.LBB21_25
// %bb.7:
	mov	w9, #-2                         // =0xfffffffe
	b	.LBB21_9
.LBB21_8:                               //   in Loop: Header=BB21_9 Depth=1
	cmp	w10, #255
	csel	x2, x2, xzr, ne
	cmp	x2, x4
	b.eq	.LBB21_13
.LBB21_9:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_10 Depth 2
	ldr	x10, [x2], #8
	str	x10, [x20], #8
	ldrb	w10, [x1, #1]!
	cmp	w9, w10, sxtb
	b.lt	.LBB21_8
.LBB21_10:                              //   Parent Loop BB21_9 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w10, [x1, #1]!
	add	x2, x2, #8
	cmn	w10, #1
	b.lt	.LBB21_10
// %bb.11:                              //   in Loop: Header=BB21_9 Depth=1
	and	w10, w10, #0xff
	b	.LBB21_8
.LBB21_12:
	ldr	x20, [x19]
	ldr	x8, [x19, #8]!
.LBB21_13:
	cmp	x8, x20
	b.eq	.LBB21_15
// %bb.14:
	str	x20, [x19]
.LBB21_15:
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldr	x25, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #80             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB21_16:
	.cfi_restore_state
	.cfi_remember_state
	mov	x8, #1152921504606846975        // =0xfffffffffffffff
	cmp	x9, x8
	b.hs	.LBB21_45
// %bb.17:
	mov	x23, x1
	mov	x24, x2
	mov	x25, x4
	lsl	x0, x22, #3
	bl	_Znwm
	mov	x21, x0
	mov	w8, #-2                         // =0xfffffffe
	mov	x9, x0
	mov	x10, x25
	mov	x11, x24
	mov	x12, x23
	b	.LBB21_19
.LBB21_18:                              //   in Loop: Header=BB21_19 Depth=1
	cmp	w13, #255
	csel	x11, x11, xzr, ne
	cmp	x11, x10
	b.eq	.LBB21_22
.LBB21_19:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_20 Depth 2
	ldr	x13, [x11], #8
	str	x13, [x9], #8
	ldrb	w13, [x12, #1]!
	cmp	w8, w13, sxtb
	b.lt	.LBB21_18
.LBB21_20:                              //   Parent Loop BB21_19 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w13, [x12, #1]!
	add	x11, x11, #8
	cmn	w13, #1
	b.lt	.LBB21_20
// %bb.21:                              //   in Loop: Header=BB21_19 Depth=1
	and	w13, w13, #0xff
	b	.LBB21_18
.LBB21_22:
	cbz	x20, .LBB21_24
// %bb.23:
	mov	x0, x20
	bl	_ZdlPv
.LBB21_24:
	add	x8, x21, x22, lsl #3
	stp	x21, x8, [x19]
	str	x8, [x19, #16]
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldr	x25, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #80             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB21_25:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x8, x20
	b.eq	.LBB21_36
// %bb.26:
	mov	x10, x2
	mov	x9, x1
	b	.LBB21_28
.LBB21_27:                              //   in Loop: Header=BB21_28 Depth=1
	and	w12, w12, #0xff
	cmp	w12, #255
	csel	x10, x10, xzr, ne
	sub	x11, x11, #1
	cbz	x11, .LBB21_30
.LBB21_28:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_29 Depth 2
	ldrsb	w12, [x9, #1]!
	add	x10, x10, #8
	cmn	w12, #2
	b.gt	.LBB21_27
.LBB21_29:                              //   Parent Loop BB21_28 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w12, [x9, #1]!
	add	x10, x10, #8
	cmn	w12, #1
	b.lt	.LBB21_29
	b	.LBB21_27
.LBB21_30:
	cmp	x10, x2
	b.eq	.LBB21_43
// %bb.31:
	mov	w11, #-2                        // =0xfffffffe
	b	.LBB21_33
.LBB21_32:                              //   in Loop: Header=BB21_33 Depth=1
	cmp	w12, #255
	csel	x2, x2, xzr, ne
	cmp	x2, x10
	b.eq	.LBB21_37
.LBB21_33:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_34 Depth 2
	ldr	x12, [x2], #8
	str	x12, [x20], #8
	ldrb	w12, [x1, #1]!
	cmp	w11, w12, sxtb
	b.lt	.LBB21_32
.LBB21_34:                              //   Parent Loop BB21_33 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w12, [x1, #1]!
	add	x2, x2, #8
	cmn	w12, #1
	b.lt	.LBB21_34
// %bb.35:                              //   in Loop: Header=BB21_33 Depth=1
	and	w12, w12, #0xff
	b	.LBB21_32
.LBB21_36:
	mov	x9, x1
	mov	x10, x2
.LBB21_37:
	cmp	x10, x4
	b.eq	.LBB21_44
.LBB21_38:
	mov	w11, #-2                        // =0xfffffffe
	b	.LBB21_40
.LBB21_39:                              //   in Loop: Header=BB21_40 Depth=1
	cmp	w12, #255
	csel	x10, x10, xzr, ne
	cmp	x10, x4
	b.eq	.LBB21_44
.LBB21_40:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB21_41 Depth 2
	ldr	x12, [x10], #8
	str	x12, [x8], #8
	ldrb	w12, [x9, #1]!
	cmp	w11, w12, sxtb
	b.lt	.LBB21_39
.LBB21_41:                              //   Parent Loop BB21_40 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldrsb	w12, [x9, #1]!
	add	x10, x10, #8
	cmn	w12, #1
	b.lt	.LBB21_41
// %bb.42:                              //   in Loop: Header=BB21_40 Depth=1
	and	w12, w12, #0xff
	b	.LBB21_39
.LBB21_43:
	mov	x10, x2
	cmp	x2, x4
	b.ne	.LBB21_38
.LBB21_44:
	str	x8, [x19]
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldr	x25, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #80             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB21_45:
	.cfi_restore_state
	adrp	x0, .L.str.23
	add	x0, x0, :lo12:.L.str.23
	bl	_ZSt20__throw_length_errorPKc
.Lfunc_end21:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag, .Lfunc_end21-_ZNSt6vectorImSaImEE13_M_assign_auxIN4absl12lts_2026081718container_internal12raw_hash_setINS5_17FlatHashSetPolicyImEEJEE8iteratorEEEvT_SB_St20forward_iterator_tag
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag // -- Begin function _ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
	.p2align	2
	.type	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag: // @_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	str	x27, [sp, #16]                  // 8-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	.cfi_remember_state
	cmp	x2, x3
	b.eq	.LBB22_13
// %bb.1:
	mov	x20, x2
	mov	x19, x1
	mov	x21, x0
	sub	x22, x3, x2
	asr	x8, x22, #3
	ldp	x23, x9, [x0, #8]
	sub	x9, x9, x23
	cmp	x9, x22
	b.hs	.LBB22_14
// %bb.2:
	ldr	x24, [x21]
	sub	x9, x23, x24
	asr	x9, x9, #3
	mov	x10, #1152921504606846975       // =0xfffffffffffffff
	sub	x11, x10, x9
	cmp	x11, x8
	b.lo	.LBB22_46
// %bb.3:
	cmp	x9, x8
	csel	x8, x9, x8, hi
	adds	x11, x8, x9
	cmp	x11, x10
	csel	x11, x11, x10, lo
	cmn	x8, x9
	csel	x27, x10, x11, hs
	cbz	x27, .LBB22_28
// %bb.4:
	lsl	x0, x27, #3
	bl	_Znwm
	mov	x25, x0
	sub	x26, x19, x24
	cmp	x26, #9
	b.lt	.LBB22_29
.LBB22_5:
	mov	x0, x25
	mov	x1, x24
	mov	x2, x26
	bl	memmove
.LBB22_6:
	add	x26, x25, x26
	cmp	x22, #9
	b.lt	.LBB22_31
// %bb.7:
	mov	x0, x26
	mov	x1, x20
	mov	x2, x22
	bl	memmove
.LBB22_8:
	add	x20, x26, x22
	sub	x22, x23, x19
	cmp	x22, #9
	b.lt	.LBB22_33
// %bb.9:
	mov	x0, x20
	mov	x1, x19
	mov	x2, x22
	bl	memmove
.LBB22_10:
	add	x19, x20, x22
	cbz	x24, .LBB22_12
// %bb.11:
	mov	x0, x24
	bl	_ZdlPv
.LBB22_12:
	stp	x25, x19, [x21]
	add	x8, x25, x27, lsl #3
	str	x8, [x21, #16]
.LBB22_13:
	.cfi_def_cfa wsp, 96
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldr	x27, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB22_14:
	.cfi_restore_state
	.cfi_remember_state
	sub	x24, x23, x19
	asr	x9, x24, #3
	subs	x25, x8, x9
	b.hs	.LBB22_21
// %bb.15:
	sub	x24, x23, x8, lsl #3
	cmp	x22, #9
	b.lt	.LBB22_35
// %bb.16:
	mov	x0, x23
	mov	x1, x24
	mov	x2, x22
	bl	memmove
.LBB22_17:
	ldr	x8, [x21, #8]
	add	x8, x8, x22
	str	x8, [x21, #8]
	sub	x2, x24, x19
	asr	x8, x2, #3
	cmp	x8, #2
	b.lt	.LBB22_37
// %bb.18:
	sub	x0, x23, x8, lsl #3
	mov	x1, x19
	bl	memmove
.LBB22_19:
	cmp	x22, #9
	b.lt	.LBB22_39
// %bb.20:
	mov	x0, x19
	mov	x1, x20
	mov	x2, x22
	.cfi_def_cfa wsp, 96
	b	.LBB22_27
.LBB22_21:
	.cfi_restore_state
	.cfi_remember_state
	add	x22, x20, x24
	sub	x2, x3, x22
	cmp	x2, #9
	b.lt	.LBB22_40
// %bb.22:
	mov	x0, x23
	mov	x1, x22
	bl	memmove
.LBB22_23:
	ldr	x8, [x21, #8]
	add	x0, x8, x25, lsl #3
	str	x0, [x21, #8]
	cmp	x24, #9
	b.lt	.LBB22_42
// %bb.24:
	mov	x1, x19
	mov	x2, x24
	bl	memmove
.LBB22_25:
	ldr	x8, [x21, #8]
	add	x8, x8, x24
	str	x8, [x21, #8]
	sub	x2, x22, x20
	cmp	x2, #9
	b.lt	.LBB22_44
// %bb.26:
	mov	x0, x19
	mov	x1, x20
	.cfi_def_cfa wsp, 96
.LBB22_27:
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldr	x27, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w30
	.cfi_restore w29
	b	memmove
.LBB22_28:
	.cfi_restore_state
	mov	x25, #0                         // =0x0
	sub	x26, x19, x24
	cmp	x26, #9
	b.ge	.LBB22_5
.LBB22_29:
	cmp	x26, #8
	b.ne	.LBB22_6
// %bb.30:
	ldr	x8, [x24]
	str	x8, [x25]
	b	.LBB22_6
.LBB22_31:
	cmp	x22, #8
	b.ne	.LBB22_8
// %bb.32:
	ldr	x8, [x20]
	str	x8, [x26]
	b	.LBB22_8
.LBB22_33:
	cmp	x22, #8
	b.ne	.LBB22_10
// %bb.34:
	ldr	x8, [x19]
	str	x8, [x20]
	b	.LBB22_10
.LBB22_35:
	cmp	x22, #8
	b.ne	.LBB22_17
// %bb.36:
	ldr	x8, [x24]
	str	x8, [x23]
	b	.LBB22_17
.LBB22_37:
	cmp	x2, #8
	b.ne	.LBB22_19
// %bb.38:
	ldr	x8, [x19]
	stur	x8, [x23, #-8]
	b	.LBB22_19
.LBB22_39:
	cmp	x22, #8
	b.ne	.LBB22_13
	b	.LBB22_45
.LBB22_40:
	cmp	x2, #8
	b.ne	.LBB22_23
// %bb.41:
	ldr	x8, [x22]
	str	x8, [x23]
	b	.LBB22_23
.LBB22_42:
	cmp	x24, #8
	b.ne	.LBB22_25
// %bb.43:
	ldr	x8, [x19]
	str	x8, [x0]
	b	.LBB22_25
.LBB22_44:
	cmp	x2, #8
	b.ne	.LBB22_13
.LBB22_45:
	ldr	x8, [x20]
	str	x8, [x19]
	b	.LBB22_13
.LBB22_46:
	adrp	x0, .L.str.30
	add	x0, x0, :lo12:.L.str.30
	bl	_ZSt20__throw_length_errorPKc
.Lfunc_end22:
	.size	_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag, .Lfunc_end22-_ZNSt6vectorImSaImEE15_M_range_insertIN9__gnu_cxx17__normal_iteratorIPmS1_EEEEvS6_T_S7_St20forward_iterator_tag
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,"axG",@progbits,_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,comdat
	.weak	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag // -- Begin function _ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.p2align	2
	.type	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag,@function
_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag: // @_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x19, x0
	sub	x21, x2, x1
	ldr	x8, [x0, #16]
	ldr	x20, [x0]
	sub	x8, x8, x20
	cmp	x21, x8
	b.ls	.LBB23_8
// %bb.1:
	mov	x8, #-7                         // =0xfffffffffffffff9
	movk	x8, #32767, lsl #48
	cmp	x21, x8
	b.hs	.LBB23_26
// %bb.2:
	mov	x23, x1
	mov	x0, x21
	bl	_Znwm
	mov	x22, x0
	cmp	x21, #9
	b.lt	.LBB23_18
// %bb.3:
	mov	x0, x22
	mov	x1, x23
	mov	x2, x21
	bl	memcpy
.LBB23_4:
	cbz	x20, .LBB23_6
// %bb.5:
	mov	x0, x20
	bl	_ZdlPv
.LBB23_6:
	add	x8, x22, x21
	stp	x22, x8, [x19]
	str	x8, [x19, #16]
.LBB23_7:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB23_8:
	.cfi_restore_state
	.cfi_remember_state
	ldr	x22, [x19, #8]
	sub	x8, x22, x20
	cmp	x8, x21
	b.hs	.LBB23_14
// %bb.9:
	add	x21, x1, x8
	cmp	x8, #9
	b.lt	.LBB23_20
// %bb.10:
	mov	x0, x20
	mov	x20, x2
	mov	x2, x8
	bl	memmove
	mov	x2, x20
	ldr	x22, [x19, #8]
.LBB23_11:
	sub	x20, x2, x21
	cmp	x20, #9
	b.lt	.LBB23_22
// %bb.12:
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	bl	memmove
.LBB23_13:
	add	x8, x22, x20
	str	x8, [x19, #8]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB23_14:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x21, #9
	b.lt	.LBB23_24
// %bb.15:
	mov	x0, x20
	mov	x2, x21
	bl	memmove
	ldr	x22, [x19, #8]
.LBB23_16:
	add	x8, x20, x21
	cmp	x22, x8
	b.eq	.LBB23_7
// %bb.17:
	str	x8, [x19, #8]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB23_18:
	.cfi_restore_state
	cmp	x21, #8
	b.ne	.LBB23_4
// %bb.19:
	ldr	x8, [x23]
	str	x8, [x22]
	b	.LBB23_4
.LBB23_20:
	cmp	x8, #8
	b.ne	.LBB23_11
// %bb.21:
	ldr	x8, [x1]
	str	x8, [x20]
	b	.LBB23_11
.LBB23_22:
	cmp	x20, #8
	b.ne	.LBB23_13
// %bb.23:
	ldr	x8, [x21]
	str	x8, [x22]
	b	.LBB23_13
.LBB23_24:
	cmp	x21, #8
	b.ne	.LBB23_16
// %bb.25:
	ldr	x8, [x1]
	str	x8, [x20]
	b	.LBB23_16
.LBB23_26:
	adrp	x0, .L.str.23
	add	x0, x0, :lo12:.L.str.23
	bl	_ZSt20__throw_length_errorPKc
.Lfunc_end23:
	.size	_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag, .Lfunc_end23-_ZNSt6vectorImSaImEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPKmS1_EEEEvT_S8_St20forward_iterator_tag
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,"axG",@progbits,_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,comdat
	.weak	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_ // -- Begin function _ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.p2align	2
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_,@function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_: // @_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_startproc
// %bb.0:
	sub	x8, x1, x0
	asr	x8, x8, #3
	cmp	x8, #17
	b.lt	.LBB24_36
// %bb.1:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	mov	x20, x2
	mov	x19, x0
	add	x22, x0, #8
	neg	x23, x0
	b	.LBB24_3
.LBB24_2:                               //   in Loop: Header=BB24_3 Depth=1
	mov	x0, x21
	mov	x2, x20
	bl	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	add	x8, x23, x21
	asr	x8, x8, #3
	mov	x1, x21
	cmp	x8, #16
	b.le	.LBB24_35
.LBB24_3:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB24_16 Depth 2
                                        //       Child Loop BB24_17 Depth 3
                                        //       Child Loop BB24_19 Depth 3
	cbz	x20, .LBB24_22
// %bb.4:                               //   in Loop: Header=BB24_3 Depth=1
	lsr	x8, x8, #1
	ldr	d1, [x19, #8]
	ldr	d2, [x19, x8, lsl #3]
	ldur	d0, [x1, #-8]
	fcmp	d1, d2
	b.pl	.LBB24_7
// %bb.5:                               //   in Loop: Header=BB24_3 Depth=1
	fcmp	d2, d0
	b.pl	.LBB24_9
// %bb.6:                               //   in Loop: Header=BB24_3 Depth=1
	ldr	d0, [x19]
	str	d2, [x19]
	str	d0, [x19, x8, lsl #3]
	b	.LBB24_15
.LBB24_7:                               //   in Loop: Header=BB24_3 Depth=1
	fcmp	d1, d0
	b.pl	.LBB24_11
// %bb.8:                               //   in Loop: Header=BB24_3 Depth=1
	ldr	d0, [x19]
	stp	d1, d0, [x19]
	b	.LBB24_15
.LBB24_9:                               //   in Loop: Header=BB24_3 Depth=1
	ldr	d2, [x19]
	fcmp	d1, d0
	b.pl	.LBB24_13
// %bb.10:                              //   in Loop: Header=BB24_3 Depth=1
	str	d0, [x19]
	stur	d2, [x1, #-8]
	b	.LBB24_15
.LBB24_11:                              //   in Loop: Header=BB24_3 Depth=1
	ldr	d1, [x19]
	fcmp	d2, d0
	b.pl	.LBB24_14
// %bb.12:                              //   in Loop: Header=BB24_3 Depth=1
	str	d0, [x19]
	stur	d1, [x1, #-8]
	b	.LBB24_15
.LBB24_13:                              //   in Loop: Header=BB24_3 Depth=1
	stp	d1, d2, [x19]
	b	.LBB24_15
.LBB24_14:                              //   in Loop: Header=BB24_3 Depth=1
	str	d2, [x19]
	str	d1, [x19, x8, lsl #3]
.LBB24_15:                              //   in Loop: Header=BB24_3 Depth=1
	sub	x20, x20, #1
	mov	x8, x1
	mov	x9, x22
.LBB24_16:                              //   Parent Loop BB24_3 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB24_17 Depth 3
                                        //       Child Loop BB24_19 Depth 3
	ldr	d0, [x19]
	sub	x21, x9, #8
.LBB24_17:                              //   Parent Loop BB24_3 Depth=1
                                        //     Parent Loop BB24_16 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	d1, [x9], #8
	add	x21, x21, #8
	fcmp	d1, d0
	b.mi	.LBB24_17
// %bb.18:                              //   in Loop: Header=BB24_16 Depth=2
	sub	x10, x9, #8
.LBB24_19:                              //   Parent Loop BB24_3 Depth=1
                                        //     Parent Loop BB24_16 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	d2, [x8, #-8]!
	fcmp	d0, d2
	b.mi	.LBB24_19
// %bb.20:                              //   in Loop: Header=BB24_16 Depth=2
	cmp	x10, x8
	b.hs	.LBB24_2
// %bb.21:                              //   in Loop: Header=BB24_16 Depth=2
	str	d2, [x10]
	str	d1, [x8]
	b	.LBB24_16
.LBB24_22:
	mov	x0, x19
	mov	x20, x1
	mov	x2, x1
	bl	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	mov	w8, #1                          // =0x1
	b	.LBB24_25
.LBB24_23:                              //   in Loop: Header=BB24_25 Depth=1
	mov	x10, #0                         // =0x0
.LBB24_24:                              //   in Loop: Header=BB24_25 Depth=1
	str	d0, [x19, x10, lsl #3]
	cmp	x9, #8
	b.le	.LBB24_35
.LBB24_25:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB24_27 Depth 2
                                        //     Child Loop BB24_33 Depth 2
	ldr	d0, [x20, #-8]!
	ldr	d1, [x19]
	str	d1, [x20]
	sub	x9, x20, x19
	asr	x11, x9, #3
	subs	x10, x11, #1
	csel	x10, x11, x10, lt
	cmp	x11, #3
	b.lt	.LBB24_29
// %bb.26:                              //   in Loop: Header=BB24_25 Depth=1
	mov	x13, #0                         // =0x0
	asr	x12, x10, #1
.LBB24_27:                              //   Parent Loop BB24_25 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x10, x13, #1
	add	x10, x10, #2
	mov	w14, #1                         // =0x1
	bfi	x14, x13, #1, #63
	ldr	d1, [x19, x10, lsl #3]
	ldr	d2, [x19, x14, lsl #3]
	fcmp	d1, d2
	csel	x10, x14, x10, mi
	ldr	d1, [x19, x10, lsl #3]
	str	d1, [x19, x13, lsl #3]
	mov	x13, x10
	cmp	x10, x12
	b.lt	.LBB24_27
// %bb.28:                              //   in Loop: Header=BB24_25 Depth=1
	tbz	w9, #3, .LBB24_30
	b	.LBB24_32
.LBB24_29:                              //   in Loop: Header=BB24_25 Depth=1
	mov	x10, #0                         // =0x0
	tbnz	w9, #3, .LBB24_32
.LBB24_30:                              //   in Loop: Header=BB24_25 Depth=1
	sub	x11, x11, #2
	cmp	x10, x11, asr #1
	b.ne	.LBB24_32
// %bb.31:                              //   in Loop: Header=BB24_25 Depth=1
	orr	x11, x8, x10, lsl #1
	ldr	d1, [x19, x11, lsl #3]
	str	d1, [x19, x10, lsl #3]
	mov	x10, x11
.LBB24_32:                              //   in Loop: Header=BB24_25 Depth=1
	cmp	x10, #1
	b.lt	.LBB24_24
.LBB24_33:                              //   Parent Loop BB24_25 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x11, x10, #1
	lsr	x12, x11, #1
	ldr	d1, [x19, x12, lsl #3]
	fcmp	d1, d0
	b.pl	.LBB24_24
// %bb.34:                              //   in Loop: Header=BB24_33 Depth=2
	str	d1, [x19, x10, lsl #3]
	mov	x10, x12
	cmp	x11, #1
	b.hi	.LBB24_33
	b	.LBB24_23
.LBB24_35:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
.LBB24_36:
	ret
.Lfunc_end24:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_, .Lfunc_end24-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,"axG",@progbits,_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,comdat
	.weak	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_ // -- Begin function _ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.p2align	2
	.type	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_,@function
_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_: // @_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_startproc
// %bb.0:
	str	d8, [sp, #-64]!                 // 8-byte Folded Spill
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #8]              // 16-byte Folded Spill
	str	x23, [sp, #24]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	add	x29, sp, #8
	.cfi_def_cfa w29, 56
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w30, -48
	.cfi_offset w29, -56
	.cfi_offset b8, -64
	mov	x19, x1
	mov	x20, x0
	sub	x8, x1, x0
	cmp	x8, #129
	b.lt	.LBB25_12
// %bb.1:
	add	x21, x20, #8
	mov	w22, #8                         // =0x8
	mov	x23, x20
	b	.LBB25_6
.LBB25_2:                               //   in Loop: Header=BB25_6 Depth=1
	sub	x2, x23, x20
	asr	x9, x2, #3
	cmp	x9, #2
	b.lt	.LBB25_10
// %bb.3:                               //   in Loop: Header=BB25_6 Depth=1
	sub	x8, x8, x9, lsl #3
	add	x0, x8, #16
	mov	x1, x20
	bl	memmove
.LBB25_4:                               //   in Loop: Header=BB25_6 Depth=1
	mov	x9, x20
.LBB25_5:                               //   in Loop: Header=BB25_6 Depth=1
	str	d8, [x9]
	add	x22, x22, #8
	add	x21, x21, #8
	cmp	x22, #128
	b.eq	.LBB25_25
.LBB25_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB25_9 Depth 2
	mov	x8, x23
	add	x23, x20, x22
	ldr	d8, [x23]
	ldr	d0, [x20]
	fcmp	d8, d0
	b.mi	.LBB25_2
// %bb.7:                               //   in Loop: Header=BB25_6 Depth=1
	ldr	d0, [x8]
	fcmp	d8, d0
	mov	x9, x23
	b.pl	.LBB25_5
// %bb.8:                               //   in Loop: Header=BB25_6 Depth=1
	mov	x9, x21
.LBB25_9:                               //   Parent Loop BB25_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	d0, [x9]
	ldur	d0, [x9, #-16]
	sub	x9, x9, #8
	fcmp	d8, d0
	b.mi	.LBB25_9
	b	.LBB25_5
.LBB25_10:                              //   in Loop: Header=BB25_6 Depth=1
	mov	x9, x20
	cmp	x2, #8
	b.ne	.LBB25_5
// %bb.11:                              //   in Loop: Header=BB25_6 Depth=1
	str	d0, [x8, #8]
	b	.LBB25_4
.LBB25_12:
	cmp	x20, x19
	b.eq	.LBB25_31
// %bb.13:
	add	x8, x20, #8
	cmp	x8, x19
	b.eq	.LBB25_31
// %bb.14:
	mov	x21, x20
	b	.LBB25_19
.LBB25_15:                              //   in Loop: Header=BB25_19 Depth=1
	sub	x2, x21, x20
	asr	x8, x2, #3
	cmp	x8, #2
	b.lt	.LBB25_23
// %bb.16:                              //   in Loop: Header=BB25_19 Depth=1
	sub	x8, x9, x8, lsl #3
	add	x0, x8, #16
	mov	x1, x20
	bl	memmove
.LBB25_17:                              //   in Loop: Header=BB25_19 Depth=1
	mov	x8, x20
.LBB25_18:                              //   in Loop: Header=BB25_19 Depth=1
	str	d8, [x8]
	add	x8, x21, #8
	cmp	x8, x19
	b.eq	.LBB25_31
.LBB25_19:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB25_22 Depth 2
	mov	x9, x21
	mov	x21, x8
	ldr	d8, [x8]
	ldr	d0, [x20]
	fcmp	d8, d0
	b.mi	.LBB25_15
// %bb.20:                              //   in Loop: Header=BB25_19 Depth=1
	ldr	d0, [x9]
	fcmp	d8, d0
	mov	x8, x21
	b.pl	.LBB25_18
// %bb.21:                              //   in Loop: Header=BB25_19 Depth=1
	mov	x8, x21
.LBB25_22:                              //   Parent Loop BB25_19 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	d0, [x8]
	ldur	d0, [x8, #-16]
	sub	x8, x8, #8
	fcmp	d8, d0
	b.mi	.LBB25_22
	b	.LBB25_18
.LBB25_23:                              //   in Loop: Header=BB25_19 Depth=1
	mov	x8, x20
	cmp	x2, #8
	b.ne	.LBB25_18
// %bb.24:                              //   in Loop: Header=BB25_19 Depth=1
	str	d0, [x9, #8]
	b	.LBB25_17
.LBB25_25:
	add	x8, x20, #128
	b	.LBB25_27
.LBB25_26:                              //   in Loop: Header=BB25_27 Depth=1
	str	d0, [x9]
	add	x8, x8, #8
.LBB25_27:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB25_30 Depth 2
	cmp	x8, x19
	b.eq	.LBB25_31
// %bb.28:                              //   in Loop: Header=BB25_27 Depth=1
	ldp	d1, d0, [x8, #-8]
	fcmp	d0, d1
	mov	x9, x8
	b.pl	.LBB25_26
// %bb.29:                              //   in Loop: Header=BB25_27 Depth=1
	mov	x9, x8
.LBB25_30:                              //   Parent Loop BB25_27 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	d1, [x9]
	ldur	d1, [x9, #-16]
	sub	x9, x9, #8
	fcmp	d0, d1
	b.mi	.LBB25_30
	b	.LBB25_26
.LBB25_31:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #24]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp, #8]              // 16-byte Folded Reload
	ldr	d8, [sp], #64                   // 8-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	.cfi_restore b8
	ret
.Lfunc_end25:
	.size	_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_, .Lfunc_end25-_ZSt22__final_insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"axG",@progbits,_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.weak	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_ // -- Begin function _ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.p2align	2
	.type	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,@function
_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_: // @_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
	strb	w3, [x29, #28]
	add	x2, x29, #28
	bl	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	cmp	x20, x19
	b.hs	.LBB26_28
// %bb.1:
	sub	x8, x20, x21
	asr	x10, x8, #3
	subs	x9, x10, #1
	csel	x9, x10, x9, lt
	sub	x11, x10, #2
	cmp	x10, #3
	b.lt	.LBB26_15
// %bb.2:
	asr	x9, x9, #1
	asr	x10, x11, #1
	orr	x11, x11, #0x1
	b	.LBB26_6
.LBB26_3:                               //   in Loop: Header=BB26_6 Depth=1
	mov	x12, #0                         // =0x0
.LBB26_4:                               //   in Loop: Header=BB26_6 Depth=1
	str	d0, [x21, x12, lsl #3]
.LBB26_5:                               //   in Loop: Header=BB26_6 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB26_28
.LBB26_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB26_8 Depth 2
                                        //     Child Loop BB26_13 Depth 2
	ldr	d0, [x20]
	ldr	d1, [x21]
	fcmp	d0, d1
	b.pl	.LBB26_5
// %bb.7:                               //   in Loop: Header=BB26_6 Depth=1
	mov	x12, #0                         // =0x0
	str	d1, [x20]
.LBB26_8:                               //   Parent Loop BB26_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x13, x12
	lsl	x12, x12, #1
	add	x12, x12, #2
	mov	w14, #1                         // =0x1
	bfi	x14, x13, #1, #63
	ldr	d1, [x21, x12, lsl #3]
	ldr	d2, [x21, x14, lsl #3]
	fcmp	d1, d2
	csel	x12, x14, x12, mi
	ldr	d1, [x21, x12, lsl #3]
	str	d1, [x21, x13, lsl #3]
	cmp	x12, x9
	b.lt	.LBB26_8
// %bb.9:                               //   in Loop: Header=BB26_6 Depth=1
	tbnz	w8, #3, .LBB26_12
// %bb.10:                              //   in Loop: Header=BB26_6 Depth=1
	cmp	x12, x10
	b.ne	.LBB26_12
// %bb.11:                              //   in Loop: Header=BB26_6 Depth=1
	ldr	d1, [x21, x11, lsl #3]
	str	d1, [x21, x10, lsl #3]
	mov	x12, x11
.LBB26_12:                              //   in Loop: Header=BB26_6 Depth=1
	cmp	x12, #1
	b.lt	.LBB26_4
.LBB26_13:                              //   Parent Loop BB26_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x13, x12, #1
	lsr	x14, x13, #1
	ldr	d1, [x21, x14, lsl #3]
	fcmp	d1, d0
	b.pl	.LBB26_4
// %bb.14:                              //   in Loop: Header=BB26_13 Depth=2
	str	d1, [x21, x12, lsl #3]
	mov	x12, x14
	cmp	x13, #1
	b.hi	.LBB26_13
	b	.LBB26_3
.LBB26_15:
	tbnz	w8, #3, .LBB26_24
// %bb.16:
	cbz	x11, .LBB26_22
// %bb.17:
	ldr	d0, [x21]
	b	.LBB26_19
.LBB26_18:                              //   in Loop: Header=BB26_19 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB26_28
.LBB26_19:                              // =>This Inner Loop Header: Depth=1
	ldr	d1, [x20]
	fcmp	d1, d0
	b.pl	.LBB26_18
// %bb.20:                              //   in Loop: Header=BB26_19 Depth=1
	str	d0, [x20]
	str	d1, [x21]
	fmov	d0, d1
	b	.LBB26_18
.LBB26_21:                              //   in Loop: Header=BB26_22 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB26_28
.LBB26_22:                              // =>This Inner Loop Header: Depth=1
	ldr	d0, [x20]
	ldr	d1, [x21]
	fcmp	d0, d1
	b.pl	.LBB26_21
// %bb.23:                              //   in Loop: Header=BB26_22 Depth=1
	str	d1, [x20]
	ldr	d1, [x21, #8]
	str	d1, [x21]
	fcmp	d1, d0
	cset	w8, pl
	str	d0, [x21, w8, uxtw #3]
	b	.LBB26_21
.LBB26_24:
	ldr	d0, [x21]
	b	.LBB26_26
.LBB26_25:                              //   in Loop: Header=BB26_26 Depth=1
	add	x20, x20, #8
	cmp	x20, x19
	b.hs	.LBB26_28
.LBB26_26:                              // =>This Inner Loop Header: Depth=1
	ldr	d1, [x20]
	fcmp	d1, d0
	b.pl	.LBB26_25
// %bb.27:                              //   in Loop: Header=BB26_26 Depth=1
	str	d0, [x20]
	str	d1, [x21]
	fmov	d0, d1
	b	.LBB26_25
.LBB26_28:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end26:
	.size	_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_, .Lfunc_end26-_ZSt13__heap_selectIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,"axG",@progbits,_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,comdat
	.weak	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_ // -- Begin function _ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.p2align	2
	.type	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_,@function
_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_: // @_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_startproc
// %bb.0:
	sub	x11, x1, x0
	asr	x8, x11, #3
	subs	x10, x8, #2
	b.ge	.LBB27_2
.LBB27_1:
	ret
.LBB27_2:
	lsr	x9, x10, #1
	sub	x8, x8, #1
	lsr	x8, x8, #1
	tbnz	w11, #3, .LBB27_16
// %bb.3:
	orr	x10, x10, #0x1
	mov	x12, x9
	b	.LBB27_6
.LBB27_4:                               //   in Loop: Header=BB27_6 Depth=1
	mov	x13, x12
.LBB27_5:                               //   in Loop: Header=BB27_6 Depth=1
	str	d0, [x0, x13, lsl #3]
	sub	x12, x11, #1
	cbz	x11, .LBB27_1
.LBB27_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB27_8 Depth 2
                                        //     Child Loop BB27_12 Depth 2
	mov	x11, x12
	ldr	d0, [x0, x12, lsl #3]
	cmp	x8, x12
	b.le	.LBB27_9
// %bb.7:                               //   in Loop: Header=BB27_6 Depth=1
	mov	x13, x11
.LBB27_8:                               //   Parent Loop BB27_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x12, x13, #1
	add	x12, x12, #2
	mov	w14, #1                         // =0x1
	bfi	x14, x13, #1, #63
	ldr	d1, [x0, x12, lsl #3]
	ldr	d2, [x0, x14, lsl #3]
	fcmp	d1, d2
	csel	x12, x14, x12, mi
	ldr	d1, [x0, x12, lsl #3]
	str	d1, [x0, x13, lsl #3]
	mov	x13, x12
	cmp	x12, x8
	b.lt	.LBB27_8
.LBB27_9:                               //   in Loop: Header=BB27_6 Depth=1
	cmp	x12, x9
	b.ne	.LBB27_11
// %bb.10:                              //   in Loop: Header=BB27_6 Depth=1
	ldr	d1, [x0, x10, lsl #3]
	str	d1, [x0, x9, lsl #3]
	mov	x12, x10
.LBB27_11:                              //   in Loop: Header=BB27_6 Depth=1
	cmp	x12, x11
	b.le	.LBB27_4
.LBB27_12:                              //   Parent Loop BB27_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	subs	x13, x12, #1
	csel	x13, x12, x13, lt
	asr	x13, x13, #1
	ldr	d1, [x0, x13, lsl #3]
	fcmp	d1, d0
	b.pl	.LBB27_4
// %bb.13:                              //   in Loop: Header=BB27_12 Depth=2
	str	d1, [x0, x12, lsl #3]
	mov	x12, x13
	cmp	x13, x11
	b.gt	.LBB27_12
	b	.LBB27_5
.LBB27_14:                              //   in Loop: Header=BB27_16 Depth=1
	mov	x11, x9
.LBB27_15:                              //   in Loop: Header=BB27_16 Depth=1
	str	d0, [x0, x11, lsl #3]
	sub	x9, x10, #1
	cbz	x10, .LBB27_1
.LBB27_16:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB27_18 Depth 2
                                        //     Child Loop BB27_20 Depth 2
	mov	x10, x9
	ldr	d0, [x0, x9, lsl #3]
	mov	x11, x9
	cmp	x8, x9
	b.le	.LBB27_15
// %bb.17:                              //   in Loop: Header=BB27_16 Depth=1
	mov	x9, x10
.LBB27_18:                              //   Parent Loop BB27_16 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	mov	x11, x9
	lsl	x9, x9, #1
	add	x9, x9, #2
	mov	w12, #1                         // =0x1
	bfi	x12, x11, #1, #63
	ldr	d1, [x0, x9, lsl #3]
	ldr	d2, [x0, x12, lsl #3]
	fcmp	d1, d2
	csel	x9, x12, x9, mi
	ldr	d1, [x0, x9, lsl #3]
	str	d1, [x0, x11, lsl #3]
	cmp	x9, x8
	b.lt	.LBB27_18
// %bb.19:                              //   in Loop: Header=BB27_16 Depth=1
	cmp	x9, x10
	b.le	.LBB27_14
.LBB27_20:                              //   Parent Loop BB27_16 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	subs	x11, x9, #1
	csel	x11, x9, x11, lt
	asr	x11, x11, #1
	ldr	d1, [x0, x11, lsl #3]
	fcmp	d1, d0
	b.pl	.LBB27_14
// %bb.21:                              //   in Loop: Header=BB27_20 Depth=2
	str	d1, [x0, x9, lsl #3]
	mov	x9, x11
	cmp	x11, x10
	b.gt	.LBB27_20
	b	.LBB27_15
.Lfunc_end27:
	.size	_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_, .Lfunc_end27-_ZSt11__make_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_RT0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm // -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	.p2align	2
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm: // @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception2
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	mov	x19, x0
	mov	x20, x0
	ldr	s0, [x20, #32]!
	ldr	x21, [x20, #8]
	ldur	x8, [x20, #-8]
	add	x8, x8, #1
	ucvtf	d1, x8
	fcvt	d0, s0
	fdiv	d0, d1, d0
	fcvtpu	x8, d0
	cmp	x8, x1
	csel	x1, x8, x1, hi
	mov	x0, x20
	bl	_ZNKSt8__detail20_Prime_rehash_policy11_M_next_bktEm
	ldur	x8, [x20, #-24]
	cmp	x0, x8
	b.ne	.LBB28_2
// %bb.1:
	str	x21, [x19, #40]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB28_2:
	.cfi_restore_state
	.cfi_remember_state
.Ltmp256:
	mov	x1, x0
	mov	x0, x19
	bl	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
.Ltmp257:
// %bb.3:
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB28_4:
	.cfi_restore_state
.Ltmp258:
	bl	__cxa_begin_catch
	str	x21, [x19, #40]
.Ltmp259:
	bl	__cxa_rethrow
.Ltmp260:
// %bb.5:
.LBB28_6:
.Ltmp261:
	mov	x19, x0
.Ltmp262:
	bl	__cxa_end_catch
.Ltmp263:
// %bb.7:
	mov	x0, x19
	bl	_Unwind_Resume
.LBB28_8:
.Ltmp264:
	bl	__clang_call_terminate
.Lfunc_end28:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm, .Lfunc_end28-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE6rehashEm,comdat
	.p2align	2, 0x0
GCC_except_table28:
.Lexception2:
	.byte	255                             // @LPStart Encoding = omit
	.byte	156                             // @TType Encoding = indirect pcrel sdata8
	.uleb128 .Lttbase1-.Lttbaseref1
.Lttbaseref1:
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Lfunc_begin2-.Lfunc_begin2    // >> Call Site 1 <<
	.uleb128 .Ltmp256-.Lfunc_begin2         //   Call between .Lfunc_begin2 and .Ltmp256
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp256-.Lfunc_begin2         // >> Call Site 2 <<
	.uleb128 .Ltmp257-.Ltmp256              //   Call between .Ltmp256 and .Ltmp257
	.uleb128 .Ltmp258-.Lfunc_begin2         //     jumps to .Ltmp258
	.byte	1                               //   On action: 1
	.uleb128 .Ltmp257-.Lfunc_begin2         // >> Call Site 3 <<
	.uleb128 .Ltmp259-.Ltmp257              //   Call between .Ltmp257 and .Ltmp259
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp259-.Lfunc_begin2         // >> Call Site 4 <<
	.uleb128 .Ltmp260-.Ltmp259              //   Call between .Ltmp259 and .Ltmp260
	.uleb128 .Ltmp261-.Lfunc_begin2         //     jumps to .Ltmp261
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp262-.Lfunc_begin2         // >> Call Site 5 <<
	.uleb128 .Ltmp263-.Ltmp262              //   Call between .Ltmp262 and .Ltmp263
	.uleb128 .Ltmp264-.Lfunc_begin2         //     jumps to .Ltmp264
	.byte	1                               //   On action: 1
	.uleb128 .Ltmp263-.Lfunc_begin2         // >> Call Site 6 <<
	.uleb128 .Lfunc_end28-.Ltmp263          //   Call between .Ltmp263 and .Lfunc_end28
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
.Lcst_end2:
	.byte	1                               // >> Action Record 1 <<
                                        //   Catch TypeInfo 1
	.byte	0                               //   No further actions
	.p2align	2, 0x0
                                        // >> Catch TypeInfos <<
	.xword	0                               // TypeInfo 1
.Lttbase1:
	.p2align	2, 0x0
                                        // -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE // -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.p2align	2
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE: // @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	mov	x19, x1
	mov	x20, x0
	cmp	x1, #1
	b.eq	.LBB29_10
// %bb.1:
	lsr	x8, x19, #60
	cbnz	x8, .LBB29_14
// %bb.2:
	lsl	x22, x19, #3
	mov	x0, x22
	bl	_Znwm
	mov	x21, x0
	mov	w1, #0                          // =0x0
	mov	x2, x22
	bl	memset
	mov	x8, x20
	ldr	x9, [x8, #16]!
	str	xzr, [x8]
	cbz	x9, .LBB29_11
.LBB29_3:
	mov	x12, #0                         // =0x0
	b	.LBB29_7
.LBB29_4:                               //   in Loop: Header=BB29_7 Depth=1
	ldr	x13, [x13]
	str	x13, [x9]
	ldr	x13, [x21, x11, lsl #3]
	mov	x11, x12
.LBB29_5:                               //   in Loop: Header=BB29_7 Depth=1
	str	x9, [x13]
.LBB29_6:                               //   in Loop: Header=BB29_7 Depth=1
	mov	x9, x10
	mov	x12, x11
	cbz	x10, .LBB29_11
.LBB29_7:                               // =>This Inner Loop Header: Depth=1
	ldp	x10, x11, [x9]
	udiv	x13, x11, x19
	msub	x11, x13, x19, x11
	ldr	x13, [x21, x11, lsl #3]
	cbnz	x13, .LBB29_4
// %bb.8:                               //   in Loop: Header=BB29_7 Depth=1
	ldr	x13, [x8]
	str	x13, [x9]
	str	x9, [x8]
	str	x8, [x21, x11, lsl #3]
	ldr	x13, [x9]
	cbz	x13, .LBB29_6
// %bb.9:                               //   in Loop: Header=BB29_7 Depth=1
	add	x13, x21, x12, lsl #3
	b	.LBB29_5
.LBB29_10:
	mov	x21, x20
	str	xzr, [x21, #48]!
	mov	x8, x20
	ldr	x9, [x8, #16]!
	str	xzr, [x8]
	cbnz	x9, .LBB29_3
.LBB29_11:
	mov	x8, x20
	ldr	x0, [x8], #48
	cmp	x8, x0
	b.eq	.LBB29_13
// %bb.12:
	bl	_ZdlPv
.LBB29_13:
	stp	x21, x19, [x20]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB29_14:
	.cfi_restore_state
	lsr	x8, x19, #61
	cbz	x8, .LBB29_16
// %bb.15:
	bl	_ZSt28__throw_bad_array_new_lengthv
.LBB29_16:
	bl	_ZSt17__throw_bad_allocv
.Lfunc_end29:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE, .Lfunc_end29-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_ // -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	.p2align	2
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_: // @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
.Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception3
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x8, x0
	ldr	x9, [x0, #24]
	cbz	x9, .LBB30_7
// %bb.1:
	ldr	x19, [x1]
	ldp	x10, x9, [x8]
	udiv	x11, x19, x9
	msub	x20, x11, x9, x19
	ldr	x10, [x10, x20, lsl #3]
	cbz	x10, .LBB30_6
// %bb.2:
	ldr	x0, [x10]
	ldr	x10, [x0, #8]
.LBB30_3:                               // =>This Inner Loop Header: Depth=1
	cmp	x19, x10
	b.eq	.LBB30_11
// %bb.4:                               //   in Loop: Header=BB30_3 Depth=1
	ldr	x0, [x0]
	cbz	x0, .LBB30_6
// %bb.5:                               //   in Loop: Header=BB30_3 Depth=1
	ldr	x10, [x0, #8]
	udiv	x11, x10, x9
	msub	x11, x11, x9, x10
	cmp	x11, x20
	b.eq	.LBB30_3
.LBB30_6:
	mov	x21, x8
	b	.LBB30_13
.LBB30_7:
	add	x0, x8, #16
	ldr	x19, [x1]
.LBB30_8:                               // =>This Inner Loop Header: Depth=1
	ldr	x0, [x0]
	cbz	x0, .LBB30_12
// %bb.9:                               //   in Loop: Header=BB30_8 Depth=1
	ldr	x9, [x0, #8]
	cmp	x19, x9
	b.ne	.LBB30_8
// %bb.10:
	mov	x22, #0                         // =0x0
	mov	x1, x22
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB30_11:
	.cfi_restore_state
	.cfi_remember_state
	mov	x22, #0                         // =0x0
	mov	x1, x22
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB30_12:
	.cfi_restore_state
	.cfi_remember_state
	mov	x21, x8
	ldr	x8, [x8, #8]
	udiv	x9, x19, x8
	msub	x20, x9, x8, x19
.LBB30_13:
	mov	w0, #16                         // =0x10
	bl	_Znwm
	mov	x23, x0
	stp	xzr, x19, [x0]
	mov	w22, #1                         // =0x1
.Ltmp265:
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	mov	x3, x23
	mov	w4, #1                          // =0x1
	bl	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
.Ltmp266:
// %bb.14:
	mov	x1, x22
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB30_15:
	.cfi_restore_state
.Ltmp267:
	mov	x19, x0
	mov	x0, x23
	bl	_ZdlPv
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end30:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_, .Lfunc_end30-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE16_M_insert_uniqueIRKmSF_NS1_10_AllocNodeISaINS1_10_Hash_nodeImLb0EEEEEEEESt4pairINS1_14_Node_iteratorImLb1ELb0EEEbEOT_OT0_RKT1_,comdat
	.p2align	2, 0x0
GCC_except_table30:
.Lexception3:
	.byte	255                             // @LPStart Encoding = omit
	.byte	255                             // @TType Encoding = omit
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end3-.Lcst_begin3
.Lcst_begin3:
	.uleb128 .Lfunc_begin3-.Lfunc_begin3    // >> Call Site 1 <<
	.uleb128 .Ltmp265-.Lfunc_begin3         //   Call between .Lfunc_begin3 and .Ltmp265
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp265-.Lfunc_begin3         // >> Call Site 2 <<
	.uleb128 .Ltmp266-.Ltmp265              //   Call between .Ltmp265 and .Ltmp266
	.uleb128 .Ltmp267-.Lfunc_begin3         //     jumps to .Ltmp267
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp266-.Lfunc_begin3         // >> Call Site 3 <<
	.uleb128 .Lfunc_end30-.Ltmp266          //   Call between .Ltmp266 and .Lfunc_end30
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
.Lcst_end3:
	.p2align	2, 0x0
                                        // -- End function
	.section	.text._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,"axG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,comdat
	.weak	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm // -- Begin function _ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
	.p2align	2
	.type	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,@function
_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm: // @_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
.Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception4
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x20, x3
	mov	x22, x2
	mov	x21, x1
	mov	x19, x0
	ldr	x23, [x0, #40]
	ldr	x1, [x0, #8]
	ldr	x2, [x0, #24]
	add	x0, x0, #32
	mov	x3, x4
	bl	_ZNKSt8__detail20_Prime_rehash_policy14_M_need_rehashEmmm
	tbz	w0, #0, .LBB31_3
// %bb.1:
.Ltmp268:
	mov	x0, x19
	bl	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE
.Ltmp269:
// %bb.2:
	ldr	x8, [x19, #8]
	udiv	x9, x22, x8
	msub	x21, x9, x8, x22
.LBB31_3:
	ldr	x8, [x19]
	ldr	x9, [x8, x21, lsl #3]
	cbz	x9, .LBB31_5
// %bb.4:
	ldr	x9, [x9]
	str	x9, [x20]
	ldr	x8, [x8, x21, lsl #3]
	str	x20, [x8]
	b	.LBB31_8
.LBB31_5:
	mov	x9, x19
	ldr	x10, [x9, #16]!
	str	x10, [x20]
	str	x20, [x9]
	ldr	x10, [x20]
	cbz	x10, .LBB31_7
// %bb.6:
	ldr	x11, [x19, #8]
	ldr	x10, [x10, #8]
	udiv	x12, x10, x11
	msub	x10, x12, x11, x10
	str	x20, [x8, x10, lsl #3]
	ldr	x8, [x19]
.LBB31_7:
	str	x9, [x8, x21, lsl #3]
.LBB31_8:
	ldr	x8, [x19, #24]
	add	x8, x8, #1
	str	x8, [x19, #24]
	mov	x0, x20
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB31_9:
	.cfi_restore_state
.Ltmp270:
	bl	__cxa_begin_catch
	str	x23, [x19, #40]
.Ltmp271:
	bl	__cxa_rethrow
.Ltmp272:
// %bb.10:
.LBB31_11:
.Ltmp273:
	mov	x19, x0
.Ltmp274:
	bl	__cxa_end_catch
.Ltmp275:
// %bb.12:
	mov	x0, x19
	bl	_Unwind_Resume
.LBB31_13:
.Ltmp276:
	bl	__clang_call_terminate
.Lfunc_end31:
	.size	_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm, .Lfunc_end31-_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm
	.cfi_endproc
	.section	.gcc_except_table._ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,"aG",@progbits,_ZNSt10_HashtableImmSaImENSt8__detail9_IdentityESt8equal_toImESt4hashImENS1_18_Mod_range_hashingENS1_20_Default_ranged_hashENS1_20_Prime_rehash_policyENS1_17_Hashtable_traitsILb0ELb1ELb1EEEE21_M_insert_unique_nodeEmmPNS1_10_Hash_nodeImLb0EEEm,comdat
	.p2align	2, 0x0
GCC_except_table31:
.Lexception4:
	.byte	255                             // @LPStart Encoding = omit
	.byte	156                             // @TType Encoding = indirect pcrel sdata8
	.uleb128 .Lttbase2-.Lttbaseref2
.Lttbaseref2:
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end4-.Lcst_begin4
.Lcst_begin4:
	.uleb128 .Lfunc_begin4-.Lfunc_begin4    // >> Call Site 1 <<
	.uleb128 .Ltmp268-.Lfunc_begin4         //   Call between .Lfunc_begin4 and .Ltmp268
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp268-.Lfunc_begin4         // >> Call Site 2 <<
	.uleb128 .Ltmp269-.Ltmp268              //   Call between .Ltmp268 and .Ltmp269
	.uleb128 .Ltmp270-.Lfunc_begin4         //     jumps to .Ltmp270
	.byte	1                               //   On action: 1
	.uleb128 .Ltmp269-.Lfunc_begin4         // >> Call Site 3 <<
	.uleb128 .Ltmp271-.Ltmp269              //   Call between .Ltmp269 and .Ltmp271
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp271-.Lfunc_begin4         // >> Call Site 4 <<
	.uleb128 .Ltmp272-.Ltmp271              //   Call between .Ltmp271 and .Ltmp272
	.uleb128 .Ltmp273-.Lfunc_begin4         //     jumps to .Ltmp273
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp274-.Lfunc_begin4         // >> Call Site 5 <<
	.uleb128 .Ltmp275-.Ltmp274              //   Call between .Ltmp274 and .Ltmp275
	.uleb128 .Ltmp276-.Lfunc_begin4         //     jumps to .Ltmp276
	.byte	1                               //   On action: 1
	.uleb128 .Ltmp275-.Lfunc_begin4         // >> Call Site 6 <<
	.uleb128 .Lfunc_end31-.Ltmp275          //   Call between .Ltmp275 and .Lfunc_end31
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
.Lcst_end4:
	.byte	1                               // >> Action Record 1 <<
                                        //   Catch TypeInfo 1
	.byte	0                               //   No further actions
	.p2align	2, 0x0
                                        // >> Catch TypeInfos <<
	.xword	0                               // TypeInfo 1
.Lttbase2:
	.p2align	2, 0x0
                                        // -- End function
	.section	.text._ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,"axG",@progbits,_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,comdat
	.weak	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm // -- Begin function _ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.p2align	2
	.type	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm,@function
_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm: // @_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.cfi_startproc
// %bb.0:
	ldr	x8, [x1]
	eor	x8, x8, x2
	mov	x9, #36085                      // =0x8cf5
	movk	x9, #56862, lsl #16
	movk	x9, #63968, lsl #32
	movk	x9, #31189, lsl #48
	mul	x10, x8, x9
	umulh	x8, x8, x9
	eor	x0, x8, x10
	ret
.Lfunc_end32:
	.size	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm, .Lfunc_end32-_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.cfi_endproc
                                        // -- End function
	.section	.text._ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,"axG",@progbits,_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,comdat
	.weak	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m // -- Begin function _ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.p2align	2
	.type	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m,@function
_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m: // @_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.cfi_startproc
// %bb.0:
	mov	x8, x2
	mov	x0, x1
	lsl	x2, x3, #3
	mov	x1, x8
	b	memcpy
.Lfunc_end33:
	.size	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m, .Lfunc_end33-_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.cfi_endproc
                                        // -- End function
	.section	.text._ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,"axG",@progbits,_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,comdat
	.weak	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE // -- Begin function _ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.p2align	2
	.type	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE,@function
_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE: // @_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	mov	x19, #0                         // =0x0
	mov	x8, #-1                         // =0xffffffffffffffff
	ldp	x9, x20, [x0]
	lsl	x8, x8, x9
	mvn	x21, x8
	lsr	x22, x21, #1
	sub	x8, x20, x8
	add	x23, x8, #7
	and	x24, x22, #0x3ffffffffffffff8
	mov	x25, #-9187201950435737472      // =0x8080808080808080
	mov	x26, #36085                     // =0x8cf5
	movk	x26, #56862, lsl #16
	movk	x26, #63968, lsl #32
	movk	x26, #31189, lsl #48
	b	.LBB34_2
.LBB34_1:                               //   in Loop: Header=BB34_2 Depth=1
	add	x19, x19, #8
	cmp	x19, x22
	b.hs	.LBB34_10
.LBB34_2:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB34_3 Depth 2
	ldr	x8, [x1, x19]
	add	x9, x20, x19
	add	x10, x9, x22
	str	x25, [x9]
	stur	x25, [x10, #1]
	bics	x27, x25, x8
	b.eq	.LBB34_1
.LBB34_3:                               //   Parent Loop BB34_2 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	rbit	x8, x27
	clz	x8, x8
	orr	x8, x19, x8, lsr #3
	ldr	x9, [x0]
	and	x9, x9, #0x7c0
	ldr	x10, [x2, x8, lsl #3]
	eor	x9, x10, x9
	mul	x10, x9, x26
	umulh	x9, x9, x26
	eor	x10, x9, x10
	lsr	x9, x10, #57
	sub	x11, x8, x10
	tst	x24, x11
	b.ne	.LBB34_6
// %bb.4:                               //   in Loop: Header=BB34_3 Depth=2
	and	x11, x11, #0x7
	add	x10, x11, x10
	and	x10, x10, x21
.LBB34_5:                               //   in Loop: Header=BB34_3 Depth=2
	strb	w9, [x20, x10]
	ldr	x8, [x2, x8, lsl #3]
	str	x8, [x23, x10, lsl #3]
	sub	x8, x27, #1
	ands	x27, x8, x27
	b.ne	.LBB34_3
	b	.LBB34_1
.LBB34_6:                               //   in Loop: Header=BB34_3 Depth=2
	and	x11, x22, x10
	cmp	x11, x8
	b.hs	.LBB34_9
// %bb.7:                               //   in Loop: Header=BB34_3 Depth=2
	and	x11, x10, x21
	ldr	d0, [x20, x11]
	cmlt	v0.8b, v0.8b, #0
	fmov	x12, d0
	cbz	x12, .LBB34_9
// %bb.8:                               //   in Loop: Header=BB34_3 Depth=2
	rbit	x10, x12
	clz	x10, x10
	add	x10, x11, x10, lsr #3
	b	.LBB34_5
.LBB34_9:                               //   in Loop: Header=BB34_3 Depth=2
	stur	x0, [x29, #-8]                  // 8-byte Folded Spill
	mov	x0, x3
	stp	x2, x1, [sp, #8]                // 16-byte Folded Spill
	mov	x1, x9
	mov	x2, x8
	str	x3, [sp]                        // 8-byte Folded Spill
	mov	x3, x10
	mov	x28, x4
	blr	x4
	ldur	x0, [x29, #-8]                  // 8-byte Folded Reload
	ldp	x2, x1, [sp, #8]                // 16-byte Folded Reload
	ldr	x3, [sp]                        // 8-byte Folded Reload
	mov	x4, x28
	sub	x8, x27, #1
	ands	x27, x8, x27
	b.ne	.LBB34_3
	b	.LBB34_1
.LBB34_10:
	.cfi_def_cfa wsp, 128
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	add	sp, sp, #128
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end34:
	.size	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE, .Lfunc_end34-_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.cfi_endproc
                                        // -- End function
	.section	.text._ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,"axG",@progbits,_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,comdat
	.weak	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE // -- Begin function _ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.p2align	2
	.type	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE,@function
_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE: // @_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.cfi_startproc
// %bb.0:
	ldr	x8, [x0, #8]
	ldr	x8, [x8]
	eor	x8, x8, x1
	mov	x9, #36085                      // =0x8cf5
	movk	x9, #56862, lsl #16
	movk	x9, #63968, lsl #32
	movk	x9, #31189, lsl #48
	mul	x10, x8, x9
	umulh	x8, x8, x9
	eor	x0, x8, x10
	ret
.Lfunc_end35:
	.size	_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE, .Lfunc_end35-_ZN4absl12lts_2026081719functional_internal12InvokeObjectIRNS0_18container_internal7HashKeyINS0_13hash_internal4HashImEEmLb1EEEmJmEEET0_NS1_7VoidPtrEDpNS1_8ForwardTIT1_E4typeE
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"axG",@progbits,_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.weak	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_ // -- Begin function _ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.p2align	2
	.type	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,@function
_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_: // @_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
.Lfunc_begin5:
	.cfi_startproc
	.cfi_personality 156, DW.ref.__gxx_personality_v0
	.cfi_lsda 28, .Lexception5
// %bb.0:
	stp	x29, x30, [sp, #-80]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 80
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 80
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
	.cfi_remember_state
	cmp	x0, x1
	b.eq	.LBB36_7
// %bb.1:
	cmp	x1, x2
	b.eq	.LBB36_7
// %bb.2:
	sub	x8, x1, x0
	asr	x20, x8, #3
	sub	x8, x2, x1
	asr	x19, x8, #3
	cmp	x19, x20
	csel	x23, x19, x20, lt
	cmp	x23, #1
	b.lt	.LBB36_8
// %bb.3:
	mov	x24, x0
	mov	x25, x1
	mov	x26, x2
	adrp	x22, :got:_ZSt7nothrow
	ldr	x22, [x22, :got_lo12:_ZSt7nothrow]
	mov	x21, x23
.LBB36_4:                               // =>This Inner Loop Header: Depth=1
	lsl	x0, x21, #3
	mov	x1, x22
	bl	_ZnwmRKSt9nothrow_t
	cbnz	x0, .LBB36_9
// %bb.5:                               //   in Loop: Header=BB36_4 Depth=1
	add	x8, x21, #1
	lsr	x8, x8, #1
	cmp	x21, #1
	mov	x21, x8
	b.hi	.LBB36_4
// %bb.6:
	mov	x5, #0                          // =0x0
	mov	x21, #0                         // =0x0
	b	.LBB36_10
.LBB36_7:
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #80             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB36_8:
	.cfi_restore_state
	.cfi_remember_state
	mov	x5, #0                          // =0x0
	mov	x21, #0                         // =0x0
	b	.LBB36_11
.LBB36_9:
	mov	x5, x0
.LBB36_10:
	mov	x2, x26
	mov	x1, x25
	mov	x0, x24
.LBB36_11:
	cmp	x21, x23
	b.ne	.LBB36_14
// %bb.12:
.Ltmp281:
	mov	x3, x20
	mov	x4, x19
	mov	x22, x5
	bl	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
.Ltmp282:
.LBB36_13:
	mov	x0, x22
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #80             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w30
	.cfi_restore w29
	b	_ZdlPv
.LBB36_14:
	.cfi_restore_state
	mov	x8, x5
	mov	x22, x5
	cbz	x5, .LBB36_16
// %bb.15:
.Ltmp277:
	mov	x3, x20
	mov	x4, x19
	mov	x5, x22
	mov	x6, x21
	bl	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
.Ltmp278:
	b	.LBB36_13
.LBB36_16:
.Ltmp279:
	mov	x3, x20
	mov	x4, x19
	bl	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
.Ltmp280:
	b	.LBB36_13
.LBB36_17:
.Ltmp283:
	mov	x19, x0
	mov	x0, x22
	bl	_ZdlPv
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end36:
	.size	_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_, .Lfunc_end36-_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_
	.cfi_endproc
	.section	.gcc_except_table._ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,"aG",@progbits,_ZSt15__inplace_mergeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEENS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_,comdat
	.p2align	2, 0x0
GCC_except_table36:
.Lexception5:
	.byte	255                             // @LPStart Encoding = omit
	.byte	255                             // @TType Encoding = omit
	.byte	1                               // Call site Encoding = uleb128
	.uleb128 .Lcst_end5-.Lcst_begin5
.Lcst_begin5:
	.uleb128 .Ltmp281-.Lfunc_begin5         // >> Call Site 1 <<
	.uleb128 .Ltmp280-.Ltmp281              //   Call between .Ltmp281 and .Ltmp280
	.uleb128 .Ltmp283-.Lfunc_begin5         //     jumps to .Ltmp283
	.byte	0                               //   On action: cleanup
	.uleb128 .Ltmp280-.Lfunc_begin5         // >> Call Site 2 <<
	.uleb128 .Lfunc_end36-.Ltmp280          //   Call between .Ltmp280 and .Lfunc_end36
	.byte	0                               //     has no landing pad
	.byte	0                               //   On action: cleanup
.Lcst_end5:
	.p2align	2, 0x0
                                        // -- End function
	.section	.text._ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,"axG",@progbits,_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,comdat
	.weak	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_ // -- Begin function _ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.p2align	2
	.type	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_,@function
_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_: // @_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x19, x5
	mov	x22, x2
	mov	x21, x1
	mov	x20, x0
	cmp	x3, x4
	b.le	.LBB37_12
// %bb.1:
	sub	x23, x22, x21
	cmp	x23, #9
	b.lt	.LBB37_23
// %bb.2:
	mov	x0, x19
	mov	x1, x21
	mov	x2, x23
	bl	memmove
.LBB37_3:
	cmp	x20, x21
	b.eq	.LBB37_19
// %bb.4:
	cmp	x22, x21
	b.eq	.LBB37_18
// %bb.5:
	add	x8, x19, x23
	sub	x11, x8, #8
.LBB37_6:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB37_7 Depth 2
	mov	x8, #0                          // =0x0
	mov	x10, x11
	mov	x9, x22
	sub	x12, x22, #8
	add	x11, x11, x8
	ldr	x14, [x11]
	ldr	x13, [x21, #-8]!
	cmp	x14, x13
	b.lo	.LBB37_9
.LBB37_7:                               //   Parent Loop BB37_6 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x14, [x12, x8]
	cmp	x11, x19
	b.eq	.LBB37_18
// %bb.8:                               //   in Loop: Header=BB37_7 Depth=2
	sub	x8, x8, #8
	add	x11, x10, x8
	ldr	x14, [x11]
	ldr	x13, [x21]
	cmp	x14, x13
	b.hs	.LBB37_7
.LBB37_9:                               //   in Loop: Header=BB37_6 Depth=1
	add	x22, x9, x8
	str	x13, [x22, #-8]!
	cmp	x21, x20
	b.ne	.LBB37_6
// %bb.10:
	sub	x10, x10, x19
	add	x10, x10, x8
	add	x2, x10, #8
	asr	x11, x2, #3
	cmp	x11, #2
	b.lt	.LBB37_31
// %bb.11:
	sub	x9, x9, x11, lsl #3
	add	x8, x9, x8
	sub	x0, x8, #8
	mov	x1, x19
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	b	memmove
.LBB37_12:
	.cfi_restore_state
	.cfi_remember_state
	sub	x23, x21, x20
	cmp	x23, #9
	b.lt	.LBB37_25
// %bb.13:
	mov	x0, x19
	mov	x1, x20
	mov	x2, x23
	bl	memmove
.LBB37_14:
	cmp	x21, x20
	b.eq	.LBB37_18
// %bb.15:
	add	x8, x19, x23
.LBB37_16:                              // =>This Inner Loop Header: Depth=1
	cmp	x21, x22
	b.eq	.LBB37_21
// %bb.17:                              //   in Loop: Header=BB37_16 Depth=1
	ldr	x9, [x21]
	ldr	x10, [x19]
	cmp	x9, x10
	csel	x9, x9, x10, lo
	cset	w10, hs
	cset	w11, lo
	add	x21, x21, w11, uxtw #3
	add	x19, x19, w10, uxtw #3
	str	x9, [x20], #8
	cmp	x19, x8
	b.ne	.LBB37_16
.LBB37_18:
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB37_19:
	.cfi_restore_state
	.cfi_remember_state
	asr	x8, x23, #3
	cmp	x8, #2
	b.lt	.LBB37_27
// %bb.20:
	sub	x0, x22, x8, lsl #3
	mov	x1, x19
	mov	x2, x23
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	b	memmove
.LBB37_21:
	.cfi_restore_state
	.cfi_remember_state
	sub	x2, x8, x19
	cmp	x2, #9
	b.lt	.LBB37_29
// %bb.22:
	mov	x0, x20
	mov	x1, x19
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	b	memmove
.LBB37_23:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x23, #8
	b.ne	.LBB37_3
// %bb.24:
	ldr	x8, [x21]
	str	x8, [x19]
	b	.LBB37_3
.LBB37_25:
	cmp	x23, #8
	b.ne	.LBB37_14
// %bb.26:
	ldr	x8, [x20]
	str	x8, [x19]
	b	.LBB37_14
.LBB37_27:
	cmp	x23, #8
	b.ne	.LBB37_18
// %bb.28:
	ldr	x8, [x19]
	stur	x8, [x22, #-8]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB37_29:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x2, #8
	b.ne	.LBB37_18
// %bb.30:
	ldr	x8, [x19]
	str	x8, [x20]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB37_31:
	.cfi_restore_state
	cbnz	x10, .LBB37_18
// %bb.32:
	add	x8, x9, x8
	ldr	x9, [x19]
	stur	x9, [x8, #-16]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end37:
	.size	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_, .Lfunc_end37-_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,"axG",@progbits,_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,comdat
	.weak	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_ // -- Begin function _ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	.p2align	2
	.type	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_,@function
_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_: // @_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	.cfi_startproc
// %bb.0:
	cbz	x3, .LBB38_18
// %bb.1:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 96
	str	x27, [sp, #16]                  // 8-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	mov	x19, x4
	cbz	x4, .LBB38_17
// %bb.2:
	mov	x20, x3
	mov	x21, x2
	mov	x22, x0
.LBB38_3:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB38_11 Depth 2
                                        //     Child Loop BB38_7 Depth 2
	add	x8, x19, x20
	cmp	x8, #2
	b.eq	.LBB38_15
// %bb.4:                               //   in Loop: Header=BB38_3 Depth=1
	cmp	x20, x19
	b.le	.LBB38_9
// %bb.5:                               //   in Loop: Header=BB38_3 Depth=1
	cmp	x20, #0
	cinc	x8, x20, lt
	asr	x26, x8, #1
	add	x24, x22, x26, lsl #3
	sub	x8, x21, x1
	asr	x8, x8, #3
	mov	x23, x1
	cmp	x8, #1
	b.lt	.LBB38_8
// %bb.6:                               //   in Loop: Header=BB38_3 Depth=1
	ldr	x9, [x24]
	mov	x23, x1
.LBB38_7:                               //   Parent Loop BB38_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsr	x10, x8, #1
	add	x11, x23, x10, lsl #3
	ldr	x12, [x11], #8
	mvn	x13, x10
	add	x8, x8, x13
	cmp	x12, x9
	csel	x23, x11, x23, lo
	csel	x8, x8, x10, lo
	cmp	x8, #0
	b.gt	.LBB38_7
.LBB38_8:                               //   in Loop: Header=BB38_3 Depth=1
	sub	x8, x23, x1
	asr	x25, x8, #3
	b	.LBB38_13
.LBB38_9:                               //   in Loop: Header=BB38_3 Depth=1
	cmp	x19, #0
	cinc	x8, x19, lt
	asr	x25, x8, #1
	add	x23, x1, x25, lsl #3
	sub	x8, x1, x22
	asr	x8, x8, #3
	mov	x24, x22
	cmp	x8, #1
	b.lt	.LBB38_12
// %bb.10:                              //   in Loop: Header=BB38_3 Depth=1
	ldr	x9, [x23]
	mov	x24, x22
.LBB38_11:                              //   Parent Loop BB38_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsr	x10, x8, #1
	add	x11, x24, x10, lsl #3
	ldr	x12, [x11], #8
	mvn	x13, x10
	add	x8, x8, x13
	cmp	x9, x12
	csel	x24, x24, x11, lo
	csel	x8, x10, x8, lo
	cmp	x8, #0
	b.gt	.LBB38_11
.LBB38_12:                              //   in Loop: Header=BB38_3 Depth=1
	sub	x8, x24, x22
	asr	x26, x8, #3
.LBB38_13:                              //   in Loop: Header=BB38_3 Depth=1
	mov	x0, x24
	mov	x2, x23
	bl	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	mov	x27, x0
	mov	x0, x22
	mov	x1, x24
	mov	x2, x27
	mov	x3, x26
	mov	x4, x25
	bl	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	sub	x20, x20, x26
	cbz	x20, .LBB38_17
// %bb.14:                              //   in Loop: Header=BB38_3 Depth=1
	mov	x1, x23
	mov	x22, x27
	sub	x19, x19, x25
	cbnz	x19, .LBB38_3
	b	.LBB38_17
.LBB38_15:
	ldr	x8, [x1]
	ldr	x9, [x22]
	cmp	x8, x9
	b.hs	.LBB38_17
// %bb.16:
	str	x8, [x22]
	str	x9, [x1]
.LBB38_17:
	.cfi_def_cfa wsp, 96
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldr	x27, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w30
	.cfi_restore w29
.LBB38_18:
	ret
.Lfunc_end38:
	.size	_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_, .Lfunc_end38-_ZSt22__merge_without_bufferIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,"axG",@progbits,_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,comdat
	.weak	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_ // -- Begin function _ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	.p2align	2
	.type	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_,@function
_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_: // @_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	mov	x19, x5
	mov	x20, x4
	mov	x21, x3
	str	x2, [sp, #8]                    // 8-byte Folded Spill
	mov	x22, x0
	cmp	x3, x6
	b.le	.LBB39_13
// %bb.1:
	mov	x23, x6
	cmp	x20, x6
	b.le	.LBB39_13
.LBB39_2:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB39_9 Depth 2
                                        //     Child Loop BB39_5 Depth 2
	cmp	x21, x20
	b.le	.LBB39_7
// %bb.3:                               //   in Loop: Header=BB39_2 Depth=1
	cmp	x21, #0
	cinc	x8, x21, lt
	asr	x28, x8, #1
	add	x26, x22, x28, lsl #3
	ldr	x8, [sp, #8]                    // 8-byte Folded Reload
	sub	x8, x8, x1
	asr	x8, x8, #3
	mov	x24, x1
	cmp	x8, #1
	b.lt	.LBB39_6
// %bb.4:                               //   in Loop: Header=BB39_2 Depth=1
	ldr	x9, [x26]
	mov	x24, x1
.LBB39_5:                               //   Parent Loop BB39_2 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsr	x10, x8, #1
	add	x11, x24, x10, lsl #3
	ldr	x12, [x11], #8
	mvn	x13, x10
	add	x8, x8, x13
	cmp	x12, x9
	csel	x24, x11, x24, lo
	csel	x8, x8, x10, lo
	cmp	x8, #0
	b.gt	.LBB39_5
.LBB39_6:                               //   in Loop: Header=BB39_2 Depth=1
	sub	x8, x24, x1
	asr	x27, x8, #3
	b	.LBB39_11
.LBB39_7:                               //   in Loop: Header=BB39_2 Depth=1
	cmp	x20, #0
	cinc	x8, x20, lt
	asr	x27, x8, #1
	add	x24, x1, x27, lsl #3
	sub	x8, x1, x22
	asr	x8, x8, #3
	mov	x26, x22
	cmp	x8, #1
	b.lt	.LBB39_10
// %bb.8:                               //   in Loop: Header=BB39_2 Depth=1
	ldr	x9, [x24]
	mov	x26, x22
.LBB39_9:                               //   Parent Loop BB39_2 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsr	x10, x8, #1
	add	x11, x26, x10, lsl #3
	ldr	x12, [x11], #8
	mvn	x13, x10
	add	x8, x8, x13
	cmp	x9, x12
	csel	x26, x26, x11, lo
	csel	x8, x10, x8, lo
	cmp	x8, #0
	b.gt	.LBB39_9
.LBB39_10:                              //   in Loop: Header=BB39_2 Depth=1
	sub	x8, x26, x22
	asr	x28, x8, #3
.LBB39_11:                              //   in Loop: Header=BB39_2 Depth=1
	sub	x21, x21, x28
	mov	x0, x26
	mov	x2, x24
	mov	x3, x21
	mov	x4, x27
	mov	x5, x19
	mov	x6, x23
	bl	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	mov	x25, x0
	mov	x0, x22
	mov	x1, x26
	mov	x2, x25
	mov	x3, x28
	mov	x4, x27
	mov	x5, x19
	mov	x6, x23
	bl	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	sub	x20, x20, x27
	cmp	x21, x23
	b.le	.LBB39_14
// %bb.12:                              //   in Loop: Header=BB39_2 Depth=1
	mov	x1, x24
	mov	x22, x25
	cmp	x20, x23
	b.gt	.LBB39_2
	b	.LBB39_14
.LBB39_13:
	mov	x25, x22
	mov	x24, x1
.LBB39_14:
	mov	x0, x25
	mov	x1, x24
	ldr	x2, [sp, #8]                    // 8-byte Folded Reload
	mov	x3, x21
	mov	x4, x20
	mov	x5, x19
	.cfi_def_cfa wsp, 112
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #112
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	b	_ZSt16__merge_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_T2_
.Lfunc_end39:
	.size	_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_, .Lfunc_end39-_ZSt23__merge_adaptive_resizeIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEElS2_NS0_5__ops15_Iter_less_iterEEvT_S9_S9_T0_SA_T1_SA_T2_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,"axG",@progbits,_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,comdat
	.weak	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag // -- Begin function _ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.p2align	2
	.type	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag,@function
_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag: // @_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-48]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]                  // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	cmp	x0, x1
	b.eq	.LBB40_9
// %bb.1:
	mov	x19, x1
	subs	x9, x2, x1
	b.eq	.LBB40_10
// %bb.2:
	sub	x8, x2, x0
	asr	x8, x8, #3
	sub	x10, x19, x0
	cmp	x8, x10, asr #2
	b.ne	.LBB40_11
// %bb.3:
	sub	x8, x10, #8
	cmp	x8, #72
	b.lo	.LBB40_6
// %bb.4:
	and	x9, x8, #0xfffffffffffffff8
	add	x9, x9, #8
	add	x10, x19, x9
	cmp	x10, x0
	b.ls	.LBB40_47
// %bb.5:
	add	x9, x0, x9
	cmp	x9, x19
	b.ls	.LBB40_47
.LBB40_6:
	mov	x8, x19
	mov	x9, x0
.LBB40_7:                               // =>This Inner Loop Header: Depth=1
	ldr	x10, [x9]
	ldr	x11, [x8]
	str	x11, [x9], #8
	str	x10, [x8], #8
	cmp	x9, x19
	b.ne	.LBB40_7
.LBB40_8:
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_9:
	.cfi_restore_state
	.cfi_remember_state
	mov	x19, x2
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_10:
	.cfi_restore_state
	.cfi_remember_state
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_11:
	.cfi_restore_state
	.cfi_remember_state
	asr	x11, x10, #3
	add	x19, x0, x9
	mov	x9, x11
	sub	x10, x8, x11
	cmp	x11, x10
	b.ge	.LBB40_26
	b	.LBB40_15
.LBB40_12:                              //   in Loop: Header=BB40_26 Depth=1
	mov	x12, x0
.LBB40_13:                              //   in Loop: Header=BB40_26 Depth=1
	sdiv	x9, x8, x10
	msub	x11, x9, x10, x8
	mov	x0, x12
	mov	x8, x10
	cbz	x11, .LBB40_8
// %bb.14:                              //   in Loop: Header=BB40_26 Depth=1
	mov	x9, x11
	sub	x10, x8, x11
	cmp	x11, x10
	b.ge	.LBB40_26
.LBB40_15:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB40_41 Depth 2
                                        //     Child Loop BB40_22 Depth 2
	cmp	x9, #1
	b.eq	.LBB40_45
// %bb.16:                              //   in Loop: Header=BB40_15 Depth=1
	cmp	x10, #1
	b.lt	.LBB40_23
// %bb.17:                              //   in Loop: Header=BB40_15 Depth=1
	add	x11, x0, x9, lsl #3
	cmp	x10, #4
	b.lo	.LBB40_20
// %bb.18:                              //   in Loop: Header=BB40_15 Depth=1
	add	x12, x0, x8, lsl #3
	cmp	x0, x12
	b.hs	.LBB40_40
// %bb.19:                              //   in Loop: Header=BB40_15 Depth=1
	add	x12, x0, x10, lsl #3
	cmp	x11, x12
	b.hs	.LBB40_40
.LBB40_20:                              //   in Loop: Header=BB40_15 Depth=1
	mov	x13, #0                         // =0x0
	mov	x12, x0
.LBB40_21:                              //   in Loop: Header=BB40_15 Depth=1
	add	x10, x13, x9
	sub	x10, x10, x8
.LBB40_22:                              //   Parent Loop BB40_15 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	x13, [x12]
	ldr	x14, [x11]
	str	x14, [x12], #8
	str	x13, [x11], #8
	adds	x10, x10, #1
	b.lo	.LBB40_22
	b	.LBB40_24
.LBB40_23:                              //   in Loop: Header=BB40_15 Depth=1
	mov	x12, x0
.LBB40_24:                              //   in Loop: Header=BB40_15 Depth=1
	sdiv	x10, x8, x9
	msub	x8, x10, x9, x8
	cbz	x8, .LBB40_8
// %bb.25:                              //   in Loop: Header=BB40_15 Depth=1
	sub	x11, x9, x8
	mov	x0, x12
	mov	x8, x9
	mov	x9, x11
	sub	x10, x8, x11
	cmp	x11, x10
	b.lt	.LBB40_15
.LBB40_26:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB40_38 Depth 2
                                        //     Child Loop BB40_31 Depth 2
	add	x11, x0, x8, lsl #3
	cmp	x10, #1
	b.eq	.LBB40_43
// %bb.27:                              //   in Loop: Header=BB40_26 Depth=1
	sub	x12, x11, x10, lsl #3
	subs	x16, x9, #1
	b.lt	.LBB40_13
// %bb.28:                              //   in Loop: Header=BB40_26 Depth=1
	cmp	x9, #20
	b.hs	.LBB40_32
.LBB40_29:                              //   in Loop: Header=BB40_26 Depth=1
	mov	x13, #0                         // =0x0
.LBB40_30:                              //   in Loop: Header=BB40_26 Depth=1
	sub	x9, x9, x13
	sub	x11, x11, #8
	sub	x12, x12, #8
.LBB40_31:                              //   Parent Loop BB40_26 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	x13, [x12]
	ldr	x14, [x11]
	str	x14, [x12], #-8
	str	x13, [x11], #-8
	subs	x9, x9, #1
	b.ne	.LBB40_31
	b	.LBB40_12
.LBB40_32:                              //   in Loop: Header=BB40_26 Depth=1
	mov	x13, #0                         // =0x0
	sub	x17, x0, #8
	lsl	x14, x9, #3
	lsl	x18, x16, #3
	add	x15, x17, x14
	sub	x1, x15, x18
	cmp	x1, x15
	b.hi	.LBB40_30
// %bb.33:                              //   in Loop: Header=BB40_26 Depth=1
	lsl	x15, x8, #3
	add	x17, x17, x15
	sub	x18, x17, x18
	cmp	x18, x17
	b.hi	.LBB40_30
// %bb.34:                              //   in Loop: Header=BB40_26 Depth=1
	lsr	x16, x16, #61
	cbnz	x16, .LBB40_30
// %bb.35:                              //   in Loop: Header=BB40_26 Depth=1
	cmp	x0, x11
	b.hs	.LBB40_37
// %bb.36:                              //   in Loop: Header=BB40_26 Depth=1
	add	x13, x0, x10, lsl #3
	cmp	x13, x12
	b.lo	.LBB40_29
.LBB40_37:                              //   in Loop: Header=BB40_26 Depth=1
	and	x13, x9, #0x7ffffffffffffffc
	lsl	x16, x13, #3
	sub	x11, x11, x16
	sub	x12, x12, x16
	sub	x16, x0, #16
	add	x14, x16, x14
	add	x15, x16, x15
	mov	x16, x13
.LBB40_38:                              //   Parent Loop BB40_26 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldp	q1, q0, [x14, #-16]
	ldp	q3, q2, [x15, #-16]
	stp	q3, q2, [x14, #-16]
	stp	q1, q0, [x15, #-16]
	sub	x14, x14, #32
	sub	x15, x15, #32
	subs	x16, x16, #4
	b.ne	.LBB40_38
// %bb.39:                              //   in Loop: Header=BB40_26 Depth=1
	cmp	x9, x13
	b.eq	.LBB40_12
	b	.LBB40_30
.LBB40_40:                              //   in Loop: Header=BB40_15 Depth=1
	and	x13, x10, #0x7ffffffffffffffc
	lsl	x14, x13, #3
	add	x12, x0, x14
	add	x11, x11, x14
	lsl	x14, x9, #3
	mov	x15, x13
.LBB40_41:                              //   Parent Loop BB40_15 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x16, x0, x14
	ldp	q0, q1, [x0]
	ldp	q2, q3, [x16]
	stp	q2, q3, [x0], #32
	stp	q0, q1, [x16]
	subs	x15, x15, #4
	b.ne	.LBB40_41
// %bb.42:                              //   in Loop: Header=BB40_15 Depth=1
	cmp	x10, x13
	b.ne	.LBB40_21
	b	.LBB40_24
.LBB40_43:
	mov	x8, x11
	ldr	x21, [x8, #-8]!
	mov	x20, x0
	sub	x2, x8, x0
	asr	x9, x2, #3
	cmp	x9, #2
	b.lt	.LBB40_50
// %bb.44:
	sub	x0, x11, x9, lsl #3
	mov	x1, x20
	bl	memmove
	str	x21, [x20]
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_45:
	.cfi_restore_state
	.cfi_remember_state
	mov	x1, x0
	ldr	x20, [x1], #8
	lsl	x9, x8, #3
	add	x21, x0, x9
	sub	x2, x9, #8
	cmp	x8, #3
	b.lt	.LBB40_53
// %bb.46:
	bl	memmove
	stur	x20, [x21, #-8]
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_47:
	.cfi_restore_state
	.cfi_remember_state
	mov	x11, #0                         // =0x0
	lsr	x8, x8, #3
	add	x10, x8, #1
	and	x12, x10, #0x3ffffffffffffff8
	lsl	x9, x12, #3
	add	x8, x19, x9
	add	x9, x0, x9
	add	x13, x0, #32
	mov	x14, x12
.LBB40_48:                              // =>This Inner Loop Header: Depth=1
	add	x15, x19, x11
	add	x16, x13, x11
	ldp	q0, q1, [x16, #-32]
	ldp	q2, q3, [x16]
	ldp	q4, q5, [x15]
	ldp	q6, q7, [x15, #32]
	stp	q4, q5, [x16, #-32]
	stp	q6, q7, [x16]
	stp	q0, q1, [x15]
	add	x11, x11, #64
	stp	q2, q3, [x15, #32]
	subs	x14, x14, #8
	b.ne	.LBB40_48
// %bb.49:
	cmp	x10, x12
	b.ne	.LBB40_7
	b	.LBB40_8
.LBB40_50:
	cmp	x2, #8
	b.ne	.LBB40_52
// %bb.51:
	ldr	x9, [x20]
	str	x9, [x8]
.LBB40_52:
	str	x21, [x20]
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB40_53:
	.cfi_restore_state
	cmp	x2, #8
	b.ne	.LBB40_55
// %bb.54:
	ldr	x8, [x0, #8]
	str	x8, [x0]
.LBB40_55:
	stur	x20, [x21, #-8]
	mov	x0, x19
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldr	x21, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #48             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end40:
	.size	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag, .Lfunc_end40-_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
	.cfi_endproc
                                        // -- End function
	.section	.text._ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,"axG",@progbits,_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,comdat
	.weak	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_ // -- Begin function _ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.p2align	2
	.type	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_,@function
_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_: // @_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-64]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]                  // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x19, x5
	mov	x21, x2
	mov	x20, x0
	cmp	x3, x4
	b.le	.LBB41_10
// %bb.1:
	cmp	x4, x6
	b.gt	.LBB41_10
// %bb.2:
	cbz	x4, .LBB41_9
// %bb.3:
	sub	x22, x21, x1
	cmp	x22, #9
	b.lt	.LBB41_21
// %bb.4:
	mov	x0, x19
	mov	x23, x1
	mov	x2, x22
	bl	memmove
	mov	x1, x23
.LBB41_5:
	sub	x2, x1, x20
	asr	x8, x2, #3
	cmp	x8, #2
	b.lt	.LBB41_23
// %bb.6:
	sub	x0, x21, x8, lsl #3
	mov	x1, x20
	bl	memmove
.LBB41_7:
	cmp	x22, #9
	b.lt	.LBB41_25
// %bb.8:
	mov	x0, x20
	mov	x1, x19
	mov	x2, x22
	bl	memmove
	add	x20, x20, x22
.LBB41_9:
	mov	x0, x20
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB41_10:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x3, x6
	b.le	.LBB41_12
// %bb.11:
	mov	x0, x20
	mov	x2, x21
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	b	_ZNSt3_V28__rotateIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEEEET_S8_S8_S8_St26random_access_iterator_tag
.LBB41_12:
	.cfi_restore_state
	.cfi_remember_state
	cbz	x3, .LBB41_20
// %bb.13:
	sub	x22, x1, x20
	cmp	x22, #9
	b.lt	.LBB41_28
// %bb.14:
	mov	x0, x19
	mov	x23, x1
	mov	x1, x20
	mov	x2, x22
	bl	memmove
	mov	x1, x23
.LBB41_15:
	sub	x2, x21, x1
	cmp	x2, #9
	b.lt	.LBB41_30
// %bb.16:
	mov	x0, x20
	bl	memmove
.LBB41_17:
	asr	x20, x22, #3
	cmp	x20, #2
	b.lt	.LBB41_32
// %bb.18:
	sub	x0, x21, x20, lsl #3
	mov	x1, x19
	mov	x2, x22
	bl	memmove
.LBB41_19:
	sub	x20, x21, x20, lsl #3
	mov	x0, x20
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB41_20:
	.cfi_restore_state
	.cfi_remember_state
	mov	x20, x21
	mov	x0, x20
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB41_21:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x22, #8
	b.ne	.LBB41_5
// %bb.22:
	ldr	x8, [x1]
	str	x8, [x19]
	b	.LBB41_5
.LBB41_23:
	cmp	x2, #8
	b.ne	.LBB41_7
// %bb.24:
	ldr	x8, [x20]
	stur	x8, [x21, #-8]
	b	.LBB41_7
.LBB41_25:
	cmp	x22, #8
	b.ne	.LBB41_27
// %bb.26:
	ldr	x8, [x19]
	str	x8, [x20]
.LBB41_27:
	add	x20, x20, x22
	mov	x0, x20
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldr	x23, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #64             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB41_28:
	.cfi_restore_state
	cmp	x22, #8
	b.ne	.LBB41_15
// %bb.29:
	ldr	x8, [x20]
	str	x8, [x19]
	b	.LBB41_15
.LBB41_30:
	cmp	x2, #8
	b.ne	.LBB41_17
// %bb.31:
	ldr	x8, [x1]
	str	x8, [x20]
	b	.LBB41_17
.LBB41_32:
	cmp	x22, #8
	b.ne	.LBB41_19
// %bb.33:
	ldr	x8, [x19]
	stur	x8, [x21, #-8]
	b	.LBB41_19
.Lfunc_end41:
	.size	_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_, .Lfunc_end41-_ZSt17__rotate_adaptiveIN9__gnu_cxx17__normal_iteratorIPmSt6vectorImSaImEEEES2_lET_S7_S7_S7_T1_S8_T0_S8_
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"sort"
	.size	.L.str, 5

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"--alg"
	.size	.L.str.1, 6

	.type	.L.str.2,@object                // @.str.2
.L.str.2:
	.asciz	"--n"
	.size	.L.str.2, 4

	.type	.L.str.3,@object                // @.str.3
.L.str.3:
	.asciz	"--u"
	.size	.L.str.3, 4

	.type	.L.str.4,@object                // @.str.4
.L.str.4:
	.asciz	"--reserve"
	.size	.L.str.4, 10

	.type	.L.str.5,@object                // @.str.5
.L.str.5:
	.asciz	"--calls"
	.size	.L.str.5, 8

	.type	.L.str.6,@object                // @.str.6
.L.str.6:
	.asciz	"--nlocal"
	.size	.L.str.6, 9

	.type	.L.str.7,@object                // @.str.7
.L.str.7:
	.asciz	"bad arg %s\n"
	.size	.L.str.7, 12

	.type	.L.str.8,@object                // @.str.8
.L.str.8:
	.asciz	"merge"
	.size	.L.str.8, 6

	.type	.L.str.9,@object                // @.str.9
.L.str.9:
	.asciz	"unique"
	.size	.L.str.9, 7

	.type	.L.str.10,@object               // @.str.10
.L.str.10:
	.asciz	"uset"
	.size	.L.str.10, 5

	.type	.L.str.11,@object               // @.str.11
.L.str.11:
	.asciz	"flat"
	.size	.L.str.11, 5

	.type	.L.str.12,@object               // @.str.12
.L.str.12:
	.asciz	"insert"
	.size	.L.str.12, 7

	.type	.L.str.13,@object               // @.str.13
.L.str.13:
	.asciz	"assign"
	.size	.L.str.13, 7

	.type	.L.str.14,@object               // @.str.14
.L.str.14:
	.asciz	"dtor"
	.size	.L.str.14, 5

	.type	.L.str.15,@object               // @.str.15
.L.str.15:
	.asciz	"radix"
	.size	.L.str.15, 6

	.type	.L.str.16,@object               // @.str.16
.L.str.16:
	.asciz	"count"
	.size	.L.str.16, 6

	.type	.L.str.17,@object               // @.str.17
.L.str.17:
	.asciz	"scatter"
	.size	.L.str.17, 8

	.type	.L.str.18,@object               // @.str.18
.L.str.18:
	.asciz	"sortdelta"
	.size	.L.str.18, 10

	.type	.L.str.19,@object               // @.str.19
.L.str.19:
	.asciz	"inplace_merge"
	.size	.L.str.19, 14

	.type	.L.str.20,@object               // @.str.20
.L.str.20:
	.asciz	"unknown alg\n"
	.size	.L.str.20, 13

	.type	.L.str.21,@object               // @.str.21
.L.str.21:
	.asciz	"WRONG RESULT %s\n"
	.size	.L.str.21, 17

	.type	.L.str.22,@object               // @.str.22
.L.str.22:
	.asciz	"%s,%s,%zu,%zu,%.2f\n"
	.size	.L.str.22, 20

	.type	.L.str.23,@object               // @.str.23
.L.str.23:
	.asciz	"cannot create std::vector larger than max_size()"
	.size	.L.str.23, 49

	.type	.L.str.26,@object               // @.str.26
.L.str.26:
	.asciz	"basic_string: construction from null is not valid"
	.size	.L.str.26, 50

	.type	.L.str.27,@object               // @.str.27
.L.str.27:
	.asciz	"basic_string::_M_create"
	.size	.L.str.27, 24

	.type	.L.str.28,@object               // @.str.28
.L.str.28:
	.asciz	"stoull"
	.size	.L.str.28, 7

	.type	.L.str.29,@object               // @.str.29
.L.str.29:
	.asciz	"vector::_M_realloc_insert"
	.size	.L.str.29, 26

	.type	.L.str.30,@object               // @.str.30
.L.str.30:
	.asciz	"vector::_M_range_insert"
	.size	.L.str.30, 24

	.type	.L.str.31,@object               // @.str.31
.L.str.31:
	.asciz	"vector::_M_fill_insert"
	.size	.L.str.31, 23

	.type	.L.str.32,@object               // @.str.32
.L.str.32:
	.asciz	"vector::reserve"
	.size	.L.str.32, 16

	.type	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,@object // @_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.section	.data.rel.ro._ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,"awG",@progbits,_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value,comdat
	.weak	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value
	.p2align	3, 0x0
_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value:
	.word	8                               // 0x8
	.word	8                               // 0x8
	.word	8                               // 0x8
	.hword	8                               // 0x8
	.byte	1                               // 0x1
	.byte	1                               // 0x1
	.xword	_ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.xword	_ZN4absl12lts_2026081718container_internal23TypeErasedApplyToSlotFnINS0_13hash_internal4HashImEEmLb1EEEmPKvPvm
	.xword	_ZN4absl12lts_2026081718container_internal20TransferNRelocatableILm8EEEvPvS3_S3_m
	.xword	_ZN4absl12lts_2026081718container_internal19GetRefForEmptyClassERNS1_12CommonFieldsE
	.xword	_ZN4absl12lts_2026081718container_internal20AllocateBackingArrayILm8ESaIcEEEPvS4_m
	.xword	_ZN4absl12lts_2026081718container_internal22DeallocateBackingArrayILm8ESaIcEEEvPvmPNS1_6ctrl_tEmmbm
	.xword	_ZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE46transfer_unprobed_elements_to_next_capacity_fnERNS1_12CommonFieldsEPKNS1_6ctrl_tEPvSB_PFvSB_hmmE
	.size	_ZZN4absl12lts_2026081718container_internal12raw_hash_setINS1_17FlatHashSetPolicyImEEJEE18GetPolicyFunctionsEvE5value, 72

	.section	".linker-options","e",@llvm_linker_options
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.p2align	3, 0x0
	.type	DW.ref.__gxx_personality_v0,@object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.xword	__gxx_personality_v0
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
