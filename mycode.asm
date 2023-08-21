  
STSEG SEGMENT  
     BUFFER1  DB 3,?,3 DUP(0) 
     BUFFER2  DB 3,?,3 DUP(0)
STSEG ENDS 
;--------------------------------------
 DTSEG SEGMENT
 
  MASSAGE1 DB 'Welcome to the Grid Program':'$'
  MASSAGE2 DB CR,LF,'Please input the number of your horizontal lines? (0-99)':'$'                
 
  MASSAGE3 DB CR,LF,'Please Ýnput the number of your vertical lines? (0-99)':'$'
  
  MASSAGE4 DB CR,LF,'Thank you :)Please wait patiently while I draw your grid 8x8.':'$'
  MASSAGE5 DB CR,LF,'Now I am going to clean the screen and start drawing your Grid.':'$'
  MASSAGE6 DB CR,LF,'Please press any key to start the drawing operation!':'$'
  DTSEG ENDS    
  CR EQU 10D
  LF EQU 08
  ALINANr DW 0  
  ALINANc DW 0 
  w DW 0 
  h DW 0 
;----------------------------------------
 CDSEG SEGMENT
  MAIN PROC FAR
    MOV AX,DTSEG
    MOV DS,AX
    CALL clear
    
    MOV AH,09
    MOV DX,OFFSET MASSAGE1
    INT 21H  
    
     MOV AH,09
    MOV DX,OFFSET MASSAGE2
    INT 21H 
    
    MOV AH,0AH
    MOV DX,OFFSET BUFFER1
    INT 21H
    
    MOV AH,09
    MOV DX,OFFSET MASSAGE3
    INT 21H 
    
    MOV AH,0AH
    MOV DX,OFFSET BUFFER2
    INT 21H      
    
    MOV AH,09
    MOV DX,OFFSET MASSAGE4
    INT 21H 
    
    MOV AH,09
    MOV DX,OFFSET MASSAGE5
    INT 21H 
    MOV AH,09
    MOV DX,OFFSET MASSAGE6
    INT 21H   
    
    MOV AH, 0
    INT 16H
     
    CALL clear 
     
    MOV  AX,0012H      ;Set mode 12h,
    INT  10H           ;  clear screen  
   
   CALL roww   
    CALL columm
   CALL kacc
    CALL kacr    
     MOV CX,ALINANc 
     
    b1: push cx
     CALL    cizcolum 
     pop cx  
     sub ax,ax 
    
     loop b1
        
        
       
    MOV AH,4CH
    INT 21H
   MAIN ENDP    
;---------------------------------------
cizcolum PROC
   
     ; draw upper line:
  

    mov cx, 720 ; column  
   
    mov dx,h      ; row 
    
    mov al, 15      ; white
u1: mov ah, 0ch     ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    jae u1  
    
     RET
cizcolum ENDP
  
;---------------------------------------
kacc PROC
   SUB AX,AX
   MOV AX,720h
   MUL ALINANc 
   MOV h,AX
     RET
kacc ENDP
    
;---------------------------------------
kacr PROC
   SUB AX,AX
   MOV AX,400H
   MUL ALINANr 
   MOV w,AX
     RET
kacr ENDP
    
 
;---------------------------------------
roww PROC
    MOV BX, OFFSET BUFFER1  
    SUB CX,CX
    MOV CL,[BX]+1  
    MOV DI,CX 
    ;MOV BYTE PTR[BX+DI],20H  
   
    SUB DX,DX
    MOV DX,10D
AGAIN:   SUB AX,AX 
MOV AL,[BX]+2  
    AND AX,0F0FH
    CMP CX,1H
    JLE a
    MUL DL   
   
   a:  
    ADD ALINANr,AX
    INC BX
    LOOP AGAIN     
     RET
roww ENDP
    
;----------------------------    
columm PROC
    MOV BX, OFFSET BUFFER2 
    SUB CX,CX
    MOV CL,[BX]+1  
    MOV DI,CX 
    ;MOV BYTE PTR[BX+DI],20H  
   
    SUB DX,DX
    MOV DX,10D
AGAINn:   SUB AX,AX 
MOV AL,[BX]+2  
    AND AX,0F0FH
    CMP CX,1H
    JLE aa
    MUL DL   
   
   aa:  
    ADD ALINANc,AX
    INC BX
    LOOP AGAINn     
     RET
columm ENDP
    
;----------------------------
clear PROC
       MOV AX,0600H
       MOV BH,07
       MOV CX,0000
       MOV DX,184FH
       INT 10H
       RET
clear  ENDP 
CDSEG ENDS
        END MAIN

