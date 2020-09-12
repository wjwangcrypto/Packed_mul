	
	MACRO
	mult_ft $res ,$pttab ,$tmp0
	LDRB $res , [$pttab ,$tmp0] 
	MEND
	
	
	MACRO
	concat $dst, $input, $_left_shift
	IF $_left_shift == 32
		ORR $dst, $input
	ELSE
		ORR $dst, $input, LSL #$_left_shift
	ENDIF
	MEND
	
	MACRO 
	filter $dst, $mask, $input, $_right_shift
	IF $_right_shift == 0
		AND $dst, $mask, $input
	ELSE		
		AND $dst, $mask, $input, LSR #$_right_shift
	ENDIF
	MEND

	END
		