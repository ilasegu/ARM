     AREA     largest, CODE, READONLY
     EXPORT __main
    ; ENTRY 
__main  FUNCTION
	
		MOV  R1,#04
		MOV  R2,#06
		MOV  R3,#05
		CMP  R1,R2			;compare R1 and R2
		IT GT
		MOVGT R2,R1			;Move the largest of R1,R2 to R2
		CMP R2,R3
		IT GT				;Now compare R2 and R3
		MOVGT R3,R2			;Move the largest of R2,R3 to R3
		MOV R0,R3			;R0 contains the largest of R1,R2,R3
stop    B stop ; stop program
     ENDFUNC
     END 