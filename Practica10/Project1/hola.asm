; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo ; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 10
; Descripción:Se realiza el codigo en .asm usando Irvine32 donde se simula una decarga de un archivo con valores ya definidos para una obtencion de una cadena decimal

INCLUDE Irvine32.inc

.data
;Se le dan valores ya definidos
    totalBytes       DWORD 100000
    bloques          DWORD 125
    tamBloque        DWORD 512
    bytesDescargados DWORD ?
    bytesPendientes  DWORD ?
    porcentaje       DWORD ?
    grupos1024       DWORD ?
    residuo1024      DWORD ?

    buffer           BYTE 11 DUP(0) ; El buffer para el recorrido de las cadenas
;Los mensajes que se van a ocupar
    m1 BYTE "Bytes descargados: ", 0
    m2 BYTE "Bytes pendientes: ", 0
    m3 BYTE "Porcentaje de avance: ", 0
    m4 BYTE "%", 0
    m5 BYTE "Grupos completos de 1024 bytes: ", 0
    m6 BYTE "Residuo del agrupamiento: ", 0

.code
main PROC
    ; Aca se multiplica la cantidad de bloques por el tamaño de cada bloque 125 * 512
    mov eax, bloques
    mov ebx, tamBloque
    mul ebx
    mov bytesDescargados, eax ;Aca ya se guarda el resultado en bytesDescargados

    ; aca ya resta al total de bytes el total que ya fue descargado 100,000 - 64,000 para diferencia
    mov eax, totalBytes
    sub eax, bytesDescargados
    mov bytesPendientes, eax ;Igual aca tambien se guarda

    ; Aca ya se efectua una formula para saber el porcentaje (BytesDescargados * 100) / TotalBytes
    mov eax, bytesDescargados
    mov edx, 0          ;Se limpia edx para multiplicar por datos basura
    mov ebx, 100            
    mul ebx
    mov ebx, totalBytes      ;Se realiza el primer paso de la fromula y despues se divide usanod mul y depues div 
    div ebx
    mov porcentaje, eax

    ; aca ya se divide los bytes descargados entre 1024 para ver cuántos bloques de 1KB hay
    mov eax, bytesDescargados
    mov edx, 0
    mov ebx, 1024
    div ebx
    mov grupos1024, eax        ;Guarda el numero de grupos completos
    mov residuo1024, edx       ;Guarda el residuo de la division
    
    ;Aca esta seccion es para la impresion y llamar al procedimiento para convertirlo a decimal usando la funcion call
    mov edx, OFFSET m1
    call WriteString
    mov eax, bytesDescargados     
    mov esi, OFFSET buffer      ;toma la direccion y la guarda en esi y pasa al procedimiento convertir a decimal que esta abajo guardadno la direccion de retorno
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf


;Lo mismo pasa en las demas impresiones
    mov edx, OFFSET m2
    call WriteString
    mov eax, bytesPendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET m3
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    mov edx, OFFSET m4
    call WriteString
    call Crlf

    mov edx, OFFSET m5
    call WriteString
    mov eax, grupos1024
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov edx, OFFSET m6
    call WriteString
    mov eax, residuo1024
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP
;Aca ya en esta area se observa como es el procedimiento para convertir a decimal usanod el ASCII
convertirDecimal PROC
    push ecx         ; Aca resguarda los registros modificados en la pila
    push edx
    push ebx
    push esi
    mov ecx, 0       ;eax funciona como contador de dígitos extraídos

   ;Esto verifica si el número a convertir es exactamente 0
    cmp eax, 0
    jne ciclo
    mov dl, '0'           ;Carga el carácter '0' en ASCII y lo guarda en esi
    mov [esi], dl
    mov BYTE PTR [esi+1], 0
    jmp fin

ciclo:
;Este bloque se usa para extraer cada dígito dividiendo iterativamente entre 10
    cmp eax, 0                 ;Aca primero se compureba si ya llego a 0 osea al final para comenzar a sacar
    je sacar
    mov edx, 0 
    mov ebx, 10               ;Aca se usa el divisor decimal fijo
    div ebx
    push edx                 ;Se guarda en la pilpara proteger
    inc ecx                  ; Incrementa el contador de dígitos
    jmp ciclo

sacar:
; este bloque sirve para sacar los dígitos de la pila en orden correcto 
    cmp ecx, 0
    je finStr
    pop edx
    add dl, '0'                 ;Aca ya convierte el valor numérico (0-9) a caracter ASCII ('0'-'9')
    mov [esi], dl               ; y se guarda en la posicion actual
    inc esi                     ;Aca aumenta el indicador del buffer y baja el de digitos
    dec ecx
    jmp sacar

finStr:
    mov BYTE PTR [esi], 0   ;Aca se indica un 0 para cerrar cada cadena de texto

fin:
;Aca se restaura los registros  que fueron guardados al inicio
    pop esi
    pop ebx
    pop edx
    pop ecx
    ret        ; aca ya se regresa en la parte que se quedo alla arriba para apsar a la siguiente cadena
convertirDecimal ENDP

END main