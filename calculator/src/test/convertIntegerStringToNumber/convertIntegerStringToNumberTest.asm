	extern convertIntegerStringToNumber
	extern printlnToTerminal
	global _startTest
	section .text
_startTest:
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	
	push testPrologue
	call printlnToTerminal
	add esp,4

	push testString
	call convertIntegerStringToNumber
	add esp,4

	cmp eax,050d
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



	mov eax,1
	mov ebx,0
	int 0x80




section .data
success: db 'success. string 50 was convertet to number 50$'
failure: db 'failure!$'
testPrologue: db 'converting 50 to number$'
testString: db '50$'
