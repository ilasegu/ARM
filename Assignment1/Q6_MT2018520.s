     AREA     gcd, CODE, READONLY
     EXPORT __main
    ; ENTRY 
__main  FUNCTION
		MOV  R1,#3
		MOV  R2,#5
;If R1>R2 observe R1 for the gcd of R1,R2 
;else     observe R2 .

loop	CMP  R1,R2
		IT EQ
		BEQ  stop
		ITE GT
		SUBGT R1,R1,R2
		SUBLE R2,R2,R1
		B loop

stop    B stop ; stop program
     ENDFUNC
     END 