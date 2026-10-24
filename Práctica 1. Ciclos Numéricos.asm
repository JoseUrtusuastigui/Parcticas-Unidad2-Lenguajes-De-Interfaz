; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 1-Ciclos Numericos 
; Descripción: Programa que muestra el mensaje "Hola, mundo" varias veces al usar el ciclo
INCLUDE Irvine32.inc

.data
mensaje BYTE "Hola, mundo: ", 0 

.code
main PROC
 mov ecx, 5 ; Numero de veces que se repite el ciclo

 ciclo:
  mov edx, OFFSET mensaje  ; Para mostrar el mensaje en pantalla
   call writeString
   call crlf 
   loop ciclo ; ciclo para repetir hasta que ECX llegue a 0
   exit
main ENDP 

END main 
