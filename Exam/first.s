	 AREA     circle, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
	 IMPORT printMsg3p
	 IMPORT printMsg4p
 	
__main  FUNCTION
	 VLDR.F32 S0,=360  ; 360 is the max degree
     VLDR.F32 S19,=60	   ;Initial S17 value
	   
	  
while VMOV.F32  S1,S19  
 
     VLDR.F32 S2,=20   ;Radius=20
     VLDR.F32 S15,=10  ; Increment
	 
     ;Calculating sin and cos
     MOV r0,#10        ; no. of terms in cos
     MOV r1,#1 			;counting variable
	 LDR r2,=0x40490fdb ;pi value
	 VMOV S3,r2			
	 LDR r3,=0x43340000  ;180 value
	 VMOV S4,r3          ;
	 BL convert          ;s1 stores the radian value
	 VMUL.F32 S5,S1,S1 ; S5=X^2
	 MOV r4,#2 ; R4=2
	 VMOV.F32 S6,#1; S6 holds sum of cos series
	 VMOV.F32 S7,#1; S7 holds temp values of cos series
	 VMOV.F32 S8,S1; S8 holds sum of sin series
	 VMOV.F32 S9,S1; S9 holds temp values of sin series

check1     VCVT.S32.F32 S21,s19
	       VMOV r9,s21
		   VCVT.S32.F32 S22,s0
	       VMOV r10,s22
          CMP r9,r10   ;while degree<360

	       BLT cos
	       B stop

cos   CMP r1,r0
      BLT loop
	  B loop2
	   
loop  VMUL.F32 S7,S7,S5 ; t1=t1*(x2)
      MUL r5,r4,r1 ; r5=2i
	  BL fact       ; r7 contain the fact(2i)
	  VMOV s10,r7
	  VCVT.F32.U32 s10,s10
	  VDIV.F32 s11,s7,s10  ;t3=t1/f(2i)
	  BL evenoddcos
	  ADD r1,r1,#1    ;  r1=r1+1;
	  B cos
	      
	  
fact    MOV r6,r5 ; load n into r6
        MOV r7,#1 ; if n = 0, at least n! = 1
loop1    CMP r6, #0
        MULGT r7, r6, r7
        SUBGT r6, r6, #1 ; decrement n
        BGT loop1 ; do another mul if counter!= 0
	    BX lr

evenoddcos 
		udiv R8,R1,R4 ;quotient of R1/2
		mls R8,R8,R4,R1; R1-(2*R8) in R8
		CMP R8,#0;
		ITE GT
		VSUBGT.F32 S6,S6,S11 ; c=c-t3
		VADDLE.F32 S6,S6,S11; c=c+t3
		BX LR
; for sine series

loop2  MOV r0,#10        ; no. of terms in sin
       MOV r1,#1          ; i value
sin    CMP r1,r0
       BLT loop3
	   B cal	
	   
loop3  	VMUL.F32 s9,s9,s5 ; t2=t2*(x2)
		MUL r5,r4,r1 ; r5=2i
		ADD r5,r5,#1 ; r5=2i+1
		BL fact ; r7 gives the factorial value
		VMOV s10,r7
	    VCVT.F32.U32 s10,s10
	    VDIV.F32 s11,s9,s10  ;t3=t2/f(2i)
	    BL evenoddsin
	    ADD r1,r1,#1    ;  r1=r1+1;
	    B sin
evenoddsin
		udiv R8,R1,R4 ;quotient of R1/2
		mls R8,R8,R4,R1; R1-(2*R8) in R8
		CMP R8,#0;
		ITE GT
		VSUBGT.F32 S8,S8,S11 ; s=s-t3
		VADDLE.F32 S8,S8,S11 ; s=s+t3
		BX LR	   
	   
cal   VMUL.F32 S12,S2,S6 ; x=rcos
	  VMUL.F32 s13,S2,s8 ; y=rsin
;	  VLDR.F32 S17,=319; h
;	  VLDR.F32 S18,=239;k
;	  VADD.F32 S12,S12,S17 ;x=x+h
	  VCVT.S32.F32 S12,s12
	  VMOV r1,s12
;	  VADD.F32 S13,S18,S13 ;y=y+k
	  VCVT.S32.F32 S13,s13
	  VMOV r2,s13
	  VCVT.S32.F32 S20,S19 ; print deg
	  VMOV r0,S20
	  BL printMsg3p
      VADD.F32 S19,S19,S15
	  B while
	
convert ;CMP S0,S12
		VDIV.F32 S16,S3,S4 ; s16=pi/180
		VMUL.F32 S1,S16,S1
		BX LR	
stop B stop		
		
     ENDFUNC
     END 
