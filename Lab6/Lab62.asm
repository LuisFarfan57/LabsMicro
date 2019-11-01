.model small
.stack 
.data

    Pedir1 db 0ah,0dh, 'Cadena 1: $'
    Pedir2 db 0ah,0dh, 'Cadena 2: $'
    Igual db 0ah,0dh, 'Las cadenas son iguales $'
    diferentes db 0ah,0dh, 'Las cadenas son diferentes $'
    cadena1 db 50 dup(' '), '$'
    cadena2 db 50 dup(' '), '$'
.code 
PROGRAMA:
    mov ax,@data
    mov ds,ax
    
    ;Se pide la primer cadena
    mov ah,09
    mov dx,offset Pedir1
    int 21h
 
    lea si,cadena1
    
PedirCadena1:
    mov ah,01h
    int 21h
    mov [si],al
    inc si
    cmp al,0dh
    ja PedirCadena1
    jb PedirCadena1

    mov ax,@data
    mov ds,ax
    
    ;Se pide la segunda cadena
    mov ah,09
    mov dx,offset Pedir2
    int 21h
    lea si,cadena2

PedirCadena2:
    mov ah,01h
    int 21h
    mov [si],al
    inc si
    cmp al,0dh
    ja PedirCadena2
    jb PedirCadena2
  
    mov cx,50
    mov AX,DS
    mov ES,AX

VerSiSonIguales: 
    lea si,cadena1
    lea di,cadena2
    repe cmpsb
    Jne MostrarDiferente    
 
MostrarIgual:
    mov ax,@data
    mov ds,ax
    mov ah,09
    mov dx,offset Igual
    int 21h
    jmp finalizar

MostrarDiferente:
    mov ax,@data
    mov ds,ax
    mov ah,09
    mov dx,offset diferentes  ; Imprime que son diferentes y finaliza el programa.
    int 21h
finalizar:
    mov ah,04ch
    int 21h   
END PROGRAMA 