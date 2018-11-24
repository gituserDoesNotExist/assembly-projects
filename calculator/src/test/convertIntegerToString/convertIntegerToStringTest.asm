	extern convertIntegerToString
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

	mov edx,[testNumber]
	push edx
	call convertIntegerToString
	add esp,4

	;save result
	mov DWORD [startAddressResultString],eax

	push introduceResult
	call printlnToTerminal
	add esp,4

	mov eax,[startAddressResultString]
	push eax
	call printlnToTerminal
	add esp,4


exit:
	mov eax,1
	mov ebx,0
	int 0x80




	section .data
testPrologue: db 'converting the number 75 to a string: $'
introduceResult: db 'result is:$'

testNumber: db 075d

	section .bss
startAddressResultString: resb 4
