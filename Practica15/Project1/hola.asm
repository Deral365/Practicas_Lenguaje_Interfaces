; Materia: Lenguajes de Interfaz 
; Alumno:Perez Rojas Angel Eduardo 
; Horario:10:00-11:00 
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 15
; Descripción:Se realiza el codigo en .asm usando Irvine32 donde se como se crea y se guarda un archivo usando varias funciones handle
INCLUDE Irvine32.inc

.data
;Aqui se declara lo que se va ocupar como el nombre del archivo y lo que ira dentro
    nombreArchivo   BYTE "archivo.txt", 0
    archivoHandle   HANDLE ?
    texto           BYTE "Hola mundo", 0
    mensajeExito    BYTE "Archivo guardado correctamente.", 0
    mensajeError    BYTE "No se pudo guardar el archivo", 0

.code
main PROC

    ; 1. Crear archivo txt.
    mov edx, OFFSET nombreArchivo   ; es la función de Irvine para crear o sobrescribir el archivo
    call CreateOutputFile

    ; aqui windows nos regresa un codigo especial en eax que puede ser el hanlde o error
    cmp eax, INVALID_HANDLE_VALUE
    je error

    mov archivoHandle, eax

    ; 2. Escribir caracteres en archivo txt.
    mov eax, archivoHandle     ; aqui juntamos el handle del archivo
    mov edx, OFFSET texto      ;apuntamos al texto que vamos a grabar
    mov ecx, SIZEOF texto - 1  ;aqui damos la longitud y quitando 1 que es el valor nulo
    call WriteToFile           ; mandamos la informacion a disco

    jc errorEscritura     

    cmp eax, SIZEOF texto - 1      ; checamos si se escribieron los bytes completos que pedimos
    jne errorEscritura             ; si faltaron bytes nos vamos al error

    ; 3. Cerrar archivo txt.
    mov eax, archivoHandle         
    call CloseFile             ;cerramos el archivo para que windows lo libere

    cmp eax, 0
    je error                   ;si falla nos vamos al error
    ;esto se imprime si salio todo bien
    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin

errorEscritura:
    mov eax, archivoHandle
    call CloseFile

error:
    mov edx, OFFSET mensajeError
    call WriteString

fin:
    exit

main ENDP
END main