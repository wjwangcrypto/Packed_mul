

	MACRO
	multi_product $_xpak_adr, $_ypak_adr, $_zshare_adr, $_ks_adr, $_uoffset, $_voffset, $_woffset, $_koffset, $_soffset
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; z share reuse:
	;; p vector: 4 * 8 bits       --> this is the first shares of 8 nibbles of z
	;; w matrix: 4 * 8 * 4 bits   --> this is the second to fivth shares of 8 nibbles of z
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; ks:
	;; k matrix: 4 * 8 * 4  bits
	;; s matrix: 4 * 4 * 8 bits : offset = 4*8*4/8 = 16
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; _uoffset = 4, _voffset = 4, _woffset = 4, _koffset = 0, _soffset = 16
	;    y1 y2 y3 v1 v2
	;x1  p  0  0  K  K
	;x2  0  p  0  K  K
	;x3  0  0  p  K  K
	;u1  W  W  W  S  S 0 0
	;u2  W  W  W  S  S 0 0
	
	LDR r7, =mulTable
	;; compute W
	;; op1:u (r5), op2:y (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0, #$_uoffset]
	LDR r0, =$_ypak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_zshare_adr
	ADD r4, #$_woffset
	LTORG
;   tensor_primOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim  r0,     r1,    r2,     r3,    r4,   r5,   r6,    r7
	
	;; compute P
	;; op1:x (r5), op2:y (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0]
	LDR r0, =$_ypak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_zshare_adr
	LTORG
	;tensor_prim_tinyOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim_tiny r0,      r1,     r2,    r3,    r4,  r5,   r6,    r7
	
	;; compute K
	;; op1:x (r5), op2:v (r6)
	LDR r0, =$_ypak_adr
	LTORG
	LDR r5, [r0, #$_voffset]
	LDR r0, =$_xpak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_ks_adr
	LTORG
	ADD r4, #$_koffset
;   tensor_primOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim  r0,     r1,    r2,     r3,    r4,   r5,   r6,    r7
	
	
	;; compute S
	;; op1:u (r5), op2:v (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0, #$_uoffset]
	LDR r0, =$_ypak_adr
	LDR r6, [r0, #$_voffset]
	LDR r4, =$_ks_adr
	LTORG
	ADD r4, #$_soffset
;	tensor_prim_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim_small  r0,    r1,    r2,      r3,   r4,   r5,   r6,    r7
	MEND
	
	
	MACRO 
	smaskadd $_s_adr, $_rand_adr
	LDR r6, =$_s_adr
	LTORG
	LDR r7, =$_rand_adr
	LTORG
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
	MEND
	
	
	MACRO 
	wkadd $_w_addr, $_k_addr
	LDR r6, =$_w_addr
	LTORG
	LDR r7, =$_k_addr
	LTORG
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
	MEND
	
	MACRO
	thelins $_w_adr, $_s_adr, $_k_adr, $_rand_adr
	LDR r7 , =linTable
	LTORG
	LDR r5 , =$_w_adr
	LTORG
	LDR r6 , =$_s_adr
	LTORG
	lintran r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 0, 0, 0
	LDR r7 , =linTable2
	LDR r5 , =$_k_adr
	LTORG
	LDR r6 , =$_rand_adr
	LTORG
;	lintrandp $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_z_addr
	lintrandp  r0,   r1,    r2,   r3,   r4,    r5,    r6,    r7,    r8,        r9,      r10,    r11,   zshare
	MEND
	
	MACRO
	thedots $_z_addr, $_w_adr, $_k_adr
	LDR r7 , =mulTable
	LTORG
	LDR r6, =$_w_adr
	LTORG
	dotproduct r0, r1, r2, r3, r4, r5, r6, r7, 0
	MEND
	
	
	MACRO
	multiplication $_x_pack, $_y_pack, $_zshare
	multi_product $_x_pack, $_y_pack, $_zshare, kmat, 4, 4, 4, 0, 4*4
	smaskadd smat, randmat
	thelins wmat, smat, kmat, randmat
	wkadd wmat, kmat
	thedots zshare, wmat, kmat
	MEND
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; security order = 8
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MACRO
	multi_productOE $_xpak_adr, $_ypak_adr, $_zshare_adr, $_ks_adr, $_uoffset, $_voffset, $_woffset, $_koffset, $_soffset
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; z share reuse:
	;; p vector: 4 * 8 bits       --> this is the first shares of 8 nibbles of z
	;; w matrix: 4 * 8 * 8 bits   --> this is the second to fivth shares of 8 nibbles of z
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; ks:
	;; k matrix: 4 * 8 * 8  bits
	;; s matrix: 4 * 8 * 8 bits : offset = 8*8*8/8 = 64
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;; _uoffset = 4, _voffset = 4, _woffset = 20, _koffset = 0, _soffset = 16
	;    y1 y2 y3 v1 v2
	;x1  p  0  0  K  K
	;x2  0  p  0  K  K
	;x3  0  0  p  K  K
	;u1  W  W  W  S  S 
	;u2  W  W  W  S  S
	
	LDR r7, =mulTable
	;; compute W
	;; op1:u (r5), op2:y (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0, #$_uoffset]
	LDR r0, =$_ypak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_zshare_adr
	ADD r4, #$_woffset
	LTORG
;   tensor_primOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_primOE  r0,     r1,    r2,     r3,    r4,   r5,   r6,    r7
	
	;; compute P
	;; op1:x (r5), op2:y (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0]
	LDR r0, =$_ypak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_zshare_adr
	LTORG
	;tensor_prim_tinyOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim_tinyOE r0,      r1,     r2,    r3,    r4,  r5,   r6,    r7
	
	;; compute K
	;; op1:x (r5), op2:v (r6)
	LDR r0, =$_ypak_adr
	LTORG
	LDR r5, [r0, #$_voffset]
	LDR r0, =$_xpak_adr
	LTORG
	LDR r6, [r0]
	LDR r4, =$_ks_adr
	LTORG
	ADD r4, #$_koffset
;   tensor_primOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_primOE  r0,     r1,    r2,     r3,    r4,   r5,   r6,    r7
	
	
	;; compute S
	;; op1:u (r5), op2:v (r6)
	LDR r0, =$_xpak_adr
	LTORG
	LDR r5, [r0, #$_uoffset]
	LDR r0, =$_ypak_adr
	LDR r6, [r0, #$_voffset]
	LDR r4, =$_ks_adr
	LTORG
	ADD r4, #$_soffset
;	tensor_prim_smallOE $tmp1, $tmp2, $const, $ress, $dst, $op1, $op2, $table
	tensor_prim_smallOE  r0,    r1,    r2,      r3,   r4,   r5,   r6,    r7
	MEND
	
	
	MACRO 
	smaskaddOE $_s_adr, $_rand_adr
	LDR r6, =$_s_adr
	LTORG
	LDR r7, =$_rand_adr
	LTORG
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
	ADD r6, #(4*4)
	
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
	
;	LDM r6, {r0, r1, r2, r3} 
;	LDR r4, [r7], #4
;	EOR r0, r4
;	LDR r4, [r7], #4
;	EOR r1, r4
;	LDR r4, [r7], #4
;	EOR r2, r4
;	LDR r4, [r7], #4
;	EOR r3, r4
;	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
;	
;	LDM r6, {r0, r1, r2, r3}
;	LDR r4, [r7], #4
;	EOR r0, r4
;	LDR r4, [r7], #4
;	EOR r1, r4
;	LDR r4, [r7], #4
;	EOR r2, r4
;	LDR r4, [r7], #4
;	EOR r3, r4
;	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
	MEND
	
	MACRO 
	wkaddOE $_w_addr, $_k_addr
	LDR r6, =$_w_addr
	LTORG
	LDR r7, =$_k_addr
	LTORG
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
	ADD r6, #(4*4)
	
	LDM r6, {r0, r1, r2, r3}
	LDR r4, [r7], #4
	EOR r0, r4
	LDR r4, [r7], #4
	EOR r1, r4
	LDR r4, [r7], #4
	EOR r2, r4
	LDR r4, [r7], #4
	EOR r3, r4
	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
	
;	LDM r6, {r0, r1, r2, r3}  ;;;;may be saved
;	LDR r4, [r7], #4
;	EOR r0, r4
;	LDR r4, [r7], #4
;	EOR r1, r4
;	LDR r4, [r7], #4
;	EOR r2, r4
;	LDR r4, [r7], #4
;	EOR r3, r4
;	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
;	
;	LDM r6, {r0, r1, r2, r3}
;	LDR r4, [r7], #4
;	EOR r0, r4
;	LDR r4, [r7], #4
;	EOR r1, r4
;	LDR r4, [r7], #4
;	EOR r2, r4
;	LDR r4, [r7], #4
;	EOR r3, r4
;	STM r6, {r0, r1, r2, r3}
;	ADD r6, #(4*4)
	MEND
	
	MACRO
	thelinsOE $_w_adr, $_s_adr, $_k_adr, $_rand_adr
	LDR r7 , =linTable
	LTORG
	LDR r5 , =$_w_adr
	LTORG
	LDR r6 , =$_s_adr
	LTORG
	lintranOE r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, 0, 0, 0
	LDR r7 , =linTable2
	LDR r5 , =$_k_adr
	LTORG
	LDR r6 , =$_rand_adr
	LTORG
;;	lintrandpOE $tmp, $res, $ress, $vec, $msk, $share, $rnd, $table, $store1, $store2, $store3, $store4, $_z_addr
	lintrandpOE  r0,   r1,    r2,   r3,   r4,    r5,    r6,    r7,    r8,        r9,      r10,    r11,   zshare
	MEND
	
	MACRO
	thedotsOE $_z_addr, $_w_adr, $_k_adr
	LDR r7 , =mulTable
	LTORG
	LDR r6, =$_w_adr
	LTORG
	dotproductOE r0, r1, r2, r3, r4, r5, r6, r7, 0
	MEND
	
	
	MACRO
	multiplicationOE $_x_pack, $_y_pack, $_zshare
	multi_productOE $_x_pack, $_y_pack, $_zshare, kmat, 4, 4, 4, 0, 4*8
	smaskaddOE smat, randmat
	thelinsOE wmat, smat, kmat, randmat
	wkaddOE wmat, kmat
	thedotsOE zshare, wmat, kmat
	MEND
	
	END