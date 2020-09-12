	GET macro_tensor.s
	GET macro_dot.s	
	GET macro_lin.s	
	GET macro_pack.s
	GET macro_multi.s
	GET macro_delta.s
	GET macro_linop.s
	GET macro_squareop.s
	GET macro_lambdasquare.s
	GET macro_doubesquare.s		
	GET macro_utils.s	
	GET macro_ahlplus.s		
	GET macro_premul.s	
	GET macro_dvalueplus.s		
	GET macro_deltai.s	
	GET macro_packadd.s	
		
	AREA acMATMUL, code, readonly	
	THUMB
	EXPORT  acMatmul5o
	IMPORT  mulTable
	IMPORT  linTable
	IMPORT  linTable2
	IMPORT tables1
	IMPORT tables2
		
acMatmul5o
	PUSH {LR}
	LDR r0, =sbox_out
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;		security order = 4 ;
;;		5 shares
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;delta transformation, the output is aH and aL, where the address of aL positions after that of aH.	
	deltaop sbox_in, aH, tables1
	
;\lamda a^2, result is lmba		
	lambdasquareop aH, lmba, tables1, 16

;aH+aL
	ahlplus5o aH, aL, ahlp

;;this is packing, result is aL_pack
	prepack5o aL
	LDR r0, =packoe
	LDR LR, =conoe_pack_al
	BX r0
conoe_pack_al
	postpack5o aL_pack
	
;;this is packing, reusult is ahl_pack	
	prepack5o ahlp
	LDR r0, =packoe
	LDR LR, =conoe_pack_ahl
	BX r0
conoe_pack_ahl
	postpack5o ahl_pack

;;this is mutiplying, result is temp
	premulti5o ahl_pack,aL_pack
	LDR r0, =multioe
	LDR LR, =conoe_multi_temp
	BX r0
conoe_multi_temp
	postmulti5o temp

;;temp+lmba
	dvalueplus5o temp, lmba, dvalue
	squareop dvalue, dvalue2, tables1, 8

;;Inv in gf(2^4) start
	prepack5o dvalue
	LDR r0, =packoe
	LDR LR, =conoe_pack_dvalue
	BX r0
conoe_pack_dvalue
	postpack5o dvalue_pack
	
	prepack5o dvalue2
	LDR r0, =packoe
	LDR LR, =conoe_pack_dvalue2
	BX r0
conoe_pack_dvalue2
	postpack5o dvalue2_pack

	premulti5o dvalue_pack,dvalue2_pack
	LDR r0, =multioe
	LDR LR, =conoe_multi_dvalue3
	BX r0
conoe_multi_dvalue3
	postmulti5o dvalue3
	
	doublesquareop dvalue3, dvalue12, tables1, 0
	
	prepack5o dvalue12
	LDR r0, =packoe
	LDR LR, =conoe_pack_dvalue12
	BX r0
conoe_pack_dvalue12
	postpack5o dvalue12_pack	
	
	premulti5o dvalue12_pack,dvalue2_pack
	LDR r0, =multioe
	LDR LR, =conoe_multi_dvaluep
	BX r0
conoe_multi_dvaluep
	postmulti5o dvaluep
	;; Inv in gf(2^4) complete, resutl is dvaluep
	
	;;pack the dvaluep
	prepack5o dvaluep
	LDR r0, =packoe
	LDR LR, =conoe_pack_dvaluep
	BX r0
conoe_pack_dvaluep
	postpack5o dvaluep_pack	
	
	;aL_pack + ahl_pack
	pack_add aL_pack, ahl_pack, aH_pack

	;; the last two multiplying
	premulti5o dvaluep_pack,aH_pack
	LDR r0, =multioe
	LDR LR, =conoe_multi_apH
	BX r0
conoe_multi_apH
	postmulti5o apH
	
	premulti5o dvaluep_pack, ahl_pack
	LDR r0, =multioe
	LDR LR, =conoe_multi_apL
	BX r0
conoe_multi_apL
	postmulti5o apL
	
	;; \delta^{-1} and Aff. outputing the sboxout 
	deltaiop apH, sbox_out, tables2
	
	POP     {LR}
	BX 		 LR

packoe
	pack_x xshare, randmat, (4*5), (4*5+4), linTable
	BX 		 LR 

multioe
	multiplication x_pack, y_pack, zshare
	BX 		 LR
	BX 		 LR 


	

	
	AREA VARS, data, readwrite

;;random matrix, the value should be refreshed by internal TRNG			
randmat
	DCD 0x11110000
	DCD 0x11110000
	DCD 0x11110000 
	DCD 0x11110000

	
		
;;the internal temp varaibles for multiplication
xshare
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678

x_pack
	DCD 0x12345678
u_pack
	DCD 0x11111234

yshare
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678

y_pack
	DCD 0x12345678
v_pack
	DCD 0x00001234

zshare
	DCD 0x12345678
wmat
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678

		
kmat
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678
	DCD 0x12345678

smat
	DCD 0x00000000 
	DCD 0x00000000 
	DCD 0x00000000 
	DCD 0x00000000 

;; This is the input of sboxes: 8 sboxes and 5 shares
sbox_in
	DCB 54  , 53  , 52  , 51  , 58  , 57  , 56  , 55
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

;; Followings are the inernal results of the S-boxes calculation
sbox_hlin
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

aH
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

aL
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

aL_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

aH_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

ahl_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03	
	

lmba	
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

ahlp
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
temp
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
dvalue
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

dvalue_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

dvalue2
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
dvalue2_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
dvalue3
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

dvalue12
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

dvalue12_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03

dvaluep
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
dvaluep_pack
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
apH
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
apL
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	DCB 0x00, 0x01, 0x02, 0x03
	
;; This is the output of sboxes: 8 sboxes and 5 shares
sbox_out
	DCB 54  , 53  , 52  , 51  , 58  , 57  , 56  , 55
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	
	END