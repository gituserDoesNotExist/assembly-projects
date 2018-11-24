	extern printToTerminal
	global printlnToTerminal	
	section .text
printlnToTerminal:
	;function prologue
	push ebp
	mov ebp,esp

	;body
	mov edx,[ebp+8]
	push edx
	call printToTerminal
	add esp,4

	mov BYTE [linebreakchar],0Ah
	mov BYTE [linebreakchar+1],024h
	push linebreakchar
	call printToTerminal
	add esp,4

	;function epilogue
	mov esp,ebp
	pop ebp
	ret

	section .bss
linebreakchar: resb 2
