datas	SEGMENT PARA 'veri'

n		DW ?
dizi	DW 100 DUP(0)
CR		EQU 13
LF		EQU 10
I       DW 0  
min     DW 3001 
sum     DW ? 
nctrl1  DW ?
nctrl2  DW ?  
k1      DW ?
k2      DW ?
k3      DW ?
msg1	DB CR, LF,'boyutu giriniz ', 0
msg2	DB CR, LF, 'Elemani giriniz ', 0
msg3a   DB CR, LF, 0   
msg3b   DB ', ', 0 
msg3c   DB '(', 0
msg3d   DB ')', 0     
msg4    DB CR, LF, 'Verilen dizide ucgen olusturabilecek eleman yok !', 0
HATA	DB CR, LF, 'YANLIS BUTON ', 0    
HATA2   DB CR, LF, 'Eleman 1000den buyuk ve 0dan kucuk olamaz ', 0
HATA3   DB CR, LF, 'Boyut minimum 3 maksimum 100 ola bilir ', 0
HATA4   DB CR, LF, 'Eleman minimum 1 ola bilir ', 0
while1  DW ?    

datas	ENDS

stacks	SEGMENT	PARA STACK 'yigin'
		DW 32 DUP (?)
stacks	ENDS	

codes	SEGMENT PARA  'code'
		ASSUME CS: codes, DS: datas, SS: stacks

		
main	PROC FAR
		PUSH DS
		XOR AX, AX
		PUSH AX
		MOV AX, datas
		MOV DS, AX 
		JMP noprob
ops1:   MOV AX, OFFSET HATA3         
		CALL PUT_STR 		
noprob:	MOV AX, OFFSET msg1        
		CALL PUT_STR               ;PUT_STR fonksiyonu ile ekrana "boyutu giriniz" yazdiriyor
		CALL GETN                  ;GETN fonksiyonu ile boyutu kullanicidan aliyoruz 
		CMP AX, 101
		JAE ops1
		CMP AX, 3
		JB ops1
		MOV n, AX                  ;Boyut AX'deydi, n'e atildi
		MOV CX, AX                 ;CX=n
		MOV DX, AX                 ;DX=n
		XOR SI, SI                 ;SI=0
LOOP1:	
		JMP noprob2
ops2:	MOV AX, OFFSET HATA2        
		CALL PUT_STR  
noprob2:MOV AX, OFFSET msg2        
		CALL PUT_STR               ;PUT_STR sayesinde ekrana "Elemani giriniz" yazdiriyor
		CALL GETN                  ;GETN ile AX register'ina degeri aliyoruz, GETN fonksiyonunda input AX'e alinir
		CMP AX, 1001
		JAE ops2 
		CMP AX, 1
		JB ops2
		MOV dizi[SI], AX           ;AX icindeki degeri dizi[SI]'ya atiyoruz
		ADD SI, 2                  ;dizi elemanlari DW boyutunda oldugu icin SI'yi 2 arttiriyoruz
		LOOP LOOP1                 ;LOOP'da da CX 1 azaliyor, dongu sayimiz n kadar 
		XOR SI, SI                 ;SI=0
		MOV DI,SI                  ;DI=0
		ADD DI, 2                  ;dizi elemanlari DW boyutunda oldugu icin DI'yi 2 arttiriyoruz, DI=2
		MOV CX,n                   ;CX=n
		DEC CX                     ;CX=n-1
FOR1:                   	       ;SELECTION SORT
		PUSH CX                    ;CX degerini memory'e pushluyoruz, memoryde suan n degeri var
		                           
		MOV CX,n                   ;CX=n
		SUB CX,I                   ;CX=n-I
		DEC CX                     ;CX=n-I-1
	FOR2:                          
		MOV BX, dizi[DI]           ;dizi[DI]=BX
		CMP dizi[SI], BX           
		JBE exc                    ;dizi[SI] ile BX'i(yani dizi[DI]'yi) kiyasliyor, eger dizi[SI] buyukse devam ediyor kucukse exc'e atliyor
		XCHG BX, dizi[SI]          ;dizi[SI] ile BX'in yerini degistiriyor
		MOV dizi[DI], BX           ;BX icindeki degeri dizi[DI]'ya atiyor
	exc:
		ADD DI, 2                  ;DI 2 artiyor (dizi DW oldugu icin)
		LOOP FOR2                  
		POP CX                     ;icdeki dongu bittikten sonra memorye PUSH'ladigimiz CX degerini (yani n'i) ordan cikariyoruz, suan CX=n
		ADD SI, 2                  ;SI 2 artiyor
		MOV DI, SI                 ;DI=SI
		ADD DI, 2                  ;DI'yi 2 daha arttiriyoruz (Selection sort geregi)
		INC I                      ;I 1 artiyor (Selection sort geregi)
		LOOP FOR1                  ;dongu bitiyor, elimizde kucukten buyuge dizilmis dizi var.
	    
	    
	   XOR SI, SI 
	   
	   CMP n, 3
	   JE  exception
	   MOV DX, n
	   MOV AX, n
	   ADD DX, AX  
	   SUB DX, 2
	   MOV nctrl2, DX    
	   SUB DX, 4
	   MOV nctrl1, DX  
	   CMP DX, 0
	   JE  whileson
	   
	   
	DISWHILE:
	   CMP SI, nctrl1
	   JNB whileson       
	   XOR DI, DI
	   MOV DI, SI
	   ADD DI, 2
	icwhile:
	   CMP DI, nctrl2
	   JNB whileicson    
	   MOV AX, dizi[SI]
	   ADD AX, dizi[DI]
	   CMP AX, dizi[DI+2]
	   JNA arttirDI  
	   ADD AX, dizi[DI+2]
	   CMP AX, min
	   JNB arttirDI
	   MOV min, AX
	   MOV DX, dizi[SI]
	   MOV k1, DX
       MOV DX, dizi[DI]
       MOV k2, DX
       MOV DX, dizi[DI+2]
	   MOV k3, DX
	    
	arttirDI:
       ADD DI, 2
       JMP icwhile     
	whileicson:
	   ADD SI, 2
	   JMP DISWHILE
	    
	whileson: 
	   JMP go_on
	
	exception:
	   XOR SI, SI
	   XOR DI, DI
	   ADD DI, 2
	   MOV AX, dizi[SI]
	   ADD AX, dizi[DI]
	   CMP AX, dizi[DI+2]
	   JBE bitir1
	   MOV AX, dizi[SI]
	   ADD AX, dizi[DI+2]
	   CMP AX, dizi[DI]
	   JBE bitir1
	   MOV AX, dizi[DI]
	   ADD AX, dizi[DI+2]
	   CMP AX, dizi[SI]
	   JBE bitir
	   MOV AX, OFFSET msg3a
	   CALL PUT_STR
	   MOV AX, OFFSET msg3c
	   CALL PUT_STR
       MOV AX, dizi[SI]
       CALL PUTN
       MOV AX, OFFSET msg3b  
       CALL PUT_STR
       MOV AX, dizi[DI]
       CALL PUTN
       MOV AX, OFFSET msg3b  
       CALL PUT_STR
       MOV AX, dizi[DI+2]
       CALL PUTN
       MOV AX, OFFSET msg3d
       CALL PUT_STR
	   JMP devam
	bitir1:
	    JMP bitir   
	go_on:
	   CMP k1, 0
	   JE bitir
	   CMP k1, 0    
	   MOV AX, OFFSET msg3a
	   CALL PUT_STR
	   MOV AX, OFFSET msg3c
	   CALL PUT_STR
       MOV AX, k1
       CALL PUTN
       MOV AX, OFFSET msg3b  
       CALL PUT_STR
       MOV AX, k2
       CALL PUTN    
       MOV AX, OFFSET msg3b  
       CALL PUT_STR
       MOV AX, k3
       CALL PUTN
       MOV AX, OFFSET msg3d
       CALL PUT_STR
       JMP devam 
    bitir:
       MOV AX, OFFSET msg4
       CALL PUT_STR  
    devam:               
                       
		RETF
main	ENDP 

GETC 	PROC NEAR
		MOV AH, 1h
		INT 21H
		RET
GETC    ENDP

PUTC	PROC NEAR
		PUSH AX
		PUSH DX
		MOV DL, AL
		MOV AH, 2
		INT 21H
		POP DX
		POP AX
		RET
PUTC	ENDP


GETN	PROC NEAR
		PUSH BX
		PUSH CX
		PUSH DX
	GETN_START:
		Mov DX, 1
		XOR BX, BX
		XOR CX, CX
	NEW:
		CALL GETC
		CMP AL, CR
		JE FIN_READ
		CMP AL, '-'
		JNE CTRL_NUM
	NEGATIVE:
		MOV DX, -1
		JMP NEW
	CTRL_NUM:
		CMP AL, '0'
		JB error
		CMP AL, '9'
		JA error
		SUB AL, '0'
		MOV BL, AL
		MOV AX, 10
		PUSH DX
		MUL CX
		POP DX
		MOV CX, AX
		ADD CX, BX
		JMP NEW
	ERROR:
		MOV AX, OFFSET HATA
		CALL PUT_STR 
		JMP GETN_START
	FIN_READ:
		MOV AX, CX
		CMP DX, 1
		JE FIN_GETN
		NEG AX
	FIN_GETN:
		POP BX
		POP CX
		POP DX
		RET
  GETN  ENDP
		
PUTN	PROC NEAR
		PUSH CX
		PUSH DX
		XOR DX, DX
		PUSH DX
		MOV CX, 10
		CMP AX, 0
		JGE CALC_DIGITS
		NEG AX
		PUSH AX
		MOV AL, '-'
		CALL PUTC
		POP AX
	CALC_DIGITS:
		DIV CX
		ADD DX, '0'
		PUSH DX
		XOR DX, DX
		CMP AX, 0
		JNE CALC_DIGITS
	DISP_LOOP:
		POP AX
		CMP AX, 0
		JE END_DISP_LOOP
		CALL PUTC
		JMP DISP_LOOP
	END_DISP_LOOP:
		POP DX
		POP CX
		RET
  PUTN 	ENDP
		
PUT_STR	PROC NEAR
		PUSH BX
		MOV BX,AX
		MOV AL, BYTE PTR [BX]
	PUT_LOOP:
		CMP AL, 0
		JE PUT_FIN
		CALL PUTC
		INC BX
		MOV AL, BYTE PTR [BX]
		JMP PUT_LOOP
	PUT_FIN:
		POP BX
		RET
PUT_STR	ENDP        


codes	ENDS
		END main
