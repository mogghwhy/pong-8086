STACK SEGMENT PARA STACK
    DB 64 DUP (' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'

    BALL_X DW 0Ah ; x position ( column ) of the ball
    BALL_Y DW 0Ah ; y position ( line ) of the ball

DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA,SS:STACK ;assume as code, data and stack segments
    PUSH DS                         ;push to the stack the ds segment
    SUB AX,AX                       ;clean ax register
    PUSH AX                         ;push ax to the stack
    MOV AX,DATA                     ;save on the ax register the contents of the data segment
    MOV DS,AX                       ;save on the ds segment the contents of ax
    POP AX                          ;release the top item from the stack to the ax register
    POP AX                          ;release the top item from the stack to the ax register
        
        MOV AH,00h ; set the configuration to video mode
        MOV AL,13h ; choose the video mode
        INT 10h    ; execute the configuration

        MOV AH,0Bh ; set the configuration
        MOV BH,00h ; to the background color
        MOV BL,00h ; set the bg color as black
        INT 10h

        CALL DRAW_BALL

        RET
    MAIN ENDP

    DRAW_BALL PROC NEAR

        MOV AH,0Ch ; set the function to write graphics pixel
        MOV AL,0Fh ; choose white color for the pixel
        MOV BH,00h ; set the page number
        MOV CX,BALL_X ; set the x position
        MOV DX,BALL_Y ; set the y position
        INT 10h    ; execute the configuration
        
        RET
    DRAW_BALL ENDP

CODE ENDS
END
