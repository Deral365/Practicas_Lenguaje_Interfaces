; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo ; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 9
; Descripción:Se realiza el codigo en .asm usando Irvine32 donde se explica en diferentes bloques sobre como usar las pilas y que funciones utilizar para cada caso
;pero siempre usando el POP/PUSH y otras funciones como call y ret

INCLUDE Irvine32.inc

.data

.code
main PROC
;BLOQUE 1: PUSH Y POP
mov eax, 40           ;Se carga el número 40 en el registro eax.
push eax           ;el  PUSH guarda una copia de ese 40 en la Pila .


nop              ;es una instrucción de pausa

mov eax,0         ;se le asigna otro valor a eax
pop ebx           ;se saca el valor y se guarda en ebx ya que eax ahora tiene otro valor es como proteger ese valor
nop

;BLOQUE 2: ORDEN DE LIFO   En esta parte del codigo se muestra como se guardan en una pila y como deben de salir ya que su funciones que
;el ultimo en entrar es el primero en salir
mov eax, 10
push eax

mov eax, 20
push eax

mov eax, 30
push eax
nop

pop ebx
pop ebx
pop ebx

;BLOQUE 3: CONSERVAR REGISTROS ;En esta parte como se guardan dos valores temporalmente en la pila y son protegidos ya que de primera sus registros son 
;remplazados por otro valor

mov eax, 100
mov ebx, 200

push eax
push ebx

mov eax,999
mov ebx, 666

pop ebx
pop eax

nop

;BLOQUE 4:CALL Y RET   En esta parte ya se utiliza otra instruccion Call donde agarra la ultima direccion de retorno y la guarda en la pila para pasar a otro procedimiento
mov eax, 50
mov ebx,100

call aumentarDiez
nop             
exit

main ENDP 
;Aca ya esta el procedimiento donde se protege ebx usando PUSH/POP para preservar su valor original y se hace la operacion aritmetica
; y La instrucción RET extrae de la pila la dirección de memoria guardada y retorno donde se quedo que seria en el nop de arriba 
aumentarDiez PROC
push ebx

mov ebx,10
add eax,ebx

pop ebx

 ret 
 aumentarDiez ENDP
END main