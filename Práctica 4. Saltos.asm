; Materia: Lenguajes de Interfaz
; Alumno: Fabian Alexis Camacho Oviedo
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4-Saltos
; Descripción: Compara dos valores y muestra si son iguales o diferentes, ademas de utilizar los saltos para agilizar el proceso.

INCLUDE Irvine32.inc

.data
msgIguales BYTE "Los valores son iguales", 0
msgDiferente BYTE "Los valores son diferentes", 0

.code
main PROC
  mov eax, 10
  mov ebx, 10

  cmp eax, ebx ; para comparar los dos valores

  je iguales ; se salta si son iguales

  mov edx, OFFSET msgDiferentes  ; Mostrar el mensaje si son diferentes
  call WriteString


  jmp fin

  iguales: 
  mov edx, OFFSET msgIguales  ; Mostrar el mensaje si son iguales
  call WriteString

fin:
call crlf
exit 
  main ENDP 

END main 
