; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 8
; Descripción:Esto realiza el codigo en .asm usando Irvine32 donde se ejecutan diferentes instrucciones que realizan operaciones aritmeticas como suma,resta,division, multplicacion
;con y sin signo ambas o sumas o restas con acarreo como tambien negacion aritmetico


INCLUDE Irvine32.inc

.data
    msgSuma     BYTE "1. ADD : ", 0
    msgAdc      BYTE "2. ADC : ", 0
    msgResta    BYTE "3. SUB : ", 0
    msgSbb      BYTE "4. SBB : ", 0
    msgInc      BYTE "5. INC : ", 0
    msgDec      BYTE "6. DEC : ", 0
    msgNeg      BYTE "7. NEG : ", 0
    msgMul      BYTE "8. MUL : ", 0
    msgImul     BYTE "9. IMUL : ", 0
    msgDiv      BYTE "10. DIV : ", 0
    msgIdiv     BYTE "11. IDIV : ", 0

.code
main PROC
    
    ;  ADD - Suma
    mov eax, 30
    add eax, 10             ; EAX = 30 + 10 = 40
    mov edx, OFFSET msgSuma
    call WriteString
    call WriteDec
    call Crlf

    ;  ADC - Suma con acarreo
    mov eax, 100
    stc                     ; Se activa manualmente la bandera Carry 
    adc eax, 40             ; EAX = 100 + 40 + 1 = 141
    mov edx, OFFSET msgAdc
    call WriteString
    call WriteDec
    call Crlf

    ;  SUB - sirve para resta
    mov eax, 50
    sub eax, 10             ; EAX = 50 - 10 = 40
    mov edx, OFFSET msgResta
    call WriteString
    call WriteDec
    call Crlf

    ; SBB - Resta con préstamo
    mov eax, 90
    stc                     ; Se activa manualmente la bandera carry
    sbb eax, 30             ; EAX = 90 - 30 - 1 = 59
    mov edx, OFFSET msgSbb
    call WriteString
    call WriteDec
    call Crlf

    ; INC -  el incremento se utiliza para que sume de uno en uno 
    mov eax, 50
    inc eax                 ; EAX = 50 + 1 = 51
    mov edx, OFFSET msgInc
    call WriteString
    call WriteDec
    call Crlf

    ; DEC - Aqui es al reves se resta de uno en uno 
    mov eax, 10
    dec eax                 ; EAX = 10 - 1 = 9
    mov edx, OFFSET msgDec
    call WriteString
    call WriteDec
    call Crlf

    ;NEG - Negación aritmética su función principal es cambiar el signo de un número
    mov eax, 10
    neg eax                 ; EAX = 0 - 10 = -10
    mov edx, OFFSET msgNeg
    call WriteString
    call WriteInt           ;Se usa WriteInt para mostrar números negativos con signo
    call Crlf

    ;MUL - Multiplicación sin signo[cite: 61, 63]
    mov eax, 50
    mov ebx, 10
    mul ebx                 ; EDX:EAX = 50 * 10 = 500
    mov edx, OFFSET msgMul
    call WriteString
    call WriteDec
    call Crlf

    ;9. IMUL - Multiplicación con signo
    mov eax, -5
    mov ebx, 4
    imul ebx                ; EDX:EAX = -5 * 4 = -20
    mov edx, OFFSET msgImul
    call WriteString
    call WriteInt            ;Se utiliza igual Writeint para que aparezca el signo
    call Crlf

    ;DIV - División sin el signo
    mov eax, 50
    mov edx, 0              ; Limpiar EDX  antes de dividir ya que fue utilizado y queda basura y se ocupa para guardar el residuo
    mov ebx, 10
    div ebx                 ;Se indica donde se guarda EAX = Cociente 5, EDX = Residuo 0
    mov edx, OFFSET msgDiv
    call WriteString
    call WriteDec
    call Crlf

    ; IDIV - División con signo
    mov eax, -20            
    cdq                     ;Extiende el bit de signo de EAX hacia EDX como es con signo y pues sin usar eso seria otra bronca y no hay tiempo
    mov ebx, 4              
    idiv ebx                ;Se indica donde se guarda EAX = Cociente -5, EDX = Residuo 0
    mov edx, OFFSET msgIdiv
    call WriteString
    call WriteInt
    call Crlf

    exit
main ENDP
END main