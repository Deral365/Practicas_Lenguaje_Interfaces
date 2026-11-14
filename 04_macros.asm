; Materia: Lenguajes de Interfaz
; Alumno: Perez Rojas Angel Eduardo
; Horario: 10:00-11:00
; Docente: Dr. José Luis Medina Jiménez
; Descripción: Programa en .asm con Irvine32 que utiliza macros (MACRO/ENDM): una para mostrar mensajes de texto y otra para multiplicar dos numeros e imprimir el resultado con WriteInt.

INCLUDE Irvine32.inc


MostrarMensaje MACRO texto
	mov edx, OFFSET texto
	call WriteString
	call Crlf
ENDM

Multi MACRO num1, num2
	mov eax, num1
	imul eax, num2
	call WriteInt
	call Crlf
ENDM

.data
	mensajeBienvenida BYTE "BIENVENIDO AL SISTEMA DE GLOWUP MAKEUP SINALOA", 0
	mensajeFin BYTE "ADIOS", 0
.code
main PROC 
	MostrarMensaje mensajeBienvenida
	MostrarMensaje mensajeFin

	Multi 4, 5

main ENDP
END main
