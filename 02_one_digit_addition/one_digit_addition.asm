;
; One digit addition
;


ASSUME CS:CODES, DS:DATAS


DATAS SEGMENT
    inputHintStr1 DB "input a number (one digit only) : ", '$'
    inputHintStr2 DB "input another number (one digit only): ", '$'
    outputStr DB "sum: ", '$'
    X DB ?          ; A question mark indicates not to initialize memory.
    Y DB ?          ; X and Y for storing input number, one digit only.
    Z DB ?          ; Z for storing the sum result, one digit only.
DATAS ENDS


CODES SEGMENT

START:

    MOV AX, DATAS
    MOV DS, AX

    LEA DX, inputHintStr1   ; Print inputHintStr1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; INT 21h / AH=1
    INT 21H             ; Read character from standard input, with echo, result is stored in AL.
    SUB AL, '0'         ; Subtracts the ascii value of '0'
    MOV X, AL           ; Store input number to X
    MOV AH, 01H
    INT 21H             ; Wait for Enter key

    LEA DX, inputHintStr2   ; Print inputHintStr2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; Input Y, same as above.
    INT 21H
    SUB AL, '0'
    MOV Y, AL
    MOV AH, 01H
    INT 21H
    
    MOV AL, X           ; Add X and Y
    ADD AL, Y
    MOV Z, AL

    LEA DX, outputStr   ; Print outputStr
    MOV AH, 09H
    INT 21H

    MOV DL, Z           ; Print character of Z
    ADD DL, '0'         ; Add the ascii value of '0'
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH         ; INT 21h / AH=4CH - EXIT
    INT 21H

CODES ENDS

    END START
