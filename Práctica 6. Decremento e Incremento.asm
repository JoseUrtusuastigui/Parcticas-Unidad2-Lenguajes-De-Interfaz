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
   mov ebx, 3 ; NUMERO DE INTENTOS PARA INGRESAR

  intentar:
  mov edx, OFFSET msgPIN 
   call WriteString
   call ReadInt

   cmp eax, pinCorrecto
   je acceso
   
   mov edx, OFFSET msgError
   call WriteString
   call crlf

   dec ebx

   jz bloqueado

   mov edx, OFFSET msgIntentos
   call WriteString

   mov eax, ebx
   call WriteDec
   call crlf

   jmp intentar


acceso:
mov edx, OFFSET msgAcceso
call WriteString 
call crlf
jmp fin


bloqueado:
mov edx, OFFSET msgBloqueado
call WriteString
call crlf 
jmp fin

fin:
exit

main ENDP 

END main 