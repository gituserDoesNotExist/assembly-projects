;converts a given string (integer) to a number
;first parameter: address of string (string should be terminated with $ sign)

	extern printlnToTerminal
	extern printToTerminal
	extern strlen
	extern power
	global convertIntegerStringToNumber
	section .text
convertIntegerStringToNumber:
	;function prologue
	push ebp
	mov ebp,esp
	sub esp,4 ;first local variable: lengthOfString-1. n_1*10^0 + n_2*10^1 + .. + n_n*10^(n-1)
	sub esp,4 ;second local variable: result (the real number)
	mov DWORD [ebp-4],0 ;clear memory
	mov DWORD [ebp-8],0 ;clear memory

	;body
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	mov ebx,[ebp+8] ;save ebx since it is modified in strlen
	push ebx
	call strlen ;result is in eax
	pop ebx ;restore address of string
	dec eax
	mov [ebp-4],eax
	

convert:
	push ebx ;save ebx since it is modified in power
	mov edx,[ebp-4]
	push edx ;push last parameter first!
	push 010d
	call power ;result is in eax
	add esp,08d
	pop ebx ;restore ebx

	xor edx,edx
	mov dl,[ebx]
	sub dl,030h ;039h is ASCII for 9 - to get the number one has to subtract 030h
	mul dx
	add [ebp-8],eax

	inc ebx
	dec BYTE [ebp-4]

	cmp BYTE [ebx-4],0
	jnz convert




	;function epilogue
	mov eax,[ebp-8] ;save result in eax
	mov esp,ebp
	pop ebp
	ret

