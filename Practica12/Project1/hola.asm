; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 12
; Descripción:Se realiza el codigo en .asm usando Irvine32 donde se las funciones para rotacion y desplazamiento

INCLUDE Irvine32.inc

.data
.code
main PROC
 Mov eax, 0
 Mov ebx, 0

;1 SHL: DESPLAZAR UN BIT A LA IZQUIERDA 
; Multiplica el numero por 2 por cada posicion que muevas los bits
 Mov al, 10000110b     
 shl al, 1  ;Desplazamos 1 bit a la izquierda y el sale se va al CF
 Call DumpRegs
 Call WriteBin

;2 SHR: DESPLAZAR UN BIT A LA DERECHA 
;Divide el numero sin signo entre 2 por cada movimiento
mov al, 00001101b

 Shr al,1      ;Desplazamos 1 bit a la derecha

Call DumpRegs
 Call WriteBin

;3 SAR: DESPLAZAMIENTO CON SIGNO 
;este respeta el signo del número negativo y rellena con 1s a la izquierda.
mov eax, 0
Mov al, -8
Sar al,1   ; Divide entre 2 conservando el signo

 Call DumpRegs
 Call WriteBin

;4 SAR: DESPLAZAMIENTO CON SIGNO IMPAR
; Con numeros impares negativos -9 al dividir entre 2 y redondea hacia abajo
mov eax, 0
Mov al, -9
Sar al,1

 Call DumpRegs
 Call WriteBin

;5 CONTEO CONSTANTE: DESPLAZAR CON 2 POSICIONES 
; Puedes mover los bits más de una posición fija usando un numero directo
mov al, 00001100b
Shl al,2

 Call DumpRegs
 Call WriteBin

;6 CONTEO CON CL: UTILIZANDO REGISTRO 
; aqui si el numero de desplazamientos es variable lo guardas en el registro CL
mov al, 00001100b
Shl cl,2

 Shr al, cl

;7 ROR, ROL, RCR, RCL
   clc   ;Limpiamos el carry flag
   ;Aqui los bits que se salen por un extremo dan la vuelta y se meten por el otro lado
; ROL 
   mov al, 10000001b
   rol al, 1   ;el bit de la extrema izquierda da la vuelta y cae a la derecha
   Call DumpRegs
   Call WriteBin

   ; ROR 
   mov al, 10000001b
   ror al, 1        ;aqui bit de la extrema derecha da la vuelta y cae a la izquierda
    Call DumpRegs
   Call DumpRegs
   Call WriteBin

   ; RCL 
                   
   mov al, 10000001b
   rcl al, 1        ;aqui incluye la bandera carry en el caminito de rotacion
   Call DumpRegs
   Call WriteBin

   ; RCR 
   
   mov al, 10000001b
   rcr al, 1      ; aqui rota a la derecha metiendo el carry en el proceso
   Call DumpRegs
   Call WriteBin

	exit

main ENDP
END main