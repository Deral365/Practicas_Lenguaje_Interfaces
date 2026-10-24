; Materia: Lenguajes de Interfaz 
; Alumno: Perez Rojas Angel Eduardo 
; Horario: 10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Descripción: Este programa que lee una cantidad ingresada por el usuario validando que sean de 1 a 2 digitos y un rango de 1 a 99 y
;le suma una existencia inicial de 25 y imprime el resultado actualizado usando conversion de decimal a cadena
INCLUDE Irvine32.inc

.data
    ; Variables 
    existenciaInicial   DWORD 25
    cantidadRecibida    DWORD ?
    existenciaActual    DWORD ?

    ; Mensajes y textos en pantalla
    msgPrompt           BYTE "Ingrese la cantidad recibida (1-99): ", 0
    msgError            BYTE "Error: Cantidad invalida o fuera de rango.", 0
    msgActual           BYTE "Existencia actual en almacen: ", 0
    
    ; Buffers para lectura de cadena y la conversion
    bufferEntrada       BYTE 10 DUP(0)
    bufferDecimal       BYTE 11 DUP(0)

.code
main PROC
pedir_cantidad:
    ; Mostrar mensaje inicial
    mov edx, OFFSET msgPrompt
    call WriteString

    ; Capturar entrada mediante ReadString 
    mov edx, OFFSET bufferEntrada
    mov ecx, SIZEOF bufferEntrada
    call ReadString                 ; eax devuelve la cantidad de caracteres leidos

    ; se checa que no este vacia la entrada
    cmp eax, 0
    je error_entrada

    ; Validamos que sea de 1 o 2 dígitos maximo
    cmp eax, 2
    ja error_entrada

    ; 3. se valida y se convierten de caracteres a numero numerico
    mov esi, OFFSET bufferEntrada
    mov ecx, eax                    ; ecx sera el contador de caracteres
    mov eax, 0                      ; Acumulador numérico en 0

validar_caracteres:
    mov edx, 0                      ; Limpiar edx por completo para evitar basura en los bits altos
    mov dl, [esi]                   ; Cargar unicamente el carácter actual en dl
    
    ; comprobamos que sea un dígito válido 0 a 9
    cmp dl, '0'
    jb error_entrada
    cmp dl, '9'
    ja error_entrada

    ; Convertir carácter a su valor numerico restando '0' (30h)
    sub dl, '0'

    ; Acumulador = Acumulador * 10 + dígito
    push edx                        ; Guardar el dígito limpio temporalmente en la pila
    mov ebx, 10
    mul ebx                         ; EAX = EAX * 10 (Ojo: mul usa EDX, por eso guardamos el dígito antes)
    pop edx                         ; Recuperar nuestro dígito
    
    add eax, edx                    ; EAX = (EAX anterior * 10) + dígito actual

    inc esi                         ; Siguiente carácter
    loop validar_caracteres

    ;Validar que el rango este entre 1 y 99
    cmp eax, 1
    jb error_entrada
    cmp eax, 99
    ja error_entrada

    ; guardar en la variable DWORD solicitada
    mov cantidadRecibida, eax

    ;Sumar a la existencia inicial 25 + cantidadRecibida
    mov eax, existenciaInicial
    add eax, cantidadRecibida
    mov existenciaActual, eax

    ;Mostrar el resultado usando WriteString y el convertidor decimal
    call Crlf
    mov edx, OFFSET msgActual
    call WriteString

    ; Convertimos el resultado numérico entero de vuelta a cadena usando tu subrutina
    mov eax, existenciaActual
    mov esi, OFFSET bufferDecimal
    call convertirDecimal
    mov edx, OFFSET bufferDecimal
    call WriteString
    call Crlf

    jmp fin_programa

error_entrada:
    call Crlf
    mov edx, OFFSET msgError
    call WriteString
    call Crlf
    call Crlf
    jmp pedir_cantidad              ; esta ante un error
;Aqui aca los digitos de un número entero dividiendo entre 10 y los apila y luego los acomoda en orden correcto como texto en el buffer 
convertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi

    mov ecx, 0                  

conversion_loop:
    mov edx, 0                  
    mov ebx, 10
    div ebx                     
    
    push edx                    
    inc ecx                     

    cmp eax, 0                  
    jne conversion_loop         

extrar_digitos_loop:
    pop edx                     
    add dl, '0'                 
    mov [esi], dl               
    inc esi                     
    loop extrar_digitos_loop

    mov BYTE PTR [esi], 0        ; Cerramos la cadena con el terminador nulo

    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret                         ;Se regresa donde se quedo 
convertirDecimal ENDP
fin_programa:
    exit
main ENDP
END main    ;