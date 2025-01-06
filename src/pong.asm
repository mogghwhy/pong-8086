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

        MOV AH,0Bh ; set the configuration
        MOV BH,00h ; to the background color
        MOV BL,00h ; set the bg color as black
        INT 10h

        RET
    MAIN ENDP

CODE ENDS
END
