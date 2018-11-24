	extern strlen
	extern printlnToTerminal
	global _startTest:
	section .data
_startTest:

	xor eax,eax
	xor ebx,ebx

	mov ebx,testString
	push ebx
	call strlen
	add esp,4

	cmp eax,05d
	jnz else
	push success
	call printlnToTerminal
	add esp,4
	jmp endif
else:
	push failure
	call printlnToTerminal
	add esp,4

endif:

	mov ebx,0
	mov eax,1
	int 0x80



	section .data
testString: db 'hello$'

success: db 'success, hello has a length of 5$'
failure: db 'faulure'
