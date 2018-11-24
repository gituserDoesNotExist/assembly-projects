	extern power
	extern printlnToTerminal
	global _startTest
	section .text
_startTest:
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	mov ebx,010d
	mov ecx,00d

	push ecx
	push ebx
	call power
	add esp,08d


	cmp ax,01d
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
success: db 'success. ten to the power of 0 computed to 1$'
failure: db 'computation failed!$'
