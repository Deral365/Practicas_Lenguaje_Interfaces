; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 3
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se utiliza la instruccion CMP para ver si dos valores son iguales o diferentes

INCLUDE Irvine32.inc

.data
;Se declaran los mensajes a imprimir

	msgIguales BYTE "Los valores son iguales", 0       
	msgDiferentes BYTE "los valores son diferentes", 0

.code
main PROC 

;Se les da valor a los dos registros que se van a comparar
	mov eax, 10
	mov ebx, 10
	CMP eax, ebx ; se enciende zeroflag = 1 ya que cmp resta los dos numeros sin almacenar el resultado
	
	JE iguales  ;se usa esta instruccion para mandarlo al bloque iguales siempre y cuando se encienda la bandera ZF
	mov edx, OFFSET msgDiferentes      ;si no son iguales se imprime el mensaje diferentes
	call writeString
	jmp fin   ; Se da final programa despues de ejecutar cualqueira de los dos bloques

	iguales:
		mov edx, OFFSET msgIguales
		call writeString
		jmp fin
	
	fin:
		call crlf
		exit


main ENDP
END main