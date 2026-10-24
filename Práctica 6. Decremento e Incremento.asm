; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5-Condicionales
; Descripción: se muestran los numeros del 1 al 100 utilizando un ciclo y una condicion.
INCLUDE Irvine32.inc

.data
    msgPIN BYTE "Ingrese eL PIN: ", 0
    msgIntentos BYTE "Intentos restantes: ", 0
    msgError BYTE "PIN incorrecto", 0
    msgAcceso BYTE "ACCESO PERMITIDO", 0
    msgBloqueado BYTE "ACCESO BLOQUEADO", 0

    pinCorrecto = 1234

.code
main PROC
   ; Inicializa el contador de intentos configurando el registro EBX en 3
   mov ebx, 3 

  intentar:
   ; Muestra la solicitud en pantalla y lee el PIN numérico introducido por el usuario (se almacena en EAX)
   mov edx, OFFSET msgPIN 
   call WriteString
   call ReadInt

   ; Compara el PIN ingresado con la constante 'pinCorrecto' y, si coincide, salta al bloque de acceso concedido
   cmp eax, pinCorrecto
   je acceso
   
   ; Muestra el mensaje de error en pantalla al no coincidir el PIN
   mov edx, OFFSET msgError
   call WriteString
   call crlf

   ; Resta 1 al contador de intentos y si el contador llega a cero, salta al bloque de bloqueo
   dec ebx
   jz bloqueado

   ; Muestra el texto de intentos restantes seguido del valor actual del contador convertido a texto
   mov edx, OFFSET msgIntentos
   call WriteString
   mov eax, ebx
   call WriteDec
   call crlf

   ; Regresa de forma incondicional al inicio del bucle para solicitar el PIN otra vez
   jmp intentar


acceso:
   ; Muestra el mensaje de éxito en pantalla y salta al final del programa
   mov edx, OFFSET msgAcceso
   call WriteString 
   call crlf
   jmp fin


bloqueado:
   ; Muestra el mensaje de cuenta bloqueada en pantalla y salta al final del programa
   mov edx, OFFSET msgBloqueado
   call WriteString
   call crlf 
   jmp fin

fin:
   ; Finaliza la ejecución del programa 
   exit

main ENDP 

END main

