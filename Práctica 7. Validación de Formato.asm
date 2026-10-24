; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5-Condicionales
; Descripción: se muestran los numeros del 1 al 100 utilizando un ciclo y una condicion.
INCLUDE Irvine32.inc

.data
cadena BYTE "TEC-123", 0
MsgValido BYTE "Formato valido", 0
msgInvalido BYTE "Formato Invalido", 0

.code
main PROC
    ; Inicializa el puntero ESI al inicio de la cadena y pone el contador ECX en 0
    mov esi, OFFSET cadena
    mov ecx, 0
    
validarLetras:
    ; Lee el carácter actual y verifica que esté en el rango de mayúsculas ('A' a 'Z'); si no, salta a inválido
    mov al, [esi]
    cmp al, "A"
    jb invalido
    cmp al, "Z"
    ja invalido

    ; Avanza al siguiente carácter, incrementa el contador y repite el proceso hasta revisar los primeros 3 caracteres
    inc esi
    inc ecx
    cmp ecx, 3
    jb validarLetras

    ; Lee el cuarto carácter de la cadena y verifica estrictamente que sea un guion (-); si no lo es, salta a inválido
    mov al, [esi]
    cmp al, "-"
    jne invalido

    ; Avanza el puntero pasando el guion y reinicia el contador ECX a 0 para la siguiente validación
    inc esi
    mov ecx, 0

validarNumeros:
    ; Lee el carácter actual y verifica que sea un dígito numérico ('0' a '9'); si no, salta a inválido
    mov al, [esi]
    cmp al, "0"
    jb invalido
    cmp al, "9"
    ja invalido

    ; Avanza al siguiente carácter, incrementa el contador y repite el bucle buscando validar un total de 8 dígitos
    inc esi
    inc ecx
    cmp ecx, 8
    jb validarNumeros

    ; Compara el carácter actual con el valor nulo (0) para asegurarse de que la cadena termine exactamente aquí
    cmp BYTE PTR [esi], 0
    jne invalido

valido:
    ; Muestra en pantalla el mensaje de éxito indicando que el formato es correcto y salta al cierre del programa
    mov edx, OFFSET MsgValido
    call WriteString
    call Crlf
    jmp fin

invalido:
    ; Muestra en pantalla el mensaje de error indicando que el formato no es correcto
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf

fin:
    ; Finaliza la ejecución del programa de forma segura
    exit

main ENDP
END main
