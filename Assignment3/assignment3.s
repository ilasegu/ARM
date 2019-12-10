      AREA     appcode, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg1
     ENTRY 
__main  FUNCTION
	
				; Logic gates using NeuralNetworks	
				; output is in S8

	 MOV R4, #1  	            ; To increment
	 MOV R5, #0
	 MOV R7, #0		   ;R7 is used to know which logic you want to implement
	 VLDR.F32 S1,=1            ; S1 initialised to 1
	 VLDR.F32 S23,=0.5         ; S23 is used as threshold
	 BAL Logic
	 
Logic					; switch case 
		CMP R7,#0		;go to and gate 
		BEQ Gand
		CMP R7,#1		;go to or gate
		BEQ Gor
		CMP R7,#2		;go to not gate
		BEQ Gnot
		CMP R7,#3		;go to nand gate
		BEQ Gnand
		CMP R7,#4		;go to nor gate
		BEQ Gnor
		CMP R7,#5               ;go to xor gate 
		BEQ Gxor
		CMP R7,#6		;go to xnor gate
		BEQ Gxnor
		
	;S14,S11,S12 contain the weights and S13 has the bias value 
	
Gand
		VLDR.F32 S14,=-0.1 
		VLDR.F32 S11,=0.2 
		VLDR.F32 S12,=0.2 
		VLDR.F32 S13,=-0.2 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4
		
Gor
		VLDR.F32 S14,=-0.1 
		VLDR.F32 S11,=0.7 
		VLDR.F32 S12,=0.7 
		VLDR.F32 S13,=-0.1 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4
		
Gnot
		VLDR.F32 S14,=0.5 
		VLDR.F32 S11,=-0.7 
		VLDR.F32 S12,=0 
		VLDR.F32 S13,=0.1 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4
		
Gnand
		VLDR.F32 S14,=0.6 
		VLDR.F32 S11,=-0.8 
		VLDR.F32 S12,=-0.8 
		VLDR.F32 S13,=0.3 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4
		
Gnor	VLDR.F32 S14,=0.5 
		VLDR.F32 S11,=-0.7 
		VLDR.F32 S12,=-0.7 
		VLDR.F32 S13,=0.1 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4
		
Gxor		
		VLDR.F32 S14,=-5 
		VLDR.F32 S11,=20 
		VLDR.F32 S12,=10 
		VLDR.F32 S13,=1 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4

Gxnor
		VLDR.F32 S14,=-5 
		VLDR.F32 S11,=20 
		VLDR.F32 S12,=10 
		VLDR.F32 S13,=1 
		CMP R5, #0
		BEQ IN1
		CMP R5, #1
		BEQ IN2
		CMP R5, #2
		BEQ IN3
		CMP R5, #3
		BEQ IN4	
	
	   ;Input is in S15,S16,S17
IN1   
		VLDR.F32 S15,=1 
		VLDR.F32 S16,=0 
		VLDR.F32 S17,=0 
		B Sigmoid
		
IN2    
		VLDR.F32 S15,=1 
		VLDR.F32 S16,=0 
		VLDR.F32 S17,=1 
		B Sigmoid		
		
IN3    
		VLDR.F32 S15,=1 
		VLDR.F32 S16,=1 
		VLDR.F32 S17,=0 
		B Sigmoid
		
IN4    
		VLDR.F32 S15,=1 
		VLDR.F32 S16,=1 
		VLDR.F32 S17,=1 
		B Sigmoid
	
Sigmoid
		VMUL.F32 S18,S15,S14 
		VMUL.F32 S19,S11,S16 
		VMUL.F32 S20,S12,S17 
		VADD.F32 S21,S19,S18 
		VADD.F32 S21,S21,S20 
		VADD.F32 S21,S21,S13    ;S21 contain the value of perceptron w1x1+w2x2+w3x3
		VMOV.F32 S10, S21    
		BL exp		        ; e^x subroutine is called
		
		VADD.F S22,S4,S1        ; (1+e^x)
		VDIV.F S6,S4,S22 	; (e^x/(1+e^x)) value is stored in S6
		VMOV.F S8,S6            ;Sigmoid value is in S8
		VCMP.F S6,S23
		vmrs APSR_nzcv,FPSCR
		BLT LOGIC0
		BGT LOGIC1
FINAL
        MOV R1,R7
	    VCVT.U32.F32 S16,S16
	    VMOV R2,S16
	    VCVT.U32.F32 S17,S17
	    VMOV R3,S17 	    
		BL printMsg1             ; printMsg1 is called
		ADD R5,R5,R4
		CMP R5,#4
		BNE Logic
		MOV R5, #0
		ADD R7,R7,R4
		CMP R7,#5
		BNE Logic
		BEQ STOP
		
		
LOGIC0 LDR R0,= 0x00000000  
       B FINAL
	   
	   
	   
LOGIC1 LDR R0,= 0x00000001
       B FINAL
	   
      ; Calculation of Exponent value
exp	
	   VMOV.F S7,S10
	   VMOV.F S9,S10 ;
	   LDR r8,= 0x00000001 ;
       
       VMOV.F S0,S10
	   LDR r1,= 0x00000030     ;r1 has number of terms in exp   
	   LDR r2,= 0x00000001     ; r2 is used in factorial
	   VLDR.F S4,= 1           ; S4 to store final result
       VLDR.F S5,= 1 	           ; S5 has Factorial result
	   
loop     
       VMOV.F S7,S9
       CMP r8,r2
	   BNE pow
loop2
       VMOV.F S0,S7
       VDIV.F S3,S0,S5
	   VADD.F S4,S4,S3
	   LDR r8,= 0x00000001 
	   ADD r2,#0x00000001
	   VMOV.F S2,r2
	   VCVT.F32.U32 S2,S2
	   VMUL.F S5,S5,S2         ; factorial is found here
	   CMP r2,r1
       BNE loop
       BX lr
	  

      ; loop gives X^n term
pow     
       VMUL.F S7,S7,S9  
	   ADD r8,#0x00000001
	   CMP r8,r2
	   BNE pow
	   BEQ loop2
	   
STOP B STOP ; stop program
     ENDFUNC
     END
