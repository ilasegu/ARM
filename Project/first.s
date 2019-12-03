	 AREA    hammingcode, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
	 IMPORT printMsg3p
	 IMPORT printMsg4p
 	
	;Generation of (31,26) HammingCode using even-parity
	;R1--->	26-bit message word(INPUT)
	;R0--->	31-bit codeword
	;R1--->	26-bit decoded received message(OUTPUT)
	
__main  FUNCTION
	
	
	;Align databits in the codeword.
	
	LDR R1,=0x288AFA7 		;26-bit(d26-d1)test msg in R1
	;LDR R1,=0x288BF3C	;26-bit(d26-d1)test msg in R1

	MOV R0,#0			;31-bit codeword in R0
	LDR R8,=31
	
	
	AND R2,R1,#0x1		;mask all bits of R1 except d1
	MOV R0,R2,LSL #2	;align d1 in codeword
	
	AND R2,R1,#0xE		;mask all bits of R1 except d2-d4
	ORR R0,R0,R2,LSL #3	;align d2-d4 in codeword

    LDR R3,=0x7F0
	AND R2,R1,R3	    ;mask all bits of R1 except d5-d11
	ORR R0,R0,R2,LSL #4 ;align d5-d11 in codeword
	
	LDR R3,=0x3FFF800
	AND R2,R1,R3		;mask all bits of R1 except d12-d26
	ORR R0,R0,R2,LSL #5 ;align d12-d26 in codeword
	
	
	;Generation of parity bits p1-p5
	
;The following bits of R0 are considered for parity	bits generation
;P1-->1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31
;P2-->2,3,6,7,10,11,14,15,18,19,22,23,26,27,30,31
;P3-->4,5,6,7,12,13,14,15,20,21,22,23,28,29,30,31
;P4-->8,9,10,11,12,13,14,15,24,25,26,27,28,29,30,31
;P5-->16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31

P1  LDR R3,=0x1			;R3 contains initial shift value=1
	LDR R4,=0x0			;R4 is for the internal count(i=0)
	LDR R5,=0x1			;R5 has the count=1
	LDR R7,=0x0
	BL parity_gen
	SUB R5,R5,#1			;count=count-1
	LSL R12,R12,R5
	ORR R0,R0,R12

P2  LDR R3,=0x2			;R3 contains initial shift value=2----R3=Rin
	LDR R4,=0x0			;R4 is for the internal count(i=0)----R4=i
	LDR R5,=0x2			;R5 has the count=2-------------------R5=count
	LDR R7,=0x0
	BL parity_gen
	SUB R5,R5,#1			;count=count-1
	LSL R12,R12,R5
	ORR R0,R0,R12
	
P3  LDR R3,=0x4			;R3 contains initial shift value=4
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x4 		;R5 has the count=4
	LDR R7,=0x0
	BL parity_gen
	SUB R5,R5,#1			;count=count-1
	LSL R12,R12,R5
	ORR R0,R0,R12
	
P4  LDR R3,=0x8			;R3 contains initial shift value=8
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x8 		;R5 has the count=8
	LDR R7,=0x0
	BL parity_gen
	SUB R5,R5,#1			;count=count-1
	LSL R12,R12,R5
	ORR R0,R0,R12
	
P5  LDR R3,=0x10		;R3 contains initial shift value=16
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x10 		;R5 has the count=16
	LDR R7,=0x0
	BL parity_gen
	SUB R5,R5,#1			;count=count-1
	LSL R12,R12,R5
	ORR R0,R0,R12
	
	;Introduce an single bit error in the codeword R0

	EOR R0,R0,#4		;Introduce d1 single-bit error
	
	
	;Error detection  using Errorcheck parity bits E5-E1
	
E1  LDR R3,=0x1			;R3 contains initial shift value=1
	LDR R4,=0x0			;R4 is for the internal count(i=0)
	LDR R5,=0x1			;R5 has the count=1
	LDR R7,=0x0
	BL parity_gen
	MOV R3,R12			;Move E1 into R3 register
	PUSH {R3}

E2  LDR R3,=0x2			;R3 contains initial shift value=2----R3=Rin
	LDR R4,=0x0			;R4 is for the internal count(i=0)----R4=i
	LDR R5,=0x2			;R5 has the count=2-------------------R5=count
    LDR R7,=0x0
    BL parity_gen
	MOV R4,R12			;Move E2 into R4 register
	PUSH {R4}
	
E3  LDR R3,=0x4			;R3 contains initial shift value=4
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x4 		;R5 has the count=4
	LDR R7,=0x0
	BL parity_gen
	MOV R5,R12			;Move E3 into R5 register
	PUSH {R5}
	
E4  LDR R3,=0x8			;R3 contains initial shift value=8
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x8 		;R5 has the count=8
	LDR R7,=0x0
	BL parity_gen
	MOV R6,R12			;Move E4 into R6 register
	
E5  LDR R3,=0x10		;R3 contains initial shift value=16
	LDR R4,=0x0	 		;R4 is for the internal count(i=0)
	LDR R5,=0x10 		;R5 has the count=16
	LDR R7,=0x0
	BL parity_gen
	MOV R7,R12			;Move E5 into R7 register
	
	
	;Finding the position of error bit in the codeword using E5-E1 error bits i.e. finding the decimal equivalent of E5E4E3E2E1 value.
	
	MOV R9,#1
	MOV R10,#2
	POP {R5}
	POP {R4}
	POP {R3}
	MUL R11,R3,R9		;R11 temporary register
	MLA R11,R10,R4,R11	;E1+E2*2
	MUL R9,R10,R10		;R9=4
	MLA R11,R9,R5,R11	;E1+E2*2+E3*4
	MUL R9,R10,R9 		;R9=8
	MLA R11,R9,R6,R11	;E1+E2*2+E3*4+E4*16
	MUL R9,R9,R10		;R9=16
	MLA R11,R9,R7,R11	;E1+E2*2+E3*4+E4*16+E5*32=R11
	
	;R11 has the position of single bit error in received hamming code.
	
	CMP R11,#0
	BGT correction
	
correction 	MOV R9,#1
			SUB R11,R11,#1
			LSL R9,R9,R11
			EOR R0,R0,R9  ;R0 contains the corrected hamming codeword
			
	;Decoding of the message R1 from the codeword R0
	
	LDR R2,=0x7FFF0000
	AND R3,R0,R2		;R3 masks the bits d26-d12
	LSR R3,R3,#5		;R3 positions the bits d26-d12
	LDR R2,=0x00007F00
	AND R4,R0,R2		;R4 masks the bits d11-d5
	LSR R4,R4,#4		;R4 positions the bits d11-d5
	LDR R2,=0x00000070
	AND R5,R0,R2		;R5 masks the bits d4-d2
	LSR R5,R5,#3		;R5 positions the bits d4-d2
	LDR R2,=0x00000004
	AND R6,R0,R2		;R6 masks the bits d1
	LSR R6,R6,#2		;R6 positions the bits d1
	
	ORR R1,R3,R4
	ORR R1,R1,R5
	ORR R1,R1,R6		;R1 contains the decoded received message.

stop B stop

parity_gen  LSRS R6,R0,R3
			B carry_check
next		ADD R4,R4,#1
			ADD R3,R3,#1
			CMP R4,R5
			IT LT
			BLT parity_gen
			ADD R3,R3,R5
			MOV R4,#0
			CMP R3,R8 
			BLE parity_gen
			BGT count_ones
			
count_ones  MOV  R9,R7				;Load R1 with given value
			MOV  R10,#2
			;MOV  R0,#0				;Observe R0 to find if R1 is odd or even.
			udiv R11,R9,R10			;Quotient 
			mls  R11,R11,R10,R9		;Performs R9-(R11*R10) and is loaded into R11, gives the remainder of division
			CMP  R11,#0
			ITE	 NE
			MOVNE R12,#1    		;parity=1
			MOVEQ R12,#0			;parity=0	
			BX lr


carry_check IT CS
			ADDCS R7,R7,#1 	;R7 counts the number of 1's
			B next
     ENDFUNC
     END 