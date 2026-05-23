; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
; This file has been modified to reflect an array for storage rather than a single value.

.386									; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096								; Allocates stack space (4096 bytes) for program.

.data									; Variables are declared past this point

numbers dword 1, 2, 3, 4, 5				; numbers[] = [1, 2, 3, 4, 5]
sum dword ?								; variable to store the sum of the values in 'numbers' array.
ExitProcess proto,dwExitCode:dword 

.code									; Instructions go past this point

main proc								; Main procedure (function) starts here.

	mov ecx, 5							; Initialize ecx (Extended Counter Register) as the counter for a loop with a value of 5. (Value decrements each loop till it gets to 0) ECX = 5
	mov esi, 0							; Initialize esi (Extended Source Index) to keep track of indexing while inside the loop. ESI = 0
	mov	eax, 0							; Initialize eax (Extended Acumulator Register) with the value of 0 to keep track of the sum of. EAX = 0
	
	; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.
	; (for int i = 0; i < 5; i++)
	L1:
	add eax, numbers[esi*4]				; Add the value stored in numbers[index value] to eax. (eax = eax + numbers[index])
	inc esi								; Increment the value of esi to cycle through array. (esi++)
	loop L1								; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.
	mov sum, eax						; Move the value stored inside eax to the sum in memory. sum = eax (sum of array.)

	invoke ExitProcess,0				; Tell Operating System to terminate the program.

main endp								; Main procedure (function) ends here.

end main								; Code for "linker", lets program know the entry point is the main procedure (function)