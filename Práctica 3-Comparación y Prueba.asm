; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9 
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 3-Comparación y Prueba
; Descripción: se observaran los cambios en las diferentes banderas 
INCLUDE Irvine32.inc

.code
main PROC

; CONDICION 1: ZERO FLAGS
 ; se comparan valores iguales
   mov EBX, 1
   cmp EBX, 1
   call dumpRegs

   mov EAX, 01h
   cmp EAX, EBX 
   call dumpRegs 

   mov cl, 11111111b
   cmp cl, cl
   call dumpRegs 

   ; CONDICION 2: SIGN FLAG
     ; se compara un numero negativo con uno positivo
   mov EAX, 0
   mov EBX, 0

   mov al, -5
   mov bl, 1
   cmp al, bl 
   call dumpRegs 

   ; CONDICION 3: CARRY FLAGS 
    ; Se suman los valores que superan la capacidad de AL
   mov EAX, 0
   mov EBX, 0

   mov al, 255
   add al, 1
   call dumpRegs 

   ; CONDICION 4: OVERFLOW FLAG 
     ; se comparan valores con signo
   mov EAX, 0
   mov EBX, 0

   mov al, -128
   mov bl, 1
   cmp al, bl
   call dumpRegs

   ;CASO 5: TEST
     ; se comprueban los bits mediante un AND
   mov EAX, 0
   mov EAX, 5; 00000101b
   test EAX, 1
   call dumpRegs 
   
   ;00000101b
   ;-
   ;00000001b
   ;------------
   ;00000001b

   mov eax, 0
   mov al, 10000000b
   test al, al
   call dumpRegs

main ENDP 

END main 
