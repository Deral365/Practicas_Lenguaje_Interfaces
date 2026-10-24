; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo ; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 11
; Descripción:Se realiza el codigo en .asm usando Irvine32 donde se desarrolan algunas operaciones logicas

INCLUDE Irvine32.inc
;Estados de computadora:
;0- Computdaora encendida
;1 - Alarma encendida
;2 - computadora conectada a internet.
;Estados : 0: Apagado, 1:Encendido

;Estado inicial:  0000 0101
.data
    msgAlarmaEncendida BYTE "Alarma encendida", 0
    msgAlarmaApagada   BYTE "Alarma apagada", 0
.code
main PROC
; Aquí usamos una mascara 00000010b para apagar todo lo demas 
; y ver que unicamente con el bit de la alarma el bit 1
 ;1 - operacion AND :Evaluacion de estado de alarma
  mov eax, 0
  mov al, 00000111b
  and al, 00000010b

  call WriteBin   ;Aca imprime en binario para ver el resultado en pantalla
  nop

  ;2- operacion de OR: Encender alarma
  ; Con OR  si ponemos un 1 en la mascara hacemos que ese bit se encienda 
   ;sin importar como estaba antes.
   mov eax, 0
   mov al, 00000101b
   or al, 00000010b      ;Forzamos a encender el bit 1 la alarma

   call WriteBin
   nop

   ;3 - operacion XOR: Apaguen y enciendan la computadora
   ;4 - Operacion TEST: Evaluar la alarma encendida y apagada
   ;Mandar mensaje de alarma encendida o alarma apagada
   ; 3 - Operación XOR: Apaguen y enciendan la computadora (alternar bits)
    ; Tomamos el estado inicial 00000101b y alternamos el bit 0 computadora encendida/apagada
    mov eax, 0
    mov al, 00000101b
    xor al, 00000001b      ;Aqui alterna el estado de la computadora
    call WriteBin
    call Crlf
    nop

    ; 4 - Operación TEST: Evaluar la alarma encendida y apagada
    ; TEST hace un AND invisible y revisa si el bit esta prendido
    ; Verificamos el bit 1 alarma usando la instrucción TEST sin modificar el registro
    mov al, 00000101b      ; Estado de ejemplo donde la alarma bit 1 es 0 apagada
    test al, 00000010b     ; Realiza un AND logico afectando solo a las banderas
    jz alarmaApagada       ; Si Zero Flag ZF es 1, significa que dio cero alarma apagada

    ; Si la bandera ZF = 0, la alarma está encendida
    mov edx, OFFSET msgAlarmaEncendida
    call WriteString
    call Crlf
    jmp continuar
    ;Aqui cae si el test detecto que la alarma estaba en ceros
    alarmaApagada:
    mov edx, OFFSET msgAlarmaApagada
    call WriteString
    call Crlf

    continuar:
    exit

main ENDP
END main