
INCLUDE Irvine32.inc

.code
main PROC
     ; 0 - Encendido de computadora
     ; 1 - Alarma
     ; 2 - Conectado
     ; Estado inicial: 00000101

     ; 1 - AND: EXTRAER EL ESTADO DE ENCENDIDO
     mov eax, 0
     mov ebx, 0
     mov al, 00000101b
     mov bl, al
     and bl, 00000111b

     call DumpRegs
     nop


     ; 2 - OR: ENCENDER LA ALARMA
     mov al, 00000101b
     or al, 00000010b

     call DumpRegs
     nop


     ; 3 - XOR: CAMBIAR EL ESTADO DE CONECTADO
     mov al, 00000101b
     xor al, 00000100b

     call DumpRegs
     nop


     ; 4 - NOT: INVERTIR ESTADOS
     mov al, 00000101b
     not al

     call DumpRegs
     nop


     ; 5 - TEST: EVALUAR ALARMA Y REALIZAR SALTO
     mov al, 00000101b
     test al, 00000010b

     jz alarmaApagada

     ; SI LA ALARMA ESTA ENCENDIDA
     mov ebx, 1
     jmp finTest

alarmaApagada:
     ; SI LA ALARMA ESTA APAGADA
     mov ebx, 0

finTest:
     call DumpRegs
     nop

     exit

main ENDP

END main
