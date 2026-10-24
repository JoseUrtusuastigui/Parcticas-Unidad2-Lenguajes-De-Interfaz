
INCLUDE Irvine32.inc

.data
cadena BYTE "TEC-123", 0
MsgValido BYTE "Formato valido", 0
msgInvalido BYTE "Formato Invalido", 0

.code
main PROC
    mov esi, OFFSET cadena
    mov ecx, 0
    
validarLetras:
    mov al, [esi]

    cmp al, "A"
    jb invalido

    cmp al, "Z"
    ja invalido

    inc esi
    inc ecx

    cmp ecx, 3
    jb validarLetras

    ; Validar el guion
    mov al, [esi]
    cmp al, "-"
    jne invalido

    inc esi
    mov ecx, 0

validarNumeros:
    mov al, [esi]

    cmp al, "0"
    jb invalido

    cmp al, "9"
    ja invalido

    inc esi
    inc ecx

    cmp ecx, 8
    jb validarNumeros

    ; Verificar que termine la cadena
    cmp BYTE PTR [esi], 0
    jne invalido

valido:
    mov edx, OFFSET MsgValido
    call WriteString
    call Crlf
    jmp fin

invalido:
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf

fin:
    exit

main ENDP
END main
