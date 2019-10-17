.MODEL small
.STACK
.DATA
    fila DB 1
    columna DB 1
    filaIngresada DB 20
    columnaIngresada DB 45
    filaCabeza DB 10
    columnaCabeza DB 21
    apuntadorFin DW 0 
    contadorFin DB 0  
    puntero DW 0
    frutas DB '?$', 50 DUP(0)
    punteroFruta DW 0
    comiofruta DB 1
    cadenaVacia DB '               $'
    posFilaAnterior DB ?
    posColumnaAnterior DB ?
    filaFrutaActual DB ?
    columnaFrutaActual DB ?
    cadenaFin DB 'Fin del Juego$'
    filaCabezaF DB ?
    columnaCabezaF DB ?
    filaCuerpo DB ?
    columnaCuerpo DB ?
    longitudCuerpo DB 3
    contadorCuerpo DB 0
    cadenaFilas DB 'Ingrese la cantidad de filas $'
    cadenaColumnas DB 'Ingrese la cantidad de columnas $'
    bienvenida DB 'Bienvenido a SNAKE$',10
    instrucciones DB 10,13, 'utilice las teclas w (arriba), a (izquierda), s (Abajo), d (Derecha), x(Salir)$',10
    errorPos DB 'Tecla invalida$'
    direccionSnake DB ?
    head DB '>$',10,10
    snake DB 10,21,10,20,15*3 DUP(0)
.CODE
programa:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,00h 
    MOV AL,03h
    INT 10h
    
    MOV DX, OFFSET bienvenida
    MOV AH,09h
    INT 21h
    MOV DX, OFFSET instrucciones
    MOV AH,09h
    INT 21h
    MOV AH,00h
    INT 16h
    llenarFrutas:
    MOV si, offset frutas
    MOV SI, 00h
    MOV frutas[si], 5
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 3
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 10
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 28
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 17
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 2
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 8
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 42
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 4
    INC punteroFruta
    MOV SI,punteroFruta
    MOV frutas[si], 2
    MOV punteroFruta,0
  
    ;limpiar pantalla 
    MOV AH,00h 
    MOV AL,03h
    INT 10h
      
    imprimirColumna:
    ;ubicar el cursor
    MOV AH,02h    
    MOV DH,fila
    MOV DL,columna
    INT 10h
    ;imprimir esquina superior izq
    mov ah,09h   
    mov al,"*"
    mov bl,10
    mov cx,1
    int 10h   
    INC fila
    MOV CL,20;filaIngresada
    CMP fila,CL
    JE imprimirFila
    JMP imprimirColumna
  
    imprimirFila:
    ;ubicar el cursor
    MOV AH,02h    
    MOV DH,fila
    MOV DL,columna
    INT 10h
    ;imprimir esquina superior izq
    mov ah,09h   
    mov al,"*"
    mov bl,10
    mov cx,1
    int 10h   
    INC columna
    MOV CL,45;columnaIngresada
    CMP columna,CL
    JE imprimirColumna2
    JMP imprimirFila
  
    imprimirColumna2:
    ;ubicar el cursor
    MOV AH,02h    
    MOV DH,fila
    MOV DL,columna
    INT 10h
    ;imprimir esquina superior izq
    mov ah,09h   
    mov al,"*"
    mov bl,10
    mov cx,1
    int 10h   
    DEC fila
    MOV CL,0
    CMP fila,CL
    JE imprimirFila2
    JMP imprimirColumna2
  
    imprimirFila2:
    ;ubicar el cursor
    MOV AH,02h    
    MOV DH,fila
    MOV DL,columna
    INT 10h
    ;imprimir esquina superior izq
    mov ah,09h   
    mov al,"*"
    mov bl,10
    mov cx,1
    int 10h   
    DEC columna
    MOV CL,0
    CMP columna,CL
    JE imprimirCabeza
    JMP imprimirFila2
    
    imprimirCabeza:
    ;Imprimir cabeza de serpiente
    ;ubicar el cursor
    MOV AH,02h    
    MOV DH,filaCabeza
    MOV DL,columnaCabeza
    INT 10h
    ;imprimir cabeza
    mov ah,09h   
    mov al,"+"
    mov bl,10
    mov cx,1
    int 10h
    
    MOV BL, columnaCabeza
    MOV columnaCuerpo, BL
    MOV BL, filaCabeza
    MOV filaCuerpo, BL
    
    MOV SI,OFFSET snake
    MOV SI,1
    
    ImprimirCuerpoInicial:
    
    ;ubicar el cursor           
    DEC columnaCuerpo
    MOV AH,02h     
    MOV DH,filaCuerpo
    INC SI
    MOV snake[SI],DH
    MOV DL,columnaCuerpo
    INC SI
    MOV snake[SI],DL
    INT 10h
    ;imprimir parte
    mov ah,09h   
    mov al,"O"
    mov bl,10
    mov cx,1
    int 10h
    ;Verifica cuantos hay que imprimir
    INC contadorCuerpo
    MOV BL, longitudCuerpo
    CMP contadorCuerpo, BL
    JE  Movimientos
    JMP ImprimirCuerpoInicial
    
    
    Movimientos:
    MOV SI, OFFSET snake
    MOV SI,0
    MOV BL,snake[SI];guarda fila cabeza
    MOV filaCabeza,BL
    MOV SI,1
    MOV BL,snake[SI] ;guarda columna cabeza
    MOV columnaCabeza,BL
    MOV SI, 3    
    ;verificar posicion de snake
    MOV BL,snake[SI]
    CMP columnaCabeza,BL
    ;se dirige a la derecha
    JG haciaDerecha
    CMP columnaCabeza,BL
    ;se dirige a la izquierda
    JL haciaIzquierda
    MOV SI, 2
    MOV BL,snake[SI]
    CMP filaCabeza,BL
    ;se dirige hacia arriba
    JG haciaArriba
    CMP filaCabeza,BL
    ;se dirige hacia abajo
    JL haciaAbajo
    JMP EsperarTecla
    
    haciaDerecha:
    MOV direccionSnake,61h
    JMP EsperarTecla
    
    haciaIzquierda:
    MOV direccionSnake,64h
    JMP EsperarTecla
    
    haciaArriba:
    MOV direccionSnake,73h
    JMP EsperarTecla
    
    haciaAbajo:
    MOV direccionSnake,77h
    JMP EsperarTecla
    
    imprimirFrutas:
    MOV comiofruta,0 
    CMP punteroFruta,10
    JE ReiniciarFruta 
    MOV SI, OFFSET frutas 
    MOV AH,02h   
    MOV SI, punteroFruta
    MOV DH, frutas[SI] ;fila
    MOV filaFrutaActual,DH
    INC punteroFruta
    MOV SI,punteroFruta
    MOV DL, frutas[SI] ; columna
    MOV columnaFrutaActual,DL
    INT 10h
    mov ah,09h   
    mov al, '@'
    mov bl,10
    mov cx,1
    int 10h
    INC punteroFruta
    JMP Seguir
    
    ReiniciarFruta:
    MOV punteroFruta,0
    JMP imprimirFrutas
    
    EsperarTecla:
    TEST comiofruta,1
    JNE imprimirFrutas
    Seguir:  
    XOR AX, AX
    mov ah, 00H
    MOV CL,direccionSnake
    CMP CL, 61H;D
    JE  MovimientosPosiblesDerecha
    CMP CL, 64H;D
    JE  MovimientosPosiblesIzquierda
    CMP CL, 73H;D
    JE  MovimientosPosiblesArriba
    CMP CL, 77H;D
    JE  MovimientosPosiblesAbajo
    MovimientosPosiblesDerecha:    
    int 16H
    CMP AL, 78H
    JE  Terminar2
    CMP AL, 64H;D
    JE  MoverDerecha
    CMP AL, 61H;A
    JE  MostrarError
    CMP AL, 77H;W
    JE  MoverArriba2
    CMP AL, 73H;S
    JE  MoverAbajo2
    JMP EsperarTecla
    MovimientosPosiblesIzquierda:     
    int 16H
    CMP AL, 78H
    JE  Terminar2
    CMP AL, 64H;D
    JE  MostrarError
    CMP AL, 61H;A
    JE  MoverIzquierda1
    CMP AL, 77H;W
    JE  MoverArriba2
    CMP AL, 73H;S
    JE  MoverAbajo2
    JMP EsperarTecla
    MovimientosPosiblesArriba:     
    int 16H
    CMP AL, 78H
    JE  Terminar2
    CMP AL, 64H;D
    JE  MoverDerecha
    CMP AL, 61H;A
    JE  MoverIzquierda1
    CMP AL, 77H;W
    JE  MostrarError
    CMP AL, 73H;S
    JE  MoverAbajo2
    JMP EsperarTecla
  MovimientosPosiblesAbajo:     
    int 16H
    CMP AL, 78H
    JE  Terminar2
    CMP AL, 64H;D
    JE  MoverDerecha
    CMP AL, 61H;A
    JE  MoverIzquierda1
    CMP AL, 77H;W
    JE  MoverArriba2
    CMP AL, 73H;S
    JE  MostrarError
    JMP EsperarTecla

    MostrarError:
    MOV AH,02h     
    MOV DH,22 ;fila
    MOV DL,35 ;columna
    INT 10h
    MOV DX, OFFSET errorPos
    MOV AH,09h
    INT 21h
    JMP VolverCabeza
     MoverArriba2:
     JMP MoverArriba1
     MoverAbajo2:
     JMP MoverAbajo1
     MoverIzquierda1:
     JMP MoverIzquierda
    Terminar2:
    JMP Terminar1
    MoverDerecha:
    ;borra mensaje de error
     MOV AH,02h     
     MOV DH,22 ;fila
     MOV DL,35 ;columna
     INT 10h
     MOV DX, OFFSET cadenaVacia
     MOV AH,09h
     INT 21h
    ;borra cabeza actual
    MOV SI, OFFSET snake
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV posFilaAnterior,DH ;guarda posicion actual cabeza fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    MOV posColumnaAnterior,DL;guarda posicion actual cabeza columna
    INT 10h
    ;borra cabeza en posicion actual
    MOV AH, 02h
    MOV DL,''
    INT 21h
    ;imprime nueva posicion de cabeza
    MOV SI,1
    ADD snake[SI],1 ;mueve cabeza hacia derecha
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    INT 10h
    ;imprime cabeza en nueva posicion     
     mov ah,09h   
     mov al,43
     mov bl,10
     mov cx,1
    int 10h
    JMP MoverCuerpo 
        
    MoverArriba1:
    JMP MoverArriba
    MoverAbajo1:
    JMP MoverAbajo
 
    MoverCuerpo2:
    JMP MoverCuerpo 
    
    MoverIzquierda:
       ;borra mensaje de error
     MOV AH,02h     
     MOV DH,22 ;fila
     MOV DL,35 ;columna
     INT 10h
     MOV DX, OFFSET cadenaVacia
     MOV AH,09h
     INT 21h
    ;borra cabeza actual
    MOV SI, OFFSET snake
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV posFilaAnterior,DH ;guarda posicion actual cabeza fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    MOV posColumnaAnterior,DL;guarda posicion actual cabeza columna
    INT 10h
    ;borra cabeza en posicion actual
    MOV AH, 02h
    MOV DL,''
    INT 21h
    ;imprime nueva posicion de cabeza
    MOV SI,1
    SUB snake[SI],1 ;mueve cabeza hacia izquierda
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    INT 10h
    ;imprime cabeza en nueva posicion     
     mov ah,09h   
     mov al,43
     mov bl,10
     mov cx,1
    int 10h
    JMP MoverCuerpo 
    
    Movimientos2:
    JMP Movimientos1
    MoverCuerpo1:
    JMP MoverCuerpo
    
    MoverArriba:
       ;borra mensaje de error
     MOV AH,02h     
     MOV DH,22 ;fila
     MOV DL,35 ;columna
     INT 10h
     MOV DX, OFFSET cadenaVacia
     MOV AH,09h
     INT 21h
    ;borra cabeza actual
    MOV SI, OFFSET snake
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV posFilaAnterior,DH ;guarda posicion actual cabeza fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    MOV posColumnaAnterior,DL;guarda posicion actual cabeza columna
    INT 10h
    ;borra cabeza en posicion actual
    MOV AH, 02h
    MOV DL,''
    INT 21h
    ;imprime nueva posicion de cabeza
    MOV SI,0
    SUB snake[SI],1 ;mueve cabeza hacia arriba
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    INT 10h
    ;imprime cabeza en nueva posicion     
     mov ah,09h   
     mov al,43
     mov bl,10
     mov cx,1
    int 10h
    JMP MoverCuerpo 
    
    MoverAbajo:
       ;borra mensaje de error
     MOV AH,02h     
     MOV DH,22 ;fila
     MOV DL,35 ;columna
     INT 10h
     MOV DX, OFFSET cadenaVacia
     MOV AH,09h
     INT 21h
    ;borra cabeza actual
    ;CMP AL, direccionSnake
    ;JE  Movimientos2
    MOV SI, OFFSET snake
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV posFilaAnterior,DH ;guarda posicion actual cabeza fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    MOV posColumnaAnterior,DL;guarda posicion actual cabeza columna
    INT 10h
    ;borra cabeza en posicion actual
    MOV AH, 02h
    MOV DL,''
    INT 21h
    ;imprime nueva posicion de cabeza
    MOV SI,0
    ADD snake[SI],1 ;mueve cabeza hacia abajo
    MOV SI,0 ;posicion fila cabeza
    MOV AH,02h     
    MOV DH,snake[SI] ;fila
    MOV SI,1 ;posicion columna cabeza
    MOV DL,snake[SI] ;columna
    INT 10h
    ;imprime cabeza en nueva posicion     
     mov ah,09h   
     mov al,43
     mov bl,10
     mov cx,1
    int 10h
    JMP MoverCuerpo 
    
    MoverCuerpo:     
     MOV contadorCuerpo,0
     MOV SI,OFFSET snake
     MOV puntero,1
     MOV SI,puntero
     ciclo:     
     MOV AH,posFilaAnterior ;guarda posicion fila de inicio cuerpo
     MOV AL,posColumnaAnterior ;guarda posicion columna de inicio cuerpo
     ;guarda antiguas posiciones inicio del cuerpo
     INC puntero
     MOV SI,puntero
     MOV CH,snake[SI] ;fila
     MOV posFilaAnterior,CH
     INC puntero
     MOV SI,puntero
     MOV CL,snake[SI];columna
      MOV posColumnaAnterior,CL
     ;asigna nuevas posiciones a inicio del cuerpo
     DEC puntero
     MOV SI,puntero
     MOV snake[SI],AH
     INC puntero
     MOV SI,puntero
     MOV snake[SI],AL
     ;mueve el cursor
     DEC puntero
     MOV SI,puntero ;posicion fila cabeza
     MOV AH,02h     
     MOV DH,snake[SI] ;fila
     INC puntero
     MOV SI,puntero ;posicion columna cabeza
     MOV DL,snake[SI] ;columna
     INT 10h
     ;imprime cuERPO en nueva posicion   
     xor ax,ax
     ;xor bx,bx
     mov ah,09h   
     mov al,79
     mov bl,10
     mov cx,1
     int 10h
     INC contadorCuerpo
     MOV AL,longitudCuerpo
     CMP AL,contadorCuerpo
     JE BorrarUltimo
     JMP ciclo
     
     BorrarUltimo:
      xor ax,ax
      MOV AH,02h     
      MOV DH,posFilaAnterior ;fila
      MOV DL,posColumnaAnterior ;columna
      INT 10h
      ;imprime null para borrar
      mov ah,09h   
      mov al,0
      mov bl,10
      mov cx,1
      int 10h
      JMP VolverCabeza
     
     VolverCabeza:
      MOV SI, OFFSET snake
      MOV SI,0
     MOV AH,02h     
     MOV DH,snake[SI] ;fila
     MOV filaCabezaF,DH
     MOV SI,1 ;posicion columna cabeza
     MOV DL,snake[SI] ;columna
     MOV columnaCabezaF,DL
     INT 10h
     CMP filaCabezaF, 0
     JE  Terminar1
    CMP filaCabezaF, 20
    JE  Terminar1
    CMP columnaCabezaF, 1
    JE  Terminar1
    CMP columnaCabezaF, 45
    JE  Terminar1
    JMP VerificarChoqueCuerpo
    Continuar:
    XOR AX,AX
    MOV AL,filaFrutaActual
    CMP filaCabezaF,AL
    JE compararColumna
    JMP Movimientos1
    
    compararColumna:
    XOR AX,AX
    MOV AL,columnaFrutaActual
    cmp AL,columnaCabezaF 
    JNE Movimientos1
     MOV comiofruta,1
    INC longitudCuerpo
    JMP Movimientos1  
             
    Movimientos1:
    JMP Movimientos
    
    Terminar1:
    JMP Terminar
    
    Continuar1:
    JMP Continuar
    
    VerificarChoqueCuerpo:
    XOR CX, CX
    MOV SI, OFFSET snake
    MOV SI, 2
    MOV apuntadorFin, SI
Verificar1:
    MOV CL, filaCabezaF
    CMP CL, snake[SI]
    JE  FilaIgual
    JMP FilaDiferente    
FilaIgual:
    ADD apuntadorFin, 1
    MOV SI, apuntadorFin
    MOV CL, columnaCabezaF
    CMP CL, snake[SI]
    JE  Terminar
    JMP ColumnaDiferente
FilaDiferente:
    ADD apuntadorFin, 2
    MOV SI, apuntadorFin    
    INC contadorFin
    MOV CL, contadorFin
    CMP CL, longitudCuerpo
    JE  Continuar
    JMP Verificar1    
ColumnaDiferente:
    ADD apuntadorFin, 1
    MOV SI, apuntadorFin
    INC contadorFin
    INC contadorFin
    MOV CL, contadorFin
    CMP CL, longitudCuerpo
    JE  Continuar1
    JMP Verificar1    
    
    Terminar:
    ;limpiar pantalla 
    MOV AH,00h 
    MOV AL,03h
    INT 10h
    ;Mensaje de fin
    MOV DX, OFFSET  CadenaFin
    MOV AH, 09h
    INT 21h
    MOV AH,00H
    INT 16H    
    ;finalizar
    MOV AH, 4Ch
    INT 21h
End programa