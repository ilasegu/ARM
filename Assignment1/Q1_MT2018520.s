     AREA     fibonacci, CODE, READONLY
     EXPORT __main
    ; ENTRY 
__main  FUNCTION
		LDR  R1,=0x00000000		;R1,R2 values form the first two numbers of the fibonacci series
		LDR  R2,=0x00000001
loop	ADD  R3,R1,R2			;Observe R3 for the next numbers in the series.
		MOV  R1,R2
		MOV  R2,R3
		B loop

stop    B stop ; stop program
     ENDFUNC
     END 