	extern printlnToTerminal
	extern printToTerminal
	extern addStringIntegers
	extern convertIntegerToString
    global _start
    section .text

_start:
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	; prompt user to enter calculation
	push prompt	
	call printToTerminal
	add esp,4
	
	;store user input
	mov eax,3 ;read
	mov ebx,0 ;stdin
	mov ecx, userInput ;here string is stored
	mov edx,10
	int 80h

	
	;analyze user input
	xor ebx,ebx ;ebx will point to firstNumber and secondNumber respectively
	xor ecx,ecx ;ecx will be the counter
	xor edx,edx ;edx (or dl) will hold the current value of the user input

	dec eax ;eax holds now number of characters entered by user
	mov ecx,eax ;ecx holds number of characters entered by user and is loop cound

	mov ebx,firstNumber

	xor eax,eax ;eax will hold address of userInput
	mov eax,userInput
analyzeUserInput:
	mov dl,[eax]
	inc eax
	cmp dl,[strPlus]
	jnz fillNumber
		;terminate firstNumber with string-terminator
		mov BYTE [ebx],024h
		;store operation
		mov BYTE [operation],dl
		mov BYTE [operation+1],024h ;024h is hex for $ sign which is string terminator
		mov ebx,secondNumber ;now second number is filled
	jmp endif
	fillNumber:
		mov BYTE [ebx],dl
		inc ebx
	endif:	
	loop analyzeUserInput
;terminate secondNumber with string-terminator
mov BYTE [ebx],024h

	push presentParseResult
	call printlnToTerminal
	add esp,04d

	push firstNumber
	call printToTerminal
	add esp,04d
	
	push operation
	call printToTerminal
	add esp,04d

	push secondNumber
	call printlnToTerminal
	add esp,04d

	mov al,[operation]
	mov ah,[strPlus]
	cmp al,ah
	jnz nomatch
	push infoAddingNumbers
	call printlnToTerminal
	add esp,4

	push firstNumber
	push secondNumber
	call addStringIntegers	
	add esp,8

	;result is in eax
	push eax
	call convertIntegerToString ;start address of resulting string will be in eax
	add esp,4
	
	push eax ;save value of eax
	
	push infoResult
	call printToTerminal
	add esp,4

	pop eax ;restore start address of result string

	push eax
	call printlnToTerminal
	add esp,4

	jmp exit

nomatch:
	push noOperationFound
	call printlnToTerminal
	mov esp,4


exit:
    mov edx,02
    mov ebx,0
    mov eax,1
    int 0x80
    
	section .data
strPlus: db 02Bh
infoAddingNumbers: db 'adding numbers$'
infoResult: db 'the result is: $'

prompt: db 'enter calculation:$'
presentParseResult: db 'result:$'
noOperationFound: db 'operation could not be determined$'

	section .bss
userInput: resb 10
firstNumber: resb 5
secondNumber: resb 5
operation: resb 2
