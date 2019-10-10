.MODEL  small
.STACK
.DATA
    num DB  ?
    residuo DB  ?
    espar   DB  'El numero es par$'
    noEsPar DB  'El numero no es par$'
.CODE
programa:

    MOV AX, @DATA
    MOV DS, AX
    
    ;Leer nuemro
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV num,AL
    SUB num,30h
    
    ;Comparar si es par
    XOR AX, AX
    MOV AL, num
    MOV CL, 2h
    DIV CL
    
    ;Residuo en ah    
    MOV residuo, AH
    
    ;Comparar
    CMP residuo,0
    JE  ImprimirEsPar
    MOV DX, offset  noEsPar
    MOV AH, 09h
    INT 21h
    JMP Finalizar
    
ImprimirEsPar:
    MOV DX, offset  espar
    MOV AH, 09h
    INT 21h        

Finalizar:
    MOV AH,4ch
    INT 21h    
END programa