
	MACRO
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $_offset, $_table_offset
	filter $tmp1, $msk1, $vec, 24 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-4)
	
	filter $tmp1, $msk1, $vec, 16 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-4-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-4-4)
	
	filter $tmp1, $msk1, $vec, 8 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-8-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-8-4)
	
	filter $tmp1, $msk1, $vec, 0 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-12-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-12-4)
	MEND
	
	MACRO
	deltaop1 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $vec_adr_st, $dst_adr_st, $_table_offset
	MOV $msk1, #0xFF
	MOV $msk2, #0x0F
	
	;;1
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #4]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1]
	STR $lpart, [$tmp1,#(4*5)]
	;;2
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #8]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #12]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#4]
	STR $lpart, [$tmp1,#(4+4*5)]
	;;3
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #16]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #20]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*2)]
	STR $lpart, [$tmp1,#(4*2+4*5)]
	;;4
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #24]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #28]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*3)]
	STR $lpart, [$tmp1,#(4*3+4*5)]
	;;5
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1,#32]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #36]
	delta0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*4)]
	STR $lpart, [$tmp1,#(4*4+4*5)]
	

	MEND
	
	MACRO
	deltaop $_sbox_in, $_sbox_hlin, $_Table
	LDR r2, =$_sbox_in
	LTORG
	MOV r8, r2
	LDR r2, =$_sbox_hlin
	LTORG
	MOV r9, r2
	LDR r7, =$_Table
	LTORG
	deltaop1 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, 24
	MEND
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; security order = 8
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $_offset, $_table_offset
	filter $tmp1, $msk1, $vec, 24 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-4)
	
	filter $tmp1, $msk1, $vec, 16 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-4-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-4-4)
	
	filter $tmp1, $msk1, $vec, 8 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-8-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-8-4)
	
	filter $tmp1, $msk1, $vec, 0 ; $msk1 = 0xff
	LDR $tmp2, [$table, $tmp1, LSL #2]
	filter $tmp1, $msk2, $tmp2, (4+$_table_offset)
	concat $hpart, $tmp1, (32-$_offset-12-4)
	filter $tmp1, $msk2, $tmp2, $_table_offset
	concat $lpart, $tmp1, (32-$_offset-12-4)
	MEND
	
	MACRO
	deltaopOE1 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, $vec_adr_st, $dst_adr_st, $_table_offset
	MOV $msk1, #0xFF
	MOV $msk2, #0x0F
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #4]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1]
	STR $lpart, [$tmp1,#(4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #8]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #12]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#4]
	STR $lpart, [$tmp1,#(4+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #16]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #20]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*2)]
	STR $lpart, [$tmp1,#(4*2+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #24]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #28]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*3)]
	STR $lpart, [$tmp1,#(4*3+4*9)]
	
	;;
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1,#32]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #36]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*4)]
	STR $lpart, [$tmp1,#(4*4+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #40]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #44]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*5)]
	STR $lpart, [$tmp1,#(4*5+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #48]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #52]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*6)]
	STR $lpart, [$tmp1,#(4*6+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #56]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #60]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*7)]
	STR $lpart, [$tmp1,#(4*7+4*9)]
	
	MOV $hpart, #0
	MOV $lpart, #0
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #64]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 0, $_table_offset
	MOV $tmp1, $vec_adr_st
	LDR $vec, [$tmp1, #68]
	deltaOE0 $hpart, $lpart, $tmp1, $tmp2, $msk1, $msk2, $vec, $table, 16, $_table_offset
	MOV $tmp1, $dst_adr_st
	STR $hpart, [$tmp1,#(4*8)]
	STR $lpart, [$tmp1,#(4*8+4*9)]
	MEND
	
	MACRO
	deltaopOE $_sbox_in, $_sbox_hlin, $_Table
	LDR r2, =$_sbox_in
	LTORG
	MOV r8, r2
	LDR r2, =$_sbox_hlin
	LTORG
	MOV r9, r2
	LDR r7, =$_Table
	LTORG
	deltaopOE1 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, 24
	MEND
	END