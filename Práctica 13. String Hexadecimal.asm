; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 1-Ciclos Numericos 
; Descripción: Programa que muestra el mensaje "Hola, mundo" varias veces al usar el ciclo
INCLUDE Irvine32.inc

.data
cadena BYTE "123AB4CD", 0
numero DWORD 0

.code
main PROC

    mov esi, 0
    mov ecx, 8
    mov eax, 0

L1:
    shl eax, 4

    mov bl, cadena[esi]

    cmp bl, '9'
    jbe Digito

    sub bl, 7

Digito:
    sub bl, '0'

    movzx ebx, bl
    add eax, ebx

    inc esi

    loop L1

    mov numero, eax

    call DumpRegs

    mov eax, numero
    call WriteHex

    call Crlf

    exit

main ENDP

END main











