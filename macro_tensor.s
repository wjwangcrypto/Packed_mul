	MACRO
	tensor_prim0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, $_index	
	IF $_index == 28
		AND $tmp2, $const, $op2
	ELSE
		AND $tmp2, $const, $op2, LSR #(28-$_index)
	ENDIF
	ORR $tmp2, $op1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	MEND
	
	MACRO
	tensor_prim1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	MOV $ress, 0
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 0
	ORR $ress, $tmp1, LSL #28
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 4
	ORR $ress, $tmp1, LSL #24
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 8
	ORR $ress, $tmp1, LSL #20
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 12
	ORR $ress, $tmp1, LSL #16
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 16
	ORR $ress, $tmp1, LSL #12
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 20
	ORR $ress, $tmp1, LSL #8
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 24
	ORR $ress, $tmp1, LSL #4
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 28
	ORR $ress, $tmp1
	MEND
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;      op2  op2   op2  op2
	;; op1 
	;; op1
	;; 0
	;; 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	tensor_prim $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	
	MOV r9, $op1
	AND $op1, $const, $op1, LSR #28
	tensor_prim1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #0]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #24
	tensor_prim1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #4]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #20
	;MOV $ress, #0
	tensor_prim1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #8]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #16
	;MOV $ress, #0
	tensor_prim1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #12]
	
	MEND
	
	

	MACRO
	tensor_prim1_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	MOV $ress, 0
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 0
	ORR $ress, $tmp1, LSL #28
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 4
	ORR $ress, $tmp1, LSL #24
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 8
	ORR $ress, $tmp1, LSL #20
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 12
	ORR $ress, $tmp1, LSL #16
	MEND
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;      op2  op2   0  0 
	;; op1 
	;; op1
	;; 0
	;; 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	tensor_prim_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	
	MOV r9, $op1
	AND $op1, $const, $op1, LSR #28
	tensor_prim1_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #0]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #24
	tensor_prim1_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #4]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #20
	tensor_prim1_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #8]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #16
	tensor_prim1_small $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #12]

	MEND
	
	
	MACRO
	tensor_prim_tiny $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	MOV $ress, #0
	
	AND $tmp1, $const, $op1, LSR #28
	AND $tmp2, $const, $op2, LSR #28
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #28
	;
	AND $tmp1, $const, $op1, LSR #24
	AND $tmp2, $const, $op2, LSR #24
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #24
	;
	AND $tmp1, $const, $op1, LSR #20
	AND $tmp2, $const, $op2, LSR #20
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #20
	;
	AND $tmp1, $const, $op1, LSR #16
	AND $tmp2, $const, $op2, LSR #16
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #16
	;
	AND $tmp1, $const, $op1, LSR #12
	AND $tmp2, $const, $op2, LSR #12
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #12
	;
	AND $tmp1, $const, $op1, LSR #8
	AND $tmp2, $const, $op2, LSR #8
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #8
	;
	AND $tmp1, $const, $op1, LSR #4
	AND $tmp2, $const, $op2, LSR #4
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #4
	;
	AND $tmp1, $const, $op1
	AND $tmp2, $const, $op2
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1
	
	STR $ress, [$dst, #0]
	
	MEND
	
	
	MACRO
	outerpd
	LDR r7 , =mulTable
	LTORG
	;LTORG
	LDR r0, =yvec
	LTORG
	;LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	;LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	;LTORG
	tensor_primOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_primOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_prim_smallOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_prim_tinyOE r0, r1, r2, r3, r4, r5, r6, r7
	MEND
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; security order = 8 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, $_index	
	IF $_index == 28
		AND $tmp2, $const, $op2
	ELSE
		AND $tmp2, $const, $op2, LSR #(28-$_index)
	ENDIF
	ORR $tmp2, $op1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	MEND
	
	MACRO
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	MOV $ress, 0
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 0
	ORR $ress, $tmp1, LSL #28
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 4
	ORR $ress, $tmp1, LSL #24
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 8
	ORR $ress, $tmp1, LSL #20
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 12
	ORR $ress, $tmp1, LSL #16
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 16
	ORR $ress, $tmp1, LSL #12
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 20
	ORR $ress, $tmp1, LSL #8
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 24
	ORR $ress, $tmp1, LSL #4
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 28
	ORR $ress, $tmp1
	MEND
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;      op2  op2  op2
	;; op1 
	;; op1
	;; op1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	tensor_primOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	
	MOV r9, $op1
	AND $op1, $const, $op1, LSR #28
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #0]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #24
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #4]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #20
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #8]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #16
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #12]
	;;;
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #12
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #16]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #8
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #20]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #4
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #24]
	
	MOV $op1, r9
	AND $op1, $const, $op1
	;MOV $ress, #0
	tensor_primOE1 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #28]
	
	MEND
	
	
	MACRO
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	MOV $ress, 0
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 0
	ORR $ress, $tmp1, LSL #28
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 4
	ORR $ress, $tmp1, LSL #24
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 8
	ORR $ress, $tmp1, LSL #20
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 12
	ORR $ress, $tmp1, LSL #16
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 16
	ORR $ress, $tmp1, LSL #12
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 20
	ORR $ress, $tmp1, LSL #8
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 24
	ORR $ress, $tmp1, LSL #4
	tensor_primOE0 $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table, 28
	ORR $ress, $tmp1
	MEND
	
	
	MACRO
	tensor_prim_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	
	MOV r9, $op1
	AND $op1, $const, $op1, LSR #28
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #0]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #24
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #4]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #20
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #8]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #16
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #12]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #12
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #16]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #8
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #20]
	
	MOV $op1, r9
	AND $op1, $const, $op1, LSR #4
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #24]
	
	MOV $op1, r9
	AND $op1, $const, $op1
	tensor_prim1_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table	
	STR $ress, [$dst, #28]
	
	MEND
	
	
	MACRO
	tensor_prim_tinyOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	MOV $const, #0x0F
	MOV $ress, #0
	
	AND $tmp1, $const, $op1, LSR #28
	AND $tmp2, $const, $op2, LSR #28
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #28
	;
	AND $tmp1, $const, $op1, LSR #24
	AND $tmp2, $const, $op2, LSR #24
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #24
	;
	AND $tmp1, $const, $op1, LSR #20
	AND $tmp2, $const, $op2, LSR #20
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #20
	;
	AND $tmp1, $const, $op1, LSR #16
	AND $tmp2, $const, $op2, LSR #16
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #16
	;
	AND $tmp1, $const, $op1, LSR #12
	AND $tmp2, $const, $op2, LSR #12
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #12
	;
	AND $tmp1, $const, $op1, LSR #8
	AND $tmp2, $const, $op2, LSR #8
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #8
	;
	AND $tmp1, $const, $op1, LSR #4
	AND $tmp2, $const, $op2, LSR #4
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1, LSL #4
	;
	AND $tmp1, $const, $op1
	AND $tmp2, $const, $op2
	ORR $tmp2, $tmp1, LSL #4
	LDRB $tmp1, [$table, $tmp2, LSL #2] ;search lookup table
	ORR $ress, $tmp1
	
	STR $ress, [$dst, #0]
	
	MEND
	
	
	MACRO
	outerpdOE
	LDR r7 , =mulTable
	LTORG
	;LTORG
	LDR r0, =yvec
	LTORG
	;LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	;LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	;LTORG
	tensor_primOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_primOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_prim_smallOE r0, r1, r2, r3, r4, r5, r6, r7
	LDR r0, =yvec
	LTORG
	LDR r6, [r0]
	LDR r0, =uvec
	LTORG
	LDR r5, [r0]
	LDR r4, =kmat
	LTORG
	tensor_prim_tinyOE r0, r1, r2, r3, r4, r5, r6, r7
	MEND
	

	END