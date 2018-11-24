;expects two numbers represented as string
;the string should be terminated using a $ sign
	extern convertIntegerStringToNumber
	global addStringIntegers
	section .text
addStringIntegers:
	;function prologue
	push ebp
	mov ebp,esp
	sub esp,4 ;first parameter: first number
	sub esp,4 ;second parameter: second number

	;body
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	push DWORD [ebp+8] ;memory address of first parameter
	call convertIntegerStringToNumber
	add esp,4

	mov [ebp-4],eax
	
	push DWORD [ebp+12] ;memory address of second parameter
	call convertIntegerStringToNumber
	add esp,4

	mov [ebp-8],eax	

	pop eax ;fetch first number from stack and put it in eax
	pop edx ;fetch second number from stack and put it in edx

	add eax,edx

	;function epilogue
	;result is already in eax
	mov esp,ebp
	pop ebp ;restore caller's base pointer value
	ret ;returns to caller (pops eip from the stack)
