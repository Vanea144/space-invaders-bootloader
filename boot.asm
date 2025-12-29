bits 16			;tell nasm to use 16 bit addresses and values
org 0x7c00		;every address should be relative to this

start:
	mov ax, 0x0013	;Sets ah=00 and al=13 (VGA Mode 13h)
	int 0x10	;BIOS video interrupt
	
	hang:
		jmp hang 	;infinite loop for CPU not to crash

	times 510-($-$$) db 0	;pad with zeros	
	dw 0xAA55		;so BIOS thinks it is bootable
