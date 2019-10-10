.MODEL small
.STACK 
.DATA        
    
    Contador db ?  
    res db ?
    cos db ?    
    CadenaNum1 db 'Ingrese el numero 1$'
    CadenaNum2 db 'Ingrese el numero 2$'
    Producto db 'Producto: $'
    Cociente db 'Cociente: $'
    Residuo db 'Residuo: $'
    
.CODE
programa:
    ; Inicializar el registro de datos
    MOV AX, @DATA
    MOV DS, AX
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
    
    ;Inicia el contador para las sumas sucesivas
    XOR CX, CX
    MOV CL, 1
    MOV Contador, CL
    XOR CX, CX
    ;Mueve el numero 1 a CL
    MOV CL, BL
    
SUMAS:
    ;Mira si el contador es igual al segundo n?mero
    CMP Contador, BH
    ;Si es igual se sale del ciclo
    JE  SIGUIENTE
    
    ;Se le suma a CL el primer numero y se guarda en CL    
    ADD CL, BL
    
    ;Incrementa el contador luego de un ciclo
    INC Contador
    JMP SUMAS
    

SIGUIENTE:
    ;Cadena para mostrar el producto 
    MOV DX, OFFSET  Producto
    MOV AH, 09h
    INT 21h    
    ;Imprimir resultado de producto    
    ADD CL, 30h
    MOV AH, 02h
    XOR DX, DX
    MOV DL, CL
    INT 21h   
    ;Salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    
    ;Pide otros numeros
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
    
    ;Inicia el cociente y residuo en 0
    XOR CX, CX
    MOV CL, 0
    MOV cos, CL
    MOV res, CL
    ;Se guarda el numero 1 en CL
    MOV CL, BL
    
RESTAS:    
    ;Mira si CL es igual a 0, es decir, hizo todas las restas posibles
    CMP CL, 0
    JE  CONTINUAR2
    ;Mira si CL es menor al segundo n?mero, es decir, hizo todas las restas posibles pero quedo un residuo
    CMP CL, BH    
    JL  CONTINUAR2
    
    ;Realiza la resta entre CL y el segundo n?mero, se guarda en CL
    SUB CL, BH    
    
    ;Aumenta la variable que cuenta cuantas restas se han realizado, el cociente
    INC cos       
    
    JMP RESTAS        
    
CONTINUAR2:
    ;El residuo ser? lo que qued? en CL
    MOV res, CL
    ;Cadena para mostrar el cociente
    MOV DX, OFFSET  Cociente
    MOV AH, 09h
    INT 21h    
    ;Imprimir cociente
    ADD cos, 30h
    MOV AH, 02h
    XOR DX, DX
    MOV DL, cos
    INT 21h
    ;Salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;Cadena para mostrar el residuo
    MOV DX, OFFSET  Residuo
    MOV AH, 09h
    INT 21h       
    ;Imprimir residuo
    ADD res, 30h
    MOV AH, 02h
    XOR DX, DX
    MOV DL, res
    INT 21h   
    ;Salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
        
FIN:
    ;Fin de programa
    MOV AH,4CH
    INT 21h
END programa