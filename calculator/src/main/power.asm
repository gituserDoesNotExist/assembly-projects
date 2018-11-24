;computes n^e.
;n: first parameter
;e: second parameter
	global power
	section .text
power:
	;function prologue
	push ebp
	mov ebp,esp

	;body
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	;we want to comput n^e
	mov ebx,[ebp+8] ;corresponds to n 
	mov ecx,[ebp+12] ;corresponds to exponent e (last parameter is pushed first on stack)

	mov ax,1 ;holds result
	jcxz finish
compPower:
	mul bx
	loop compPower

finish:
	;function epilogue
	;result is already in eax
	mov esp,ebp
	pop ebp
	ret

	section .data
test: db 'this is a test'
