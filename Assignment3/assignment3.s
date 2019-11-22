     area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
__main  function	
		
		
		  VLDR.F32 S17,=1   ;3 inputs are in S17,S18,S19
          VLDR.F32 S18,=1
		  VLDR.F32 S19,=1
		  ;VLDR.F32 S20,=0	;S20 holds the z value which is later used to calculate sigmoid value.
		  VLDR.F32 S21,=1
	                      ; To implement switch case
	     
     	  MOV r10,#0    ; change r10 to select the logic operation
case      CMP r10,#6       
		  BGT.W stop        ; indicates no logic gate available
		  
		  
		  
		  CMP r10,#0
		  BEQ Gand
		  CMP r10,#1
		  BEQ Gor
		  CMP r10,#2
		  BEQ Gnot
		  CMP r10,#3
		  BEQ Gxor
		  CMP r10,#4
		  BEQ Gxnor
		  CMP r10,#5
		  BEQ Gnand
		  CMP r10,#6
		  BEQ Gnor
		  
     ;weights to the inputs are stored in S13,S14,S15, bias in S16, inputs are stored in S17,S18,S19 , z value in S20
     
Gand	VLDR.F32 S13,=-0.1
		VLDR.F32 S14,=0.2
		VLDR.F32 S15,=0.2
		VLDR.F32 S16,=-0.2
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case

Gor     VLDR.F32 S13,=-0.1
		VLDR.F32 S14,=0.7
		VLDR.F32 S15,=0.7
		VLDR.F32 S16,=-0.1
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg
		ADD r10,r10,#1
		B case

Gnot    VLDR.F32 S13,=0
		VLDR.F32 S14,=-0.6
		VLDR.F32 S15,=0
		VLDR.F32 S16,=0.1
		BL zvalue				;S0 conatin the z value=sigma(w*x)
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case

Gxor    VLDR.F32 S13,=-5
		VLDR.F32 S14,=20
		VLDR.F32 S15,=10
		VLDR.F32 S16,=1
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case

Gxnor   VLDR.F32 S13,=-5
		VLDR.F32 S14,=20
		VLDR.F32 S15,=10
		VLDR.F32 S16,=1
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case

Gnand   VLDR.F32 S13,=0.6
		VLDR.F32 S14,=-0.8
		VLDR.F32 S15,=-0.8
		VLDR.F32 S16,=0.3
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case
		
		
Gnor    VLDR.F32 S13,=0.5
		VLDR.F32 S14,=-0.7
		VLDR.F32 S15,=-0.7
		VLDR.F32 S16,=0.1
		BL zvalue
		BL sigmoid				;S9 contains the sigmoid value and prints in the round value
		BL printMsg

		ADD r10,r10,#1
		B case

		  
stop  B stop ; stop program



zvalue  VLDR.F32 S20,=0
		VFMA.F32 S20,S13,S17   ;s20=s20+s13*s17
		VFMA.F32 S20,S14,S18
		VFMA.F32 S20,S15,S19
		VFMA.F32 S20,S16,S21   ; bias is also added
		VMOV.F32 S0,S20
		BX lr


		 
		 ;sigmoid function  : i/p z is in S0 f(z)=1/(1+(e^-z)) is evaluated
sigmoid  
	      VLDR.F32 S3,=1 ;
		 ;VLDR.F32 S10,=6 ; max z value
		  

         VNEG.F32 S7,S0  ; negate the value x and call the exp
		  B exp		  ; observe S1 for the value of e-z
next	  VADD.F32 S8,S1,S3 ; 1+e-z is in S8
		  VDIV.F32 S9,S3,S8 ; S9 gives the sigmoid function value before rounding.Took these values of S9 for plotting sigmoid graph.
		  VCVTR.S32.F32 S9,S9 ; if sigmoid value>0.5 it rounds off to 1 else to 0.
		  VMOV r0,S9 
		  ;BL printMsg 		;print the value of sigmoid
		  BX lr

	
	                            ;Observe S1 for the exponent series value.
	
exp		MOV R0,#30              ; R0 holds number of terms              
		MOV  R1,#1				;counting variable
		VLDR.F32 S1,=1			;holds the sum of series
		VMOV.F32 S2,S7          ;value of -x is given from sigmoid
		VLDR.F32 S5,=1			;intermediate values are stored in S5

loop	
		CMP R1,R0
		BLT loop1
		B next

loop1  	
		VMUL.F32 S5,S5,S2
		VMOV.F32 S6,R1
        VCVT.F32.U32 S6, S6;		;Moving the R1 value to floating point register
		VDIV.F32 S5,S5,S6
		VADD.F32 S1,S1,S5
		ADD R1,R1,#1
		B loop
	   
     endfunc
     end
