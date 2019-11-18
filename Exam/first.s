	 AREA     tan, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
	 IMPORT printMsg2p
	 IMPORT printMsg4p
    ; ENTRY 	
	;Here R0=n, R1=i ,R2=fact ,R3=2i ,R4=2i+1 ,R5=2 ,R6=0 or 1,R7=2 , R8=pi, R9=180
;			S0=value of x in degree ,S1=sum of cos series,      S2=temp value of cosx
;			S3=sum of sin series, 	 S4=temp value of sinx,     S5=pi/180
;			S6=(x*x),				 S7=fact*2i for cos series  S8=fact*(2i+1) for sin series
;			S9=pi					 S10=180
;		S11= tanx value for the output
;	
__main  FUNCTION
	
	
	VLDR.F32 S12,=360  ;max angle        
	VLDR.F32 S13,=20  ;radius
	VLDR.F32 S0,=0    ;initial angle is 0      

	
check	VCMP.F32 S0,S12
		BLT  start
		B stop
	
start	MOV R0,#10;Holding the Number of Terms in Series 'n'
        MOV R1,#1;Counting Variable 'i'
		;VLDR.F32 S0,=60;Holding 'x' Value in degree
	    LDR R8,=0x40490fd0 ; pi in hexadecimal floating point
		VMOV S9,R8
		LDR R9,=0x43340000 ;180 in hexadecimal floating point
		VMOV S10,R9
		BL convert	  ; To convert x from degree to radian
		VMOV.F32 S1,#1; S1 holds sum of cos series
		VMOV.F32 S2,#1; S2 holds temp values of cos series
		VMOV.F32 S3,S0; S3 holds sum of sin series
		VMOV.F32 S4,S0; S4 holds temp values of sin series
		MOV R2,#1; for the factorial R2=fact 
		VMUL.F32 S6,S0,S0 ; S6= x^2
		MOV R7,#2 ; R7=2
		VLDR.F32 S14,=10 ;for increment degree by 10
		
loop   CMP R1,R0
	   BLT loop1
	   B inc
	   
loop1  
       VMUL.F32 S2,S2,S6 ; S2=t1 in C code for cos
	   VMUL.F32 S4,S4,S6 ; S4=t2 in C code for sin

	   MUL R3,R1,R7       ; R3=2i
	   ADD R4,R3,#1		 ; R4=2i+1
	   MUL R2,R2,R3      ; R2=R2*2i
	   VMOV S7,R2    ; Move to floating point register
	   VCVT.F32.U32 S7, S7
	   VDIV.F32 S2,S2,S7 ;t1/=fact
	   MUL R2,R2,R4      ; R2=R2*(2i+1)
       VMOV S8,R2    ; Move to floating point register
	   VCVT.F32.U32 S8, S8
	   VDIV.F32 S4,S4,S8 ;t2/=fact
	   BL evnodd
	   ;VDIV.F32 S11,S3,S1 ; tan= sin/cos

       ADD R1,R1,#1       ;R1=R1+1
	   B loop
       
inc   	VMUL.F32 S15,S1,S13
        VCVT.U32.F32 S15,S15 ;to print cos
		VMOV R0,S15
		VMUL.F32 S16,S3,S13
		VCVT.U32.F32 S16,S16 ;to print sin
		VMOV  R1,S16
		BL printMsg2p 
		VADD.F32 S0,S0,S14
		B check
		
		
stop    B stop ; stop program



convert VDIV.F32 S5,S9,S10 ; s5=pi/180
		VMUL.F32 S0,S5,S0
		BX LR
		
evnodd  MOV R5,#2;
		udiv R6,R1,R5 ;quotient of R1/R2
		mls R6,R6,R5,R1; R1-(R5*R6) in R6
		CMP R6,#0;
		ITTEE GT
		VSUBGT.F32 S1,S1,S2 ; c=c-t1
		VSUBGT.F32 S3,S3,S4 ; s=s-t2
		VADDLE.F32 S1,S1,S2 ; c=c+t1
		VADDLE.F32 S3,S3,S4 ; s=s+t2
		BX LR
		
		
     ENDFUNC
     END 