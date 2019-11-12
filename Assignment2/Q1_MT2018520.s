     AREA     exp, CODE, READONLY
     EXPORT __main
    ; ENTRY 
	; the following c code depicts the behaviour
    ;while(i<n)
    ;{
    ;   t=t*x;
    ;    t/=i;
    ;    sum+=t;
    ;    i++;
    ;    
    ; }

    ;Here R0 holds n value, R denotes i,S1 holds sum, S5 holds t value.
	;Observe S1 for the sum
__main  FUNCTION
		
		MOV R0,30; R0 holds number of terms              
		MOV  R1,#1				;counting variable
		VLDR.F32 S1,=1			;holds the sum of series
		VLDR.F32 S2,=12 ;value of x
		VLDR.F32 S5,=1			;intermediate values are stored in S5

loop	
		CMP R1,R0
		BLT loop1
		B stop

loop1  	
		VMUL.F32 S5,S5,S2
		VMOV.F32 S6,R1
        VCVT.F32.U32 S6, S6;		;Moving the R1 value to floating point register
		VDIV.F32 S5,S5,S6
		VADD.F32 S1,S1,S5
		ADD R1,R1,#1
		B loop

stop    B stop ; stop program
     ENDFUNC
     END 