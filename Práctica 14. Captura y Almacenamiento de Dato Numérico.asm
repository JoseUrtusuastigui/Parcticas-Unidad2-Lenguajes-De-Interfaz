; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 1-Ciclos Numericos 
; Descripción: Programa que muestra el mensaje "Hola, mundo" varias veces al usar el ciclo
INCLUDE Irvine32.inc

.data
mensaje BYTE "Ingrese la cantidad de ESP32 recibidas (1-99): ", 0
mensajeError BYTE "Error: ingrese un numero entre 1 y 99.", 0
mensajeFinal BYTE "Existencia actual: ", 0
mensajeUnidades BYTE " unidades", 0

cadena BYTE 10 DUP(0)
cadenaSalida BYTE 12 DUP(0)

cantidadRecibida DWORD 0
existenciaActual DWORD 25

.code
main PROC

Capturar:
    ; Capturar la cantidad como cadena
    mov edx, OFFSET mensaje
    call WriteString

    mov edx, OFFSET cadena
    mov ecx, SIZEOF cadena - 1
    call ReadString

    ; Validar longitud de 1 o 2 digitos
    cmp eax, 1
    jb Error
    cmp eax, 2
    ja Error

    mov ecx, eax
    mov esi, OFFSET cadena
    mov eax, 0

Convertir:
    ; Revisar que cada caracter sea un digito
    movzx ebx, BYTE PTR [esi]

    cmp bl, '0'
    jb Error
    cmp bl, '9'
    ja Error

    ; Convertir ASCII a numero decimal
    sub ebx, '0'
    imul eax, eax, 10
    add eax, ebx

    inc esi
    loop Convertir

    ; Validar rango de 1 a 99
    cmp eax, 1
    jb Error
    cmp eax, 99
    ja Error

    ; Guardar cantidad recibida
    mov cantidadRecibida, eax

    ; Sumar a las 25 unidades iniciales
    add eax, existenciaActual
    mov existenciaActual, eax

    ; Mostrar existencia actual
    mov edx, OFFSET mensajeFinal
    call WriteString

    mov eax, existenciaActual
    mov edi, OFFSET cadenaSalida
    call ConvertirDecimal

    mov edx, OFFSET cadenaSalida
    call WriteString

    mov edx, OFFSET mensajeUnidades
    call WriteString
    call Crlf

    jmp Salir

Error:
    mov edx, OFFSET mensajeError
    call WriteString
    call Crlf
    jmp Capturar

Salir:
    exit

main ENDP

; Convertir numero decimal a cadena
ConvertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov ebx, 10
    mov ecx, 0

Dividir:
    mov edx, 0
    div ebx
    add dl, '0'
    push edx
    inc ecx

    cmp eax, 0
    jne Dividir

Guardar:
    pop eax
    mov [edi], al
    inc edi
    loop Guardar

    mov BYTE PTR [edi], 0

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ConvertirDecimal ENDP

END main
