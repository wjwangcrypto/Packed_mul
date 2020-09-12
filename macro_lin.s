	
	MACRO
	lintran0 $tmp, $res, $ress, $vec, $msk, $dst, $rnd, $table, $_isdiag, $_diagi
	IF $_isdiag == 1
		IF $_diagi == 7
			ADD $table, #(16*4*$_diagi)       
			AND $tmp, $msk, $vec			
			LDR $res, [$table, $tmp, LSL #2]
			EOR $ress, $res
		ELSE
			ADD $table, #(16*4*$_diagi)
			AND $tmp, $msk, $vec, LSR #(28-$_diagi*4)        
			LDR $res, [$table, $tmp, LSL #2]
			EOR $ress, $res	
			SUB $table, #(16*4*$_diagi)
		ENDIF
	ENDIF
	IF $_isdiag == 0
		AND $tmp, $msk, $vec, LSR #28            ;1
		LDR $res, [$table, $tmp, LSL #2]
		EOR $ress, $res
	
		AND $tmp, $msk, $vec, LSR #24       ;2
		ADD $table, #(16*4)
		LDR $res, [$table, $tmp, LSL #2]
		EOR $ress, $res
	
	
		AND $tmp, $msk, $vec, LSR #20       ;3
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		AND $tmp, $msk, $vec, LSR #16       ;4
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		SUB $table,#(16*4*3)
		
		
	ENDIF
		
	MEND
	
	
	MACRO
	lintran $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_issum, $_pack_offset, $_isdiag
	MOV $msk, #0x0F  ;set the value of msk

	LDR $vec, [$rnd] ;put ith row of random to $vec
	IF $_issum == 0
		SUB $share, #4
	ENDIF
	LDR $ress, [$share,#4] ;put the (i+1)th row of result to $ress
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 0 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #4]
	LDR $ress, [$share, #8]
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 1
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #8]
	LDR $ress, [$share, #12]
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 2
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #12]
	LDR $ress, [$share, #16]
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 3
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	IF $_issum == 0
		ADD $share, #4
		STM $share, {$tmp,$res,$ress,$vec}
		SUB $share, #4
	ELSE
		MOV $tmp, $store1
		EOR $tmp, $res
		EOR $tmp, $ress
		EOR $tmp, $vec
		LDR $res, [$share]
		EOR $tmp, $res
		STR $tmp, [$share, #$_pack_offset]
	ENDIF
	MEND
	
	
	MACRO
	lintrandp $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_z_addr
	MOV $msk, #0x0F  ;set the value of msk

	LDR $vec, [$rnd] ;put ith row of random to $vec
	MOV $ress, #0
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 0 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #4]
	MOV $ress, #0
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 1
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #8]
	MOV $ress, #0
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 2
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #12]
	MOV $ress, #0
	lintran0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 3
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	
	MOV $tmp, $store1
	EOR $tmp, $res
	EOR $tmp, $ress
	EOR $tmp, $vec
	LDR $ress, =$_z_addr
	LDR $res, [$ress]
	EOR $tmp, $res
	STR $tmp, [$ress]
	MEND
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;  probing security order = 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	MACRO
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $dst, $rnd, $table, $_isdiag, $_diagi
	IF $_isdiag == 1
		IF $_diagi == 7
			ADD $table, #(16*4*$_diagi)       
			AND $tmp, $msk, $vec			
			LDR $res, [$table, $tmp, LSL #2]
			EOR $ress, $res
		ELSE
			ADD $table, #(16*4*$_diagi)
			AND $tmp, $msk, $vec, LSR #(28-$_diagi*4)        
			LDR $res, [$table, $tmp, LSL #2]
			EOR $ress, $res	
			SUB $table, #(16*4*$_diagi)
		ENDIF
	ENDIF
	IF $_isdiag == 0
		AND $tmp, $msk, $vec, LSR #28            ;1
		LDR $res, [$table, $tmp, LSL #2]
		EOR $ress, $res
	
		AND $tmp, $msk, $vec, LSR #24       ;2
		ADD $table, #(16*4)
		LDR $res, [$table, $tmp, LSL #2]
		EOR $ress, $res
	
	
		AND $tmp, $msk, $vec, LSR #20       ;3
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		AND $tmp, $msk, $vec, LSR #16       ;4
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		
		
		AND $tmp, $msk, $vec, LSR #12       ;5
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		AND $tmp, $msk, $vec, LSR #8       ;6
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		AND $tmp, $msk, $vec, LSR 4       ;7
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		AND $tmp, $msk, $vec       ;8
		ADD $table, #(16*4)
		LDR $res, [$table,$tmp, LSL #2]
		EOR $ress, $res
		
		SUB $table,#(16*4*7)
		
		
	ENDIF
		
	MEND
	

	
	
	MACRO
	lintranOE $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_issum, $_pack_offset, $_isdiag, $_ispackoffset
	MOV $msk, #0x0F  ;set the value of msk

	LDR $vec, [$rnd] ;put ith row of random to $vec
	IF $_issum == 0
		SUB $share, #4
	ENDIF
	LDR $ress, [$share,#4] ;put the (i+1)th row of result to $ress
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 0 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #4]
	LDR $ress, [$share, #8]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 1
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #8]
	LDR $ress, [$share, #12]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 2
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #12]
	LDR $ress, [$share, #16]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 3
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	IF $_issum == 0
		ADD $share, #4
		STM $share, {$tmp,$res,$ress,$vec}
		SUB $share, #4
	ELSE
		MOV $tmp, $store1
		EOR $tmp, $res
		EOR $tmp, $ress
		EOR $tmp, $vec
		LDR $res, [$share]
		EOR $tmp, $res
		STR $tmp, [$share, #$_pack_offset]
	ENDIF
		
	LDR $vec, [$rnd, #16] ;put ith row of random to $vec
	LDR $ress, [$share,#20] ;put the (i+1)th row of result to $ress
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 4 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #20]
	LDR $ress, [$share, #24]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 5
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #24]
	LDR $ress, [$share, #28]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 6
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #28]
	LDR $ress, [$share, #32]
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $_isdiag, 7
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	IF $_issum == 0
		ADD $share, #(4*4+4)
		STM $share, {$tmp,$res,$ress,$vec}
	ELSE
		MOV $tmp, $store1
		EOR $tmp, $res
		EOR $tmp, $ress
		EOR $tmp, $vec
		LDR $res, [$share, #$_pack_offset]
		EOR $tmp, $res
		STR $tmp, [$share, #$_pack_offset]
	ENDIF
	MEND
	
	
	MACRO
	lintrandpOE $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_z_addr
	MOV $msk, #0x0F  ;set the value of msk

	LDR $vec, [$rnd] ;put ith row of random to $vec
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 0 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #4]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 1
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #8]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 2
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #12]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 3
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	
	MOV $tmp, $store1
	EOR $tmp, $res
	EOR $tmp, $ress
	EOR $tmp, $vec
	LDR $ress, =$_z_addr
	LDR $res, [$ress]
	EOR $tmp, $res
	STR $tmp, [$ress]
		
	LDR $vec, [$rnd, #16] ;put ith row of random to $vec
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 4 ;put the (i+1)th row of result
	MOV $store1, $ress
	;;
	LDR $vec, [$rnd, #20]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 5
	MOV $store2, $ress
	;;
	LDR $vec, [$rnd, #24]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 6
	MOV $store3, $ress
	;;
	LDR $vec, [$rnd, #28]
	MOV $ress, #0
	lintranOE0 $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, 1, 7
	MOV $store4, $ress
	
	MOV $tmp, $store1
	MOV $res, $store2
	MOV $ress, $store3
	MOV $vec, $store4
	
	MOV $tmp, $store1
	EOR $tmp, $res
	EOR $tmp, $ress
	EOR $tmp, $vec
	LDR $ress, =$_z_addr
	LDR $res, [$ress]
	EOR $tmp, $res
	STR $tmp, [$ress]
	MEND
	
	
	END