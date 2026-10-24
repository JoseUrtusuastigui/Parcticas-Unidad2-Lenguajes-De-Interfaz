; Materia: Lenguajes de Interfaz
; Alumno: Fabian Alexis Camacho Oviedo
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5-Condicionales (2)
; Descripción: Muestra los numeros del 1 al 10 utilizando un ciclo y saltos condicionales.

INCLUDE Irvine32.inc

.code
main PROC
  mov ebx, 1 ; valor inicial para incrementar 

ciclo:
    cmp ebx, 10 ; Condicion de salida

jg fin ; salto a finalizar el codigo cuando se cumpla la condicion de salida


mov eax, ebx ; se copia el valor de ebx a eax para poder imprimirlo
call writeDec ; DESPLIEGA EN CONSOLA EL NUMERO QUE SE VA INCREMENTANDO
call crlf ; SALTO DE LINEA

inc ebx ; REALIZA UN INCREMENTO DE 1 AL VALOR DE EBX

jmp ciclo ; SALTO SIN CONDICION PARA REPETIR EL CODIGO MIENTRAS NO SE SIGA CUMPLIENDO LA CONDICION DE SALIDA
fin: 
    exit


main ENDP 

END main 
