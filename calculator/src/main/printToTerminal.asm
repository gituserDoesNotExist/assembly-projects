	global printToTerminal
	section .text

printToTerminal:
	;function prologue
	push ebp
	mov ebp,esp

	;body
	mov eax,4 ;systemcall 4 is for sys-write
	mov ebx,1 ;use std-out
	mov ecx,[ebp+8]

	xor edx,edx
determineLength:
	cmp BYTE [ecx+edx],024h
	jz endif	
	inc edx
endif:
	jnz determineLength

	int 080h

	;function epilogue
	mov esp,ebp
	pop ebp
	ret
