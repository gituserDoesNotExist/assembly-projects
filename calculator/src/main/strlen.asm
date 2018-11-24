;computes length of string (number of bytes till $ sign is reached)
;firstParameter: address of string

	global strlen
	section .text
strlen:
	;function prologue
	push ebp
	mov ebp,esp

	xor eax,eax
	xor ebx,ebx
	;body
	mov ebx,[ebp+8] ;address of string
computeLength:
	cmp BYTE [ebx],024h ;024h is ASCII code for $ sign
	jz finish
	inc ebx
	inc eax
	jmp computeLength

finish:

	;function epilogue
	;result is alredy in eax
	mov esp,ebp
	pop ebp
	ret
	


