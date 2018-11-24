;converts an integer to its string representation. The string is terminated the by $ sign
;	divide number by then until quotient is zero.
;		548/10=54 rest 8
;		54/10=5 rest 4
;		5/10 =0 rest 5
;		done	

;first parameter: number
	global convertIntegerToString
convertIntegerToString:
	;function prologue
	push ebp
	mov ebp,esp
	

	;body
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx
	
	mov ax,[ebp+8]
	mov ebx, resultingNumber

	cmp BYTE [ebx],024h
	jz finish
	
convertChars:
	inc ecx

	;divide number by ten and add to rest 030h in order to convert it to ASCII code
	mov dl,010d
	div dl
	add ah,030h ;<number> + 030h is ASCII code for <number>

	;mov al to edx since it is not possible to push just e.g. al on the stack
	xor edx,edx
	mov dl,ah
	push edx

	xor ah,ah ;quotient is in al. when clearing ah then ax is propertly loaded
	;check if dividend is zero
	cmp al,0
	jnz convertChars

;ecx is the counter
	xor edx,edx
concatChars:
	pop edx
	mov [ebx],edx
	inc ebx
	loop concatChars

finish:
;terminate string
mov BYTE [ebx],024h

	;function epilogue
	mov eax,resultingNumber ;return start address of string	
	mov esp,ebp
	pop ebp
	ret
	

	section .bss
resultingNumber: resb 10



