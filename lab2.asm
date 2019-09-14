.MODEL small

.DATA
;variable que contiene el texto que queremos mostrar
nombre DB 'Luis Enrique Farfan $'; $ significa el final de la cadena
carnet DB '1260217 $'
saludo DB 'El simbolo elegido es: $'

.STACK
.CODE

Programa: ; etiqueta de inicio de programa
; inicializar el programa
MOV AX, @Data ; guardando direccion de inicio segmento de 
MOV DS, AX

; Imprimir cadena
MOV DX, OFFSET nombre ; asignando a DX la variable nombre
MOV AH, 09h	      ; ordenar que se imprima una cadena
INT 21h		      ; ejecuta la interrupcion, imprime la cadena

MOV DX, OFFSET carnet ; asignando a DX la variable carnet
MOV AH, 09h	      ; ordenar que se imprima una cadena
INT 21h		      ; ejecuta la interrupcion, imprime la cadena

MOV DX, OFFSET saludo ; asignando a DX la variable saludo
MOV AH, 09h	      ; ordenar que se imprima una cadena
INT 21h		      ; ejecuta la interrupcion, imprime la cadena

MOV AX, 0000h	      ; inicializar registro
MOV AX, 15h
MOV AH, 02h
INT 21h


; finalizar el programa
MOV AH, 4ch ; finalizar proceso
INT 21h     ; ejecuta la interrupcion
END Programa