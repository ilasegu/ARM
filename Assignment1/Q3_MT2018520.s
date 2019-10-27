     AREA     oddoreven, CODE, READONLY
     EXPORT __main
    ; ENTRY 
__main  FUNCTION
		MOV  R1,#25				;Load R1 with given value
		MOV  R2,#2
		MOV  R0,#0				;Observe R0 to find if R1 is odd or even.
		udiv R3,R1,R2			;Quotient of R1/R2 is stored in R3
		mls  R3,R3,R2,R1		;Performs R1-(R3*R2) and is loaded into R3, gives the remainder of division
		CMP  R3,#0
		IT	 GT
		MOVGT R0,R3     		;IF R0=1,then R1 is odd else even 
		
stop    B stop ; stop program
     ENDFUNC
     END 