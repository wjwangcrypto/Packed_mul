
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; security order = 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	MACRO
	pack_add $_pack1, $_pack2, $_packr
	
	LDR r7 , =$_pack1
	LDR r6 , =$_pack2
	LTORG

	LDRD r0,r1, [r7]
	LDRD r2,r3, [r6]
	
	EOR r0,r2
	EOR r1,r3
	
	LDR r7 , =$_packr
	STRD r0,r1, [r7]
	MEND
	
	
	END