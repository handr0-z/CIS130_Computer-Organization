; =========================================================================================
; AUTHOR:		ALEJANDRO PANTOJA-ZURITA
; COLLEGE:		DELAWARE TECHNICAL COMMUNITY COLLEGE
; COURSE:		CIS 130: COMPUTER ORGANIZATION
; INSTRUCTOR:	JIN AN
; DATE:			APRIL 7, 2026
; PROJECT:		ASSEMBLY LAB 4: ASSEMBLY PROCEDURES (FUNCTIONS)
; NOTES:		PROGRAM CREATED TO GET FAMILIAR WITH LOOPS IN ASSEMBLY LANGUAGE.
; =========================================================================================


.386												; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096											; Allocates stack space (4096 bytes) for program.

.data												; Variables are declared past this point

	numbers dword 4, 8, 12, 16, 20					; variable used to store an array of elements.
	sum dword 0										; variable used to store the sum.

ExitProcess proto,dwExitCode:dword 

.code												; Instructions go past this point

main proc											; Main procedure (function) starts here.

	mov ecx, LENGTHOF numbers						; (used in sumArray procedure) Initialize ecx as the counter for a loop with a value of the array length. ECX = 5
	mov edx, OFFSET numbers							; (used in sumArray procedure) Initialize edx with the value of memory address for numbers array. EDX = numbers array address
	
	call sumArray									; call sumArray procedure (function).

	mov sum, eax									; Move the value stored inside eax to the sum in memory. sum = eax (sum of array.)

	invoke ExitProcess,0							; Tell Operating System to terminate the program.

main endp											; Main procedure (function) ends here.







; --------------------------------------------------------------------------------------------------------------------------------------------------
sumArray proc										; sumArray procedure (function) starts here.
;
; Calculates and returms the sum of an array (32 bit integer - 4 bytes per element is hardcoded into loop used to calculate sum)
; Recieves: ECX (Loop Counter), EDX (Array Address)
; Returns: EAX = sum
; Requires: ECX & EDX to be initialized before procedure is called to function properly.
; --------------------------------------------------------------------------------------------------------------------------------------------------

mov esi, 0											; Initialize esi with a value of 0 to keep track of indexing while inside the loop. ESI = 0
mov	eax, 0											; Initialize eax with the value of 0 to keep track of the sum of the array. EAX = 0

L1:													; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.
	
	add eax, [edx + esi * 4]						; Add the value stored in numbers[index value] to eax. (eax = eax + numbers[index])
	inc esi											; Increment the value of esi to cycle through array. (esi++)

loop L1												; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.

	ret												; return to main procedure (function).

sumArray endp										; sumArray procedure (function) ends here.








end main											; Code for "linker", lets program know the entry point is the main procedure (function)