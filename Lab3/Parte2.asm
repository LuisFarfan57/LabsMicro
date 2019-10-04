.MODEL small
.STACK 
.DATA        
    cociente db ?
    residuo db ?
    CadenaNum1 db 'Ingrese el numero 1$'
    CadenaNum2 db 'Ingrese el numero 2$'
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
    XOR BX, BX
    ;Pedir numero 1:    
    MOV DX, OFFSET  CadenaNum1
    MOV AH, 09h
    INT 21h   
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num1
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    SUB BL, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Pedir numero 2:    
    MOV DX, OFFSET  CadenaNum2
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num2
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BH, AL
    SUB BH, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H    
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
    XOR BX, BX
    ;Pedir numero 1:    
    MOV DX, OFFSET  CadenaNum1
    MOV AH, 09h
    INT 21h   
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num1
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    SUB BL, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Pedir numero 2:    
    MOV DX, OFFSET  CadenaNum2
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num2
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BH, AL
    SUB BH, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
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
    ;Operar    
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
    XOR BX, BX
    ;Pedir numero 1:    
    MOV DX, OFFSET  CadenaNum1
    MOV AH, 09h
    INT 21h   
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num1
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    SUB BL, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Pedir numero 2:    
    MOV DX, OFFSET  CadenaNum2
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num2
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BH, AL
    SUB BH, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
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
    MOV AL,BL
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
  XOR BX, BX
    ;Pedir numero 1:    
    MOV DX, OFFSET  CadenaNum1
    MOV AH, 09h
    INT 21h   
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num1
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    SUB BL, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Pedir numero 2:    
    MOV DX, OFFSET  CadenaNum2
    MOV AH, 09h
    INT 21h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Leer num2
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV BH, AL
    SUB BH, 30h
    ;Salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H  
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
    MOV AL,BL
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
    