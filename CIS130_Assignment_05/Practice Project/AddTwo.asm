; =========================================================================================
; AUTHOR:		ALEJANDRO PANTOJA-ZURITA
; COLLEGE:		DELAWARE TECHNICAL COMMUNITY COLLEGE
; COURSE:		CIS 130: COMPUTER ORGANIZATION
; INSTRUCTOR:	JIN AN
; DATE:			APRIL 3, 2026
; PROJECT:		ASSIGNMENT 5: ASSEMBLY PROGRAM 1
; NOTES:		PROGRAM CREATED TO GET BETTER UNDERSTANDING OF ASSEMBLY PROGRAMMING.
; =========================================================================================


.386												; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096											; Allocates stack space (4096 bytes) for program.

.data												; Variables are declared past this point

	numbers dword 1, 2, 3, 4, 5, 6, 7, 8, 9, 10		; numbers[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	sum dword 0										; variable to store the sum of the values in 'numbers' array. sum = 0.

ExitProcess proto,dwExitCode:dword 

.code												; Instructions go past this point

main proc											; Main procedure (function) starts here.

	mov ecx, lengthof numbers / 2					; ecx (Extended Counter Register) = 5 -> LENGTHOF numbers (10) / 2 (# of loops).
													; (Value decrements each loop till it gets to 0)

	mov esi, 0										; esi (Extended Source Index) = 0 -> keeps track of indexing while inside loop.
	mov	eax, 0										; eax (Extended Acumulator Register) = 0 -> keeps track of the sum while inside loop.
	
	L1:												; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.

		add eax, [numbers + esi * TYPE numbers]		; Add the value stored in numbers[index value] to eax. index = esi * TYPE numbers (4)
		add esi, 2									; Increment the value of esi to cycle through array. (esi += 2)

	loop L1											; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.

	mov sum, eax									; Move the value stored inside eax to the sum in memory. sum = eax (sum of array.)

	invoke ExitProcess,0							; Tell Operating System to terminate the program.

main endp											; Main procedure (function) ends here.

end main											; Code for "linker", lets program know the entry point is the main procedure (function)