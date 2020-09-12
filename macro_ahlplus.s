

	MACRO
	ahlplus5o $_aH, $_aL, $_ahlp
	LDR r7, =$_ahlp
	LDR r6, =$_aH
	LDR r5, =$_aL
	
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

	MACRO
	ahlplus $_aH, $_aL, $_ahlp
	LDR r7, =$_ahlp
	LDR r6, =$_aH
	LDR r5, =$_aL
	
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