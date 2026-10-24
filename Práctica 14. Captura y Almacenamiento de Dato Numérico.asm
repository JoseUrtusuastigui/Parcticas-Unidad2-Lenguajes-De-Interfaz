; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 14-Captura y almacenamiento de dato numerico
; Descripción: Actualiza el inventario sumando una cantidad de dispositivos ingresada por el usuario tras validar que se encuentre entre 1 y 99.
INCLUDE Irvine32.inc

.data
mensaje BYTE "Ingrese la cantidad de ESP32 recibidas (1-99): ", 0
mensajeError BYTE "Error: ingrese un numero entre 1 y 99.", 0
mensajeFinal BYTE "Existencia actual: ", 0
mensajeUnidades BYTE " unidades", 0

cadena BYTE 10 DUP(0)
cadenaSalida BYTE 12 DUP(0)

cantidadRecibida DWORD 0
existenciaActual DWORD 25

.code
main PROC

Capturar:
    ; Muestra la solicitud en la consola y captura la entrada del usuario guardándola como texto en 'cadena' 
    mov edx, OFFSET mensaje
    call WriteString
    mov edx, OFFSET cadena
    mov ecx, SIZEOF cadena - 1
    call ReadString

    ; Valida que el texto ingresado tenga obligatoriamente una longitud de 1 o 2 caracteres; si no cumple, salta al bloque de error
    cmp eax, 1
    jb Error
    cmp eax, 2
    ja Error

    ; Configura el contador ECX con la longitud de la cadena, apunta ESI al inicio del texto y limpia EAX para usarlo como acumulador
    mov ecx, eax
    mov esi, OFFSET cadena
    mov eax, 0

Convertir:
    ; Lee el carácter actual y verifica de forma estricta que sea un dígito válido entre '0' y '9'; si no, interrumpe y salta a error
    movzx ebx, BYTE PTR [esi]
    cmp bl, '0'
    jb Error
    cmp bl, '9'
    ja Error

    ; Resta '0' para obtener el valor numérico, multiplica el acumulador EAX por 10 para desplazar la posición decimal, suma el nuevo dígito y avanza al siguiente carácter
    sub ebx, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    loop Convertir

    ; Verifica que el número final convertido se encuentre estrictamente dentro del rango de 1 a 99; de lo contrario, salta a error
    cmp eax, 1
    jb Error
    cmp eax, 99
    ja Error

    ; Almacena el número en 'cantidadRecibida', lo suma a la variable 'existenciaActual' para actualizar el inventario y guarda de nuevo el resultado
    mov cantidadRecibida, eax
    add eax, existenciaActual
    mov existenciaActual, eax

    ; Muestra la etiqueta final, convierte el número total de existencias a texto almacenándolo en 'cadenaSalida' e imprime el resultado junto con el texto " unidades"
    mov edx, OFFSET mensajeFinal
    call WriteString
    mov eax, existenciaActual
    mov edi, OFFSET cadenaSalida
    call ConvertirDecimal
    mov edx, OFFSET cadenaSalida
    call WriteString
    mov edx, OFFSET mensajeUnidades
    call WriteString
    call Crlf
    jmp Salir

Error:
    ; Despliega el mensaje de advertencia sobre el rango o formato inválido y regresa al inicio para pedir la cantidad nuevamente
    mov edx, OFFSET mensajeError
    call WriteString
    call Crlf
    jmp Capturar

Salir:
    ; Termina de forma correcta la ejecución del programa
    exit

main ENDP

; Convertir numero decimal a cadena
ConvertirDecimal PROC
    ; Resguarda en la pila los valores de todos los registros que se van a modificar en este procedimiento
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov ebx, 10
    mov ecx, 0

Dividir:
    ; Divide el número de forma sucesiva entre 10, transforma el residuo en carácter ASCII sumándole '0', lo guarda temporalmente en la pila e incrementa el contador de dígitos
    mov edx, 0
    div ebx
    add dl, '0'
    push edx
    inc ecx
    cmp eax, 0
    jne Dividir

Guardar:
    ; Recupera los dígitos de la pila en orden inverso, los va escribiendo de izquierda a derecha en la dirección de memoria apuntada por EDI y finaliza la cadena con un cero 
    pop eax
    mov [edi], al
    inc edi
    loop Guardar
    mov BYTE PTR [edi], 0

    ; Restaura los registros a su estado original antes de salir y regresa al procedimiento principal
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ConvertirDecimal ENDP

END main

