INCLUDE Irvine32.inc

.code
main PROC
  ; OPERACIONES: ADD Y SUB 

  mov eax, 50
  mov ebx, 20

  add eax, ebx
  sub eax, 15

  nop 


  ; CF: ACARREO EN UNA SUMA SIN SIGNO

  mov eax, 0
  mov al, 255
  add al, 1


  nop 

  ; OF: CONDICION DE DESBORDAMIENTO

  mov eax, 0
  mov al, 127
  add al, 1

  nop


  ; 4: MUL: MULTIPLICACION DE VALORES DENTRO DE 32 BITS

  mov eax, 25
  mov ebx, 3

  mul ebx

  nop

  ; 5: MUL: PRODUCTO QUE NECESITA MAS DE 32 BITS
   
   mov eax, 65537
   mov ebx, 65537

   mul ebx

   nop


   ; 6: mul: multiplicacion con signo

   mov eax, -5

   imul eax, eax, 3

   nop

   ; 7: DIV: division sin signo

   mov eax, 125
   mov edx, 0
   mov ebx, 12

   div ebx

  nop

  ; 8: IDIV: DIVISION CON SIGNOS

  mov eax, -125

  cdq

  mov ebx, 12

  idiv ebx

  nop
  exit
main ENDP 

END main 