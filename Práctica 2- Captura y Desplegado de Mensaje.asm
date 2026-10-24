; Materia: Lenguajes de Interfaz
; Alumno: Fabian Alexis Camacho Oviedo
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: Captura y despliegue de mensajes
; Descripción: Captura el nombre del usuario, lo muestra en pantalla y despliega la cantidad de caracteres.

INCLUDE Irvine32.inc

.data
mensajeEntrada BYTE "Escribe tu nombre: ", 0
mensajeLongitud BYTE "Caracteres capturados: ", 0

nombre BYTE 30 DUP(0)
longitud DWORD ?

.code
main PROC

   
    mov edx, OFFSET mensajeEntrada ; Mostrar el mensaje de entrada
    call WriteString

    mov edx, OFFSET nombre  ; Captura el nombre que se ingresara 
    mov ecx, SIZEOF nombre
    call ReadString

    mov longitud, eax  ; Guarda la cantidad de caracteres
    call Crlf

    mov edx, OFFSET nombre   ; Muestra el nombre capturado
    call WriteString
    call Crlf

    mov edx, OFFSET mensajeLongitud ; Muestra el mensaje de longitud
    call WriteString

    mov eax, longitud  ; Muestra la cantidad de caracteres puestos
    call WriteDec

    exit

main ENDP
END main
