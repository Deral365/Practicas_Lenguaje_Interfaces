; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 5
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se repite un ciclo hasta que le insertemos un numero 0 por el teclado 

INCLUDE Irvine32.inc

.data
;Se declara los mensajes a impirmir
      mensaje BYTE "Ingresa el numero 0 para parar: ", 0
      msgSalida BYTE "El programa termino",0

	  receptor DWORD 1  ;se declare una variable receptor
.code
main PROC
  
	ciclo:
	mov edx, OFFSET mensaje    ; Se imprime el primer mensaje 
	call WriteString


	mov eax, OFFSET receptor    
	call ReadDec               ; Se captura el valor y se compara para ver si es igual a 0
	cmp eax, 0  
	je fin                     ; Si es asi se salta al bloque fin y termina y imprime un mensaje 

	jmp ciclo                  ;Si no es asi se vuelve a repetir todo

	fin:
	mov edx, OFFSET msgSalida
	call WriteString
	exit


main ENDP
END main