	
	MACRO
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $_offset, $_table_offset
	filter $tmp1, $msk2, $hpart, (28-$_offset); $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (28-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 24
	
	filter $tmp1, $msk2, $hpart, (24-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (24-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 16
	
	filter $tmp1, $msk2, $hpart, (20-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (20-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 8
	
	filter $tmp1, $msk2, $hpart, (16-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (16-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 0
	MEND
	
	MACRO
	deltaiop1 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $hl_adr_st, $dst_adr_st, $_table_offset
	MOV $msk1, #0xFF
	MOV $msk2, #0x0F
	
	;;1
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1]
	LDR $lpart, [$tmp1, #(4*5)]
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #0]
	MOV $vec, #0
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #4]
	;;2
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4+4*5)]
	LDR $lpart, [$tmp1, #(4+4*5)]
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #8]
	MOV $vec, #0
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #12]
	;;3
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*2+4*5)]
	LDR $lpart, [$tmp1, #(4*2+4*5)]
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #16]
	MOV $vec, #0
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #20]
	;;4
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*3+4*5)]
	LDR $lpart, [$tmp1, #(4*3+4*5)]
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #24]
	MOV $vec, #0
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #28]
	;;5
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*4+4*5)]
	LDR $lpart, [$tmp1, #(4*4+4*5)]
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #32]
	MOV $vec, #0
	deltai0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #36]
	MEND
	
	MACRO
	deltaiop $_aphl, $_sbox_out, $_Table
	LDR r2, =$_aphl
	LTORG
	MOV r8, r2
	LDR r2, =$_sbox_out
	LTORG
	MOV r9, r2
	LDR r7, =$_Table
	LTORG
	deltaiop1 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, 24
	MEND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $_offset, $_table_offset
	filter $tmp1, $msk2, $hpart, (28-$_offset); $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (28-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 24
	
	filter $tmp1, $msk2, $hpart, (24-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (24-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 16
	
	filter $tmp1, $msk2, $hpart, (20-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (20-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 8
	
	filter $tmp1, $msk2, $hpart, (16-$_offset) ; $msk2 = 0x0f
	filter $tmp2, $msk2, $lpart, (16-$_offset) ; $msk2 = 0x0f
	ORR $tmp1, $tmp2, $tmp1, LSL #4
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk1, $tmp2, ($_table_offset); $msk1 = 0xff
	concat $vec, $tmp1, 0
	MEND
	
	MACRO
	deltaiopOE1 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $hl_adr_st, $dst_adr_st, $_table_offset
	MOV $msk1, #0xFF
	MOV $msk2, #0x0F
	
	;;1
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1]
	LDR $lpart, [$tmp1, #(4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #0]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #4]
	;;2
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4+4*9)]
	LDR $lpart, [$tmp1, #(4+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #8]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #12]
	;;3
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*2+4*9)]
	LDR $lpart, [$tmp1, #(4*2+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #16]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #20]
	;;4
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*3+4*9)]
	LDR $lpart, [$tmp1, #(4*3+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #24]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #28]
	;;5
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*4+4*9)]
	LDR $lpart, [$tmp1, #(4*4+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #32]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #36]
	;;6
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*5+4*9)]
	LDR $lpart, [$tmp1, #(4*5+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #40]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #44]
	;;7
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*6+4*9)]
	LDR $lpart, [$tmp1, #(4*6+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #48]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #52]
	;;8
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*7+4*9)]
	LDR $lpart, [$tmp1, #(4*7+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #56]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #60]
	;;9
	MOV $vec, #0
	MOV $tmp1, $hl_adr_st
	LDR $hpart, [$tmp1, #(4*8+4*9)]
	LDR $lpart, [$tmp1, #(4*8+4*9)]
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #64]
	MOV $vec, #0
	deltaiOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $vec, [$tmp1, #68]
	MEND
	
	MACRO
	deltaiopOE $_aphl, $_sbox_out, $_Table
	LDR r2, =$_aphl
	LTORG
	MOV r8, r2
	LDR r2, =$_sbox_out
	LTORG
	MOV r9, r2
	LDR r7, =$_Table
	LTORG
	deltaiopOE1 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, 24
	MEND
	END