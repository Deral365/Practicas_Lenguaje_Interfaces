; Materia: Lenguajes de Interfaz 
; Alumno: Perez Rojas Angel Eduardo 
; Horario: 10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 13
; Descripción: Codigo en .asm usando Irvine32 para convertir un numero hexadecimal de 32 bits nibble por nibble

INCLUDE Irvine32.inc

.data
    valorHex    DWORD 12AB34CDh         
    bufferHex   BYTE 9 DUP(0)           ; Buffer de 9 bytes de 8 dígitos y otro para terminador nulo
    msgHex      BYTE "La representacion es: ", 0

.code
main PROC
    mov eax, valorHex                   ; lo guardamos en eax
    mov esi, OFFSET bufferHex           ; esi apunta al inicio del buffer

    ; --- Lógica de conversión hexadecimal integrada en main ---
    mov edi, esi
    add edi, 7                          ; se posiciona en el último dígito indice 7
    mov ecx, 8                          ; 8 nibbles dígitos hexadecimales en un DWORD

 cicloHex:
    mov edx, eax
    and edx, 0Fh                        ;se aisla el nibble inferior con la mascara 0Fh

    cmp dl, 9                           ; Comparamos si es mayor a 9
    jbe esDigito                        ; Si es menor o igual a 9  es un numero normal del 0 al 9
    add dl, 7                           ; y si se pasa de 9 le sumamos 7 para llegar al rango de las letras en ascii

 esDigito:
    add dl, '0'                         ;aqui lo convertimos a caracter ASCII
    mov [edi], dl                       ; se guarda en el buffer

    dec edi                             ; Retroceder el índice a la izquierda
    shr eax, 4                          ; Desplazamos 4 bits a la derecha para el siguiente nibble
    loop cicloHex

    mov BYTE PTR [esi+8], 0             ; Colocar el terminador nulo '00h' al final

    ;muestra el resultado
    mov edx, OFFSET msgHex
    call WriteString
    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    exit
main ENDP

END main