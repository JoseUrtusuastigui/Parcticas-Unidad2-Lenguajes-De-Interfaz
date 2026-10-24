; Materia: Lenguajes de Interfaz
; Alumno: Fabian Alexis Camacho Oviedo
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4.1-Mayor, Menor o Igual con Entrada del Usuario
; Descripción: Pide dos numeros y los compara para saber si son mayores, menores o iguales, tambien utilizando los saltos en el proceso

INCLUDE Irvine32.inc

.data
msgNum1 BYTE "Ingresa el primer numero: ", 0
msgNum2 BYTE "Ingresa el segundo numero: ", 0

msgMayor BYTE "El primer numero es mayor", 0
msgMenor BYTE "El primer numero es menor", 0
msgIguales BYTE "Los numeros son iguales", 0

num1 DWORD ?
num2 DWORD ?

.code
main PROC

    ; se pide el primer numero
    mov edx, OFFSET msgNum1  
    call WriteString
    call ReadInt
    mov num1, eax

     ; se pide el segundo numero
    mov edx, OFFSET msgNum2  
    call WriteString
    call ReadInt
    mov num2, eax

    ; se Comparan los dos numeros
    mov eax, num1
    mov ebx, num2

    cmp eax, ebx

    ;saltos 
    jg mayor
    jl menor
    je iguales

iguales:
    mov edx, OFFSET msgIguales
    call WriteString
    jmp fin

mayor:
    mov edx, OFFSET msgMayor
    call WriteString
    jmp fin

menor:
    mov edx, OFFSET msgMenor
    call WriteString

fin:
    call Crlf
    exit

main ENDP
END main
