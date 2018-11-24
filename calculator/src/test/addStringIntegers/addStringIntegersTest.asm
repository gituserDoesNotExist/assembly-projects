	extern addStringIntegers
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


	push firstNumber
	push secondNumber
	call addStringIntegers
	add esp,8

	cmp eax,07d
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
testPrologue: db 'starting test addStringIntegers: adding 2 and 5$'
success: db 'success. string 2+5 was added to 7$'
failure: db 'failure!$'

firstNumber: db '2$'
secondNumber: db '5$'
