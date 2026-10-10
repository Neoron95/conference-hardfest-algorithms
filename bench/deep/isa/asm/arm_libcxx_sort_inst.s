	.text
	.file	"sort_inst.cpp"
	.globl	_Z15sort_u64_bitsetPmS_         // -- Begin function _Z15sort_u64_bitsetPmS_
	.p2align	2
	.type	_Z15sort_u64_bitsetPmS_,@function
_Z15sort_u64_bitsetPmS_:                // @_Z15sort_u64_bitsetPmS_
	.cfi_startproc
// %bb.0:
	subs	x8, x1, x0
	asr	x8, x8, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x8, x9, x8, lsl #1
	cmp	x1, x0
	csel	x3, xzr, x8, eq
	mov	w4, #1                          // =0x1
	b	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
.Lfunc_end0:
	.size	_Z15sort_u64_bitsetPmS_, .Lfunc_end0-_Z15sort_u64_bitsetPmS_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"axG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.weak	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb // -- Begin function _ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.p2align	2
	.type	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,@function
_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb: // @_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	add	x29, sp, #16
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
	mov	x21, x4
	mov	x19, x1
	mov	x20, x0
	sturb	w2, [x29, #-4]
	mov	w25, #1                         // =0x1
.LBB1_1:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB1_2 Depth 2
                                        //       Child Loop BB1_3 Depth 3
                                        //       Child Loop BB1_67 Depth 3
                                        //       Child Loop BB1_65 Depth 3
                                        //       Child Loop BB1_71 Depth 3
                                        //       Child Loop BB1_74 Depth 3
                                        //         Child Loop BB1_75 Depth 4
                                        //         Child Loop BB1_76 Depth 4
	mov	x22, x20
.LBB1_2:                                //   Parent Loop BB1_1 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB1_3 Depth 3
                                        //       Child Loop BB1_67 Depth 3
                                        //       Child Loop BB1_65 Depth 3
                                        //       Child Loop BB1_71 Depth 3
                                        //       Child Loop BB1_74 Depth 3
                                        //         Child Loop BB1_75 Depth 4
                                        //         Child Loop BB1_76 Depth 4
	sub	x8, x25, x3
.LBB1_3:                                //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	mov	x20, x22
	mov	x26, x8
	sub	x8, x19, x22
	asr	x11, x8, #3
	cmp	x11, #2
	b.gt	.LBB1_6
// %bb.4:                               //   in Loop: Header=BB1_3 Depth=3
	b.lo	.LBB1_125
// %bb.5:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x11, #2
	b.ne	.LBB1_9
	b	.LBB1_87
.LBB1_6:                                //   in Loop: Header=BB1_3 Depth=3
	cmp	x11, #3
	b.eq	.LBB1_83
// %bb.7:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x11, #4
	b.eq	.LBB1_89
// %bb.8:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x11, #5
	b.eq	.LBB1_86
.LBB1_9:                                //   in Loop: Header=BB1_3 Depth=3
	cmp	x11, #23
	b.le	.LBB1_92
// %bb.10:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x26, #1
	b.eq	.LBB1_103
// %bb.11:                              //   in Loop: Header=BB1_3 Depth=3
	lsr	x8, x11, #1
	add	x9, x20, x8, lsl #3
	mov	x8, x9
	ldur	x10, [x19, #-8]
	cmp	x11, #129
	b.lo	.LBB1_15
// %bb.12:                              //   in Loop: Header=BB1_3 Depth=3
	ldr	x12, [x8]
	ldr	x11, [x20]
	cmp	x12, x11
	b.hs	.LBB1_18
// %bb.13:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x10, x12
	b.hs	.LBB1_24
// %bb.14:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x20]
	b	.LBB1_26
.LBB1_15:                               //   in Loop: Header=BB1_3 Depth=3
	ldr	x11, [x20]
	ldr	x9, [x8]
	cmp	x11, x9
	b.hs	.LBB1_21
// %bb.16:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x10, x11
	b.hs	.LBB1_33
// %bb.17:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x8]
	b	.LBB1_35
.LBB1_18:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x10, x12
	b.hs	.LBB1_27
// %bb.19:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x8]
	stur	x12, [x19, #-8]
	ldr	x10, [x8]
	ldr	x11, [x20]
	cmp	x10, x11
	b.hs	.LBB1_27
// %bb.20:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x20]
	str	x11, [x8]
	b	.LBB1_27
.LBB1_21:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x10, x11
	b.hs	.LBB1_36
// %bb.22:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x20]
	stur	x11, [x19, #-8]
	ldr	x9, [x20]
	ldr	x10, [x8]
	cmp	x9, x10
	b.hs	.LBB1_36
// %bb.23:                              //   in Loop: Header=BB1_3 Depth=3
	str	x9, [x8]
	str	x10, [x20]
	tbz	w21, #0, .LBB1_57
	b	.LBB1_58
.LBB1_24:                               //   in Loop: Header=BB1_3 Depth=3
	str	x12, [x20]
	str	x11, [x8]
	ldur	x10, [x19, #-8]
	cmp	x10, x11
	b.hs	.LBB1_27
// %bb.25:                              //   in Loop: Header=BB1_3 Depth=3
	str	x10, [x8]
.LBB1_26:                               //   in Loop: Header=BB1_3 Depth=3
	stur	x11, [x19, #-8]
.LBB1_27:                               //   in Loop: Header=BB1_3 Depth=3
	mov	x10, x9
	ldr	x12, [x10, #-8]!
	ldr	x11, [x20, #8]
	ldur	x13, [x19, #-16]
	cmp	x12, x11
	b.hs	.LBB1_30
// %bb.28:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x12
	b.hs	.LBB1_37
// %bb.29:                              //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x20, #8]
	b	.LBB1_39
.LBB1_30:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x12
	b.hs	.LBB1_40
// %bb.31:                              //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x10]
	stur	x12, [x19, #-16]
	ldr	x11, [x10]
	ldr	x12, [x20, #8]
	cmp	x11, x12
	b.hs	.LBB1_40
// %bb.32:                              //   in Loop: Header=BB1_3 Depth=3
	str	x11, [x20, #8]
	str	x12, [x10]
	b	.LBB1_40
.LBB1_33:                               //   in Loop: Header=BB1_3 Depth=3
	str	x11, [x8]
	str	x9, [x20]
	ldur	x8, [x19, #-8]
	cmp	x8, x9
	b.hs	.LBB1_36
// %bb.34:                              //   in Loop: Header=BB1_3 Depth=3
	str	x8, [x20]
.LBB1_35:                               //   in Loop: Header=BB1_3 Depth=3
	stur	x9, [x19, #-8]
.LBB1_36:                               //   in Loop: Header=BB1_3 Depth=3
	tbz	w21, #0, .LBB1_57
	b	.LBB1_58
.LBB1_37:                               //   in Loop: Header=BB1_3 Depth=3
	str	x12, [x20, #8]
	str	x11, [x10]
	ldur	x12, [x19, #-16]
	cmp	x12, x11
	b.hs	.LBB1_40
// %bb.38:                              //   in Loop: Header=BB1_3 Depth=3
	str	x12, [x10]
.LBB1_39:                               //   in Loop: Header=BB1_3 Depth=3
	stur	x11, [x19, #-16]
.LBB1_40:                               //   in Loop: Header=BB1_3 Depth=3
	ldr	x12, [x9, #8]!
	ldr	x11, [x20, #16]
	ldur	x13, [x19, #-24]
	cmp	x12, x11
	b.hs	.LBB1_43
// %bb.41:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x12
	b.hs	.LBB1_46
// %bb.42:                              //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x20, #16]
	b	.LBB1_48
.LBB1_43:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x12
	b.hs	.LBB1_49
// %bb.44:                              //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x9]
	stur	x12, [x19, #-24]
	ldr	x11, [x9]
	ldr	x12, [x20, #16]
	cmp	x11, x12
	b.hs	.LBB1_49
// %bb.45:                              //   in Loop: Header=BB1_3 Depth=3
	str	x11, [x20, #16]
	str	x12, [x9]
	b	.LBB1_49
.LBB1_46:                               //   in Loop: Header=BB1_3 Depth=3
	str	x12, [x20, #16]
	str	x11, [x9]
	ldur	x12, [x19, #-24]
	cmp	x12, x11
	b.hs	.LBB1_49
// %bb.47:                              //   in Loop: Header=BB1_3 Depth=3
	str	x12, [x9]
.LBB1_48:                               //   in Loop: Header=BB1_3 Depth=3
	stur	x11, [x19, #-24]
.LBB1_49:                               //   in Loop: Header=BB1_3 Depth=3
	ldr	x11, [x8]
	ldr	x12, [x10]
	ldr	x13, [x9]
	cmp	x11, x12
	b.hs	.LBB1_53
// %bb.50:                              //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x11
	b.lo	.LBB1_55
// %bb.51:                              //   in Loop: Header=BB1_3 Depth=3
	str	x11, [x10]
	str	x12, [x8]
	mov	x10, x8
	mov	x11, x13
	cmp	x13, x12
	b.lo	.LBB1_55
// %bb.52:                              //   in Loop: Header=BB1_3 Depth=3
	mov	x11, x12
	ldr	x9, [x20]
	str	x12, [x20]
	str	x9, [x8]
	tbz	w21, #0, .LBB1_57
	b	.LBB1_58
.LBB1_53:                               //   in Loop: Header=BB1_3 Depth=3
	cmp	x13, x11
	b.hs	.LBB1_56
// %bb.54:                              //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x8]
	str	x11, [x9]
	mov	x9, x8
	mov	x11, x12
	cmp	x13, x12
	b.hs	.LBB1_61
.LBB1_55:                               //   in Loop: Header=BB1_3 Depth=3
	str	x13, [x10]
	str	x12, [x9]
.LBB1_56:                               //   in Loop: Header=BB1_3 Depth=3
	ldr	x9, [x20]
	str	x11, [x20]
	str	x9, [x8]
	tbnz	w21, #0, .LBB1_58
.LBB1_57:                               //   in Loop: Header=BB1_3 Depth=3
	ldp	x9, x8, [x20, #-8]
	cmp	x9, x8
	b.hs	.LBB1_63
.LBB1_58:                               //   in Loop: Header=BB1_3 Depth=3
	mov	x0, x20
	mov	x1, x19
	bl	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	mov	x23, x0
	tbz	w1, #0, .LBB1_62
// %bb.59:                              //   in Loop: Header=BB1_3 Depth=3
	mov	x0, x20
	mov	x1, x23
	bl	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	mov	x24, x0
	add	x22, x23, #8
	mov	x0, x22
	mov	x1, x19
	bl	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	tbnz	w0, #0, .LBB1_82
// %bb.60:                              //   in Loop: Header=BB1_3 Depth=3
	add	x8, x26, #1
	tbnz	w24, #0, .LBB1_3
	b	.LBB1_62
.LBB1_61:                               //   in Loop: Header=BB1_3 Depth=3
	mov	x11, x13
	ldr	x9, [x20]
	str	x13, [x20]
	str	x9, [x8]
	tbz	w21, #0, .LBB1_57
	b	.LBB1_58
.LBB1_62:                               //   in Loop: Header=BB1_2 Depth=2
	neg	x3, x26
	and	w4, w21, #0x1
	mov	x0, x20
	mov	x1, x23
	bl	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	add	x22, x23, #8
	b	.LBB1_81
.LBB1_63:                               //   in Loop: Header=BB1_2 Depth=2
	ldur	x9, [x19, #-8]
	cmp	x8, x9
	b.hs	.LBB1_66
// %bb.64:                              //   in Loop: Header=BB1_2 Depth=2
	mov	x22, x20
.LBB1_65:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x9, [x22, #8]!
	cmp	x8, x9
	b.hs	.LBB1_65
	b	.LBB1_69
.LBB1_66:                               //   in Loop: Header=BB1_2 Depth=2
	add	x9, x20, #8
.LBB1_67:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	mov	x22, x9
	cmp	x9, x19
	b.hs	.LBB1_69
// %bb.68:                              //   in Loop: Header=BB1_67 Depth=3
	mov	x9, x22
	ldr	x10, [x9], #8
	cmp	x8, x10
	b.hs	.LBB1_67
.LBB1_69:                               //   in Loop: Header=BB1_2 Depth=2
	mov	x9, x19
	cmp	x22, x19
	b.hs	.LBB1_72
// %bb.70:                              //   in Loop: Header=BB1_2 Depth=2
	mov	x9, x19
.LBB1_71:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x10, [x9, #-8]!
	cmp	x8, x10
	b.lo	.LBB1_71
.LBB1_72:                               //   in Loop: Header=BB1_2 Depth=2
	cmp	x22, x9
	b.hs	.LBB1_78
// %bb.73:                              //   in Loop: Header=BB1_2 Depth=2
	ldr	x10, [x22]
	ldr	x11, [x9]
.LBB1_74:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        // =>    This Loop Header: Depth=3
                                        //         Child Loop BB1_75 Depth 4
                                        //         Child Loop BB1_76 Depth 4
	str	x11, [x22]
	str	x10, [x9]
.LBB1_75:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        //       Parent Loop BB1_74 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x10, [x22, #8]!
	cmp	x8, x10
	b.hs	.LBB1_75
.LBB1_76:                               //   Parent Loop BB1_1 Depth=1
                                        //     Parent Loop BB1_2 Depth=2
                                        //       Parent Loop BB1_74 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x11, [x9, #-8]!
	cmp	x8, x11
	b.lo	.LBB1_76
// %bb.77:                              //   in Loop: Header=BB1_74 Depth=3
	cmp	x22, x9
	b.lo	.LBB1_74
.LBB1_78:                               //   in Loop: Header=BB1_2 Depth=2
	sub	x9, x22, #8
	cmp	x9, x20
	b.eq	.LBB1_80
// %bb.79:                              //   in Loop: Header=BB1_2 Depth=2
	ldr	x10, [x9]
	str	x10, [x20]
.LBB1_80:                               //   in Loop: Header=BB1_2 Depth=2
	str	x8, [x9]
.LBB1_81:                               //   in Loop: Header=BB1_2 Depth=2
	mov	w21, #0                         // =0x0
	neg	x3, x26
	b	.LBB1_2
.LBB1_82:                               //   in Loop: Header=BB1_1 Depth=1
	neg	x3, x26
	mov	x19, x23
	tbz	w24, #0, .LBB1_1
	b	.LBB1_125
.LBB1_83:
	ldp	x8, x9, [x20]
	ldur	x10, [x19, #-8]
	cmp	x9, x8
	b.hs	.LBB1_105
// %bb.84:
	cmp	x10, x9
	b.hs	.LBB1_122
// %bb.85:
	str	x10, [x20]
	b	.LBB1_124
.LBB1_86:
	sub	x4, x19, #8
	add	x1, x20, #8
	add	x2, x20, #16
	add	x3, x20, #24
	mov	x0, x20
	.cfi_def_cfa wsp, 96
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #96
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
	b	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
.LBB1_87:
	.cfi_restore_state
	ldur	x8, [x19, #-8]
	ldr	x9, [x20]
	cmp	x8, x9
	b.hs	.LBB1_125
// %bb.88:
	str	x8, [x20]
	stur	x9, [x19, #-8]
	b	.LBB1_125
.LBB1_89:
	mov	x8, x20
	ldr	x10, [x8, #8]!
	mov	x9, x20
	ldr	x11, [x9, #16]!
	ldr	x12, [x20]
	cmp	x10, x12
	b.hs	.LBB1_108
// %bb.90:
	mov	x13, x20
	mov	x14, x9
	mov	x0, x12
	cmp	x11, x10
	b.lo	.LBB1_110
// %bb.91:
	stp	x10, x12, [x20]
	mov	x13, x8
	mov	x14, x9
	mov	x0, x12
	cmp	x11, x12
	b.lo	.LBB1_110
	b	.LBB1_118
.LBB1_92:
	cmp	x20, x19
	add	x9, x20, #8
	ccmp	x9, x19, #4, ne
	cset	w8, eq
	tbz	w21, #0, .LBB1_112
// %bb.93:
	tbnz	w8, #0, .LBB1_125
// %bb.94:
	mov	x8, #0                          // =0x0
	mov	x10, x20
	b	.LBB1_98
.LBB1_95:                               //   in Loop: Header=BB1_98 Depth=1
	mov	x9, x20
.LBB1_96:                               //   in Loop: Header=BB1_98 Depth=1
	str	x11, [x9]
.LBB1_97:                               //   in Loop: Header=BB1_98 Depth=1
	add	x9, x10, #8
	add	x8, x8, #8
	cmp	x9, x19
	b.eq	.LBB1_125
.LBB1_98:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB1_100 Depth 2
	ldp	x12, x11, [x10]
	mov	x10, x9
	cmp	x11, x12
	b.hs	.LBB1_97
// %bb.99:                              //   in Loop: Header=BB1_98 Depth=1
	mov	x9, x8
.LBB1_100:                              //   Parent Loop BB1_98 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x13, x20, x9
	str	x12, [x13, #8]
	cbz	x9, .LBB1_95
// %bb.101:                             //   in Loop: Header=BB1_100 Depth=2
	ldur	x12, [x13, #-8]
	sub	x9, x9, #8
	cmp	x11, x12
	b.lo	.LBB1_100
// %bb.102:                             //   in Loop: Header=BB1_98 Depth=1
	add	x9, x20, x9
	add	x9, x9, #8
	b	.LBB1_96
.LBB1_103:
	cmp	x20, x19
	b.eq	.LBB1_125
// %bb.104:
	sub	x3, x29, #4
	mov	x0, x20
	mov	x1, x19
	mov	x2, x19
	bl	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	b	.LBB1_125
.LBB1_105:
	cmp	x10, x9
	b.hs	.LBB1_125
// %bb.106:
	str	x10, [x20, #8]
	stur	x9, [x19, #-8]
	ldp	x9, x8, [x20]
	cmp	x8, x9
	b.hs	.LBB1_125
// %bb.107:
	stp	x8, x9, [x20]
	b	.LBB1_125
.LBB1_108:
	cmp	x11, x10
	b.hs	.LBB1_118
// %bb.109:
	str	x11, [x8]
	str	x10, [x9]
	mov	x13, x20
	mov	x14, x8
	mov	x0, x10
	cmp	x11, x12
	b.hs	.LBB1_111
.LBB1_110:
	str	x11, [x13]
	str	x12, [x14]
	mov	x10, x0
.LBB1_111:
	ldur	x11, [x19, #-8]
	cmp	x11, x10
	b.hs	.LBB1_125
	b	.LBB1_119
.LBB1_112:
	tbz	w8, #0, .LBB1_114
	b	.LBB1_125
.LBB1_113:                              //   in Loop: Header=BB1_114 Depth=1
	add	x9, x20, #8
	cmp	x9, x19
	b.eq	.LBB1_125
.LBB1_114:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB1_116 Depth 2
	ldp	x10, x8, [x20]
	mov	x20, x9
	cmp	x8, x10
	b.hs	.LBB1_113
// %bb.115:                             //   in Loop: Header=BB1_114 Depth=1
	mov	x9, x20
.LBB1_116:                              //   Parent Loop BB1_114 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x10, [x9]
	ldur	x10, [x9, #-16]
	sub	x9, x9, #8
	cmp	x8, x10
	b.lo	.LBB1_116
// %bb.117:                             //   in Loop: Header=BB1_114 Depth=1
	str	x8, [x9]
	b	.LBB1_113
.LBB1_118:
	mov	x10, x11
	ldur	x11, [x19, #-8]
	cmp	x11, x10
	b.hs	.LBB1_125
.LBB1_119:
	str	x11, [x9]
	stur	x10, [x19, #-8]
	ldr	x9, [x9]
	ldr	x8, [x8]
	cmp	x9, x8
	b.hs	.LBB1_125
// %bb.120:
	stp	x9, x8, [x20, #8]
	ldr	x8, [x20]
	cmp	x9, x8
	b.hs	.LBB1_125
// %bb.121:
	stp	x9, x8, [x20]
	b	.LBB1_125
.LBB1_122:
	stp	x9, x8, [x20]
	ldur	x9, [x19, #-8]
	cmp	x9, x8
	b.hs	.LBB1_125
// %bb.123:
	str	x9, [x20, #8]
.LBB1_124:
	stur	x8, [x19, #-8]
.LBB1_125:
	.cfi_def_cfa wsp, 96
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #96
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
.Lfunc_end1:
	.size	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb, .Lfunc_end1-_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb1EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_endproc
                                        // -- End function
	.text
	.globl	_Z16sort_u64_branchyPmS_        // -- Begin function _Z16sort_u64_branchyPmS_
	.p2align	2
	.type	_Z16sort_u64_branchyPmS_,@function
_Z16sort_u64_branchyPmS_:               // @_Z16sort_u64_branchyPmS_
	.cfi_startproc
// %bb.0:
	subs	x8, x1, x0
	asr	x8, x8, #3
	clz	x8, x8
	mov	w9, #126                        // =0x7e
	sub	x8, x9, x8, lsl #1
	cmp	x1, x0
	csel	x3, xzr, x8, eq
	mov	w4, #1                          // =0x1
	b	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
.Lfunc_end2:
	.size	_Z16sort_u64_branchyPmS_, .Lfunc_end2-_Z16sort_u64_branchyPmS_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,"axG",@progbits,_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,comdat
	.weak	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb // -- Begin function _ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.p2align	2
	.type	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb,@function
_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb: // @_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
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
	mov	x22, x4
	mov	x21, x3
	mov	x19, x1
	mov	x20, x0
	strb	w2, [x29, #28]
.LBB3_1:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB3_2 Depth 2
                                        //       Child Loop BB3_82 Depth 3
                                        //       Child Loop BB3_80 Depth 3
                                        //       Child Loop BB3_86 Depth 3
                                        //       Child Loop BB3_89 Depth 3
                                        //         Child Loop BB3_90 Depth 4
                                        //         Child Loop BB3_91 Depth 4
                                        //       Child Loop BB3_58 Depth 3
                                        //       Child Loop BB3_60 Depth 3
                                        //       Child Loop BB3_62 Depth 3
                                        //       Child Loop BB3_66 Depth 3
                                        //         Child Loop BB3_67 Depth 4
                                        //         Child Loop BB3_68 Depth 4
	mov	x23, x20
.LBB3_2:                                //   Parent Loop BB3_1 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB3_82 Depth 3
                                        //       Child Loop BB3_80 Depth 3
                                        //       Child Loop BB3_86 Depth 3
                                        //       Child Loop BB3_89 Depth 3
                                        //         Child Loop BB3_90 Depth 4
                                        //         Child Loop BB3_91 Depth 4
                                        //       Child Loop BB3_58 Depth 3
                                        //       Child Loop BB3_60 Depth 3
                                        //       Child Loop BB3_62 Depth 3
                                        //       Child Loop BB3_66 Depth 3
                                        //         Child Loop BB3_67 Depth 4
                                        //         Child Loop BB3_68 Depth 4
	mov	x20, x23
	sub	x8, x19, x23
	asr	x11, x8, #3
	cmp	x11, #2
	b.gt	.LBB3_5
// %bb.3:                               //   in Loop: Header=BB3_2 Depth=2
	b.lo	.LBB3_126
// %bb.4:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x11, #2
	b.ne	.LBB3_8
	b	.LBB3_98
.LBB3_5:                                //   in Loop: Header=BB3_2 Depth=2
	cmp	x11, #3
	b.eq	.LBB3_100
// %bb.6:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x11, #4
	b.eq	.LBB3_103
// %bb.7:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x11, #5
	b.eq	.LBB3_97
.LBB3_8:                                //   in Loop: Header=BB3_2 Depth=2
	cmp	x11, #23
	b.le	.LBB3_106
// %bb.9:                               //   in Loop: Header=BB3_2 Depth=2
	cbz	x21, .LBB3_117
// %bb.10:                              //   in Loop: Header=BB3_2 Depth=2
	lsr	x8, x11, #1
	add	x9, x20, x8, lsl #3
	mov	x8, x9
	ldur	x10, [x19, #-8]
	cmp	x11, #129
	b.lo	.LBB3_14
// %bb.11:                              //   in Loop: Header=BB3_2 Depth=2
	ldr	x12, [x8]
	ldr	x11, [x20]
	cmp	x12, x11
	b.hs	.LBB3_17
// %bb.12:                              //   in Loop: Header=BB3_2 Depth=2
	cmp	x10, x12
	b.hs	.LBB3_23
// %bb.13:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x20]
	b	.LBB3_25
.LBB3_14:                               //   in Loop: Header=BB3_2 Depth=2
	ldr	x11, [x20]
	ldr	x9, [x8]
	cmp	x11, x9
	b.hs	.LBB3_20
// %bb.15:                              //   in Loop: Header=BB3_2 Depth=2
	cmp	x10, x11
	b.hs	.LBB3_32
// %bb.16:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x8]
	b	.LBB3_34
.LBB3_17:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x10, x12
	b.hs	.LBB3_26
// %bb.18:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x8]
	stur	x12, [x19, #-8]
	ldr	x10, [x8]
	ldr	x11, [x20]
	cmp	x10, x11
	b.hs	.LBB3_26
// %bb.19:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x20]
	str	x11, [x8]
	b	.LBB3_26
.LBB3_20:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x10, x11
	b.hs	.LBB3_35
// %bb.21:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x20]
	stur	x11, [x19, #-8]
	ldr	x9, [x20]
	ldr	x10, [x8]
	cmp	x9, x10
	b.hs	.LBB3_35
// %bb.22:                              //   in Loop: Header=BB3_2 Depth=2
	str	x9, [x8]
	str	x10, [x20]
	sub	x21, x21, #1
	mov	x8, x10
	tbz	w22, #0, .LBB3_56
	b	.LBB3_57
.LBB3_23:                               //   in Loop: Header=BB3_2 Depth=2
	str	x12, [x20]
	str	x11, [x8]
	ldur	x10, [x19, #-8]
	cmp	x10, x11
	b.hs	.LBB3_26
// %bb.24:                              //   in Loop: Header=BB3_2 Depth=2
	str	x10, [x8]
.LBB3_25:                               //   in Loop: Header=BB3_2 Depth=2
	stur	x11, [x19, #-8]
.LBB3_26:                               //   in Loop: Header=BB3_2 Depth=2
	mov	x10, x9
	ldr	x12, [x10, #-8]!
	ldr	x11, [x20, #8]
	ldur	x13, [x19, #-16]
	cmp	x12, x11
	b.hs	.LBB3_29
// %bb.27:                              //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x12
	b.hs	.LBB3_36
// %bb.28:                              //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x20, #8]
	b	.LBB3_38
.LBB3_29:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x12
	b.hs	.LBB3_39
// %bb.30:                              //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x10]
	stur	x12, [x19, #-16]
	ldr	x11, [x10]
	ldr	x12, [x20, #8]
	cmp	x11, x12
	b.hs	.LBB3_39
// %bb.31:                              //   in Loop: Header=BB3_2 Depth=2
	str	x11, [x20, #8]
	str	x12, [x10]
	b	.LBB3_39
.LBB3_32:                               //   in Loop: Header=BB3_2 Depth=2
	str	x11, [x8]
	str	x9, [x20]
	ldur	x8, [x19, #-8]
	cmp	x8, x9
	b.hs	.LBB3_35
// %bb.33:                              //   in Loop: Header=BB3_2 Depth=2
	str	x8, [x20]
.LBB3_34:                               //   in Loop: Header=BB3_2 Depth=2
	stur	x9, [x19, #-8]
.LBB3_35:                               //   in Loop: Header=BB3_2 Depth=2
	sub	x21, x21, #1
	ldr	x8, [x20]
	tbz	w22, #0, .LBB3_56
	b	.LBB3_57
.LBB3_36:                               //   in Loop: Header=BB3_2 Depth=2
	str	x12, [x20, #8]
	str	x11, [x10]
	ldur	x12, [x19, #-16]
	cmp	x12, x11
	b.hs	.LBB3_39
// %bb.37:                              //   in Loop: Header=BB3_2 Depth=2
	str	x12, [x10]
.LBB3_38:                               //   in Loop: Header=BB3_2 Depth=2
	stur	x11, [x19, #-16]
.LBB3_39:                               //   in Loop: Header=BB3_2 Depth=2
	ldr	x12, [x9, #8]!
	ldr	x11, [x20, #16]
	ldur	x13, [x19, #-24]
	cmp	x12, x11
	b.hs	.LBB3_42
// %bb.40:                              //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x12
	b.hs	.LBB3_45
// %bb.41:                              //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x20, #16]
	b	.LBB3_47
.LBB3_42:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x12
	b.hs	.LBB3_48
// %bb.43:                              //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x9]
	stur	x12, [x19, #-24]
	ldr	x11, [x9]
	ldr	x12, [x20, #16]
	cmp	x11, x12
	b.hs	.LBB3_48
// %bb.44:                              //   in Loop: Header=BB3_2 Depth=2
	str	x11, [x20, #16]
	str	x12, [x9]
	b	.LBB3_48
.LBB3_45:                               //   in Loop: Header=BB3_2 Depth=2
	str	x12, [x20, #16]
	str	x11, [x9]
	ldur	x12, [x19, #-24]
	cmp	x12, x11
	b.hs	.LBB3_48
// %bb.46:                              //   in Loop: Header=BB3_2 Depth=2
	str	x12, [x9]
.LBB3_47:                               //   in Loop: Header=BB3_2 Depth=2
	stur	x11, [x19, #-24]
.LBB3_48:                               //   in Loop: Header=BB3_2 Depth=2
	ldr	x11, [x8]
	ldr	x12, [x10]
	ldr	x13, [x9]
	cmp	x11, x12
	b.hs	.LBB3_52
// %bb.49:                              //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x11
	b.lo	.LBB3_54
// %bb.50:                              //   in Loop: Header=BB3_2 Depth=2
	str	x11, [x10]
	str	x12, [x8]
	mov	x10, x8
	mov	x11, x13
	cmp	x13, x12
	b.lo	.LBB3_54
// %bb.51:                              //   in Loop: Header=BB3_2 Depth=2
	mov	x11, x12
	ldr	x9, [x20]
	str	x12, [x20]
	str	x9, [x8]
	sub	x21, x21, #1
	ldr	x8, [x20]
	tbnz	w22, #0, .LBB3_57
	b	.LBB3_56
.LBB3_52:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x13, x11
	b.hs	.LBB3_55
// %bb.53:                              //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x8]
	str	x11, [x9]
	mov	x9, x8
	mov	x11, x12
	cmp	x13, x12
	b.hs	.LBB3_77
.LBB3_54:                               //   in Loop: Header=BB3_2 Depth=2
	str	x13, [x10]
	str	x12, [x9]
.LBB3_55:                               //   in Loop: Header=BB3_2 Depth=2
	ldr	x9, [x20]
	str	x11, [x20]
	str	x9, [x8]
	sub	x21, x21, #1
	ldr	x8, [x20]
	tbnz	w22, #0, .LBB3_57
.LBB3_56:                               //   in Loop: Header=BB3_2 Depth=2
	ldur	x9, [x20, #-8]
	cmp	x9, x8
	b.hs	.LBB3_78
.LBB3_57:                               //   in Loop: Header=BB3_2 Depth=2
	mov	x12, #0                         // =0x0
.LBB3_58:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	add	x9, x20, x12
	ldr	x11, [x9, #8]
	add	x12, x12, #8
	cmp	x11, x8
	b.lo	.LBB3_58
// %bb.59:                              //   in Loop: Header=BB3_2 Depth=2
	add	x9, x20, x12
	mov	x10, x19
	cmp	x12, #8
	b.eq	.LBB3_61
.LBB3_60:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x12, [x10, #-8]!
	cmp	x12, x8
	b.hs	.LBB3_60
	b	.LBB3_64
.LBB3_61:                               //   in Loop: Header=BB3_2 Depth=2
	mov	x10, x19
.LBB3_62:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	cmp	x9, x10
	b.hs	.LBB3_64
// %bb.63:                              //   in Loop: Header=BB3_62 Depth=3
	ldr	x12, [x10, #-8]!
	cmp	x12, x8
	b.hs	.LBB3_62
.LBB3_64:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x9, x10
	b.hs	.LBB3_71
// %bb.65:                              //   in Loop: Header=BB3_2 Depth=2
	ldr	x14, [x10]
	mov	x12, x9
	mov	x13, x10
.LBB3_66:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Loop Header: Depth=3
                                        //         Child Loop BB3_67 Depth 4
                                        //         Child Loop BB3_68 Depth 4
	str	x14, [x12]
	str	x11, [x13]
.LBB3_67:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        //       Parent Loop BB3_66 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x11, [x12, #8]!
	cmp	x11, x8
	b.lo	.LBB3_67
.LBB3_68:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        //       Parent Loop BB3_66 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x14, [x13, #-8]!
	cmp	x14, x8
	b.hs	.LBB3_68
// %bb.69:                              //   in Loop: Header=BB3_66 Depth=3
	cmp	x12, x13
	b.lo	.LBB3_66
// %bb.70:                              //   in Loop: Header=BB3_2 Depth=2
	sub	x24, x12, #8
	cmp	x24, x20
	b.ne	.LBB3_72
	b	.LBB3_73
.LBB3_71:                               //   in Loop: Header=BB3_2 Depth=2
	sub	x24, x9, #8
	cmp	x24, x20
	b.eq	.LBB3_73
.LBB3_72:                               //   in Loop: Header=BB3_2 Depth=2
	ldr	x11, [x24]
	str	x11, [x20]
.LBB3_73:                               //   in Loop: Header=BB3_2 Depth=2
	str	x8, [x24]
	cmp	x9, x10
	b.lo	.LBB3_76
// %bb.74:                              //   in Loop: Header=BB3_2 Depth=2
	mov	x0, x20
	mov	x1, x24
	bl	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	mov	x25, x0
	add	x23, x24, #8
	mov	x0, x23
	mov	x1, x19
	bl	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	tbnz	w0, #0, .LBB3_96
// %bb.75:                              //   in Loop: Header=BB3_2 Depth=2
	tbnz	w25, #0, .LBB3_2
.LBB3_76:                               //   in Loop: Header=BB3_2 Depth=2
	and	w4, w22, #0x1
	mov	x0, x20
	mov	x1, x24
	mov	x3, x21
	bl	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	mov	w22, #0                         // =0x0
	add	x23, x24, #8
	b	.LBB3_2
.LBB3_77:                               //   in Loop: Header=BB3_2 Depth=2
	mov	x11, x13
	ldr	x9, [x20]
	str	x13, [x20]
	str	x9, [x8]
	sub	x21, x21, #1
	ldr	x8, [x20]
	tbnz	w22, #0, .LBB3_57
	b	.LBB3_56
.LBB3_78:                               //   in Loop: Header=BB3_2 Depth=2
	ldur	x9, [x19, #-8]
	cmp	x8, x9
	b.hs	.LBB3_81
// %bb.79:                              //   in Loop: Header=BB3_2 Depth=2
	mov	x23, x20
.LBB3_80:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x9, [x23, #8]!
	cmp	x8, x9
	b.hs	.LBB3_80
	b	.LBB3_84
.LBB3_81:                               //   in Loop: Header=BB3_2 Depth=2
	add	x9, x20, #8
.LBB3_82:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	mov	x23, x9
	cmp	x9, x19
	b.hs	.LBB3_84
// %bb.83:                              //   in Loop: Header=BB3_82 Depth=3
	mov	x9, x23
	ldr	x10, [x9], #8
	cmp	x8, x10
	b.hs	.LBB3_82
.LBB3_84:                               //   in Loop: Header=BB3_2 Depth=2
	mov	x9, x19
	cmp	x23, x19
	b.hs	.LBB3_87
// %bb.85:                              //   in Loop: Header=BB3_2 Depth=2
	mov	x9, x19
.LBB3_86:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	ldr	x10, [x9, #-8]!
	cmp	x8, x10
	b.lo	.LBB3_86
.LBB3_87:                               //   in Loop: Header=BB3_2 Depth=2
	cmp	x23, x9
	b.hs	.LBB3_93
// %bb.88:                              //   in Loop: Header=BB3_2 Depth=2
	ldr	x10, [x23]
	ldr	x11, [x9]
.LBB3_89:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        // =>    This Loop Header: Depth=3
                                        //         Child Loop BB3_90 Depth 4
                                        //         Child Loop BB3_91 Depth 4
	str	x11, [x23]
	str	x10, [x9]
.LBB3_90:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        //       Parent Loop BB3_89 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x10, [x23, #8]!
	cmp	x8, x10
	b.hs	.LBB3_90
.LBB3_91:                               //   Parent Loop BB3_1 Depth=1
                                        //     Parent Loop BB3_2 Depth=2
                                        //       Parent Loop BB3_89 Depth=3
                                        // =>      This Inner Loop Header: Depth=4
	ldr	x11, [x9, #-8]!
	cmp	x8, x11
	b.lo	.LBB3_91
// %bb.92:                              //   in Loop: Header=BB3_89 Depth=3
	cmp	x23, x9
	b.lo	.LBB3_89
.LBB3_93:                               //   in Loop: Header=BB3_2 Depth=2
	sub	x9, x23, #8
	cmp	x9, x20
	b.eq	.LBB3_95
// %bb.94:                              //   in Loop: Header=BB3_2 Depth=2
	ldr	x10, [x9]
	str	x10, [x20]
.LBB3_95:                               //   in Loop: Header=BB3_2 Depth=2
	mov	w22, #0                         // =0x0
	str	x8, [x9]
	b	.LBB3_2
.LBB3_96:                               //   in Loop: Header=BB3_1 Depth=1
	mov	x19, x24
	tbz	w25, #0, .LBB3_1
	b	.LBB3_126
.LBB3_97:
	sub	x4, x19, #8
	add	x1, x20, #8
	add	x2, x20, #16
	add	x3, x20, #24
	mov	x0, x20
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
	b	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
.LBB3_98:
	.cfi_restore_state
	.cfi_remember_state
	ldur	x8, [x19, #-8]
	ldr	x9, [x20]
	cmp	x8, x9
	b.hs	.LBB3_126
// %bb.99:
	str	x8, [x20]
	stur	x9, [x19, #-8]
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
.LBB3_100:
	.cfi_restore_state
	.cfi_remember_state
	ldp	x8, x9, [x20]
	ldur	x10, [x19, #-8]
	cmp	x9, x8
	b.hs	.LBB3_119
// %bb.101:
	cmp	x10, x9
	b.hs	.LBB3_137
// %bb.102:
	str	x10, [x20]
	b	.LBB3_139
.LBB3_103:
	mov	x8, x20
	ldr	x10, [x8, #8]!
	mov	x9, x20
	ldr	x11, [x9, #16]!
	ldr	x12, [x20]
	cmp	x10, x12
	b.hs	.LBB3_122
// %bb.104:
	mov	x13, x20
	mov	x14, x9
	mov	x0, x12
	cmp	x11, x10
	b.lo	.LBB3_124
// %bb.105:
	stp	x10, x12, [x20]
	mov	x13, x8
	mov	x14, x9
	mov	x0, x12
	cmp	x11, x12
	b.lo	.LBB3_124
	b	.LBB3_133
.LBB3_106:
	cmp	x20, x19
	add	x9, x20, #8
	ccmp	x9, x19, #4, ne
	cset	w8, eq
	tbz	w22, #0, .LBB3_127
// %bb.107:
	tbnz	w8, #0, .LBB3_126
// %bb.108:
	mov	x8, #0                          // =0x0
	mov	x10, x20
	b	.LBB3_112
.LBB3_109:                              //   in Loop: Header=BB3_112 Depth=1
	mov	x9, x20
.LBB3_110:                              //   in Loop: Header=BB3_112 Depth=1
	str	x11, [x9]
.LBB3_111:                              //   in Loop: Header=BB3_112 Depth=1
	add	x9, x10, #8
	add	x8, x8, #8
	cmp	x9, x19
	b.eq	.LBB3_126
.LBB3_112:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB3_114 Depth 2
	ldp	x12, x11, [x10]
	mov	x10, x9
	cmp	x11, x12
	b.hs	.LBB3_111
// %bb.113:                             //   in Loop: Header=BB3_112 Depth=1
	mov	x9, x8
.LBB3_114:                              //   Parent Loop BB3_112 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x13, x20, x9
	str	x12, [x13, #8]
	cbz	x9, .LBB3_109
// %bb.115:                             //   in Loop: Header=BB3_114 Depth=2
	ldur	x12, [x13, #-8]
	sub	x9, x9, #8
	cmp	x11, x12
	b.lo	.LBB3_114
// %bb.116:                             //   in Loop: Header=BB3_112 Depth=1
	add	x9, x20, x9
	add	x9, x9, #8
	b	.LBB3_110
.LBB3_117:
	cmp	x20, x19
	b.eq	.LBB3_126
// %bb.118:
	add	x3, x29, #28
	mov	x0, x20
	mov	x1, x19
	mov	x2, x19
	bl	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
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
.LBB3_119:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x10, x9
	b.hs	.LBB3_126
// %bb.120:
	str	x10, [x20, #8]
	stur	x9, [x19, #-8]
	ldp	x9, x8, [x20]
	cmp	x8, x9
	b.hs	.LBB3_126
// %bb.121:
	stp	x8, x9, [x20]
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
.LBB3_122:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x11, x10
	b.hs	.LBB3_133
// %bb.123:
	str	x11, [x8]
	str	x10, [x9]
	mov	x13, x20
	mov	x14, x8
	mov	x0, x10
	cmp	x11, x12
	b.hs	.LBB3_125
.LBB3_124:
	str	x11, [x13]
	str	x12, [x14]
	mov	x10, x0
.LBB3_125:
	ldur	x11, [x19, #-8]
	cmp	x11, x10
	b.lo	.LBB3_134
.LBB3_126:
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
.LBB3_127:
	.cfi_restore_state
	.cfi_remember_state
	tbz	w8, #0, .LBB3_129
	b	.LBB3_126
.LBB3_128:                              //   in Loop: Header=BB3_129 Depth=1
	add	x9, x20, #8
	cmp	x9, x19
	b.eq	.LBB3_126
.LBB3_129:                              // =>This Loop Header: Depth=1
                                        //     Child Loop BB3_131 Depth 2
	ldp	x10, x8, [x20]
	mov	x20, x9
	cmp	x8, x10
	b.hs	.LBB3_128
// %bb.130:                             //   in Loop: Header=BB3_129 Depth=1
	mov	x9, x20
.LBB3_131:                              //   Parent Loop BB3_129 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x10, [x9]
	ldur	x10, [x9, #-16]
	sub	x9, x9, #8
	cmp	x8, x10
	b.lo	.LBB3_131
// %bb.132:                             //   in Loop: Header=BB3_129 Depth=1
	str	x8, [x9]
	b	.LBB3_128
.LBB3_133:
	mov	x10, x11
	ldur	x11, [x19, #-8]
	cmp	x11, x10
	b.hs	.LBB3_126
.LBB3_134:
	str	x11, [x9]
	stur	x10, [x19, #-8]
	ldr	x9, [x9]
	ldr	x8, [x8]
	cmp	x9, x8
	b.hs	.LBB3_126
// %bb.135:
	stp	x9, x8, [x20, #8]
	ldr	x8, [x20]
	cmp	x9, x8
	b.hs	.LBB3_126
// %bb.136:
	stp	x9, x8, [x20]
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
.LBB3_137:
	.cfi_restore_state
	stp	x9, x8, [x20]
	ldur	x9, [x19, #-8]
	cmp	x9, x8
	b.hs	.LBB3_126
// %bb.138:
	str	x9, [x20, #8]
.LBB3_139:
	stur	x8, [x19, #-8]
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
.Lfunc_end3:
	.size	_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb, .Lfunc_end3-_ZNSt3__111__introsortINS_17_ClassicAlgPolicyENS_6ranges4lessEPmLb0EEEvT1_S5_T0_NS_15iterator_traitsIS5_E15difference_typeEb
	.cfi_endproc
                                        // -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          // -- Begin function _ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
.LCPI4_0:
	.xword	1                               // 0x1
	.xword	2                               // 0x2
.LCPI4_1:
	.xword	4                               // 0x4
	.xword	8                               // 0x8
.LCPI4_2:
	.xword	16                              // 0x10
	.xword	32                              // 0x20
.LCPI4_3:
	.xword	64                              // 0x40
	.xword	128                             // 0x80
.LCPI4_4:
	.xword	256                             // 0x100
	.xword	512                             // 0x200
.LCPI4_5:
	.xword	1024                            // 0x400
	.xword	2048                            // 0x800
.LCPI4_6:
	.xword	4096                            // 0x1000
	.xword	8192                            // 0x2000
.LCPI4_7:
	.xword	16384                           // 0x4000
	.xword	32768                           // 0x8000
.LCPI4_8:
	.xword	65536                           // 0x10000
	.xword	131072                          // 0x20000
.LCPI4_9:
	.xword	262144                          // 0x40000
	.xword	524288                          // 0x80000
.LCPI4_10:
	.xword	1048576                         // 0x100000
	.xword	2097152                         // 0x200000
.LCPI4_11:
	.xword	4194304                         // 0x400000
	.xword	8388608                         // 0x800000
.LCPI4_12:
	.xword	16777216                        // 0x1000000
	.xword	33554432                        // 0x2000000
.LCPI4_13:
	.xword	67108864                        // 0x4000000
	.xword	134217728                       // 0x8000000
.LCPI4_14:
	.xword	268435456                       // 0x10000000
	.xword	536870912                       // 0x20000000
.LCPI4_15:
	.xword	1073741824                      // 0x40000000
	.xword	2147483648                      // 0x80000000
.LCPI4_16:
	.xword	4294967296                      // 0x100000000
	.xword	8589934592                      // 0x200000000
.LCPI4_17:
	.xword	17179869184                     // 0x400000000
	.xword	34359738368                     // 0x800000000
.LCPI4_18:
	.xword	68719476736                     // 0x1000000000
	.xword	137438953472                    // 0x2000000000
.LCPI4_19:
	.xword	274877906944                    // 0x4000000000
	.xword	549755813888                    // 0x8000000000
.LCPI4_20:
	.xword	1099511627776                   // 0x10000000000
	.xword	2199023255552                   // 0x20000000000
.LCPI4_21:
	.xword	4398046511104                   // 0x40000000000
	.xword	8796093022208                   // 0x80000000000
.LCPI4_22:
	.xword	17592186044416                  // 0x100000000000
	.xword	35184372088832                  // 0x200000000000
.LCPI4_23:
	.xword	70368744177664                  // 0x400000000000
	.xword	140737488355328                 // 0x800000000000
.LCPI4_24:
	.xword	281474976710656                 // 0x1000000000000
	.xword	562949953421312                 // 0x2000000000000
.LCPI4_25:
	.xword	1125899906842624                // 0x4000000000000
	.xword	2251799813685248                // 0x8000000000000
.LCPI4_26:
	.xword	4503599627370496                // 0x10000000000000
	.xword	9007199254740992                // 0x20000000000000
.LCPI4_27:
	.xword	18014398509481984               // 0x40000000000000
	.xword	36028797018963968               // 0x80000000000000
.LCPI4_28:
	.xword	72057594037927936               // 0x100000000000000
	.xword	144115188075855872              // 0x200000000000000
.LCPI4_29:
	.xword	288230376151711744              // 0x400000000000000
	.xword	576460752303423488              // 0x800000000000000
.LCPI4_30:
	.xword	1152921504606846976             // 0x1000000000000000
	.xword	2305843009213693952             // 0x2000000000000000
.LCPI4_31:
	.xword	4611686018427387904             // 0x4000000000000000
	.xword	-9223372036854775808            // 0x8000000000000000
.LCPI4_32:
	.xword	0                               // 0x0
	.xword	1                               // 0x1
	.section	.text._ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,"axG",@progbits,_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,comdat
	.hidden	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.weak	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.p2align	2
	.type	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_,@function
_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_: // @_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	d15, d14, [sp, #48]             // 16-byte Folded Spill
	stp	d13, d12, [sp, #64]             // 16-byte Folded Spill
	stp	d11, d10, [sp, #80]             // 16-byte Folded Spill
	stp	d9, d8, [sp, #96]               // 16-byte Folded Spill
	.cfi_offset b8, -8
	.cfi_offset b9, -16
	.cfi_offset b10, -24
	.cfi_offset b11, -32
	.cfi_offset b12, -40
	.cfi_offset b13, -48
	.cfi_offset b14, -56
	.cfi_offset b15, -64
	.cfi_remember_state
	ldr	x9, [x0]
	ldur	x8, [x1, #-8]
	cmp	x9, x8
	b.hs	.LBB4_3
// %bb.1:
	mov	x10, x0
.LBB4_2:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x10, #8]!
	cmp	x9, x8
	b.hs	.LBB4_2
	b	.LBB4_6
.LBB4_3:
	add	x8, x0, #8
.LBB4_4:                                // =>This Inner Loop Header: Depth=1
	mov	x10, x8
	cmp	x8, x1
	b.hs	.LBB4_6
// %bb.5:                               //   in Loop: Header=BB4_4 Depth=1
	mov	x8, x10
	ldr	x11, [x8], #8
	cmp	x9, x11
	b.hs	.LBB4_4
.LBB4_6:
	cmp	x10, x1
	b.hs	.LBB4_8
.LBB4_7:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x1, #-8]!
	cmp	x9, x8
	b.lo	.LBB4_7
.LBB4_8:
	mov	x8, x10
	cmp	x10, x1
	b.hs	.LBB4_10
// %bb.9:
	ldr	x11, [x10]
	ldr	x12, [x1]
	mov	x8, x10
	str	x12, [x8], #8
	str	x11, [x1]
.LBB4_10:
	sub	x11, x1, #8
	sub	x13, x11, x8
	cmp	x13, #1009
	b.lt	.LBB4_21
// %bb.11:
	mov	x12, #0                         // =0x0
	mov	x13, #0                         // =0x0
	adrp	x14, .LCPI4_0
	ldr	q0, [x14, :lo12:.LCPI4_0]
	str	q0, [sp, #32]                   // 16-byte Folded Spill
	adrp	x14, .LCPI4_1
	ldr	q0, [x14, :lo12:.LCPI4_1]
	str	q0, [sp, #16]                   // 16-byte Folded Spill
	adrp	x14, .LCPI4_2
	ldr	q0, [x14, :lo12:.LCPI4_2]
	str	q0, [sp]                        // 16-byte Folded Spill
	adrp	x14, .LCPI4_3
	ldr	q3, [x14, :lo12:.LCPI4_3]
	adrp	x14, .LCPI4_4
	ldr	q4, [x14, :lo12:.LCPI4_4]
	adrp	x14, .LCPI4_5
	ldr	q5, [x14, :lo12:.LCPI4_5]
	adrp	x14, .LCPI4_6
	ldr	q6, [x14, :lo12:.LCPI4_6]
	adrp	x14, .LCPI4_7
	ldr	q7, [x14, :lo12:.LCPI4_7]
	adrp	x14, .LCPI4_8
	ldr	q16, [x14, :lo12:.LCPI4_8]
	adrp	x14, .LCPI4_9
	ldr	q17, [x14, :lo12:.LCPI4_9]
	adrp	x14, .LCPI4_10
	ldr	q18, [x14, :lo12:.LCPI4_10]
	adrp	x14, .LCPI4_11
	ldr	q19, [x14, :lo12:.LCPI4_11]
	adrp	x14, .LCPI4_12
	ldr	q20, [x14, :lo12:.LCPI4_12]
	adrp	x14, .LCPI4_13
	ldr	q21, [x14, :lo12:.LCPI4_13]
	adrp	x14, .LCPI4_14
	ldr	q22, [x14, :lo12:.LCPI4_14]
	adrp	x14, .LCPI4_15
	ldr	q23, [x14, :lo12:.LCPI4_15]
	adrp	x14, .LCPI4_16
	ldr	q24, [x14, :lo12:.LCPI4_16]
	adrp	x14, .LCPI4_17
	ldr	q25, [x14, :lo12:.LCPI4_17]
	adrp	x14, .LCPI4_18
	ldr	q26, [x14, :lo12:.LCPI4_18]
	adrp	x14, .LCPI4_19
	ldr	q27, [x14, :lo12:.LCPI4_19]
	adrp	x14, .LCPI4_20
	ldr	q28, [x14, :lo12:.LCPI4_20]
	adrp	x14, .LCPI4_21
	ldr	q29, [x14, :lo12:.LCPI4_21]
	adrp	x14, .LCPI4_22
	ldr	q30, [x14, :lo12:.LCPI4_22]
	adrp	x14, .LCPI4_23
	ldr	q31, [x14, :lo12:.LCPI4_23]
	adrp	x14, .LCPI4_24
	ldr	q8, [x14, :lo12:.LCPI4_24]
	adrp	x14, .LCPI4_25
	ldr	q9, [x14, :lo12:.LCPI4_25]
	adrp	x14, .LCPI4_26
	ldr	q10, [x14, :lo12:.LCPI4_26]
	adrp	x14, .LCPI4_27
	ldr	q11, [x14, :lo12:.LCPI4_27]
	adrp	x14, .LCPI4_29
	adrp	x15, .LCPI4_28
	ldr	q12, [x15, :lo12:.LCPI4_28]
	adrp	x15, .LCPI4_30
	adrp	x16, .LCPI4_31
	mov	x17, #-512                      // =0xfffffffffffffe00
	dup	v13.2d, x9
	b	.LBB4_13
.LBB4_12:                               //   in Loop: Header=BB4_13 Depth=1
	cmp	x13, #0
	cset	w18, eq
	add	x8, x8, x18, lsl #9
	cmp	x12, #0
	csel	x18, x17, xzr, eq
	add	x11, x11, x18
	sub	x18, x11, x8
	cmp	x18, #1008
	b.le	.LBB4_22
.LBB4_13:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB4_19 Depth 2
	cbz	x13, .LBB4_16
// %bb.14:                              //   in Loop: Header=BB4_13 Depth=1
	cbz	x12, .LBB4_17
.LBB4_15:                               //   in Loop: Header=BB4_13 Depth=1
	cbnz	x13, .LBB4_18
	b	.LBB4_12
.LBB4_16:                               //   in Loop: Header=BB4_13 Depth=1
	ldp	q14, q15, [x8]
	cmhi	v14.2d, v13.2d, v14.2d
	ldp	q0, q1, [sp, #16]               // 32-byte Folded Reload
	bic	v14.16b, v1.16b, v14.16b
	cmhi	v15.2d, v13.2d, v15.2d
	bic	v15.16b, v0.16b, v15.16b
	orr	v14.16b, v15.16b, v14.16b
	ldp	q15, q0, [x8, #32]
	cmhi	v15.2d, v13.2d, v15.2d
	ldr	q1, [sp]                        // 16-byte Folded Reload
	bic	v15.16b, v1.16b, v15.16b
	cmhi	v0.2d, v13.2d, v0.2d
	bic	v0.16b, v3.16b, v0.16b
	orr	v0.16b, v0.16b, v15.16b
	orr	v0.16b, v0.16b, v14.16b
	ldp	q14, q15, [x8, #64]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v4.16b, v14.16b
	cmhi	v15.2d, v13.2d, v15.2d
	bic	v15.16b, v5.16b, v15.16b
	orr	v14.16b, v15.16b, v14.16b
	ldp	q15, q1, [x8, #96]
	cmhi	v15.2d, v13.2d, v15.2d
	bic	v15.16b, v6.16b, v15.16b
	orr	v14.16b, v15.16b, v14.16b
	orr	v0.16b, v14.16b, v0.16b
	cmhi	v1.2d, v13.2d, v1.2d
	bic	v1.16b, v7.16b, v1.16b
	ldp	q14, q15, [x8, #128]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v16.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v17.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #160]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v18.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	cmhi	v1.2d, v13.2d, v15.2d
	bic	v1.16b, v19.16b, v1.16b
	ldp	q14, q15, [x8, #192]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v20.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v21.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #224]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v22.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v23.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ldp	q1, q14, [x8, #256]
	cmhi	v1.2d, v13.2d, v1.2d
	bic	v1.16b, v24.16b, v1.16b
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v25.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #288]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v26.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v27.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #320]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v28.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v29.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ldp	q1, q14, [x8, #352]
	cmhi	v1.2d, v13.2d, v1.2d
	bic	v1.16b, v30.16b, v1.16b
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v31.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #384]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v8.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v9.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #416]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v10.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	cmhi	v14.2d, v13.2d, v15.2d
	bic	v14.16b, v11.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #448]
	cmhi	v14.2d, v13.2d, v14.2d
	bic	v14.16b, v12.16b, v14.16b
	orr	v1.16b, v14.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	cmhi	v1.2d, v13.2d, v15.2d
	ldr	q14, [x14, :lo12:.LCPI4_29]
	bic	v1.16b, v14.16b, v1.16b
	ldp	q14, q15, [x8, #480]
	cmhi	v14.2d, v13.2d, v14.2d
	ldr	q2, [x15, :lo12:.LCPI4_30]
	bic	v2.16b, v2.16b, v14.16b
	orr	v1.16b, v2.16b, v1.16b
	cmhi	v2.2d, v13.2d, v15.2d
	ldr	q14, [x16, :lo12:.LCPI4_31]
	bic	v2.16b, v14.16b, v2.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ext	v1.16b, v0.16b, v0.16b, #8
	orr	v0.8b, v0.8b, v1.8b
	fmov	x13, d0
	cbnz	x12, .LBB4_15
.LBB4_17:                               //   in Loop: Header=BB4_13 Depth=1
	ldur	q0, [x11, #-8]
	ext	v0.16b, v0.16b, v0.16b, #8
	cmhi	v0.2d, v13.2d, v0.2d
	ldp	q2, q1, [sp, #16]               // 32-byte Folded Reload
	and	v0.16b, v0.16b, v1.16b
	ldur	q1, [x11, #-24]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	and	v1.16b, v1.16b, v2.16b
	orr	v0.16b, v1.16b, v0.16b
	ldur	q1, [x11, #-40]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	ldr	q2, [sp]                        // 16-byte Folded Reload
	and	v1.16b, v1.16b, v2.16b
	ldur	q2, [x11, #-56]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v3.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ldur	q1, [x11, #-72]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	and	v1.16b, v1.16b, v4.16b
	ldur	q2, [x11, #-88]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v5.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-104]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v6.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ldur	q1, [x11, #-120]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	and	v1.16b, v1.16b, v7.16b
	ldur	q2, [x11, #-136]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v16.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-152]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v17.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-168]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v18.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ldur	q1, [x11, #-184]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	and	v1.16b, v1.16b, v19.16b
	ldur	q2, [x11, #-200]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v20.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-216]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v21.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-232]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v22.16b
	orr	v1.16b, v2.16b, v1.16b
	ldur	q2, [x11, #-248]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v23.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	sub	x12, x11, #264
	ldr	q1, [x12]
	ext	v1.16b, v1.16b, v1.16b, #8
	cmhi	v1.2d, v13.2d, v1.2d
	and	v1.16b, v1.16b, v24.16b
	sub	x12, x11, #280
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v25.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #296
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v26.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #312
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v27.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #328
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v28.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #344
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v29.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #360
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v30.16b
	orr	v0.16b, v2.16b, v0.16b
	sub	x12, x11, #376
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v31.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #392
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v8.16b
	orr	v0.16b, v2.16b, v0.16b
	sub	x12, x11, #408
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v9.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #424
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v10.16b
	orr	v0.16b, v2.16b, v0.16b
	sub	x12, x11, #440
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v11.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #456
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	and	v2.16b, v2.16b, v12.16b
	orr	v0.16b, v2.16b, v0.16b
	sub	x12, x11, #472
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	ldr	q14, [x14, :lo12:.LCPI4_29]
	and	v2.16b, v2.16b, v14.16b
	orr	v1.16b, v2.16b, v1.16b
	sub	x12, x11, #488
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	ldr	q14, [x15, :lo12:.LCPI4_30]
	and	v2.16b, v2.16b, v14.16b
	orr	v0.16b, v2.16b, v0.16b
	sub	x12, x11, #504
	ldr	q2, [x12]
	ext	v2.16b, v2.16b, v2.16b, #8
	cmhi	v2.2d, v13.2d, v2.2d
	ldr	q14, [x16, :lo12:.LCPI4_31]
	and	v2.16b, v2.16b, v14.16b
	orr	v1.16b, v2.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	ext	v1.16b, v0.16b, v0.16b, #8
	orr	v0.8b, v0.8b, v1.8b
	fmov	x12, d0
	cbz	x13, .LBB4_12
.LBB4_18:                               //   in Loop: Header=BB4_13 Depth=1
	cbz	x12, .LBB4_12
.LBB4_19:                               //   Parent Loop BB4_13 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	rbit	x18, x13
	clz	x18, x18
	sub	x2, x13, #1
	rbit	x3, x12
	clz	x3, x3
	lsl	x18, x18, #3
	sub	x3, x11, x3, lsl #3
	ldr	x4, [x8, x18]
	ldr	x5, [x3]
	sub	x6, x12, #1
	and	x12, x6, x12
	str	x5, [x8, x18]
	str	x4, [x3]
	and	x13, x2, x13
	cbz	x13, .LBB4_12
// %bb.20:                              //   in Loop: Header=BB4_19 Depth=2
	cbnz	x12, .LBB4_19
	b	.LBB4_12
.LBB4_21:
	mov	x12, #0                         // =0x0
	asr	x14, x13, #3
	mov	w15, #1                         // =0x1
	b	.LBB4_25
.LBB4_22:
	asr	x14, x18, #3
	cmp	x12, #0
	cset	w15, eq
	orr	x16, x13, x12
	cbz	x16, .LBB4_25
// %bb.23:
	sub	x14, x14, #63
	mov	w17, #64                        // =0x40
	mov	w16, #64                        // =0x40
	cbz	x13, .LBB4_26
// %bb.24:
	cbnz	w15, .LBB4_36
	b	.LBB4_44
.LBB4_25:
	adds	x13, x14, #1
	add	x16, x14, #2
	csinc	x14, x16, x14, lt
	asr	x14, x14, #1
	sub	x17, x13, x14
.LBB4_26:
	cmp	x14, #1
	b.lt	.LBB4_29
// %bb.27:
	cmp	x14, #8
	b.hs	.LBB4_30
// %bb.28:
	mov	x13, #0                         // =0x0
	mov	x16, #0                         // =0x0
	mov	x18, x8
	b	.LBB4_33
.LBB4_29:
	mov	x13, #0                         // =0x0
	b	.LBB4_35
.LBB4_30:
	and	x16, x14, #0x7ffffffffffffff8
	dup	v0.2d, x9
	add	x18, x8, x16, lsl #3
	adrp	x13, .LCPI4_32
	ldr	q1, [x13, :lo12:.LCPI4_32]
	add	x13, x8, #32
	movi	v2.2d, #0000000000000000
	mov	w2, #2                          // =0x2
	dup	v3.2d, x2
	mov	w2, #4                          // =0x4
	dup	v4.2d, x2
	mov	w2, #6                          // =0x6
	dup	v5.2d, x2
	mov	w2, #1                          // =0x1
	dup	v6.2d, x2
	mov	w2, #8                          // =0x8
	dup	v7.2d, x2
	mov	x2, x16
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
.LBB4_31:                               // =>This Inner Loop Header: Depth=1
	add	v19.2d, v1.2d, v3.2d
	add	v20.2d, v1.2d, v4.2d
	add	v21.2d, v1.2d, v5.2d
	ldp	q22, q23, [x13, #-32]
	ldp	q24, q25, [x13], #64
	cmhs	v22.2d, v22.2d, v0.2d
	and	v22.16b, v22.16b, v6.16b
	cmhs	v23.2d, v23.2d, v0.2d
	and	v23.16b, v23.16b, v6.16b
	cmhs	v24.2d, v24.2d, v0.2d
	and	v24.16b, v24.16b, v6.16b
	cmhs	v25.2d, v25.2d, v0.2d
	and	v25.16b, v25.16b, v6.16b
	ushl	v22.2d, v22.2d, v1.2d
	ushl	v19.2d, v23.2d, v19.2d
	ushl	v20.2d, v24.2d, v20.2d
	ushl	v21.2d, v25.2d, v21.2d
	orr	v2.16b, v22.16b, v2.16b
	orr	v16.16b, v19.16b, v16.16b
	orr	v17.16b, v20.16b, v17.16b
	orr	v18.16b, v21.16b, v18.16b
	add	v1.2d, v1.2d, v7.2d
	subs	x2, x2, #8
	b.ne	.LBB4_31
// %bb.32:
	orr	v0.16b, v16.16b, v2.16b
	orr	v0.16b, v17.16b, v0.16b
	orr	v0.16b, v18.16b, v0.16b
	ext	v1.16b, v0.16b, v0.16b, #8
	orr	v0.8b, v0.8b, v1.8b
	fmov	x13, d0
	b	.LBB4_34
.LBB4_33:
	ldr	x2, [x18], #8
	cmp	x2, x9
	cset	w2, hs
	lsl	x2, x2, x16
	orr	x13, x2, x13
	add	x16, x16, #1
.LBB4_34:
	cmp	x14, x16
	b.ne	.LBB4_33
.LBB4_35:
	mov	x16, x14
	mov	x14, x17
	cbz	w15, .LBB4_44
.LBB4_36:
	cmp	x14, #1
	b.lt	.LBB4_44
// %bb.37:
	cmp	x14, #8
	b.hs	.LBB4_39
// %bb.38:
	mov	x12, #0                         // =0x0
	mov	x15, #0                         // =0x0
	mov	x17, x11
	b	.LBB4_42
.LBB4_39:
	and	x15, x14, #0xfffffffffffffff8
	dup	v0.2d, x9
	sub	x17, x11, x15, lsl #3
	adrp	x12, .LCPI4_32
	ldr	q1, [x12, :lo12:.LCPI4_32]
	sub	x12, x11, #24
	movi	v2.2d, #0000000000000000
	mov	w18, #2                         // =0x2
	dup	v3.2d, x18
	mov	w18, #4                         // =0x4
	dup	v4.2d, x18
	mov	w18, #6                         // =0x6
	dup	v5.2d, x18
	mov	w18, #1                         // =0x1
	dup	v6.2d, x18
	mov	w18, #8                         // =0x8
	dup	v7.2d, x18
	mov	x18, x15
	movi	v16.2d, #0000000000000000
	movi	v17.2d, #0000000000000000
	movi	v18.2d, #0000000000000000
.LBB4_40:                               // =>This Inner Loop Header: Depth=1
	add	v19.2d, v1.2d, v3.2d
	add	v20.2d, v1.2d, v4.2d
	add	v21.2d, v1.2d, v5.2d
	ldp	q23, q22, [x12]
	ext	v22.16b, v22.16b, v22.16b, #8
	ext	v23.16b, v23.16b, v23.16b, #8
	ldp	q25, q24, [x12, #-32]
	ext	v24.16b, v24.16b, v24.16b, #8
	ext	v25.16b, v25.16b, v25.16b, #8
	cmhi	v22.2d, v0.2d, v22.2d
	and	v22.16b, v22.16b, v6.16b
	cmhi	v23.2d, v0.2d, v23.2d
	and	v23.16b, v23.16b, v6.16b
	cmhi	v24.2d, v0.2d, v24.2d
	and	v24.16b, v24.16b, v6.16b
	cmhi	v25.2d, v0.2d, v25.2d
	and	v25.16b, v25.16b, v6.16b
	ushl	v22.2d, v22.2d, v1.2d
	ushl	v19.2d, v23.2d, v19.2d
	ushl	v20.2d, v24.2d, v20.2d
	ushl	v21.2d, v25.2d, v21.2d
	orr	v2.16b, v22.16b, v2.16b
	orr	v16.16b, v19.16b, v16.16b
	orr	v17.16b, v20.16b, v17.16b
	orr	v18.16b, v21.16b, v18.16b
	add	v1.2d, v1.2d, v7.2d
	sub	x12, x12, #64
	subs	x18, x18, #8
	b.ne	.LBB4_40
// %bb.41:
	orr	v0.16b, v16.16b, v2.16b
	orr	v0.16b, v17.16b, v0.16b
	orr	v0.16b, v18.16b, v0.16b
	ext	v1.16b, v0.16b, v0.16b, #8
	orr	v0.8b, v0.8b, v1.8b
	fmov	x12, d0
	b	.LBB4_43
.LBB4_42:
	ldr	x18, [x17], #-8
	cmp	x18, x9
	cset	w18, lo
	lsl	x18, x18, x15
	orr	x12, x18, x12
	add	x15, x15, #1
.LBB4_43:
	cmp	x14, x15
	b.ne	.LBB4_42
.LBB4_44:
	cbz	x13, .LBB4_48
// %bb.45:
	cbz	x12, .LBB4_48
.LBB4_46:                               // =>This Inner Loop Header: Depth=1
	rbit	x15, x13
	clz	x15, x15
	sub	x17, x13, #1
	rbit	x18, x12
	clz	x18, x18
	lsl	x15, x15, #3
	sub	x18, x11, x18, lsl #3
	ldr	x2, [x8, x15]
	ldr	x3, [x18]
	sub	x4, x12, #1
	and	x12, x4, x12
	str	x3, [x8, x15]
	str	x2, [x18]
	and	x13, x17, x13
	cbz	x13, .LBB4_48
// %bb.47:                              //   in Loop: Header=BB4_46 Depth=1
	cbnz	x12, .LBB4_46
.LBB4_48:
	cmp	x13, #0
	csel	x15, x16, xzr, eq
	add	x8, x8, x15, lsl #3
	cmp	x12, #0
	csel	x14, x14, xzr, eq
	sub	x11, x11, x14, lsl #3
	cbz	x13, .LBB4_57
// %bb.49:
	mov	x12, #-1                        // =0xffffffffffffffff
	b	.LBB4_51
.LBB4_50:                               //   in Loop: Header=BB4_51 Depth=1
	lsl	x14, x12, x14
	bic	x13, x13, x14
	sub	x11, x11, #8
	cbz	x13, .LBB4_53
.LBB4_51:                               // =>This Inner Loop Header: Depth=1
	clz	x14, x13
	eor	x14, x14, #0x3f
	add	x15, x8, x14, lsl #3
	cmp	x11, x15
	b.eq	.LBB4_50
// %bb.52:                              //   in Loop: Header=BB4_51 Depth=1
	ldr	x16, [x15]
	ldr	x17, [x11]
	str	x17, [x15]
	str	x16, [x11]
	b	.LBB4_50
.LBB4_53:
	add	x8, x11, #8
.LBB4_54:
	sub	x8, x8, #8
	cmp	x8, x0
	b.eq	.LBB4_56
// %bb.55:
	ldr	x11, [x8]
	str	x11, [x0]
.LBB4_56:
	cmp	x10, x1
	cset	w1, hs
	str	x9, [x8]
	mov	x0, x8
	ldp	d9, d8, [sp, #96]               // 16-byte Folded Reload
	ldp	d11, d10, [sp, #80]             // 16-byte Folded Reload
	ldp	d13, d12, [sp, #64]             // 16-byte Folded Reload
	ldp	d15, d14, [sp, #48]             // 16-byte Folded Reload
	add	sp, sp, #112
	.cfi_def_cfa_offset 0
	.cfi_restore b8
	.cfi_restore b9
	.cfi_restore b10
	.cfi_restore b11
	.cfi_restore b12
	.cfi_restore b13
	.cfi_restore b14
	.cfi_restore b15
	ret
.LBB4_57:
	.cfi_restore_state
	cbz	x12, .LBB4_54
// %bb.58:
	mov	x13, #-1                        // =0xffffffffffffffff
	b	.LBB4_60
.LBB4_59:                               //   in Loop: Header=BB4_60 Depth=1
	lsl	x14, x13, x14
	bic	x12, x12, x14
	add	x8, x8, #8
	cbz	x12, .LBB4_54
.LBB4_60:                               // =>This Inner Loop Header: Depth=1
	clz	x14, x12
	eor	x14, x14, #0x3f
	sub	x15, x11, x14, lsl #3
	cmp	x8, x15
	b.eq	.LBB4_59
// %bb.61:                              //   in Loop: Header=BB4_60 Depth=1
	ldr	x16, [x15]
	ldr	x17, [x8]
	str	x17, [x15]
	str	x16, [x8]
	b	.LBB4_59
.Lfunc_end4:
	.size	_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_, .Lfunc_end4-_ZNSt3__118__bitset_partitionB8ne180100INS_17_ClassicAlgPolicyEPmNS_6ranges4lessEEENS_4pairIT0_bEES6_S6_T1_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,"axG",@progbits,_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,comdat
	.hidden	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_ // -- Begin function _ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.weak	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.p2align	2
	.type	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_,@function
_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_: // @_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-16]!           // 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	sub	x8, x1, x0
	asr	x8, x8, #3
	cmp	x8, #2
	b.gt	.LBB5_3
// %bb.1:
	b.hs	.LBB5_7
.LBB5_2:
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_3:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x8, #3
	b.eq	.LBB5_10
// %bb.4:
	cmp	x8, #4
	b.eq	.LBB5_16
// %bb.5:
	cmp	x8, #5
	b.ne	.LBB5_13
// %bb.6:
	sub	x4, x1, #8
	add	x1, x0, #8
	add	x2, x0, #16
	add	x3, x0, #24
	bl	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_7:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x8, #2
	b.ne	.LBB5_13
// %bb.8:
	ldur	x8, [x1, #-8]
	ldr	x9, [x0]
	cmp	x8, x9
	b.hs	.LBB5_2
// %bb.9:
	str	x8, [x0]
	stur	x9, [x1, #-8]
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_10:
	.cfi_restore_state
	.cfi_remember_state
	ldp	x8, x9, [x0]
	ldur	x10, [x1, #-8]
	cmp	x9, x8
	b.hs	.LBB5_19
// %bb.11:
	cmp	x10, x9
	b.hs	.LBB5_44
// %bb.12:
	str	x10, [x0]
	stur	x8, [x1, #-8]
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_13:
	.cfi_restore_state
	.cfi_remember_state
	mov	x10, x0
	ldr	x8, [x10, #16]!
	mov	x11, x0
	ldr	x12, [x11, #8]!
	ldr	x9, [x0]
	cmp	x12, x9
	b.hs	.LBB5_22
// %bb.14:
	mov	x13, x0
	mov	x14, x10
	cmp	x8, x12
	b.lo	.LBB5_25
// %bb.15:
	stp	x12, x9, [x0]
	mov	x13, x11
	mov	x14, x10
	b	.LBB5_24
.LBB5_16:
	mov	x8, x0
	ldr	x10, [x8, #8]!
	mov	x9, x0
	ldr	x11, [x9, #16]!
	ldr	x12, [x0]
	cmp	x10, x12
	b.hs	.LBB5_36
// %bb.17:
	mov	x13, x0
	mov	x14, x9
	mov	x2, x12
	cmp	x11, x10
	b.lo	.LBB5_38
// %bb.18:
	stp	x10, x12, [x0]
	mov	x13, x8
	mov	x14, x9
	mov	x2, x12
	cmp	x11, x12
	b.lo	.LBB5_38
	b	.LBB5_40
.LBB5_19:
	cmp	x10, x9
	b.hs	.LBB5_2
// %bb.20:
	str	x10, [x0, #8]
	stur	x9, [x1, #-8]
	ldp	x9, x8, [x0]
	cmp	x8, x9
	b.hs	.LBB5_2
// %bb.21:
	stp	x8, x9, [x0]
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_22:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x8, x12
	b.hs	.LBB5_26
// %bb.23:
	str	x8, [x11]
	str	x12, [x10]
	mov	x13, x0
	mov	x14, x11
.LBB5_24:
	cmp	x8, x9
	b.hs	.LBB5_26
.LBB5_25:
	str	x8, [x13]
	str	x9, [x14]
.LBB5_26:
	add	x8, x0, #24
	cmp	x8, x1
	b.eq	.LBB5_2
// %bb.27:
	mov	w9, #0                          // =0x0
	mov	w11, #24                        // =0x18
	b	.LBB5_30
.LBB5_28:                               //   in Loop: Header=BB5_30 Depth=1
	mov	x10, x0
	str	x12, [x0]
	add	w9, w9, #1
	cmp	w9, #8
	b.eq	.LBB5_35
.LBB5_29:                               //   in Loop: Header=BB5_30 Depth=1
	mov	x10, x8
	add	x12, x8, #8
	add	x11, x11, #8
	mov	x8, x12
	cmp	x12, x1
	b.eq	.LBB5_2
.LBB5_30:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB5_32 Depth 2
	ldr	x12, [x8]
	ldr	x10, [x10]
	cmp	x12, x10
	b.hs	.LBB5_29
// %bb.31:                              //   in Loop: Header=BB5_30 Depth=1
	mov	x14, x11
.LBB5_32:                               //   Parent Loop BB5_30 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x10, [x0, x14]
	subs	x13, x14, #8
	b.eq	.LBB5_28
// %bb.33:                              //   in Loop: Header=BB5_32 Depth=2
	add	x10, x0, x14
	ldur	x10, [x10, #-16]
	mov	x14, x13
	cmp	x12, x10
	b.lo	.LBB5_32
// %bb.34:                              //   in Loop: Header=BB5_30 Depth=1
	add	x10, x0, x13
	str	x12, [x10]
	add	w9, w9, #1
	cmp	w9, #8
	b.ne	.LBB5_29
.LBB5_35:
	add	x8, x8, #8
	cmp	x8, x1
	cset	w0, eq
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_36:
	.cfi_restore_state
	.cfi_remember_state
	cmp	x11, x10
	b.hs	.LBB5_40
// %bb.37:
	str	x11, [x8]
	str	x10, [x9]
	mov	x13, x0
	mov	x14, x8
	mov	x2, x10
	cmp	x11, x12
	b.hs	.LBB5_39
.LBB5_38:
	str	x11, [x13]
	str	x12, [x14]
	mov	x10, x2
.LBB5_39:
	ldur	x11, [x1, #-8]
	cmp	x11, x10
	b.hs	.LBB5_2
	b	.LBB5_41
.LBB5_40:
	mov	x10, x11
	ldur	x11, [x1, #-8]
	cmp	x11, x10
	b.hs	.LBB5_2
.LBB5_41:
	str	x11, [x9]
	stur	x10, [x1, #-8]
	ldr	x9, [x9]
	ldr	x8, [x8]
	cmp	x9, x8
	b.hs	.LBB5_2
// %bb.42:
	stp	x9, x8, [x0, #8]
	ldr	x8, [x0]
	cmp	x9, x8
	b.hs	.LBB5_2
// %bb.43:
	stp	x9, x8, [x0]
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_44:
	.cfi_restore_state
	stp	x9, x8, [x0]
	ldur	x9, [x1, #-8]
	cmp	x9, x8
	b.hs	.LBB5_2
// %bb.45:
	str	x9, [x0, #8]
	stur	x8, [x1, #-8]
	mov	w0, #1                          // =0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end5:
	.size	_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_, .Lfunc_end5-_ZNSt3__127__insertion_sort_incompleteB8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEbT1_S5_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,"axG",@progbits,_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,comdat
	.hidden	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_ // -- Begin function _ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.weak	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.p2align	2
	.type	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_,@function
_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_: // @_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.cfi_startproc
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x0]
	ldr	x10, [x2]
	cmp	x8, x9
	b.hs	.LBB6_3
// %bb.1:
	cmp	x10, x8
	b.hs	.LBB6_6
// %bb.2:
	str	x10, [x0]
	b	.LBB6_8
.LBB6_3:
	cmp	x10, x8
	b.hs	.LBB6_13
// %bb.4:
	str	x10, [x1]
	str	x8, [x2]
	ldr	x9, [x1]
	ldr	x10, [x0]
	cmp	x9, x10
	b.hs	.LBB6_9
// %bb.5:
	str	x9, [x0]
	str	x10, [x1]
	ldr	x8, [x2]
	ldr	x9, [x3]
	cmp	x9, x8
	b.lo	.LBB6_10
	b	.LBB6_14
.LBB6_6:
	str	x8, [x0]
	str	x9, [x1]
	ldr	x8, [x2]
	cmp	x8, x9
	b.hs	.LBB6_9
// %bb.7:
	str	x8, [x1]
.LBB6_8:
	str	x9, [x2]
	mov	x8, x9
.LBB6_9:
	ldr	x9, [x3]
	cmp	x9, x8
	b.hs	.LBB6_14
.LBB6_10:
	str	x9, [x2]
	str	x8, [x3]
	ldr	x8, [x2]
	ldr	x9, [x1]
	cmp	x8, x9
	b.hs	.LBB6_14
// %bb.11:
	str	x8, [x1]
	str	x9, [x2]
	ldr	x8, [x1]
	ldr	x9, [x0]
	cmp	x8, x9
	b.hs	.LBB6_14
// %bb.12:
	str	x8, [x0]
	str	x9, [x1]
	b	.LBB6_14
.LBB6_13:
	mov	x8, x10
	ldr	x9, [x3]
	cmp	x9, x10
	b.lo	.LBB6_10
.LBB6_14:
	ldr	x8, [x4]
	ldr	x9, [x3]
	cmp	x8, x9
	b.hs	.LBB6_19
// %bb.15:
	str	x8, [x3]
	str	x9, [x4]
	ldr	x8, [x3]
	ldr	x9, [x2]
	cmp	x8, x9
	b.hs	.LBB6_19
// %bb.16:
	str	x8, [x2]
	str	x9, [x3]
	ldr	x8, [x2]
	ldr	x9, [x1]
	cmp	x8, x9
	b.hs	.LBB6_19
// %bb.17:
	str	x8, [x1]
	str	x9, [x2]
	ldr	x8, [x1]
	ldr	x9, [x0]
	cmp	x8, x9
	b.hs	.LBB6_19
// %bb.18:
	str	x8, [x0]
	str	x9, [x1]
.LBB6_19:
	ret
.Lfunc_end6:
	.size	_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_, .Lfunc_end6-_ZNSt3__17__sort5B8ne180100INS_17_ClassicAlgPolicyENS_6ranges4lessEPmEEvT1_S5_S5_S5_S5_T0_
	.cfi_endproc
                                        // -- End function
	.section	.text._ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,"axG",@progbits,_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,comdat
	.hidden	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_ // -- Begin function _ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.weak	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.p2align	2
	.type	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_,@function
_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_: // @_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.cfi_startproc
// %bb.0:
	cmp	x0, x1
	b.eq	.LBB7_34
// %bb.1:
	sub	x9, x1, x0
	asr	x8, x9, #3
	subs	x10, x8, #2
	b.lt	.LBB7_13
// %bb.2:
	lsr	x10, x10, #1
	mov	x11, x10
	b	.LBB7_5
.LBB7_3:                                //   in Loop: Header=BB7_5 Depth=1
	str	x14, [x15]
.LBB7_4:                                //   in Loop: Header=BB7_5 Depth=1
	sub	x12, x11, #1
	cmp	x11, #0
	mov	x11, x12
	b.le	.LBB7_13
.LBB7_5:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB7_10 Depth 2
	cmp	x10, x11
	b.lt	.LBB7_4
// %bb.6:                               //   in Loop: Header=BB7_5 Depth=1
	ubfiz	x14, x11, #1, #61
	mov	w13, #1                         // =0x1
	bfi	x13, x11, #1, #61
	add	x12, x0, x13, lsl #3
	add	x14, x14, #2
	cmp	x14, x8
	b.ge	.LBB7_8
// %bb.7:                               //   in Loop: Header=BB7_5 Depth=1
	ldr	x15, [x12]
	mov	x17, x12
	ldr	x16, [x17, #8]!
	cmp	x15, x16
	csel	x16, x15, x16, hi
	csel	x12, x17, x12, lo
	csel	x13, x14, x13, lo
	add	x15, x0, x11, lsl #3
	ldr	x14, [x15]
	cmp	x16, x14
	b.hs	.LBB7_10
	b	.LBB7_4
.LBB7_8:                                //   in Loop: Header=BB7_5 Depth=1
	ldr	x16, [x12]
	add	x15, x0, x11, lsl #3
	ldr	x14, [x15]
	cmp	x16, x14
	b.hs	.LBB7_10
	b	.LBB7_4
.LBB7_9:                                //   in Loop: Header=BB7_10 Depth=2
	ldr	x16, [x12]
	mov	x18, x12
	ldr	x3, [x18, #8]!
	cmp	x16, x3
	csel	x16, x16, x3, hi
	csel	x12, x18, x12, lo
	csel	x13, x13, x17, lo
	cmp	x16, x14
	b.lo	.LBB7_3
.LBB7_10:                               //   Parent Loop BB7_5 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x16, [x15]
	mov	x15, x12
	cmp	x10, x13
	b.lt	.LBB7_3
// %bb.11:                              //   in Loop: Header=BB7_10 Depth=2
	lsl	x16, x13, #1
	mov	w17, #1                         // =0x1
	bfi	x17, x13, #1, #63
	add	x12, x0, x17, lsl #3
	add	x13, x16, #2
	cmp	x13, x8
	b.lt	.LBB7_9
// %bb.12:                              //   in Loop: Header=BB7_10 Depth=2
	ldr	x16, [x12]
	mov	x13, x17
	cmp	x16, x14
	b.hs	.LBB7_10
	b	.LBB7_3
.LBB7_13:
	mov	x3, x1
	cmp	x1, x2
	b.eq	.LBB7_32
// %bb.14:
	subs	x10, x8, #2
	b.ge	.LBB7_19
// %bb.15:
	ldr	x9, [x0]
	mov	x10, x1
	b	.LBB7_17
.LBB7_16:                               //   in Loop: Header=BB7_17 Depth=1
	add	x10, x10, #8
	cmp	x10, x2
	b.eq	.LBB7_31
.LBB7_17:                               // =>This Inner Loop Header: Depth=1
	ldr	x11, [x10]
	cmp	x11, x9
	b.hs	.LBB7_16
// %bb.18:                              //   in Loop: Header=BB7_17 Depth=1
	str	x9, [x10]
	str	x11, [x0]
	mov	x9, x11
	b	.LBB7_16
.LBB7_19:
	lsr	x10, x10, #1
	add	x11, x0, #8
	add	x12, x0, #16
	mov	w13, #1                         // =0x1
	mov	x14, x1
	b	.LBB7_22
.LBB7_20:                               //   in Loop: Header=BB7_22 Depth=1
	str	x15, [x18]
.LBB7_21:                               //   in Loop: Header=BB7_22 Depth=1
	add	x14, x14, #8
	cmp	x14, x2
	b.eq	.LBB7_31
.LBB7_22:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB7_28 Depth 2
	ldr	x15, [x14]
	ldr	x16, [x0]
	cmp	x15, x16
	b.hs	.LBB7_21
// %bb.23:                              //   in Loop: Header=BB7_22 Depth=1
	str	x16, [x14]
	str	x15, [x0]
	ldr	x17, [x0, #8]
	cmp	x9, #16
	b.ne	.LBB7_25
// %bb.24:                              //   in Loop: Header=BB7_22 Depth=1
	mov	x16, x11
	mov	w3, #1                          // =0x1
	cmp	x17, x15
	b.lo	.LBB7_21
	b	.LBB7_26
.LBB7_25:                               //   in Loop: Header=BB7_22 Depth=1
	ldr	x16, [x12]
	cmp	x17, x16
	csel	x17, x17, x16, hi
	csel	x16, x12, x11, lo
	cinc	x3, x13, lo
	cmp	x17, x15
	b.lo	.LBB7_21
.LBB7_26:                               //   in Loop: Header=BB7_22 Depth=1
	mov	x18, x0
	b	.LBB7_28
.LBB7_27:                               //   in Loop: Header=BB7_28 Depth=2
	ldr	x17, [x16]
	mov	x5, x16
	ldr	x6, [x5, #8]!
	cmp	x17, x6
	csel	x17, x17, x6, hi
	csel	x16, x5, x16, lo
	csel	x3, x3, x4, lo
	cmp	x17, x15
	b.lo	.LBB7_20
.LBB7_28:                               //   Parent Loop BB7_22 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x17, [x18]
	mov	x18, x16
	cmp	x10, x3
	b.lt	.LBB7_20
// %bb.29:                              //   in Loop: Header=BB7_28 Depth=2
	lsl	x17, x3, #1
	mov	w4, #1                          // =0x1
	bfi	x4, x3, #1, #63
	add	x16, x0, x4, lsl #3
	add	x3, x17, #2
	cmp	x3, x8
	b.lt	.LBB7_27
// %bb.30:                              //   in Loop: Header=BB7_28 Depth=2
	ldr	x17, [x16]
	mov	x3, x4
	cmp	x17, x15
	b.hs	.LBB7_28
	b	.LBB7_20
.LBB7_31:
	mov	x3, x2
.LBB7_32:
	cmp	x8, #2
	b.ge	.LBB7_37
.LBB7_33:
	mov	x2, x3
.LBB7_34:
	mov	x0, x2
	ret
.LBB7_35:                               //   in Loop: Header=BB7_37 Depth=1
	str	x10, [x9]
.LBB7_36:                               //   in Loop: Header=BB7_37 Depth=1
	sub	x9, x8, #1
	cmp	x8, #2
	mov	x8, x9
	b.le	.LBB7_33
.LBB7_37:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB7_39 Depth 2
                                        //     Child Loop BB7_44 Depth 2
	mov	x13, #0                         // =0x0
	ldr	x10, [x0]
	sub	x9, x8, #2
	lsr	x11, x9, #1
	mov	x12, x0
	b	.LBB7_39
.LBB7_38:                               //   in Loop: Header=BB7_39 Depth=2
	ldr	x15, [x16, #16]!
	ldur	x17, [x16, #-8]
	cmp	x17, x15
	csel	x15, x17, x15, hi
	csel	x9, x16, x9, lo
	csel	x13, x13, x14, lo
	str	x15, [x12]
	mov	x12, x9
	cmp	x13, x11
	b.gt	.LBB7_41
.LBB7_39:                               //   Parent Loop BB7_37 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	add	x16, x12, x13, lsl #3
	add	x9, x16, #8
	lsl	x15, x13, #1
	mov	w14, #1                         // =0x1
	bfi	x14, x13, #1, #63
	add	x13, x15, #2
	cmp	x13, x8
	b.lt	.LBB7_38
// %bb.40:                              //   in Loop: Header=BB7_39 Depth=2
	ldr	x15, [x9]
	mov	x13, x14
	str	x15, [x12]
	mov	x12, x9
	cmp	x14, x11
	b.le	.LBB7_39
.LBB7_41:                               //   in Loop: Header=BB7_37 Depth=1
	sub	x1, x1, #8
	cmp	x9, x1
	b.eq	.LBB7_35
// %bb.42:                              //   in Loop: Header=BB7_37 Depth=1
	ldr	x11, [x1]
	str	x11, [x9]
	str	x10, [x1]
	sub	x10, x9, x0
	add	x10, x10, #8
	asr	x10, x10, #3
	subs	x10, x10, #2
	b.lt	.LBB7_36
// %bb.43:                              //   in Loop: Header=BB7_37 Depth=1
	lsr	x10, x10, #1
	add	x12, x0, x10, lsl #3
	ldr	x13, [x12]
	ldr	x11, [x9]
	cmp	x13, x11
	b.hs	.LBB7_36
.LBB7_44:                               //   Parent Loop BB7_37 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	str	x13, [x9]
	mov	x9, x12
	cbz	x10, .LBB7_46
// %bb.45:                              //   in Loop: Header=BB7_44 Depth=2
	sub	x10, x10, #1
	lsr	x10, x10, #1
	add	x12, x0, x10, lsl #3
	ldr	x13, [x12]
	cmp	x13, x11
	b.lo	.LBB7_44
.LBB7_46:                               //   in Loop: Header=BB7_37 Depth=1
	str	x11, [x9]
	b	.LBB7_36
.Lfunc_end7:
	.size	_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_, .Lfunc_end7-_ZNSt3__119__partial_sort_implB8ne180100INS_17_ClassicAlgPolicyERNS_6ranges4lessEPmS5_EET1_S6_S6_T2_OT0_
	.cfi_endproc
                                        // -- End function
	.section	".linker-options","e",@llvm_linker_options
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
