STACK SEGMENT PARA STACK
    DB 64 DUP (' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'
DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
        
        MOV AH,00h ; set the configuration to video mode
        MOV AL,13h ; choose the video mode
        INT 10h    ; execute the configuration

        RET
    MAIN ENDP

CODE ENDS
END
