.MODEL small
.STACK 
.DATA        
    
    CadenaNum1 db 'Ingrese el numero 1$'
    CadenaNum2 db 'Ingrese el numero 2$'
    Mayor1 db 'El numero 1 es mayor$'
    Mayor2 db 'El numero 2 es mayor$'
    Igual db 'Los numeros son iguales$'
    
.CODE
programa:
    ; Inicializar el registro de datos
    MOV AX, @DATA
    MOV DS, AX
    
    ;Pedir numero 1:    
    MOV DX, OFFSET  CadenaNum1
    MOV AH, 09h
    INT 21h   
    CALL SALTO
    
    ;Leer num1
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    SUB BL, 30h
    CALL SALTO
    
    ;Pedir numero 2:    
    MOV DX, OFFSET  CadenaNum2
    MOV AH, 09h
    INT 21h
    CALL SALTO
    
    ;Leer num2
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BH, AL
    SUB BH, 30h
    CALL SALTO
    
    ;Salto de linea
SALTO:    
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ret
    
FIN:
    ;Fin de programa
    MOV AH,4CH
    INT 21h
END programa