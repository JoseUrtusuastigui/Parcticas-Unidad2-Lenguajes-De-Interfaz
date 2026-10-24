; Materia: Lenguajes de Interfaz
; Alumno: Urtusuastigui Villaseñor Jose Luis 
; Horario: 8-9
; Docente: Dr José Luis Medina Jiménez
; Práctica: 15-manipulacion de archivo
; Descripción: Crea un archivo de texto llamado "Inventario.txt" y escribe en él la cadena "125" y valida que el proceso se realice sin errores.
INCLUDE Irvine32.inc

.data
nombreArchivo BYTE "Inventario.txt", 0
texto BYTE "125", 0
archivoHandle DWORD ?

mensajeExito BYTE "Archivo guardado", 0
mensajeError BYTE "No se guardo el archivo correctamente", 0

.code
main PROC

    ; Intenta crear o sobrescribir el archivo de texto especificado; si la función devuelve un identificador inválido en EAX, salta al bloque de error general
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE
    je error
    mov archivoHandle, eax

    ; Intenta escribir la cadena "125" en el archivo utilizando su identificador; si el acarreo (Carry Flag) se activa o los bytes escritos no coinciden con la longitud esperada, salta a la rutina de error de escritura
    mov eax, archivoHandle
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1
    call WriteToFile
    jc errorEscritura
    cmp eax, SIZEOF texto - 1
    jne errorEscritura

    ; Cierra el descriptor del archivo para guardar los cambios en el disco duro; si la operación devuelve un cero, salta al manejo de errores
    mov eax, archivoHandle
    call CloseFile
    test eax, eax
    jz error

    ; Despliega en pantalla el mensaje de éxito indicando que el archivo se guardó sin problemas y salta directo a la finalización del programa
    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin

errorEscritura:
    ; Cierra de manera segura el descriptor del archivo que quedó abierto tras haber fallado el proceso de escritura en el bloque anterior
    mov eax, archivoHandle
    call CloseFile

error:
    ; Despliega en la consola el mensaje de error general informando que el archivo no pudo ser procesado correctamente
    mov edx, OFFSET mensajeError
    call WriteString

fin:
    ; Finaliza la ejecución del programa
    exit

main ENDP

END main
