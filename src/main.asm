org 0x7C00 ; tells assembly the memory adress where the program starts
bits 16 ; tells assembly to generate 16 bits instruc

%define ENDL 0x0D, 0x0A ; a thing that we can use for comfortable printing text, as we don't have to remember the memory directions for ending a text

start:
  jmp main 

puts:
  push si ; pushes the content of the register si into the stack
  push ax ; pushes the content of the register ax into the stack

.loop:
  lodsb ; reads a byte from the memory adress si, and stores the content into the "al" register
  or al, al ; 
  jz .done ; if it doesn't have more bytes to read, jump to .done
  
  mov ah, 0x0e 
  int 0x10 ; trigger a BIOS video software interrupt

  jmp .loop ; go to loop

.done:
  pop ax ; restore the original value of ax from the stack 
  pop si ; restore the original value of si from the stack 
  ret 

main:
  ; prepares ax to initialize the segment registers
  mov ax, 0

  ; this allows us to access data using addresses relative to segment 0
  mov ds, ax

  ; es is an additional data segment register
  mov es, ax

  ; this defines the memory segment where the stack is located
  mov ss, ax

  ; the stack starts at the bootloader's loading address
  mov sp, 0x7C00

  ; si will point to the beginning of the string
  mov si, msg_hello

  ; call puts to print the string stored at DS:SI
  call puts

  ; halt the CPU until an interrupt occurs
  hlt

.halt:
  ; this prevents execution from continuing into unintended memory
  jmp .halt

; ENDL adds carriage return and line feed characters
msg_hello: db 'Hello World!', ENDL, 0

; fill the remaining bytes with zeros until the boot sector reaches 510 bytes
times 510-($-$$) db 0

; write the boot signature (0xAA55)
; BIOS uses this signature to recognize a valid boot sector
dw 0AA55h
