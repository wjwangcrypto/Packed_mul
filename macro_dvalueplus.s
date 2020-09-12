	MACRO
	dvalueplus5o $_temp, $_lmba, $_dvalue
	LDR r7, =$_dvalue
	LDR r6, =$_temp
	LDR r5, =$_lmba
	
	LDR r1, [r6], #4;;1
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;2
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;3
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;4
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;5
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	MEND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	MACRO
	dvalueplus $_temp, $_lmba, $_dvalue
	LDR r7, =$_dvalue
	LDR r6, =$_temp
	LDR r5, =$_lmba
	
	LDR r1, [r6], #4;;1
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;2
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;3
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;4
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;5
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;6
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4 ;;7
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;8
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	LDR r1, [r6], #4;;9
	LDR r2, [r5], #4
	EOR r0, r1, r2
	STR r0, [r7], #4
	
	MEND
	
	END