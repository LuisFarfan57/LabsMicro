.model small
.stack 
.data 
    PedirCadena db 10,13,7, 'Ingrese la cadena: ','$'
    cadena db 100 dup(' '), '$'     
.code 
PROGRAMA:
    MOV ax,@data 
    MOV ds,ax 

    MOV ah, 09h
    LEA dx, PedirCadena
    INT 21h
    
    MOV AH, 3fH
    MOV BX, 00
    MOV CX, 100
    MOV DX, OFFSET[cadena]
    INT 21h

    MOV ah, 09h
    MOV dx, OFFSET[cadena]
    INT 21h

    CALL Convertir 

    MOV ah,4ch 
    INT 21h 


Convertir proc 
    MOV si,0 
siguiente: 
    MOV AL,cadena[si] 
    CMP AL,'$' 
    JZ fin 
    CMP AL,'z' 
    JG continuar 
    CMP AL,'a' 
    JL continuar 
    SUB AL,20H 
continuar:
    MOV DL,AL 
    MOV ah,2 
    INT 21h 
    INC si 
    JMP siguiente 
fin: ret 
Convertir ENDP 
END PROGRAMA