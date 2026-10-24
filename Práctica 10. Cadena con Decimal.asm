; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 10-Cadena con decimal
; Descripción: Calcula y muestra estadísticas de descarga de un archivo de 1024 bytes.
INCLUDE Irvine32.inc

.data
    ; DATOS DEL ARCHIVO
    tamArchivo DWORD 100000
    bloques DWORD 125
    tamBloque DWORD 512

    ; RESULTADOS
    descargados DWORD ?
    pendientes DWORD ?
    porcentaje DWORD ?
    grupos DWORD ?
    residuo DWORD ?

    ; MENSAJES
    msg1 BYTE "Bytes descargados: ", 0
    msg2 BYTE "Bytes pendientes: ", 0
    msg3 BYTE "Porcentaje de avance: ", 0
    msg4 BYTE "Grupos completos de 1024: ", 0
    msg5 BYTE "Residuo del agrupamiento: ", 0
    simbolo BYTE "%", 0

    ; BUFFER PARA CONVERSION DECIMAL
    buffer BYTE 11 DUP(0)

.code
main PROC

    ; Calcula los bytes descargados multiplicando 'bloques' por 'tamBloque' y guarda el resultado en 'descargados'
    mov eax, bloques
    mul tamBloque
    mov descargados, eax

    ; Calcula los bytes pendientes restando los bytes 'descargados' del total de 'tamArchivo'
    mov eax, tamArchivo
    sub eax, descargados
    mov pendientes, eax

    ; Calcula el porcentaje entero de avance multiplicando los bytes descargados por 100 y dividiendo entre el tamaño del archivo
    mov eax, descargados
    mov ebx, 100
    mul ebx
    mov ebx, tamArchivo
    div ebx
    mov porcentaje, eax

    ; Divide los bytes descargados entre 1024 para obtener la cantidad de grupos completos y el residuo sobrante 
    mov eax, descargados
    mov edx, 0
    mov ebx, 1024
    div ebx
    mov grupos, eax
    mov residuo, edx

    ; Imprime la etiqueta de bytes descargados, convierte el valor numérico a texto usando el buffer y lo muestra en pantalla
    mov edx, OFFSET msg1
    call WriteString
    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime la etiqueta de bytes pendientes, convierte el valor numérico a texto usando el buffer y lo muestra en pantalla
    mov edx, OFFSET msg2
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime la etiqueta de porcentaje de avance, convierte el valor numérico a texto y le añade al final el símbolo "%"
    mov edx, OFFSET msg3
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    mov edx, OFFSET simbolo
    call WriteString
    call Crlf

    ; Imprime la etiqueta de grupos completos de 1024, convierte el valor numérico a texto usando el buffer y lo muestra en pantalla
    mov edx, OFFSET msg4
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime la etiqueta de residuo del agrupamiento, convierte el valor numérico a texto usando el buffer y lo muestra en pantalla
    mov edx, OFFSET msg5
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Finaliza la ejecución del programa de forma segura
    exit

main ENDP


; PROCEDIMIENTO: CONVERTIR DECIMAL
; ENTRADA:
; EAX = NUMERO A CONVERTIR
; ESI = DIRECCION DEL BUFFER

convertirDecimal PROC

    ; Resguarda el estado actual de todos los registros utilizados en la pila antes de iniciar la conversión
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; Posiciona el puntero EDI al final del buffer y coloca un carácter nulo para terminar la cadena de texto
    mov edi, esi
    add edi, 10
    mov BYTE PTR [edi], 0
    mov ebx, 10

    ; Evalúa si el número es cero; si es así, escribe directamente el carácter '0' en el buffer y salta a la fase de copia
    cmp eax, 0
    jne convertir
    dec edi
    mov BYTE PTR [edi], '0'
    jmp copiar

convertir:
    ; Divide el valor de EAX entre 10 de forma sucesiva para aislar el último dígito en el registro de residuo 
    mov edx, 0
    div ebx

    ; Convierte el dígito numérico a su representación en carácter ASCII sumándole '0' y lo almacena retrocediendo en el buffer
    add dl, '0'
    dec edi
    mov [edi], dl

    ; Evalúa si aún quedan dígitos por procesar en EAX; si el cociente no es cero, repite el proceso de división
    cmp eax, 0
    jne convertir

copiar:
    ; Realiza un bucle para desplazar la cadena de caracteres generada desde su posición temporal (EDI) hacia el inicio del buffer (ESI)
    mov al, [edi]
    mov [esi], al
    inc edi
    inc esi
    cmp al, 0
    jne copiar

    ; Restaura los valores originales de los registros desde la pila y regresa al punto de llamada del procedimiento
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

convertirDecimal ENDP

END main

