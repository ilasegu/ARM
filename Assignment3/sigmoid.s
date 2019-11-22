     area     appcode, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
__main  function	
	;sigmoid function  : i/p z is varied is varied from -5 to 5 and f(z)=1/(1+(e^-z)) is evaluated
          VLDR.F32 S0,=2 ; to find sigmoid value of S0. 
	      VLDR.F32 S3,=1 ;
		 ; VLDR.F32 S10,=6 ; max z value
		  MOV r11,#-10;
		  

cal       VNEG.F32 S7,S0  ; negate the value x and call the exp
		  BL exp		  ; observe S1 for the value of e-z
		  VADD.F32 S8,S1,S3 ; 1+e-z is in S8
		  VDIV.F32 S9,S3,S8 ; S9 gives the sigmoid function value before rounding.Took these values of S9 for plotting sigmoid graph.
		  VCVTR.S32.F32 S9,S9 ; if sigmoid value>0.5 it rounds off to 1 else to 0.
		  VMOV r0,S9 
		  BL printMsg 		;print the value of sigmoid
		  
stop  B stop ; stop program
 
 ;for calculation of exp(x) call exp subroutine
	 ;while(i<n)
    ;{
    ;   t=t*x;
    ;    t/=i;
    ;    sum+=t;
    ;    i++;
    ;    
    ; }
	;Here R0 holds n value, R1 denotes i,S1 holds sum, S5 holds t value.
	;Observe S1 for the sum
	
exp		MOV R0,#30; R0 holds number of terms              
		MOV  R1,#1				;counting variable
		VLDR.F32 S1,=1			;holds the sum of series
		VMOV.F32 S2,S7        ;value of -x is given from sigmoid
		VLDR.F32 S5,=1			;intermediate values are stored in S5

loop	
		CMP R1,R0
		BLT loop1
		BX lr

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