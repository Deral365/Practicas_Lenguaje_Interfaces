; Materia: Lenguajes de Interfaz
; Alumno: Perez Rojas Angel Eduardo
; Horario: 10:00-11:00
; Docente: Dr. José Luis Medina Jiménez
; Descripción: Programa en .asm con Irvine32 que muestra en hexadecimal (WriteHex) la direccion de retorno guardada en el tope de la pila ([esp]) en llamadas anidadas: main, procUno y procDos.

INCLUDE Irvine32.inc

.data


.code
main PROC 
	mov eax,[esp]
	call WriteHEx
	call Crlf
	call procUno
	exit
main ENDP
	
procUno PROC
	mov eax, [esp]
	call WriteHex
	call Crlf
	call procDos
	
	ret
procUno ENDP

procDos PROC
	mov eax, [esp]
	call WriteHex
	call Crlf
	ret
procDos ENDP

END main
