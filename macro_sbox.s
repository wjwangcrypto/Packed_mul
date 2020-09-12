

	MACRO
	sbox4order
	deltaop sbox_in, sbox_hlin, mulTable
	lambdasquareop sbox_in, sbox_hlin, mulTable, 0
	LDR r0, =mult
	LDR LR, =con1
	BX r0
con1
	squareop sbox_in, sbox_hlin, mulTable, 0
	LDR r0, =mult
	LDR LR, =con2
	BX r0
con2
	doublesquareop sbox_in, sbox_hlin, mulTable, 0
	LDR r0, =mult
	LDR LR, =con3
	BX r0
con3
	LDR r0, =mult
	LDR LR, =con4
	BX r0
con4
	LDR r0, =mult
	LDR LR, =con5
	BX r0
con5
	deltaop sbox_in, sbox_hlin, mulTable
	ADD r0, r1
	
mult
	pack xshare, yshare, randmat, 20, 24, 20, 24, linTable
	multiplication
	BX 		 LR 
	MEND
	
	MACRO
	sbox8order
	
	deltaopOE sbox_in, sbox_hlin, tables1
	lambdasquareopOE aH, lmba, tables1, 16
	LDR r0, =multoe
	LDR LR, =conoe1
	BX r0
conoe1
	squareopOE sbox_in, sbox_hlin, mulTable, 0
	LDR r0, =multoe
	LDR LR, =conoe2
	BX r0
conoe2
	doublesquareopOE sbox_in, sbox_hlin, mulTable, 0
	LDR r0, =multoe
	LDR LR, =conoe3
	BX r0
conoe3
	LDR r0, =multoe
	LDR LR, =conoe4
	BX r0
conoe4
	LDR r0, =multoe
	LDR LR, =conoe5
	BX r0
conoe5
	deltaopOE sbox_in, sbox_hlin, mulTable
	ADD r0, r1
	
multoe
	packOE xshare, yshare, randmat, 20, 24, 20, 24, linTable
	multiplicationOE x_pack, y_pack, zshare
	BX 		 LR 
	MEND