; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 7
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se pide un tipo de formato especifico y si no cumple indica que no es valido y viceversa, donde
; se debe capturar una cadena con 3 letras, un guion y 3 numeros al final

INCLUDE Irvine32.inc

.data
;Se declaran los mensajes a necesitar
    mensaje     BYTE "Ingrese un codigo (AAA-999): ",0
    valido      BYTE "Formato valido.",0
    invalido    BYTE "Formato invalido.",0
;Se declara el buffer a necesitar para la comprobacion caracter por caracter
    cadena      BYTE 20 DUP(?)

.code

main PROC
;Se imprime el primer mensaje 
    mov edx, OFFSET mensaje
    call WriteString

;Se lee la cadena
    mov edx, OFFSET cadena
    mov ecx, SIZEOF cadena - 1
    call ReadString

 ; se sabe que eax contiene la longitud
    cmp eax, 7                      ;si no cumple con la longitud manda mensaje de formato invalido
    jne FORMATO_INVALIDO

;Esta parte es para lo de las letras 
    mov esi, OFFSET cadena    ; se usa esi para inidcar en que parte va del buffer
;pasamos a la primera posicion [0]
    mov al, [esi]            ;se usa Al ya que almacenan un carácter por cada byte de memoria y esi para indicar la posicion de la cadena
    cmp al, 'A'              ; se compara con 'A' que vale 65 ya que la computadora solo entiende ascii y para ver si es menor
    jb FORMATO_INVALIDO 
    cmp al, 'Z'                ; se compara con 'Z' que vale 90 en ascii ya que la computadora solo entiende ascii y para ver si es mayor
    ja FORMATO_INVALIDO
;Pasamos a la siguiente posicion[1]
    mov al, [esi + 1]
    cmp al, 'A'
    jb FORMATO_INVALIDO
    cmp al, 'Z'
    ja FORMATO_INVALIDO

;Pasamos a la siguiente posicion[2]
    mov al, [esi + 2]
    cmp al, 'A'
    jb FORMATO_INVALIDO
    cmp al, 'Z'
    ja FORMATO_INVALIDO
;En los siguientes procesos se repite lo mismo pero con diferente caracter dependiendo su valor en codigo ascii y esten dentro del rango
    mov al, [esi + 3]
    cmp al, '-'
    jne FORMATO_INVALIDO           ;aqui salta si no es igual a lo comparado

;Se hace lo mismo pero condiferente posicion o valor pero ahora a la parte de los numeros
    mov al, [esi + 4]
    cmp al, '0'
    jb FORMATO_INVALIDO
    cmp al, '9'
    ja FORMATO_INVALIDO

    mov al, [esi + 5]
    cmp al, '0'
    jb FORMATO_INVALIDO
    cmp al, '9'
    ja FORMATO_INVALIDO


    mov al, [esi + 6]
    cmp al, '0'
    jb FORMATO_INVALIDO
    cmp al, '9'
    ja FORMATO_INVALIDO

;Si paso todo esto significa que es valido el formato y se impirme valido
    mov edx, OFFSET valido
    call WriteString
    jmp fin

FORMATO_INVALIDO:

    mov edx, OFFSET invalido
    call WriteString

fin:
    call Crlf
    exit

main ENDP
END main