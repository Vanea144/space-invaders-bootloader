bits 16			;tell nasm to use 16 bit addresses and values
org 0x7c00		;every address should be relative to this

start:
	mov ax, 0x0013	;Sets ah=00 and al=13 (VGA Mode 13h)
	int 0x10	;BIOS video interrupt
	mov ax, 0xA000	;Initial address for segmentation
	mov es, ax	;Needs to be in ES
	mov di, 32160 	;The value for center

	color:
		mov al, 14	;Yellow
		mov [es:di], al 		
		jmp hang

	hang:
		mov ah, 0x00	;Wait for keypress
		int 0x16	;BIOS interrupt, read from keyboard
		mov ah, 0	;Always make the current pixel black
		mov [es:di], ah

		cmp al, 'a'
			je handle_left	;move point to the left
		cmp al, 'w'
			je handle_up	;move point up
		cmp al, 's'
			je handle_down	;move point down
		cmp al, 'd'
			je handle_right	;move point to the right
		jmp color	

	handle_left:
		dec di
		jmp color

	handle_right:
		inc di
		jmp color
	
	handle_up:
		sub di, 320
		jmp color
	
	handle_down:
		add di, 320
		jmp color


	times 510-($-$$) db 0	;pad with zeros	
	dw 0xAA55		;so BIOS thinks it is bootable
