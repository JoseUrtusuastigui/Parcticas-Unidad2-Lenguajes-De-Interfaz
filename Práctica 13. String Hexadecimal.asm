; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 13-String Hexadecimal
; Descripción: Convierte una cadena de caracteres que representa un número hexadecimal en su valor numérico correspondiente.
INCLUDE Irvine32.inc

.data
cadena BYTE "123AB4CD", 0
numero DWORD 0

.code
main PROC

    ; Inicializa el índice ESI en 0, establece el contador de vueltas ECX en 8 y limpia el acumulador EAX
    mov esi, 0
    mov ecx, 8
    mov eax, 0

L1:
    ; Hace espacio para el siguiente dígito hexadecimal desplazando los bits de EAX 4 posiciones a la izquierda
    shl eax, 4

    ; Carga el carácter actual de la cadena en el registro de un byte BL
    mov bl, cadena[esi]

    ; Compara el carácter con el '9'; si es un número salta directamente a la conversión, si es una letra le resta 7 para ajustar su posición en la tabla ASCII
    cmp bl, '9'
    jbe Digito
    sub bl, 7

Digito:
    ; Resta el valor ASCII del carácter '0' para obtener el valor numérico real del dígito hexadecimal (0 a 15)
    sub bl, '0'

    ; Extiende el valor de un byte a un registro completo, lo suma al acumulador EAX e incrementa el índice ESI
    movzx ebx, bl
    add eax, ebx
    inc esi

    ; Decrementa el contador ECX y repite el proceso hasta completar la conversión de los 8 caracteres
    loop L1

    ; Almacena el resultado numérico final en la variable 'numero' y despliega el estado de todos los registros en la consola
    mov numero, eax
    call DumpRegs

    ; Muestra el valor numérico de la variable 'numero' en formato hexadecimal en la pantalla y genera un salto de línea
    mov eax, numero
    call WriteHex
    call Crlf

    ; Finaliza la ejecución del programa 
    exit

main ENDP

END main











