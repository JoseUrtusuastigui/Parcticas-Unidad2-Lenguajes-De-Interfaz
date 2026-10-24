; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6-Control de ocupacion de un estacionamiento
; Descripción: Gestiona el ingreso y salida de vehículos en un estacionamiento con capacidad máxima de 20 carros.
INCLUDE Irvine32.inc

.data
msgMenu BYTE "1. Entrada de carro", 0
msgSalida BYTE "2. Salida de carro", 0
msgOcupacion BYTE "Carros estacionados: ", 0
msgEntrada BYTE "Un carro ha entrado", 0
msgSalio BYTE "Un carro ha salido", 0
msgVacio BYTE "El estacionamiento esta vacio", 0
msgLleno BYTE "ESTACIONAMIENTO LLENO", 0
msgOpcion BYTE "Seleccione una opcion: ", 0
msgError BYTE "Opcion no valida", 0

carros DWORD 0

.code
main PROC

ciclo:
    ; Muestra en pantalla el total de carros actualmente estacionados utilizando la variable 'carros'
    mov edx, OFFSET msgOcupacion
    call WriteString
    mov eax, carros
    call WriteDec
    call Crlf

    ; Compara la cantidad actual con el límite de 20; si es igual, salta al bloque que maneja el lleno total
    cmp carros, 20
    je lleno

    ; Despliega visualmente las opciones del menú en la consola y lee la selección numérica del usuario (se guarda en EAX)
    mov edx, OFFSET msgMenu
    call WriteString
    call Crlf
    mov edx, OFFSET msgSalida
    call WriteString
    call Crlf
    mov edx, OFFSET msgOpcion
    call WriteString
    call ReadInt

    ; Evalúa la opción ingresada: salta a 'entrada' si es 1, a 'salida' si es 2, o muestra error y repite el ciclo si es otra cosa
    cmp eax, 1
    je entrada
    cmp eax, 2
    je salida
    mov edx, OFFSET msgError
    call WriteString
    call Crlf
    jmp ciclo

entrada:
    ; Incrementa en 1 el contador de carros, imprime el mensaje de confirmación de entrada y vuelve al menú principal
    inc carros
    mov edx, OFFSET msgEntrada
    call WriteString
    call Crlf
    jmp ciclo

salida:
    ; Verifica que haya carros disponibles para salir; si no hay ninguno (es 0), salta al bloque de estacionamiento vacío
    cmp carros, 0
    je vacio

    ; Decrementa en 1 el contador de carros, imprime la confirmación de salida y regresa al inicio del bucle
    dec carros
    mov edx, OFFSET msgSalio
    call WriteString
    call Crlf
    jmp ciclo

vacio:
    ; Imprime el aviso de que el lugar ya se encuentra sin vehículos y regresa automáticamente al menú
    mov edx, OFFSET msgVacio
    call WriteString
    call Crlf
    jmp ciclo

lleno:
    ; Imprime la advertencia de que el estacionamiento alcanzó su capacidad máxima y detiene la ejecución del programa
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf
    exit

main ENDP
END main

