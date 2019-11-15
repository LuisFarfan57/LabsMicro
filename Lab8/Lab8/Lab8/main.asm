.386
.model flat, stdcall    
      option casemap :none

      include \masm32\include\windows.INC
      include \masm32\include\user32.INC
      include \masm32\include\kernel32.INC
	  include \masm32\include\masm32.INC
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
	  includelib \masm32\lib\masm32.lib

.data
     
     mensaje db "Resultado:  "
     mensajel db "                                     "     
     factorialRes db "                        ",0
     valor dword 0
	 pedirNum db "Ingrese el número a operar: ", 00
	 num db 10 DUP(0)

.code
bintotxt:
		PUSH ax
		PUSH bx 
		PUSH ecx
		PUSH dx
		MOV ecx,0
		MOV bx,10
bintotxt_lazo:
        CMP ax,0
        JE bintotxt_asacar
        INC ecx
        MOV dx,0
        DIV bx
        PUSH dx
        JMP bintotxt_lazo
bintotxt_asacar:
        CMP ecx,0
        JE bintotxt_eracero
bintotxt_lazo2:
        POP ax
        add ax,48
        MOV [edi],al
        INC edi
        loop bintotxt_lazo2
        JMP bintotxt_aretornar
bintotxt_eracero:
        MOV al,'0'
        MOV [edi],al
        INC edi
bintotxt_aretornar:
        POP dx
        POP ecx
        POP bx
        POP ax
        RET

removerEspacios:
    PUSH cx
    PUSH esi
    MOV cl,1
removerEspacios_next:
    CMP byte ptr [esi],0
    JE removerEspacios_elcero
    CMP byte ptr [esi],32
    JE removerEspacios_espacio
    MOV cl,0
removerEspacios_copiar:    
    MOV ch,[esi]
    MOV [edi],ch
    INC edi
removerEspacios_incesi:
    INC esi
    JMP removerEspacios_next
removerEspacios_espacio:
    CMP cl,1
    JE removerEspacios_incesi
    MOV cl,1
    JMP removerEspacios_copiar
removerEspacios_elcero:
    MOV esi,edi
    DEC esi
    CMP byte ptr [edi],0
    JNE removerEspacios_aretornar
removerEspacios_aretornar:
    MOV byte ptr [edi],0
    INC edi
    DEC esi
    POP esi
    POP cx
    RET

factorial:
    PUSH bx
    PUSH dx
    CMP ax,1
    JE factorial_casobase
    MOV bx,ax
    DEC ax
    CALL factorial
    mul bx
factorial_casobase:
    POP dx
    POP bx
    RET

start:	 
	INVOKE StdOut, addr pedirNum
    INVOKE StdIn, addr num, 10         
	INVOKE StripLF, addr num     
    INVOKE atodw, addr num

    MOV valor, eax

    MOV eax,valor
    MOV edi,OFFSET mensajel
    CALL bintotxt
    MOV eax,valor
    CALL factorial
    MOV edi,OFFSET factorialRes
    CALL bintotxt
    MOV esi,OFFSET mensaje
    MOV edi,OFFSET mensaje
    CALL removerEspacios

	INVOKE StdOut, addr mensaje

	INVOKE ExitProcess, 0


end start

