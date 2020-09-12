	MACRO
	pack_x $_xshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_linTable_adr
	LDR r7 , =$_linTable_adr ;; this is put before pack_y
	LDR r6 , =$_rnd_adr
	LTORG

	LDR r5 , =$_xshares_adr
	LTORG
	lintran r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 1, $_x_pack_offset, 0
	LDRD r0, r1, [r6]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #8]
	EOR r0, r1
	EOR r3, r0
	STR r3, [r5, #$_u_pack_offset]
	MEND
	
	MACRO
	pack_y $_yshares_adr, $_rnd_adr, $_y_pack_offset, $_v_pack_offset, $_linTable_adr, $_is_first
	IF $_is_first == 1
		LDR r7 , =$_linTable_adr
		LDR r6 , =$_rnd_adr
		LTORG
	ENDIF
	LDR r5 , =$_yshares_adr
	LTORG
	lintran r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 1, $_y_pack_offset, 0
	LDRD r0, r1, [r6]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #8]
	EOR r0, r1
	EOR r3, r0
	STR r3, [r5, #$_v_pack_offset]
	MEND
	
	
	MACRO
	pack $_xshares_adr, $_yshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_y_pack_offset, $_v_pack_offset, $_linTable_adr
	
	pack_x $_xshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_linTable_adr, 1
	pack_y $_yshares_adr, $_rnd_adr, $_y_pack_offset, $_v_pack_offset, $_linTable_adr, 0
	
	MEND
	
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; security order = 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	MACRO
	pack_xOE $_xshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_linTable_adr

	LDR r7 , =$_linTable_adr ;; this is put before pack_y
	LDR r6 , =$_rnd_adr
	LTORG

	LDR r5 , =$_xshares_adr
	LTORG
	lintranOE r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 1, $_x_pack_offset, 0
	LDRD r0, r1, [r6]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #8]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #16]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #24]
	EOR r3, r0, r1

	STR r3, [r5, #$_u_pack_offset]
	MEND
	
	MACRO
	pack_yOE $_yshares_adr, $_rnd_adr, $_y_pack_offset, $_v_pack_offset, $_linTable_adr

	LDR r7 , =$_linTable_adr
	LDR r6 , =$_rnd_adr
	LTORG

	LDR r5 , =$_yshares_adr
	LTORG
	lintranOE r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 1, $_y_pack_offset, 0
	LDRD r0, r1, [r6]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #8]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #16]
	EOR r3, r0, r1
	LDRD r0, r1, [r6, #24]
	EOR r3, r0, r1

	STR r3, [r5, #$_v_pack_offset]
	MEND
	
	
	MACRO
	packOE $_xshares_adr, $_yshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_y_pack_offset, $_v_pack_offset, $_linTable_adr
	
	pack_xOE $_xshares_adr, $_rnd_adr, $_x_pack_offset, $_u_pack_offset, $_linTable_adr
	pack_yOE $_yshares_adr, $_rnd_adr, $_y_pack_offset, $_v_pack_offset, $_linTable_adr
	
	MEND
	
	END