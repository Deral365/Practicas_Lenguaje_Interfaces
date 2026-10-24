; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo ; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 1
; Descripción:Realizar el codigo en .asm usanod Irvine32 utilizando la instruccion loop

INCLUDE Irvine32.inc

.data
.code
main PROC
	mov ecx, 5  ;Declaremos ecx ya que en  la instruccion loop lo utiliza como contador

	ciclo:      ;Se declara la etiqueta ciclo ya que es el bloque que se repetira
	mov eax, ecx  ;Se guarda el valor de ecx en eax para despues imprimirlo y ver como se decrementa
	call WriteDec
	call crlf
	loop ciclo ;La instruccion loop para saltar en el bloque ciclo y a su vez se decrementa ecx y se repite hasta que ecx sea 0
	exit

main ENDP
END main