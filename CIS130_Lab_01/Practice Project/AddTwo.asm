; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386									; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096								; Allocates stack space (4096 bytes) for program.

.data									; Variables are declared past this point

num dword 12							; Declare 'dword' variable called 'num' with the value '12' stored inside. (num = 12)
result dword ?							; Declare 'dword' variable called 'result' to store the result of the addition. '?' means its unititalized.
ExitProcess proto,dwExitCode:dword 

.code									; Instructions go past this point

main proc								; Main procedure (function) starts here.

	mov	eax, num						; Move the data stored in 'num' to the register eax. (eax = num (12))
	mov ebx,10							; Move the value '10' to the register ebx. (ebx = 10)
	add	eax,ebx							; Add the value stored in ebx (10) to eax (12). (eax = eax + ebx)
	mov result, eax						; Move the data stored in 'eax' to the variable 'result'. (result = eax (10))

	invoke ExitProcess,0				; Tell Operating System to terminate the program.

main endp								; Main procedure (function) ends here.

end main								; Code for "linker", lets program know the entry point is the main procedure (function)