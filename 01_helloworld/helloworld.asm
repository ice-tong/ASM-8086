;
; Print Hello World!
;


ASSUME CS:CODES, DS:DATAS


DATAS SEGMENT
    helloWord DB "hello world!", 10, '$'    ; 10: ascii of \n
DATAS ENDS


CODES SEGMENT

START:

    MOV AX, DATAS   ; The symbols used below are an offset base on DS.
    MOV DS, AX      ; Set the data segment address to DS indirectly by AX.

    LEA DX, helloWord   ; Move string pointer to DX.
    MOV AH, 09H         ; INT 21h / AH=9 - DOS PRINT STRING
    INT 21H             ; Output of a string at DS:DX. String must be terminated by '$'.

    MOV AH, 4CH         ; INT 21h / AH=4Ch - DOS EXIT CODE
    INT 21H             ; Return control to the operating system (stop program).

CODES ENDS

    END START
