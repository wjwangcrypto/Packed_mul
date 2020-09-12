	MACRO
	dotproduct0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, $_index, $_n1, $_n2, $_n3, $_n4, $_n5, $_n6, $_n7, $_n8
	IF $_issum==0
		MOV $ress, #0
	ENDIF
	LDR $vector, [$mat_addr, #$_index]
	AND $op2, $const, $vector, LSR #(28-4)
	ORR $op2, #$_n1
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #28 
	;
	AND $op2, $const, $vector, LSR #(24-4) ;;2
	ORR $op2, #$_n2
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #24
	;
	AND $op2, $const, $vector, LSR #(20-4) ;;3
	ORR $op2, #$_n3
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #20
	;
	AND $op2, $const, $vector, LSR #(16-4) ;;4
	ORR $op2, #$_n4
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #16 
	;
	AND $op2, $const, $vector, LSR #(12-4) ;;5
	ORR $op2, #$_n5
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #12 
	;
	AND $op2, $const, $vector, LSR #(8-4) ;;6
	ORR $op2, #$_n6
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 , LSL #8
	;
	AND $op2, $const, $vector ;;7
	ORR $op2, #$_n7
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 , LSL #4
	;
	AND $op2, $const, $vector, LSL #4 ;;8
	ORR $op2, #$_n8
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 
	IF $_issum==0
		STR $ress, [$mat_addr, #$_index]
	ENDIF
	MEND
	
	MACRO
	dotproduct $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum
	MOV $const, #0xF0
	IF $_issum==0
		;LDRB $ress, [$table, $op2]
	ELSE
	;	MOV $ress, $op1 
	ENDIF
		
	dotproduct0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 0,  1,2,3,4,5,6,7,8
	dotproduct0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 4,  1,4,5,3,2,7,6,12
	dotproduct0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 8,  1,8,15,12,10,1,1,10
	dotproduct0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 12, 1,3,2,5,4,6,7,15
	
	
	MEND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;
;;;;  probing security order = 8
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;  1	2	3	4	5	6	7	8
;;  1	4	5	3	2	7	6	12
;;  1	8	15	12	10	1	1	10
;;  1	3	2	5	4	6	7	15
;;  1	6	6	7	7	7	6	1
;;  1	12	10	15	8	1	1	8
;;  1	11	13	9	14	6	7	12
;;  1	5	4	2	3	7	6	10
	MACRO
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, $_index, $_n1, $_n2, $_n3, $_n4, $_n5, $_n6, $_n7, $_n8
	IF $_issum==0
		MOV $ress, #0
	ENDIF
	LDR $vector, [$mat_addr, #$_index]
	AND $op2, $const, $vector, LSR #(28-4)
	ORR $op2, #$_n1
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #28 
	;
	AND $op2, $const, $vector, LSR #(24-4) ;;2
	ORR $op2, #$_n2
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #24
	;
	AND $op2, $const, $vector, LSR #(20-4) ;;3
	ORR $op2, #$_n3
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #20
	;
	AND $op2, $const, $vector, LSR #(16-4) ;;4
	ORR $op2, #$_n4
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #16 
	;
	AND $op2, $const, $vector, LSR #(12-4) ;;5
	ORR $op2, #$_n5
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1, LSL #12 
	;
	AND $op2, $const, $vector, LSR #(8-4) ;;6
	ORR $op2, #$_n6
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 , LSL #8
	;
	AND $op2, $const, $vector ;;7
	ORR $op2, #$_n7
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 , LSL #4
	;
	AND $op2, $const, $vector, LSL #4 ;;8
	ORR $op2, #$_n8
	LDRB $op1, [$table, $op2, LSL #2]
	EOR $ress, $op1 
	IF $_issum==0
		STR $ress, [$mat_addr, #$_index]
	ENDIF
	MEND
	
	MACRO
	dotproductOE $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum
	MOV $const, #0xF0
	IF $_issum==0
		;LDRB $ress, [$table, $op2]
	ELSE
	;	MOV $ress, $op1 
	ENDIF
		
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 0,  1,2,3,4,5,6,7,8
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 4,  1,4,5,3,2,7,6,12
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 8,  1,8,15,12,10,1,1,10
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 12, 1,3,2,5,4,6,7,15
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 16, 1,6,6,7,7,7,6,1
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 20, 1,12,10,15,8,1,1,8
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 24, 1,11,13,9,14,6,7,12
	dotproductOE0 $tmp, $op1, $op2, $vector, $const, $ress, $mat_addr, $table, $_issum, 28, 1,5,4,2,3,7,6,10
	
	
	MEND
	
	END