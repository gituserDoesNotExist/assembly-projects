	extern printToTerminal
	global _startTest
	section .text
_startTest:

	push str1
	call printToTerminal
	add esp,4

	push str2
	call printToTerminal
	add esp,4

	mov eax,1
	mov ebx,0
	int 080h



	section .data
str1: db 'hello world$'	
str2: db 'next line$'
