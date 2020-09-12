;	
;	MACRO
;	premul5o $_in1,$_in2
;	LDR r7, =$_in1 
;	LDR r6, =xshare 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	
;	LDR r7, =$_in2
;	LDR r6, =yshare 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	MEND
;	
;	MACRO
;	postmul5o $_out
;	LDR r7, =zshare
;	LDR r6, =$_out 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	MEND


	MACRO
	premulti5o $_in1,$_in2
	LDR r7, =$_in1
	LDR r6, =x_pack 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	
	LDR r7, =$_in2
	LDR r6, =y_pack 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	MEND
	
	MACRO
	postmulti5o $_out
	LDR r7, =zshare 
	LDR r6, =$_out 
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDR r0, [r7]
	STR r0, [r6]
	MEND
	
	MACRO
	prepack5o $_in
	LDR r7, =$_in
	LDR r6, =xshare 
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDR r0, [r7]
	STR r0, [r6]
	MEND
	
	
	MACRO
	postpack5o $_out
	LDR r7, =x_pack
	LDR r6, =$_out 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	MEND



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MACRO
;	premul $_in1,$_in2
;	LDR r7, =$_in1 
;	LDR r6, =xshare 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	
;	LDR r7, =$_in2
;	LDR r6, =yshare 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	MEND
;	
	
	MACRO
	premulti $_in1,$_in2
	LDR r7, =$_in1
	LDR r6, =x_pack 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	
	LDR r7, =$_in2
	LDR r6, =y_pack 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	MEND
	
	MACRO
	postmulti $_out
	LDR r7, =zshare 
	LDR r6, =$_out 
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDR r0, [r7]
	STR r0, [r6]
	MEND
	
	MACRO
	prepack $_in
	LDR r7, =$_in
	LDR r6, =xshare 
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDM r7, {r0,r1,r2,r3}
	STM r6, {r0,r1,r2,r3}
	ADD r7, #(4*4)
	ADD r6, #(4*4)
	LDR r0, [r7]
	STR r0, [r6]
	MEND
	
	
;	MACRO
;	postmul $_out
;	LDR r7, =zshare
;	LDR r6, =$_out 
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDM r7, {r0,r1,r2,r3}
;	STM r6, {r0,r1,r2,r3}
;	ADD r7, #(4*4)
;	ADD r6, #(4*4)
;	LDR r0, [r7]
;	STR r0, [r6]
;	MEND
	
	MACRO
	postpack $_out
	LDR r7, =x_pack
	LDR r6, =$_out 
	LDRD r1,r2, [r7]
	STRD r1,r2, [r6]
	MEND
	
	END