; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5.1-Repetir hasta que el usuario ingrese 0
; Descripción: Evalúa si un número es positivo o negativo repetidamente hasta que el usuario ingresa 0
INCLUDE Irvine32.inc

.data
msgNumero BYTE "Ingresa un numero: ", 0
msgPositivo BYTE "El numero es positivo", 0
msgNegativo BYTE "El numero es negativo", 0
msgSalir BYTE "Programa finalizado", 0

.code
main PROC

ciclo:
    ; Muestra el mensaje en pantalla y lee el número entero ingresado por el usuario (se guarda en EAX)
    mov edx, OFFSET msgNumero
    call WriteString
    call ReadInt

    ; Compara el número con 0 y decide a qué sección saltar según sea igual, mayor o menor
    cmp eax, 0
    je fin
    jg positivo
    jl negativo

positivo:
    ; Muestra el mensaje de positivo, da un salto de línea y regresa al inicio del bucle
    mov edx, OFFSET msgPositivo
    call WriteString
    call Crlf
    jmp ciclo

negativo:
    ; Muestra el mensaje de negativo, da un salto de línea y regresa al inicio del bucle
    mov edx, OFFSET msgNegativo
    call WriteString
    call Crlf
    jmp ciclo

fin:
    ; Muestra el mensaje de despedida, da un salto de línea y cierra el programa de forma segura
    mov edx, OFFSET msgSalir
    call WriteString
    call Crlf
    exit

main ENDP
END main
