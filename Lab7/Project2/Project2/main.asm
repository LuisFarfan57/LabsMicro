.386
.model flat, stdcall
option casemap:none
; Includes
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc 
; librerias
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
; Segmento de Datos
.DATA  
numero1 DB "Ingrese numero 1",0
numero2 DB "Ingrese numero 2",0
sonIguales DB "Los numeros son iguales",0
sonDiferentes DB "Los numeros son diferentes",0
num1 DB 10,0
num2 DB 10,0
suma DB 10,0
resta DB 10,0
; codigo
.CODE 
 
programa:
main PROC
	; imprimir cadena
	invoke StdOut, addr numero1
	;Ingresar numero
	invoke StdIn, addr num1, 10
	invoke atodw, addr num1
	SUB num1, 30h	
	; imprimir cadena
	INVOKE StdOut, addr numero2
	;Ingresar numero
	invoke StdIn, addr num2, 10
	invoke atodw, addr num2
	SUB num2, 30h	
	;Suma los numeros
	MOV EAX, num2
	MOV EBX, num1
	ADD EBX, EAX
	MOV suma, EBX
	; imprimir suma
	ADD suma, 30h
	INVOKE StdOut, addr suma
	;Resta los numeros
	MOV EAX, num2
	MOV EBX, num1
	SUB EBX, EAX
	MOV resta, EBX
	; imprimir resta
	ADD resta, 30h
	INVOKE StdOut, addr resta
	;Compara los 2 numeros
	MOV EAX, num2
	MOV EBX, num1
	CMP EAX, EBX
	JE SonIguales	
SonDiferentes:
	; imprimir cadena
	INVOKE StdOut, addr sonIguales
	INVOKE StdIn, addr sonIguales,50	
	JMP Finalizar
SonIguales:
	; imprimir cadena
	INVOKE StdOut, addr sonDiferentes
	INVOKE StdIn, addr sonDiferentes,50	
Finalizar:
	INVOKE ExitProcess,0
	main ENDP
END programa
