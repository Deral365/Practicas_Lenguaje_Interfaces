; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 2
; Descripción:Realiza el codigo en .asm usando Irvine32 donde se captura una cadena y se imprime lo capturado

INCLUDE Irvine32.inc

.data
    Pedir BYTE "Ingresa algo", 0  ;Se declara la indicacion para el usuario
    nombre BYTE 30 DUP(0)         ;Se reserva un espacio en la memoria para alamacenar lo capturado
.code
main PROC

    mov edx, OFFSET Pedir         ;Se da la direccion de Pedir para imprimirlo
    call WriteString
    call crlf
    

    mov edx, OFFSET nombre        ;Se da la direccion de nombre para que readString sepa donde empieza el buffer
    mov ecx, SIZEOF nombre-1      ;Se inidca la cantidad maxima de caracteres que puede almacenar
    call ReadString
    
    mov edx, OFFSET nombre        ;Se da la direccion de nombre para poder imprimirlo
    call WriteString

	exit

main ENDP
END main