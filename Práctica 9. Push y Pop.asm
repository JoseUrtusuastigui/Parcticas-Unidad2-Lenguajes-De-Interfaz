; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5-Condicionales
; Descripción: se muestran los numeros del 1 al 100 utilizando un ciclo y una condicion.
INCLUDE Irvine32.inc
.code
main PROC
  ; Carga el valor decimal 500 dentro del registro EAX
  mov eax, 500

  ; Introduce el valor actual de EAX en el tope de la pila de memoria (Stack)
  push eax 
  
  ; Ejecuta una instrucción de "No Operación" que consume un ciclo de reloj sin alterar nada
  nop
  
  ; Finaliza la ejecución del programa 
  exit
main ENDP 

END main
