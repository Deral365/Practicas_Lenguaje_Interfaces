; Materia: Lenguajes de Interfaz
; Alumno: Perez Rojas Angel Eduardo
; Horario: 10:00-11:00
; Docente: Dr. José Luis Medina Jiménez
; Descripción: Programa en .asm con Irvine32 que lee una cadena del teclado con ReadString y valida si esta vacia comparando el primer byte con el terminador nulo (cmp / je), mostrando el mensaje correspondiente.

INCLUDE Irvine32.inc

.data
    cadena BYTE 50 DUP(0)          
    msgPedir BYTE "Ingresa una cadena (o presiona Enter para dejarla vacia): ", 0
    msgVacia BYTE "La cadena ESTA vacia.", 0
    msgNoVacia BYTE "La cadena NO esta vacia.", 0

.code
main PROC
    ; 1. Pedir y leer la cadena
    mov  edx, OFFSET msgPedir
    call WriteString

    mov  edx, OFFSET cadena
    mov  ecx, SIZEOF cadena
    call ReadString ; Lee la entrada del usuario (guarda longitud en EAX)

    ; 2. Validar si está vacía comprobando el primer byte
    cmp  BYTE PTR [cadena], 0 ; ¿El primer carácter es el terminador nulo (0)?
    je   EsVacia ; Si es igual a 0, está vacía

NoEsVacia:
    mov  edx, OFFSET msgNoVacia
    call WriteString
    call Crlf
    jmp  Fin

EsVacia:
    mov  edx, OFFSET msgVacia
    call WriteString
    call Crlf

Fin:
    exit
main ENDP
END main
