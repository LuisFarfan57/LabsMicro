.MODEL SMALL
.STACK
.DATA
    PedirCadena DB 10,13,'Ingrese la Cadena:  $'

    Palindroma DB 10,13,'La cadena es palidroma$'

    NoPalindroma DB 10,13,'La cadena no es palidroma$'

    NEW DB 10,13,'$'

    INST DB 20 DUP(0)

.CODE    
           
PROGRAMA:
    MOV AX,@DATA
    MOV DS,Ax
    LEA DX,PedirCadena
    MOV AH,09H
    INT 21H
    MOV BX,00

ARRIBA:

    MOV AH,01H
    INT 21H
    CMP AL,0DH
    JE ABAJO
    MOV [INST+BX],AL
    INC BX
    LOOP ARRIBA
ABAJO:

    MOV DI,0
    DEC BX
    JNZ CHECK
CHECK:

    MOV AL,[INST+BX]
    CMP AL,[INST+DI]
    JNE MostrarNoEs
    INC DI
    DEC BX
    JNZ CHECK
    LEA DX,NEW
    MOV AH,09H
    INT 21H
    LEA DX,Palindroma
    MOV AH,09H
    INT 21H
    JMP FINAL

MostrarNoEs:

    LEA DX,NoPalindroma
    MOV AH,09H
    INT 21H
FINAL:

    INT 3
    
END PROGRAMA