     AREA     nestedITE, CODE, READONLY
     EXPORT __main
    ; ENTRY 
	;my sample algorithm
	; if(a>b)
	;     g=1;
	; else { if(a>0)
	;        p=1;
	;	     else p=0;
	;      };
	
	
__main  FUNCTION
		MOV R0,#2       ;value of a
		MOV R1,#1		;value of b
		CMP R0,R1
		ITTE GT
		MOVGT R2,#1     ;R2=g in the above algorithm
		BGT stop
		BLE loop

loop	CMP R0,#0
		ITE GT
		MOVGT R4,#1
		MOVLE R4,#0		;R4=p in the above algorithm
		

stop    B stop ; stop program
     ENDFUNC
     END 
		 
		 ;In IT instruction, we can have maximum of four instructions following it,(i.e) ITTTT,ITTEE. So,I have used a branch for else part.We can use 
		 ;branch in IT only in the last instruction.
		 ;However,the following error occur.
		 ;ERROR : first.s(19): error: A1603E: This instruction inside IT block has UNPREDICTABLE results
		 ;So,we cann't use Nested-if-then-else.

