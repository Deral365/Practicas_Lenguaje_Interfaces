; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 4
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se utilizan diferentes instrucciones para la comparacion de dos valores, si son mayor,iguak o menor

INCLUDE Irvine32.inc

.data
; Se declaran los mensajes para dar instruccion al usuario
	msgValor1 BYTE "Introduce un numero: ",0
	msgValor2 BYTE "Introduce otro numero: ",0
	msgIgual BYTE "Los numeros son iguales",0
	msgMayor BYTE "el primer numero es mayor", 0
	msgMenor BYTE "el primer numero es menor", 0
.code
main PROC
	mov edx, OFFSET msgValor1
	call WriteString							; Se imprime msgValor1
	call ReadInt								; Lee un numero entero del teclado y lo guarda en eax
	call crlf								
	mov ebx, eax								; guarda el valor en ebx
	mov edx, OFFSET msgValor2
	call WriteString
	call ReadInt								; se guarda otro valor en eax

	CMP ebx, eax								; compara ebx con eax para activar la bandera ZF
	JE iguales									; si son iguales entra a iguales

	CMP ebx, eax								; compara ebx con eax
	JG mayor									; si ebx es mayor entra a mayor esta instruccion funciona si la bandera CF=0 y ZF= 0

	CMP ebx, eax								; compara ebx con eax
	JL menor									; si ebx es menor a eax entra a menor esta instruccion funciona si la bandera CF=1



;Se declaran los bloques a imprimir dependiendo de los valores
	iguales:
		mov edx, OFFSET msgIgual
		call WriteString
		exit
	mayor:
		mov edx, OFFSET msgMayor
		call WriteString
		exit
	menor:
		mov edx, OFFSET msgMenor
		call WriteString
		exit
main ENDP
END main
