STACK SEGMENT PARA STACK
    DB 64 DUP (' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'

    TIME_AUX DB 0 ;variable used when checking if the time has changed

    BALL_X DW 0Ah ; x position ( column ) of the ball
    BALL_Y DW 0Ah ; y position ( line ) of the ball
    BALL_SIZE DW 04h ; ball width and height 
    BALL_VELOCITY_X DW 05h ; x horizontal velocity of the ball
    BALL_VELOCITY_Y DW 02h ; y vertical velocity of the ball

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
        

        CALL CLEAR_SCREEN

        CHECK_TIME:

            MOV AH,2Ch ; get the system time
            INT 21h    ; trigger the interrupt; CH = hour, CL = minute, DH = second, DL = 1/100 seconds

            CMP DL,TIME_AUX  ; is the current time equal to the previous one(TIME_AUX)
            JE CHECK_TIME    ; if it is the same, check again
                             ; if it is different then draw, move, etc

            MOV TIME_AUX,DL  ; update time

            CALL CLEAR_SCREEN

            CALL MOVE_BALL

            CALL DRAW_BALL

            JMP CHECK_TIME    ; after everything check the time again

        RET
    MAIN ENDP

    MOVE_BALL PROC NEAR

            MOV AX,BALL_VELOCITY_X
            ADD BALL_X,AX
            MOV AX,BALL_VELOCITY_Y
            ADD BALL_Y,AX
        RET

    MOVE_BALL ENDP

    DRAW_BALL PROC NEAR

        MOV CX,BALL_X ; set the initial column x
        MOV DX,BALL_Y ; set the initial line y

        DRAW_BALL_HORIZONTAL:
        
            MOV AH,0Ch ; set the function to write graphics pixel
            MOV AL,0Fh ; choose white color for the pixel
            MOV BH,00h ; set the page number
            INT 10h    ; execute the configuration

            INC CX     ; increment CX by 1, CX = CX + 1
            MOV AX,CX  ; CX - BALL_X > BALL_SIZE ( Y -> We go to the next line, N -> We go to the next column )
            SUB AX,BALL_X
            CMP AX,BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL

            MOV CX,BALL_X ; the CX register goes back to the initial column
            INC DX        ; we advance one line

            MOV AX,DX              ; DX - BALL_Y > BALL_SIZE ( Y ->  we exit this procedure, N -> we continue to the next line )
            SUB AX,BALL_Y
            CMP AX,BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL

        RET

    DRAW_BALL ENDP

    CLEAR_SCREEN PROC NEAR

        MOV AH,00h ; set the configuration to video mode
        MOV AL,13h ; choose the video mode
        INT 10h    ; execute the configuration

        MOV AH,0Bh ; set the configuration
        MOV BH,00h ; to the background color
        MOV BL,00h ; set the bg color as black
        INT 10h

        RET

    CLEAR_SCREEN ENDP

CODE ENDS
END
