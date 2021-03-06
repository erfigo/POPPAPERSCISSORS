.model SMALL
        
.stack 0E000H

.data



    ;clock dw es:[6Ch] 
    tone dw ? 
  
          
    CR      db 13,10,'$'
    RANDOMNUM db 1  
    OPEN    db 13,10,13,10, 'Hello and Welcome to Pop, Paper, and Scissors!', 13,10, 'Your Starting Point is 3. If it reaches 0, game will be terminated!', 13,10, 'Enjoy the Game!!!', 13,10,'$',0
    SELECT  db 13,10, 'Choose any number to continue, choose 0 to end the game.',13,10, 'Choose here: $',0
    MSG     db 13,10,13,10, 'GAME Instruction: Rock=1, Paper= 2, Scissors= 3, $', 0
    PL1     db 13,10, 'Player 1: $', 0
    PL2     db 13,10, 'Computer: $', 0
    PL1_Win db 13,10,13,10, 'Player 1 is the winner!',13,10,13,10, '$', 0
    PL2_Win db 13,10,13,10, 'Computer is the winner!',13,10,13,10, '$', 0
    PLEQ    db 13,10,13,10, 'TIE GAME',13,10, '$', 0 
    soal1   db 13,10,13,10, 'What is the title of this song?,$',0 
    choices db 13,10,'1. Sempurna',13,10, '2. Laskar Pelangi',13,10, '3. Ibu Kita Kartini',13,10, '4. Married Life',13,10,'$', 0
    SELECTS db 13,10, 'Choose here: $',0
    WRONG   db 13,10, 'Sorry! Wrong Answer!',13,10,13,10,'$',0
    SCORE   db 13,10, 'Your Score: $', 0
    DONE    db 13,10, 'Game Terminated! $', 0   
    
.code 

 
    
  
  
.startup

MOV SI, 3

BEGIN:  
        MOV AX, @data
        MOV DS, AX
        MOV ES, AX  
       
        MOV DX, OFFSET OPEN      ; Game Instruction
        MOV AH, 09h
        INT 21h 
        
        MOV DX, OFFSET SELECT      ; Game Instruction
        MOV AH, 09h
        INT 21h      
        MOV AH,08
        INT 21H
        MOV AH, 02
        MOV BL,AL
        MOV DL,AL
        INT 21H   
        CMP BL, '0'
        JE  ENDING
        MOV DX, OFFSET MSG      ; Game Instruction
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET CR       ; print Carrier Return
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET PL1      ; Prompt of player1
        MOV AH, 09h
        INT 21h
        
        MOV AH,08               ; Function to read a char from keyboard (Input by Player1)
        INT 21h                 ; the char saved in AL
        MOV AH,02               ; Function to display a char  
        MOV BL,AL               ; Copy a saved char in AL to BL 
        MOV DL,AL               ; Copy AL to DL to output it
        INT 21h
        
        MOV DX, OFFSET CR       ; print Carrier Return
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET PL2
        MOV AH, 09h
        INT 21h 
        
        call randgenerator 
         
          MOV CX, 3
         DIV CX
         mov randomnum,dl
        mov ah, 02h
        mov dl, randomnum
        add dl,'1'
        int 21h 
        
        MOV BH, AL
            ; Prompt of player2
       
                 ; the char saved in AL
        

        
        CMP BL, BH
        JE  EQUAL    
        
;=======================================        
        CMP BL, '1'
        JE  EQ1   
        CMP BL, '2'
        JE  EQ2
        CMP BL, '3'
        JE  EQ3
        JNE incorrect
        
    EQ1:
        CMP BH, '2'
        JE  P2_Win   
        CMP BH, '3'
        JE  P1_Win   

    EQ2:  
        CMP BH, '1'
        JE  P1_Win   
        CMP BH, '3'
        JE  P2_Win 
 
    EQ3:  
        CMP BH, '1'
        JE  P2_Win   
        CMP BH, '2'
        JE  P1_Win 

;=======================================
   
    P1_Win:                     ;Player 1 is winner 
        ADD SI, 1
        MOV CX, SI
        ADD CL, 48
        
        MOV DX, OFFSET PL1_Win     
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET SCORE
        MOV AH, 09H
        INT 21H
        
        MOV AH,02
        MOV BL, CL
        MOV DL, CL
        INT 21H
        

        JMP Final
      
    EQUAL:                      ;Player 1 == Player 2
        ADD SI, 0
        MOV CX, SI
        ADD CL, 48
    
        MOV DX, OFFSET PLEQ   
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET SCORE
        MOV AH, 09H
        INT 21H
               
        MOV AH,02
        MOV BL, CL
        MOV DL, CL
        INT 21H
        
        JMP Final
        
    P2_Win:                     ;Player 2 is winner
        SUB SI, 1
        MOV CX, SI
        ADD CL, 48
        
        MOV DX, OFFSET PL2_Win     
        MOV AH, 09h
        INT 21h
        
        MOV DX, OFFSET SCORE
        MOV AH, 09H
        INT 21H
        
        MOV AH,02
        MOV BL, CL
        MOV DL, CL
        INT 21H
        
        CMP CL, 30h
        JE ENDING
         
        ;call soala
        
        JMP LOOSE
        ;JMP Final;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    
    randgenerator proc
        call delay1
            MOV AH, 0
            INT 1AH
         
          MOV AX,DX 
           MOV DX,1
          
         MOV CX, 3
         DIV CX
         mov randomnum,dl
                ret
    randgenerator endp    
    
    randgen2 proc
        call delay1
            MOV AH, 0
            INT 1AH
         
          MOV AX,DX 
           MOV DX,1
          
         MOV CX, 4
         DIV CX
         mov randomnum,dl
               ret
    randgen2 endp  
    

    delay1 proc
        mov cx,1
        startdelay:
        cmp cx,10
        
        JE endDelay 
        inc cx
        jmp startdelay
        
        enddelay:
        ret
        delay1 endp
    
;==================================================================================================
                    
LOOSE:
        call randgen2
      
        mov ah, 02h
        mov dl, randomnum
        add dl,'1'
        ;int 21h
        
        CMP DL, '1'
        JE GOTOA 
        CMP DL, '2'
        JE GOTOB
        CMP DL, '3'
        JE GOTOC
        CMP DL, '4'
        JE GOTOD
        
incorrect:
        MOV DX, OFFSET WRONG
        MOV AH, 09h
        INT 21h
        
        SUB SI, 1
        MOV CX, SI
        ADD CL, 48
        
        MOV DX, OFFSET SCORE
        MOV AH, 09H
        INT 21H
        
        MOV AH,02
        MOV BL, CL
        MOV DL, CL
        INT 21H
        
        CMP CL, 30h
        JE ENDING
        
        JMP BEGIN
       
     
        

;====================================================================================================
GOTOA:                    
                    
SOALA PROC
    
call rec1
    
    
    MOV DX, OFFSET soal1
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET choices
    MOV AH, 09H
    INT 21H
        MOV DX, OFFSET SELECTS     
        MOV AH, 09h
        INT 21h      
        MOV AH,08
        INT 21H
        MOV AH, 02
        MOV BL,AL
        MOV DL,AL
        INT 21H
        
        CMP BL, '1'
        JE P1_Win
        JNE incorrect
        

SOALA ENDP 


GOTOB:

SOALB PROC
    
call rec1
        
      MOV DX, OFFSET soal1
      MOV AH, 09H
      INT 21H
      MOV DX, OFFSET choices
      MOV AH, 09H
      INT 21H
      
        MOV DX, OFFSET SELECTS     
        MOV AH, 09h
        INT 21h      
        MOV AH,08
        INT 21H
        MOV AH, 02
        MOV BL,AL
        MOV DL,AL
        INT 21H
        
        
        
        CMP BL, '2'
        JE P1_Win
        JNE incorrect
       
          
SOALB ENDP


GOTOC:
SOALC PROC
    
    call rec1
      MOV DX, OFFSET soal1
      MOV AH, 09H
      INT 21H
      MOV DX, OFFSET choices
      MOV AH, 09H
      INT 21H
      
        MOV DX, OFFSET SELECTS     
        MOV AH, 09h
        INT 21h      
        MOV AH,08
        INT 21H
        MOV AH, 02
        MOV BL,AL
        MOV DL,AL
        INT 21H
        
        CMP BL, '3'
        JE P1_Win
        JNE incorrect    

SOALC ENDP
  
  

GOTOD:
SOALD PROC
  
 call rec1
  
    
      MOV DX, OFFSET soal1
      MOV AH, 09H
      INT 21H
      MOV DX, OFFSET choices
      MOV AH, 09H
      INT 21H
      
        MOV DX, OFFSET SELECTS     
        MOV AH, 09h
        INT 21h      
        MOV AH,08
        INT 21H
        MOV AH, 02
        MOV BL,AL
        MOV DL,AL
        INT 21H
        
        
        CMP BL, '4'
        JE P1_Win
        JNE incorrect

   

SOALD ENDP

      
;=======================================

proc rec1
mov al,182
out 43h,al
mov ax,4560 

out 42h,al
mov al,ah
out 42h,al
in al,61h

or al,00000011b
out 61h,al
mov bx,25

     .pause1:
       mov cx, 250
       
       .pause2:
       dec cx 
       cmp cl ,'0'
jne .pause2
dec bx


in al, 61h

and al,11111100b
out 61h,al

    ret
rec1 endp
Final:   
    LOOP BEGIN 
    
 ENDING:
 
 MOV DX, OFFSET DONE
 MOV AH, 09H
 INT 21H
 
 MOV AH,4Ch 
 MOV AL,00
 INT 21H

.exit

end





