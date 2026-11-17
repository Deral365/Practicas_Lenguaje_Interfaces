INCLUDE Irvine32.inc

; ============================================================
; MACROS DE LA UNIDAD 3
; ============================================================

mEscribirMensaje MACRO mensaje
    push edx
    mov  edx, OFFSET mensaje
    call WriteString
    pop  edx
ENDM

; Constantes
MAX_PROD        EQU 10
MAX_EXIST       EQU 100
PRECIO_MAX      EQU 999999                  ; 9999.99 MXN en centavos
REC_SIZE        EQU 44
P_COD           EQU 0                       ; IMPORTANTE: debe ser 0
P_NOM           EQU 8
P_PRE           EQU 36
P_EXI           EQU 40
HDR_SIZE        EQU 8
MAGIC_ARCH      EQU 31564E49h               ; "INV1" en little-endian
BUF_ARCH_CAP    EQU HDR_SIZE + MAX_PROD * REC_SIZE + 1
DESC_MIN_QTY    EQU 5                       ; unidades minimas para descuento
DESC_PORC       EQU 10                      ; porcentaje de descuento
LONG_ENTRADA    EQU 80                      ; maximo de caracteres leidos

.data
    msgTitulo           BYTE 0Dh, 0Ah, "TIENDA DE PLAYERAS - INVENTARIO Y VENTAS (MODULARIZADO)", 0Dh, 0Ah, 0

    msgMenuPpal         BYTE 0Dh, 0Ah, "---------- MENU PRINCIPAL ----------", 0Dh, 0Ah
                        BYTE "1. Registrar y Consultar Playeras", 0Dh, 0Ah
                        BYTE "2. Recibir Mercancia", 0Dh, 0Ah
                        BYTE "3. Vender", 0Dh, 0Ah
                        BYTE "4. Mostrar Resumen", 0Dh, 0Ah
                        BYTE "5. Guardar Datos", 0Dh, 0Ah
                        BYTE "6. Cargar Datos", 0Dh, 0Ah
                        BYTE "7. Regla del Negocio: Descuento por Cantidad", 0Dh, 0Ah
                        BYTE "0. Salir", 0Dh, 0Ah
                        BYTE "Seleccione una opcion: ", 0

    msgMenuReg          BYTE 0Dh, 0Ah, "---------- REGISTRO Y CONSULTA ----------", 0Dh, 0Ah
                        BYTE "1. Registrar Nueva Playera", 0Dh, 0Ah
                        BYTE "2. Mostrar Inventario Completo", 0Dh, 0Ah
                        BYTE "3. Buscar Playera por Codigo", 0Dh, 0Ah
                        BYTE "4. Volver al Menu Principal", 0Dh, 0Ah
                        BYTE "Seleccione una opcion: ", 0

    msgMenuRes          BYTE 0Dh, 0Ah, "---------- RESUMEN DEL NEGOCIO ----------", 0Dh, 0Ah
                        BYTE "1. Mostrar Unidades Disponibles", 0Dh, 0Ah
                        BYTE "2. Mostrar Valor Total del Inventario", 0Dh, 0Ah
                        BYTE "3. Mostrar Ingresos Acumulados de la Sesion", 0Dh, 0Ah
                        BYTE "4. Volver al Menu Principal", 0Dh, 0Ah
                        BYTE "Seleccione una opcion: ", 0

    msgOpInvalida       BYTE 0Dh, 0Ah, "Opcion no valida. Intente de nuevo.", 0Dh, 0Ah, 0

    msgPedirCodigoReg   BYTE 0Dh, 0Ah, "Codigo (ej. HPC-051; Enter vacio cancela): ", 0
    msgPedirCodigo      BYTE 0Dh, 0Ah, "Codigo del producto (ej. HPC-051): ", 0
    msgErrCodigo        BYTE "Error: codigo invalido. Formato: sexo H/M/U, diseno P/E, talla C/M/G, guion, 2 digitos de ID y tela 1=poliester o 2=algodon.", 0Dh, 0Ah, 0
    msgErrDuplicado     BYTE "Error: ese codigo ya existe en el inventario.", 0Dh, 0Ah, 0
    msgPedirNombre      BYTE "Nombre (1 a 25 caracteres): ", 0
    msgErrNombre        BYTE "Error: el nombre debe tener de 1 a 25 caracteres.", 0Dh, 0Ah, 0
    msgPedirPrecio      BYTE "Precio en MXN (0.01 a 9999.99, ej. 185.50): ", 0
    msgErrPrecio        BYTE "Error: precio invalido.", 0Dh, 0Ah, 0
    msgPedirExist       BYTE "Existencia inicial (0 a 100): ", 0
    msgErrExist         BYTE "Error: la existencia debe ser de 0 a 100.", 0Dh, 0Ah, 0
    msgRegOk            BYTE 0Dh, 0Ah, "Playera registrada correctamente.", 0Dh, 0Ah, 0
    msgLleno            BYTE 0Dh, 0Ah, "Error: catalogo lleno (maximo 10 productos).", 0Dh, 0Ah, 0
    msgVacio            BYTE 0Dh, 0Ah, "No hay playeras registradas.", 0Dh, 0Ah, 0
    msgNoExiste         BYTE "Error: no existe ninguna playera con ese codigo.", 0Dh, 0Ah, 0

    msgLinea            BYTE 0Dh, 0Ah, "----------------------------------------", 0Dh, 0Ah, 0
    lblCodigo           BYTE "Codigo:     ", 0
    lblNombre           BYTE "Nombre:     ", 0
    lblPrecio           BYTE "Precio:     ", 0
    lblExist            BYTE "Existencia: ", 0

    msgPedirCantRec     BYTE "Cantidad a recibir (entero mayor que 0): ", 0
    msgPedirCantVen     BYTE "Cantidad a vender (entero mayor que 0): ", 0
    msgPedirCantSim     BYTE "Cantidad a simular (1 a 100): ", 0
    msgErrCantidad      BYTE "Error: cantidad invalida.", 0Dh, 0Ah, 0
    msgErrCantSim       BYTE "Error: la cantidad debe ser de 1 a 100.", 0Dh, 0Ah, 0
    msgExcede           BYTE "Error: la existencia total no puede exceder 100 unidades.", 0Dh, 0Ah, 0
    msgRecibidoOk       BYTE 0Dh, 0Ah, "Mercancia recibida. Nueva existencia: ", 0
    msgSinExist         BYTE "Error: existencias insuficientes. Disponibles: ", 0
    msgDesbordamiento   BYTE "Error: desbordamiento en el calculo.", 0Dh, 0Ah, 0
    msgVentaOk          BYTE 0Dh, 0Ah, "Venta registrada correctamente.", 0Dh, 0Ah, 0
    msgTicket           BYTE 0Dh, 0Ah, "------------ DETALLE DE IMPORTE ------------", 0Dh, 0Ah, 0
    msgImpBase          BYTE "Importe base:                 ", 0
    msgImpDesc          BYTE "Descuento por cantidad (10%): -", 0
    msgSinDesc          BYTE "Descuento por cantidad: NO APLICA", 0Dh, 0Ah, 0
    msgImpFinal         BYTE "Importe final:                ", 0

    msgReglaTexto       BYTE 0Dh, 0Ah, "========== REGLA: DESCUENTO POR CANTIDAD ==========", 0Dh, 0Ah, 0
    msgUnidades         BYTE 0Dh, 0Ah, "Unidades disponibles: ", 0
    msgValorInv         BYTE 0Dh, 0Ah, "Valor total del inventario: ", 0
    msgIngresos         BYTE 0Dh, 0Ah, "Ingresos acumulados de la sesion: ", 0

    msgGuardadoOk       BYTE 0Dh, 0Ah, "Datos guardados correctamente en 'inventario.txt'.", 0Dh, 0Ah, 0
    msgErrorArchivo     BYTE 0Dh, 0Ah, "Error al guardar el archivo de datos.", 0Dh, 0Ah, 0
    msgCargado          BYTE 0Dh, 0Ah, "Catalogo cargado desde 'inventario.txt'. Productos: ", 0
    msgProductosFin     BYTE 0Dh, 0Ah, 0
    msgArchNoExiste     BYTE 0Dh, 0Ah, "No se encontro 'inventario.txt'.", 0Dh, 0Ah, 0
    msgArchLectura      BYTE 0Dh, 0Ah, "Error de lectura del archivo.", 0Dh, 0Ah, 0
    msgArchInvalido     BYTE 0Dh, 0Ah, "El archivo es invalido o esta danado.", 0Dh, 0Ah, 0
    msgPerderCambios    BYTE 0Dh, 0Ah, "Hay cambios sin guardar. Continuar? (S/N): ", 0
    msgCambiosSalir     BYTE 0Dh, 0Ah, "S = guardar y salir, N = salir sin guardar, otra = cancelar: ", 0
    msgDespedida        BYTE 0Dh, 0Ah, "Saliendo del sistema... Gracias!", 0Dh, 0Ah, 0

    txtPunto            BYTE ".", 0
    txtCero             BYTE "0", 0
    txtMXN              BYTE " MXN", 0
    txtCrlf             BYTE 0Dh, 0Ah, 0

    totalProd           DWORD 0
    catalogo            BYTE MAX_PROD * REC_SIZE DUP(0)
    ingresosSesion      DWORD 0
    cambiosPend         DWORD 0

    bufEntrada          BYTE LONG_ENTRADA + 1 DUP(0)
    bufNum              BYTE 11 DUP(0)
    valorNum            DWORD 0
    ptrReg              DWORD 0
    cantTmp             DWORD 0
    impBase             DWORD 0
    impDesc             DWORD 0
    impFinal            DWORD 0

    nombreArchivo       BYTE "inventario.txt", 0
    fileHandle          HANDLE ?
    bytesArch           DWORD 0
    bytesLeidos         DWORD 0
    cntArch             DWORD 0
    bufArchivo          BYTE BUF_ARCH_CAP + 1 DUP(0)

.code
main PROC
    mEscribirMensaje msgTitulo
    call CargarCatalogo
    call MostrarResultadoCarga

MenuPrincipal:
    mEscribirMensaje msgMenuPpal
    call LeerOpcion

    cmp  eax, 1
    je   Op1
    cmp  eax, 2
    je   Op2
    cmp  eax, 3
    je   Op3
    cmp  eax, 4
    je   Op4
    cmp  eax, 5
    je   Op5
    cmp  eax, 6
    je   Op6
    cmp  eax, 7
    je   Op7
    cmp  eax, 0
    je   Op0

    mEscribirMensaje msgOpInvalida
    jmp  MenuPrincipal

Op1:
    call MenuRegistro
    jmp  MenuPrincipal
Op2:
    call RecibirMercancia
    jmp  MenuPrincipal
Op3:
    call VenderProducto
    jmp  MenuPrincipal
Op4:
    call MenuResumen
    jmp  MenuPrincipal
Op5:
    call GuardarCatalogo
    cmp  eax, 0
    jne  Op5Error
    mEscribirMensaje msgGuardadoOk
    jmp  MenuPrincipal
Op5Error:
    mEscribirMensaje msgErrorArchivo
    jmp  MenuPrincipal
Op6:
    cmp  cambiosPend, 0
    je   Op6Cargar
    mEscribirMensaje msgPerderCambios
    call PreguntaSN
    cmp  eax, 0
    je   MenuPrincipal
Op6Cargar:
    call CargarCatalogo
    call MostrarResultadoCarga
    jmp  MenuPrincipal
Op7:
    call ReglaDescuento
    jmp  MenuPrincipal
Op0:
    call ConfirmarSalida
    cmp  eax, 1
    jne  MenuPrincipal
    mEscribirMensaje msgDespedida
    exit
main ENDP


; ============================================================
; PROCEDIMIENTOS CON USES Y DOCUMENTACION
; ============================================================

SaltoLinea PROC USES edx
    mov  edx, OFFSET txtCrlf
    call WriteString
    ret
SaltoLinea ENDP

LeerCadena PROC USES ecx edx
    mov  edx, OFFSET bufEntrada
    mov  ecx, LONG_ENTRADA
    call ReadString
    ret
LeerCadena ENDP

LeerOpcion PROC USES esi
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearEntero
    cmp  eax, 0
    jne  LO_Mal
    mov  eax, valorNum
    jmp  LO_Fin
LO_Mal:
    mov  eax, -1
LO_Fin:
    ret
LeerOpcion ENDP

ParsearEntero PROC USES ebx ecx edx esi
    xor  eax, eax
    xor  ecx, ecx
    xor  ebx, ebx
PE_Loop:
    mov  bl, [esi]
    cmp  bl, 0
    je   PE_Fin
    cmp  bl, '0'
    jb   PE_Error
    cmp  bl, '9'
    ja   PE_Error
    sub  bl, '0'
    mov  edx, 10
    mul  edx
    jc   PE_Error
    add  eax, ebx
    jc   PE_Error
    inc  ecx
    inc  esi
    jmp  PE_Loop
PE_Fin:
    cmp  ecx, 0
    je   PE_Error
    mov  valorNum, eax
    xor  eax, eax
    jmp  PE_Salir
PE_Error:
    mov  eax, 1
PE_Salir:
    ret
ParsearEntero ENDP

ParsearPrecio PROC USES ebx ecx edx esi edi
    xor  eax, eax
    xor  ecx, ecx
    xor  ebx, ebx
PP_Pesos:
    mov  bl, [esi]
    cmp  bl, 0
    je   PP_SoloPesos
    cmp  bl, '.'
    je   PP_Punto
    cmp  bl, '0'
    jb   PP_Error
    cmp  bl, '9'
    ja   PP_Error
    sub  bl, '0'
    mov  edx, 10
    mul  edx
    add  eax, ebx
    cmp  eax, 9999
    ja   PP_Error
    inc  ecx
    inc  esi
    jmp  PP_Pesos

PP_SoloPesos:
    cmp  ecx, 0
    je   PP_Error
    mov  edx, 100
    mul  edx
    jmp  PP_Rango

PP_Punto:
    cmp  ecx, 0
    je   PP_Error
    mov  edx, 100
    mul  edx
    mov  edi, eax
    inc  esi
    xor  ebx, ebx
    mov  bl, [esi]
    cmp  bl, '0'
    jb   PP_Error
    cmp  bl, '9'
    ja   PP_Error
    sub  bl, '0'
    mov  eax, ebx
    mov  edx, 10
    mul  edx
    add  edi, eax
    inc  esi
    mov  bl, [esi]
    cmp  bl, 0
    je   PP_Sumar
    cmp  bl, '0'
    jb   PP_Error
    cmp  bl, '9'
    ja   PP_Error
    sub  bl, '0'
    add  edi, ebx
    inc  esi
    cmp  BYTE PTR [esi], 0
    jne  PP_Error
PP_Sumar:
    mov  eax, edi

PP_Rango:
    cmp  eax, 1
    jb   PP_Error
    cmp  eax, PRECIO_MAX
    ja   PP_Error
    mov  valorNum, eax
    xor  eax, eax
    jmp  PP_Fin
PP_Error:
    mov  eax, 1
PP_Fin:
    ret
ParsearPrecio ENDP

convertirDecimal PROC USES eax ebx ecx edx esi
    mov  ebx, 10
    xor  ecx, ecx
CD_Div:
    xor  edx, edx
    div  ebx
    push edx
    inc  ecx
    cmp  eax, 0
    jne  CD_Div
CD_Escribe:
    pop  edx
    add  dl, '0'
    mov  [esi], dl
    inc  esi
    loop CD_Escribe
    mov  BYTE PTR [esi], 0
    ret
convertirDecimal ENDP

MostrarEntero PROC USES edx esi
    mov  esi, OFFSET bufNum
    call convertirDecimal
    mov  edx, OFFSET bufNum
    call WriteString
    ret
MostrarEntero ENDP

MostrarMXN PROC USES eax ebx edx esi
    xor  edx, edx
    mov  ebx, 100
    div  ebx
    push edx
    mov  esi, OFFSET bufNum
    call convertirDecimal
    mov  edx, OFFSET bufNum
    call WriteString
    mov  edx, OFFSET txtPunto
    call WriteString
    pop  eax
    cmp  eax, 10
    jae  MM_Dos
    mov  edx, OFFSET txtCero
    call WriteString
MM_Dos:
    mov  esi, OFFSET bufNum
    call convertirDecimal
    mov  edx, OFFSET bufNum
    call WriteString
    mov  edx, OFFSET txtMXN
    call WriteString
    ret
MostrarMXN ENDP

ConvertirMayusculas PROC USES esi eax
CM_Loop:
    mov  al, [esi]
    cmp  al, 0
    je   CM_Fin
    cmp  al, 'a'
    jb   CM_Sig
    cmp  al, 'z'
    ja   CM_Sig
    sub  al, 32
    mov  [esi], al
CM_Sig:
    inc  esi
    jmp  CM_Loop
CM_Fin:
    ret
ConvertirMayusculas ENDP

CopiarCadena PROC USES esi edi eax
CCo_Loop:
    mov  al, [esi]
    mov  [edi], al
    inc  esi
    inc  edi
    cmp  al, 0
    jne  CCo_Loop
    ret
CopiarCadena ENDP

CompararCadenas PROC USES ebx esi edi
CCad_Loop:
    mov  bl, [esi]
    mov  bh, [edi]
    cmp  bl, bh
    jne  CCad_Dist
    cmp  bl, 0
    je   CCad_Igual
    inc  esi
    inc  edi
    jmp  CCad_Loop
CCad_Igual:
    xor  eax, eax
    jmp  CCad_Fin
CCad_Dist:
    mov  eax, 1
CCad_Fin:
    ret
CompararCadenas ENDP

PreguntaSN PROC USES esi
    call WriteString
    call LeerCadena
    cmp  eax, 1
    jne  PS_No
    mov  esi, OFFSET bufEntrada
    call ConvertirMayusculas
    cmp  BYTE PTR bufEntrada, 'S'
    jne  PS_No
    mov  eax, 1
    jmp  PS_Fin
PS_No:
    xor  eax, eax
PS_Fin:
    ret
PreguntaSN ENDP

ValidarCodigo PROC USES ecx esi
    mov  al, [esi]
    cmp  al, 'H'
    je   VC_Diseno
    cmp  al, 'M'
    je   VC_Diseno
    cmp  al, 'U'
    je   VC_Diseno
    jmp  VC_Mal

VC_Diseno:
    inc  esi
    mov  al, [esi]
    cmp  al, 'P'
    je   VC_Talla
    cmp  al, 'E'
    je   VC_Talla
    jmp  VC_Mal

VC_Talla:
    inc  esi
    mov  al, [esi]
    cmp  al, 'C'
    je   VC_Guion
    cmp  al, 'M'
    je   VC_Guion
    cmp  al, 'G'
    je   VC_Guion
    jmp  VC_Mal

VC_Guion:
    inc  esi
    cmp  BYTE PTR [esi], '-'
    jne  VC_Mal
    mov  ecx, 2
VC_Digitos:
    inc  esi
    mov  al, [esi]
    cmp  al, '0'
    jb   VC_Mal
    cmp  al, '9'
    ja   VC_Mal
    loop VC_Digitos

    inc  esi
    mov  al, [esi]
    cmp  al, '1'
    je   VC_Fin7
    cmp  al, '2'
    je   VC_Fin7
    jmp  VC_Mal

VC_Fin7:
    inc  esi
    cmp  BYTE PTR [esi], 0
    jne  VC_Mal
    xor  eax, eax
    jmp  VC_Fin
VC_Mal:
    mov  eax, 1
VC_Fin:
    ret
ValidarCodigo ENDP

DirRegistro PROC USES ebx edx
    mov  ebx, REC_SIZE
    mul  ebx
    add  eax, OFFSET catalogo
    mov  esi, eax
    ret
DirRegistro ENDP

BuscarProducto PROC USES ecx esi
    mov  ecx, totalProd
    mov  esi, OFFSET catalogo
    cmp  ecx, 0
    je   BP_NoEnc
BP_Reg:
    call CompararCadenas
    cmp  eax, 0
    je   BP_Enc
    add  esi, REC_SIZE
    loop BP_Reg
BP_NoEnc:
    mov  eax, 1
    jmp  BP_Fin
BP_Enc:
    xor  eax, eax
BP_Fin:
    ret
BuscarProducto ENDP

PedirProductoExistente PROC USES edx esi edi
    mEscribirMensaje msgPedirCodigo
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ConvertirMayusculas
    call ValidarCodigo
    cmp  eax, 0
    jne  PPE_Mal
    mov  edi, OFFSET bufEntrada
    call BuscarProducto
    cmp  eax, 0
    jne  PPE_NoExiste
    ret
PPE_Mal:
    mEscribirMensaje msgErrCodigo
    mov  eax, 1
    ret
PPE_NoExiste:
    mEscribirMensaje msgNoExiste
    mov  eax, 1
    ret
PedirProductoExistente ENDP

ValidarRegistro PROC USES ebx ecx esi edi
    call ValidarCodigo
    cmp  eax, 0
    jne  VR_Mal
    mov  edi, esi
    add  edi, P_NOM
    cmp  BYTE PTR [edi], 0
    je   VR_Mal
    mov  ecx, 26
VR_Nom:
    cmp  BYTE PTR [edi], 0
    je   VR_NomOk
    inc  edi
    loop VR_Nom
    jmp  VR_Mal
VR_NomOk:
    mov  ebx, [esi+P_PRE]
    cmp  ebx, 1
    jb   VR_Mal
    cmp  ebx, PRECIO_MAX
    ja   VR_Mal
    mov  ebx, [esi+P_EXI]
    cmp  ebx, MAX_EXIST
    ja   VR_Mal
    xor  eax, eax
    jmp  VR_Fin
VR_Mal:
    mov  eax, 1
VR_Fin:
    ret
ValidarRegistro ENDP

MostrarProducto PROC USES eax edx esi
    mEscribirMensaje msgLinea
    mEscribirMensaje lblCodigo
    mov  edx, esi
    add  edx, P_COD
    call WriteString
    call SaltoLinea

    mEscribirMensaje lblNombre
    mov  edx, esi
    add  edx, P_NOM
    call WriteString
    call SaltoLinea

    mEscribirMensaje lblPrecio
    mov  eax, [esi+P_PRE]
    call MostrarMXN
    call SaltoLinea

    mEscribirMensaje lblExist
    mov  eax, [esi+P_EXI]
    call MostrarEntero
    call SaltoLinea
    ret
MostrarProducto ENDP

MostrarInventario PROC USES ecx edx esi
    cmp  totalProd, 0
    jne  MI_Hay
    mEscribirMensaje msgVacio
    jmp  MI_Fin
MI_Hay:
    mov  esi, OFFSET catalogo
    mov  ecx, totalProd
MI_Loop:
    call MostrarProducto
    add  esi, REC_SIZE
    loop MI_Loop
MI_Fin:
    ret
MostrarInventario ENDP

MostrarTicket PROC USES eax edx
    mEscribirMensaje msgTicket
    mEscribirMensaje msgImpBase
    mov  eax, impBase
    call MostrarMXN
    call SaltoLinea

    cmp  cantTmp, DESC_MIN_QTY
    jb   MT_SinDesc
    mEscribirMensaje msgImpDesc
    mov  eax, impDesc
    call MostrarMXN
    call SaltoLinea
    jmp  MT_Final
MT_SinDesc:
    mEscribirMensaje msgSinDesc
    jmp  MT_Final
MT_Final:
    mEscribirMensaje msgImpFinal
    mov  eax, impFinal
    call MostrarMXN
    call SaltoLinea
    ret
MostrarTicket ENDP

MostrarResultadoCarga PROC USES eax edx
    cmp  eax, 0
    je   MRC_Ok
    cmp  eax, 1
    je   MRC_NoExiste
    cmp  eax, 2
    je   MRC_Lectura
    mov  edx, OFFSET msgArchInvalido
    jmp  MRC_Imprimir
MRC_Ok:
    mEscribirMensaje msgCargado
    mov  eax, totalProd
    call MostrarEntero
    mEscribirMensaje msgProductosFin
    ret
MRC_NoExiste:
    mov  edx, OFFSET msgArchNoExiste
    jmp  MRC_Imprimir
MRC_Lectura:
    mov  edx, OFFSET msgArchLectura
MRC_Imprimir:
    call WriteString
    ret
MostrarResultadoCarga ENDP

MenuRegistro PROC USES eax edx
MR_Loop:
    mEscribirMensaje msgMenuReg
    call LeerOpcion
    cmp  eax, 1
    je   MR_Reg
    cmp  eax, 2
    je   MR_Todas
    cmp  eax, 3
    je   MR_Buscar
    cmp  eax, 4
    je   MR_Fin
    mEscribirMensaje msgOpInvalida
    jmp  MR_Loop
MR_Reg:
    call RegistrarProducto
    jmp  MR_Loop
MR_Todas:
    call MostrarInventario
    jmp  MR_Loop
MR_Buscar:
    call BuscarPorCodigo
    jmp  MR_Loop
MR_Fin:
    ret
MenuRegistro ENDP

RegistrarProducto PROC USES eax ecx edx esi edi
    cmp  totalProd, MAX_PROD
    jb   RP_Codigo
    mEscribirMensaje msgLleno
    jmp  RP_Fin

RP_Codigo:
    mEscribirMensaje msgPedirCodigoReg
    call LeerCadena
    cmp  eax, 0
    je   RP_Fin
    mov  esi, OFFSET bufEntrada
    call ValidarCodigo
    cmp  eax, 0
    jne  RP_CodigoMal
    mov  edi, OFFSET bufEntrada
    call BuscarProducto
    cmp  eax, 0
    je   RP_Duplicado

    mov  eax, totalProd
    call DirRegistro
    mov  ptrReg, esi
    mov  edi, esi
    mov  ecx, REC_SIZE
RP_Limpia:
    mov  BYTE PTR [edi], 0
    inc  edi
    loop RP_Limpia
    mov  esi, OFFSET bufEntrada
    mov  edi, ptrReg
    add  edi, P_COD
    call CopiarCadena
    jmp  RP_Nombre

RP_CodigoMal:
    mEscribirMensaje msgErrCodigo
    jmp  RP_Codigo
RP_Duplicado:
    mEscribirMensaje msgErrDuplicado
    jmp  RP_Codigo

RP_Nombre:
    mEscribirMensaje msgPedirNombre
    call LeerCadena
    cmp  eax, 0
    je   RP_NombreMal
    cmp  eax, 25
    ja   RP_NombreMal
    mov  esi, OFFSET bufEntrada
    mov  edi, ptrReg
    add  edi, P_NOM
    call CopiarCadena
    jmp  RP_Precio
RP_NombreMal:
    mEscribirMensaje msgErrNombre
    jmp  RP_Nombre

RP_Precio:
    mEscribirMensaje msgPedirPrecio
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearPrecio
    cmp  eax, 0
    jne  RP_PrecioMal
    mov  eax, valorNum
    mov  edi, ptrReg
    mov  [edi+P_PRE], eax
    jmp  RP_Exist
RP_PrecioMal:
    mEscribirMensaje msgErrPrecio
    jmp  RP_Precio

RP_Exist:
    mEscribirMensaje msgPedirExist
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearEntero
    cmp  eax, 0
    jne  RP_ExistMal
    mov  eax, valorNum
    cmp  eax, MAX_EXIST
    ja   RP_ExistMal
    mov  edi, ptrReg
    mov  [edi+P_EXI], eax
    jmp  RP_Confirmar
RP_ExistMal:
    mEscribirMensaje msgErrExist
    jmp  RP_Exist

RP_Confirmar:
    inc  totalProd
    mov  cambiosPend, 1
    mEscribirMensaje msgRegOk
RP_Fin:
    ret
RegistrarProducto ENDP

BuscarPorCodigo PROC USES eax edx esi edi
    cmp  totalProd, 0
    jne  BC_Hay
    mEscribirMensaje msgVacio
    jmp  BC_Fin
BC_Hay:
    call PedirProductoExistente
    cmp  eax, 0
    jne  BC_Fin
    call MostrarProducto
BC_Fin:
    ret
BuscarPorCodigo ENDP

RecibirMercancia PROC USES eax ebx edx esi edi
    cmp  totalProd, 0
    jne  RM_Hay
    mEscribirMensaje msgVacio
    jmp  RM_Fin
RM_Hay:
    call PedirProductoExistente
    cmp  eax, 0
    jne  RM_Fin
    mov  ptrReg, esi

    mEscribirMensaje msgPedirCantRec
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearEntero
    cmp  eax, 0
    jne  RM_CantMal
    mov  eax, valorNum
    cmp  eax, 0
    je   RM_CantMal

    mov  esi, ptrReg
    mov  ebx, [esi+P_EXI]
    add  ebx, eax
    jc   RM_Exceso
    cmp  ebx, MAX_EXIST
    ja   RM_Exceso
    mov  [esi+P_EXI], ebx
    mov  cambiosPend, 1
    mEscribirMensaje msgRecibidoOk
    mov  eax, ebx
    call MostrarEntero
    call SaltoLinea
    jmp  RM_Fin

RM_CantMal:
    mEscribirMensaje msgErrCantidad
    jmp  RM_Fin
RM_Exceso:
    mEscribirMensaje msgExcede
RM_Fin:
    ret
RecibirMercancia ENDP

CalcularImporte PROC USES ecx edx
    mul  ebx
    jc   CI_Desb
    mov  impBase, eax
    xor  ecx, ecx
    cmp  ebx, DESC_MIN_QTY
    jb   CI_SinDesc
    mov  edx, DESC_PORC
    mul  edx
    jc   CI_Desb
    xor  edx, edx
    mov  ecx, 100
    div  ecx
    mov  ecx, eax
CI_SinDesc:
    mov  impDesc, ecx
    mov  eax, impBase
    sub  eax, ecx
    mov  impFinal, eax
    xor  eax, eax
    jmp  CI_Fin
CI_Desb:
    mov  eax, 1
CI_Fin:
    ret
CalcularImporte ENDP

VenderProducto PROC USES eax ebx edx esi edi
    cmp  totalProd, 0
    jne  VP_Hay
    mEscribirMensaje msgVacio
    jmp  VP_Fin
VP_Hay:
    call PedirProductoExistente
    cmp  eax, 0
    jne  VP_Fin
    mov  ptrReg, esi
    call MostrarProducto

    mEscribirMensaje msgPedirCantVen
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearEntero
    cmp  eax, 0
    jne  VP_CantMal
    mov  eax, valorNum
    cmp  eax, 0
    je   VP_CantMal

    mov  esi, ptrReg
    cmp  eax, [esi+P_EXI]
    ja   VP_SinExist
    mov  cantTmp, eax
    mov  ebx, eax
    mov  eax, [esi+P_PRE]
    call CalcularImporte
    cmp  eax, 0
    jne  VP_Desb

    mov  eax, ingresosSesion
    add  eax, impFinal
    jc   VP_Desb

    mov  ingresosSesion, eax
    mov  esi, ptrReg
    mov  eax, cantTmp
    sub  [esi+P_EXI], eax
    mov  cambiosPend, 1

    mEscribirMensaje msgVentaOk
    call MostrarTicket
    jmp  VP_Fin

VP_CantMal:
    mEscribirMensaje msgErrCantidad
    jmp  VP_Fin
VP_SinExist:
    mEscribirMensaje msgSinExist
    mov  eax, [esi+P_EXI]
    call MostrarEntero
    call SaltoLinea
    jmp  VP_Fin
VP_Desb:
    mEscribirMensaje msgDesbordamiento
VP_Fin:
    ret
VenderProducto ENDP

ReglaDescuento PROC USES eax ebx edx esi edi
    mEscribirMensaje msgReglaTexto
    cmp  totalProd, 0
    jne  RD_Hay
    mEscribirMensaje msgVacio
    jmp  RD_Fin
RD_Hay:
    call PedirProductoExistente
    cmp  eax, 0
    jne  RD_Fin
    mov  ptrReg, esi

    mEscribirMensaje msgPedirCantSim
    call LeerCadena
    mov  esi, OFFSET bufEntrada
    call ParsearEntero
    cmp  eax, 0
    jne  RD_CantMal
    mov  eax, valorNum
    cmp  eax, 0
    je   RD_CantMal
    cmp  eax, MAX_EXIST
    ja   RD_CantMal

    mov  cantTmp, eax
    mov  ebx, eax
    mov  esi, ptrReg
    mov  eax, [esi+P_PRE]
    call CalcularImporte
    cmp  eax, 0
    jne  RD_Desb
    call MostrarTicket
    jmp  RD_Fin

RD_CantMal:
    mEscribirMensaje msgErrCantSim
    jmp  RD_Fin
RD_Desb:
    mEscribirMensaje msgDesbordamiento
RD_Fin:
    ret
ReglaDescuento ENDP

CalcularUnidades PROC USES ecx esi
    xor  eax, eax
    mov  ecx, totalProd
    cmp  ecx, 0
    je   CU_Fin
    mov  esi, OFFSET catalogo
CU_Loop:
    add  eax, [esi+P_EXI]
    add  esi, REC_SIZE
    loop CU_Loop
CU_Fin:
    ret
CalcularUnidades ENDP

CalcularValorInv PROC USES ebx ecx edx esi
    xor  ebx, ebx
    mov  ecx, totalProd
    cmp  ecx, 0
    je   CV_Ok
    mov  esi, OFFSET catalogo
CV_Loop:
    mov  eax, [esi+P_PRE]
    mul  DWORD PTR [esi+P_EXI]
    jc   CV_Desb
    add  ebx, eax
    jc   CV_Desb
    add  esi, REC_SIZE
    loop CV_Loop
CV_Ok:
    mov  valorNum, ebx
    xor  eax, eax
    jmp  CV_Fin
CV_Desb:
    mov  eax, 1
CV_Fin:
    ret
CalcularValorInv ENDP

MenuResumen PROC USES eax edx
MRes_Loop:
    mEscribirMensaje msgMenuRes
    call LeerOpcion
    cmp  eax, 1
    je   MRes_Unid
    cmp  eax, 2
    je   MRes_Valor
    cmp  eax, 3
    je   MRes_Ingr
    cmp  eax, 4
    je   MRes_Fin
    mEscribirMensaje msgOpInvalida
    jmp  MRes_Loop
MRes_Unid:
    mEscribirMensaje msgUnidades
    call CalcularUnidades
    call MostrarEntero
    call SaltoLinea
    jmp  MRes_Loop
MRes_Valor:
    mEscribirMensaje msgValorInv
    call CalcularValorInv
    cmp  eax, 0
    jne  MRes_Desb
    mov  eax, valorNum
    call MostrarMXN
    call SaltoLinea
    jmp  MRes_Loop
MRes_Desb:
    mEscribirMensaje msgDesbordamiento
    jmp  MRes_Loop
MRes_Ingr:
    mEscribirMensaje msgIngresos
    mov  eax, ingresosSesion
    call MostrarMXN
    call SaltoLinea
    jmp  MRes_Loop
MRes_Fin:
    ret
MenuResumen ENDP

GuardarCatalogo PROC USES ebx ecx edx esi edi
    mov  DWORD PTR bufArchivo, MAGIC_ARCH
    mov  eax, totalProd
    mov  DWORD PTR bufArchivo[4], eax
    mov  ebx, REC_SIZE
    mul  ebx
    mov  ecx, eax
    add  eax, HDR_SIZE
    mov  bytesArch, eax
    cmp  ecx, 0
    je   GA_Crear
    mov  esi, OFFSET catalogo
    mov  edi, OFFSET bufArchivo + HDR_SIZE
GA_Copia:
    mov  al, [esi]
    mov  [edi], al
    inc  esi
    inc  edi
    loop GA_Copia

GA_Crear:
    mov  edx, OFFSET nombreArchivo
    call CreateOutputFile
    cmp  eax, INVALID_HANDLE_VALUE
    je   GA_Error
    mov  fileHandle, eax

    mov  eax, fileHandle
    mov  edx, OFFSET bufArchivo
    mov  ecx, bytesArch
    call WriteToFile
    jc   GA_ErrorCierra
    cmp  eax, bytesArch
    jne  GA_ErrorCierra

    mov  eax, fileHandle
    call CloseFile
    cmp  eax, 0
    je   GA_Error
    mov  cambiosPend, 0
    xor  eax, eax
    jmp  GA_Salir

GA_ErrorCierra:
    mov  eax, fileHandle
    call CloseFile
GA_Error:
    mov  eax, 1
GA_Salir:
    ret
GuardarCatalogo ENDP

CargarCatalogo PROC USES ebx ecx edx esi edi
    mov  edx, OFFSET nombreArchivo
    call OpenInputFile
    cmp  eax, INVALID_HANDLE_VALUE
    je   CG_NoExiste
    mov  fileHandle, eax

    mov  eax, fileHandle
    mov  edx, OFFSET bufArchivo
    mov  ecx, BUF_ARCH_CAP
    call ReadFromFile
    jc   CG_ErrLectura
    mov  bytesLeidos, eax
    mov  eax, fileHandle
    call CloseFile

    cmp  bytesLeidos, HDR_SIZE
    jb   CG_Invalido
    cmp  DWORD PTR bufArchivo, MAGIC_ARCH
    jne  CG_Invalido
    mov  ebx, DWORD PTR bufArchivo[4]
    cmp  ebx, MAX_PROD
    ja   CG_Invalido
    mov  cntArch, ebx
    mov  eax, ebx
    mov  ecx, REC_SIZE
    mul  ecx
    add  eax, HDR_SIZE
    cmp  eax, bytesLeidos
    jne  CG_Invalido

    mov  esi, OFFSET bufArchivo + HDR_SIZE
    xor  ebx, ebx
CG_Val:
    cmp  ebx, cntArch
    jae  CG_ValDup
    call ValidarRegistro
    cmp  eax, 0
    jne  CG_Invalido
    add  esi, REC_SIZE
    inc  ebx
    jmp  CG_Val

CG_ValDup:
    mov  esi, OFFSET bufArchivo + HDR_SIZE
    xor  ebx, ebx
CG_I:
    mov  edx, ebx
    inc  edx
    cmp  edx, cntArch
    jae  CG_Aplicar
    mov  edi, esi
    add  edi, REC_SIZE
CG_J:
    cmp  edx, cntArch
    jae  CG_NextI
    call CompararCadenas
    cmp  eax, 0
    je   CG_Invalido
    add  edi, REC_SIZE
    inc  edx
    jmp  CG_J
CG_NextI:
    add  esi, REC_SIZE
    inc  ebx
    jmp  CG_I

CG_Aplicar:
    mov  edi, OFFSET catalogo
    mov  ecx, MAX_PROD * REC_SIZE
CG_Limpia:
    mov  BYTE PTR [edi], 0
    inc  edi
    loop CG_Limpia
    mov  eax, cntArch
    mov  ecx, REC_SIZE
    mul  ecx
    mov  ecx, eax
    cmp  ecx, 0
    je   CG_Listo
    mov  esi, OFFSET bufArchivo + HDR_SIZE
    mov  edi, OFFSET catalogo
CG_Copia:
    mov  al, [esi]
    mov  [edi], al
    inc  esi
    inc  edi
    loop CG_Copia
CG_Listo:
    mov  eax, cntArch
    mov  totalProd, eax
    mov  cambiosPend, 0
    xor  eax, eax
    jmp  CG_Salir

CG_ErrLectura:
    mov  eax, fileHandle
    call CloseFile
    mov  eax, 2
    jmp  CG_Salir
CG_NoExiste:
    mov  eax, 1
    jmp  CG_Salir
CG_Invalido:
    mov  eax, 3
CG_Salir:
    ret
CargarCatalogo ENDP

ConfirmarSalida PROC USES edx esi
    cmp  cambiosPend, 0
    je   CSa_Si
    mEscribirMensaje msgCambiosSalir
    call LeerCadena
    cmp  eax, 1
    jne  CSa_No
    mov  esi, OFFSET bufEntrada
    call ConvertirMayusculas
    cmp  BYTE PTR bufEntrada, 'S'
    je   CSa_Guardar
    cmp  BYTE PTR bufEntrada, 'N'
    je   CSa_Si
    jmp  CSa_No
CSa_Guardar:
    call GuardarCatalogo
    cmp  eax, 0
    je   CSa_GuardOk
    mEscribirMensaje msgErrorArchivo
    jmp  CSa_No
CSa_GuardOk:
    mEscribirMensaje msgGuardadoOk
CSa_Si:
    mov  eax, 1
    jmp  CSa_Fin
CSa_No:
    xor  eax, eax
CSa_Fin:
    ret
ConfirmarSalida ENDP

END main