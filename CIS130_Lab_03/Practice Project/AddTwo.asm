; =========================================================================================
; AUTHOR:		ALEJANDRO PANTOJA-ZURITA
; COLLEGE:		DELAWARE TECHNICAL COMMUNITY COLLEGE
; COURSE:		CIS 130: COMPUTER ORGANIZATION
; INSTRUCTOR:	JIN AN
; DATE:			MARCH 31, 2026
; PROJECT:		ASSEMBLY LAB 3: ASSEMBLY LOOPS
; NOTES:		PROGRAM CREATED TO GET FAMILIAR WITH LOOPS IN ASSEMBLY LANGUAGE.
; =========================================================================================


.386												; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096											; Allocates stack space (4096 bytes) for program.

.data												; Variables are declared past this point

numbers dword 1, 2, 3, 4, 5, 6, 7, 8, 9, 10			; numbers[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] 
sum dword 0											; variable to store the sum of the values in 'numbers' array. sum = 0.
ExitProcess proto,dwExitCode:dword 

.code												; Instructions go past this point

main proc											; Main procedure (function) starts here.

	mov ecx, 10										; Initialize ecx (Extended Counter Register) as the counter for a loop with a value of 5. (Value decrements each loop till it gets to 0) ECX = 10
	mov esi, 0										; Initialize esi (Extended Source Index) to keep track of indexing while inside the loop. ESI = 0
	mov	eax, 0										; Initialize eax (Extended Acumulator Register) with the value of 0 to keep track of the sum of. EAX = 0
	
													; Loop below is similar to -> (for int i = 0; i < 10; i++)
	L1:												; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.

		;add eax, numbers[esi*4]					; Add the value stored in numbers[index value] to eax. (eax = eax + numbers[index])
		add eax, [numbers + esi * TYPE numbers]		; Add the value stored in numbers[index value] to eax. (eax = eax + numbers[index])
		inc esi										; Increment the value of esi to cycle through array. (esi++)

	loop L1											; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.

	mov sum, eax									; Move the value stored inside eax to the sum in memory. sum = eax (sum of array.)

	invoke ExitProcess,0							; Tell Operating System to terminate the program.

main endp											; Main procedure (function) ends here.

end main											; Code for "linker", lets program know the entry point is the main procedure (function)