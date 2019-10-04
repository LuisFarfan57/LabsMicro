.MODEL small
.STACK 
.DATA        
    cociente db ?
    residuo db ?
    MostrarSuma db 'Suma:$'
    MostrarResta db 'Resta:$'
    MostrarMul db 'Multiplicacion:$'
    MostrarDiv db 'Division:$'
.CODE
programa:
    ; Inicializar el registro de datos
    MOV AX, @DATA
    MOV DS, AX
    
    ;SUMA
    ;Asignar valores a BL y BH
    XOR BX, BX
    MOV BL, 4
    MOV BH, 2    
    ;Suma los 2 numeros
    ADD BL, BH
    ADD BL, 30h    
    ;Cadena Suma:    
    MOV DX, OFFSET  MostrarSuma
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Imprimir resultado de suma
    MOV AH, 02h
    XOR DX, DX
    MOV DL, BL
    INT 21h
    
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    
    ;RESTA
    ;Cadena Resta:    
    MOV DX, OFFSET  MostrarResta
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    ;Reasignar valor a BL y operar
    MOV BL, 4
    SUB BL, BH
    ADD BL, 30h
    ;Imprimir resultado de resta
    MOV AH, 02h
    XOR DX, DX
    MOV DL, BL
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    
    ;MULTIPLICACION
    ;Cadena multiplicacion:    
    MOV DX, OFFSET  MostrarMul
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    ;Guardar en Al num1
    XOR AX,AX
    MOV AL,4
    MUL BH
    ADD AL,30h
    ;Imprimir resultado de multiplicacion
    MOV AH, 02h
    XOR DX, DX
    MOV DL, AL
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    
    ;DIVISION
    ;Cadena division:    
    MOV DX, OFFSET  MostrarDiv
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    ;Guardar en Al num1
    XOR AX,AX
    MOV AL,4
    DIV BH
    ADD AL,30h
    ;Imprimir resultado de division
    MOV AH, 02h
    XOR DX, DX
    MOV DL, AL
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H        
    
    
    ;Fin de programa
    MOV AH,4CH
    INT 21h
END programa
    