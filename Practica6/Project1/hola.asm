; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 6
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se simula la entrada y salida de un estacionamiento con limite de cupos, y como se va llenando
; o vaciando el estacionamiento
INCLUDE Irvine32.inc

.data
;Se declaran los mensajes a necesitar
	msgAcceso BYTE "vehiculo entra", 0
	msgSalida BYTE "vehiculo sale", 0
	msgNumVehiculos BYTE "Numero de Vehiculos: ", 0
	msgLleno BYTE "Estacionamiento lleno", 0
	msgComprueba BYTE "Vehiculo entra o sale? 0.Fin	 1. Entra 2. Sale	: ", 0
	msgVacio BYTE "Estacionamiento vacio, no pueden salir vehiculos", 0
	espacios = 10				; se declaran numero de espacios en el estacionamiento



.code
main PROC
mov ebx, 0
estacionamiento:
	mov edx, OFFSET msgComprueba ;Se imprime el primer mensaje para indicar que opciones hay
	call WriteString
	call readInt				; captura lo del teclado y se guarda en eax


	CMP eax, 1					; compara lo capturado con el numero indicado al acceso
	JE acceso					; si es igual la comparacion el jump entra a acceso

	CMP eax, 2					; compara lo capturado con el numero indicado a la salida
	JE salida					; si es igual la comparacion, el jump entra a salida

	CMP eax, 0					; Compara lo capturado con el numero indicado a fin
	JE fin						; si es igual la comparacion, el jump va a salida

	JMP estacionamiento         ; se repite si no es ninguna opcion


	
	acceso:
	    CMP ebx, espacios      ;se pregunta primero si hay espacio ya que ebx es el registro para el contador
		JE lleno               ;se manda al bloque lleno

		inc ebx					;se incrementa ebx
		mov edx, OFFSET msgAcceso
		call WriteString
		call crlf				
		mov edx, OFFSET msgNumVehiculos   ;Se indica el mensaje de cantidad
		call WriteString
		mov eax, ebx
		call WriteDec                     ; se imprime lo que vale ebx pero antes fue guardado en eax
		call crlf
		JMP estacionamiento               ;despues de todo se regresa a estacionamiento para la nueva indicacion

	salida:
	    cmp ebx,0               ;Se pregunta si esta vacio esto con el fin de no sacar carros que no hay
		je vacio                ;si es asi se va a la eqtiueta vacio
		mov edx, OFFSET msgSalida
		call WriteString
		call crlf

		dec ebx					; se  decrementa ebx ya que sale un carro
		mov edx, OFFSET msgNumVehiculos
		call WriteString
		mov eax, ebx
		call WriteDec
		call crlf
		JMP estacionamiento

	lleno:
		mov edx, OFFSET msgLleno    ;este bloque esta por si se lleno el estacionamiento 
		call WriteString
		call crlf
		JMP estacionamiento
	vacio:
	   mov edx, OFFSET msgVacio      ;este bloque esta por si esta vacio el estacionamiento
	   call WriteString
	   call crlf
	   JMP estacionamiento

	fin:                             ;este bloque es para salir del sistema
		exit
main ENDP
END main