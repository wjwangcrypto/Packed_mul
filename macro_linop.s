
	MACRO
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	;AND $tmp2, $msk, $vec, LSR #8
	filter $tmp2, $msk, $vec, 24
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 24
	
	filter $tmp2, $msk, $vec, 16
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 16
	
	filter $tmp2, $msk, $vec, 8
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 8
	
	filter $tmp2, $msk, $vec, 0
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 0
	MEND
	
	MACRO
	linop1 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	MOV $msk, #0xFF
	
	LDR $vec, [$vec_addr], #4 ;1
	MOV $res, #0
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;2
	MOV $res, #0
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;3
	MOV $res, #0
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;4
	MOV $res, #0
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;5
	MOV $res, #0
	linop0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	MEND
	
	MACRO
	linop $_input, $_output, $_mulTable, $_table_offset
	LDR r6, =$_input
	LTORG
	LDR r5, =$_output
	LTORG
	LDR r7, =$_mulTable
	LTORG
	linop1 r0, r1,r2,r3,r4,r5,r6,r7, $_table_offset
	MEND
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	MACRO
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	;AND $tmp2, $msk, $vec, LSR #8
	filter $tmp2, $msk, $vec, 24
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 24
	;IF $_table_offset == 0
		;AND $tmp1, $msk, $tmp1
	;ELSE
		;AND $tmp1, $msk, $tmp1, LSR #$_table_offset
	;ENDIF
	
	;ORR $res, $tmp1, LSL #4
	
	filter $tmp2, $msk, $vec, 16
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 16
	
	filter $tmp2, $msk, $vec, 8
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 8
	
	filter $tmp2, $msk, $vec, 0
	LDR $tmp1, [$table, $tmp2, LSL #2]
	filter $tmp1, $msk, $tmp1, $_table_offset
	concat $res, $tmp1, 0
	MEND
	
	MACRO
	linopOE1 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	MOV $msk, #0xFF
	
	LDR $vec, [$vec_addr], #4 ;1
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;2
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;3
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;4
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;5
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;6
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;7
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;8
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	LDR $vec, [$vec_addr], #4 ;9
	MOV $res, #0
	linopOE0 $res, $tmp1, $tmp2, $msk, $vec, $dst_addr, $vec_addr, $table, $_table_offset
	STR $res, [$dst_addr], #4
	
	MEND
	
	MACRO
	linopOE $_input, $_output, $_mulTable, $_table_offset
	LDR r6, =$_input
	LTORG
	LDR r5, =$_output
	LTORG
	LDR r7, =$_mulTable
	LTORG
	linopOE1 r0, r1,r2,r3,r4,r5,r6,r7, $_table_offset
	MEND
	
	END