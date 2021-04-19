;
; Multi digit addition (not perfect yet...)
;


ASSUME CS:CODES, DS:DATAS


DATAS SEGMENT

    inputHintStr1 DB "input a number (up to 9 digits) : ", '$'
    inputHintStr2 DB "input another number (up to 9 digits): ", '$'
    outputStr DB "sum: ", '$'

    XArray DB 10 DUP(0)     ; XArray and YArray stands the input numbers
    YArray DB 10 DUP(0)     ; `3 DUP(0)` == `0, 0, 0` / DUP means duplicate.
    ZArray DB 10 DUP(0)     ; ZArray stands the sum result, Up to 3 characters.

DATAS ENDS


CODES SEGMENT

    START:

        MOV AX, DATAS
        MOV DS, AX

        LEA DX, inputHintStr1   ; Print inputHintStr1
        MOV AH, 09H
        INT 21H

        MOV BX, 0AH             ; The offset base on XArray / descending order

    input_x_loop:

        MOV AH, 01H             ; INT 21h / AH=1 - read character
        INT 21H

        CMP  AL, 0DH            ; If Enter key press, break.
        JE input_x_end

        SUB AL, '0'
        SUB BX, 01H             ; Decrement offset
        MOV [XArray + BX], AL   ; Store the input number into XArray with offset

        CMP BX, 00H             ; Digit length limit
        JNE input_x_loop        ; Loop

    input_x_end:

        LEA DX, inputHintStr2   ; Print inputHintStr2
        MOV AH, 09H
        INT 21H

        MOV BX, 0AH             ; The offset base on YArray / descending order

    input_y_loop:               ; same as above

        MOV AH, 01H
        INT 21H

        CMP AL, 0DH
        JE input_y_end

        SUB AL, '0'
        SUB BX, 01H
        MOV [YArray + BX], AL

        CMP BX, 00H
        JNE input_y_loop

    input_y_end:

        MOV BX, 0AH             ; offset of X, Y and Z. / descending order

    add_x_y_loop:

        SUB BX, 01H
        MOV AL, [XArray + BX]
        ADD AL, [YArray + BX]

        CMP AL, 0AH
        JB no_carry

        MOV [ZArray + BX - 01H], 01H
        SUB AL, 0AH             ; x + y >= 10, carrying.

    no_carry:

        MOV [ZArray + BX], AL

        CMP BX, 00H
        JNE add_x_y_loop

    add_x_y_end:

        LEA DX, outputStr       ; Print outputStr
        MOV AH, 09H
        INT 21H

        MOV BX, 00H

    print_z_loop:

        MOV AL, [ZArray + BX]
        ADD BX, 01H

        CMP AL, 00H             ; If current offset on ZArray is 0
        JE print_z_loop

        MOV DL, AL
        ADD DL, '0'
        MOV AH, 02H
        INT 21H

        CMP BX, 0AH
        JNE print_z_loop

        MOV AH, 4CH
        INT 21H

CODES ENDS

    END START
