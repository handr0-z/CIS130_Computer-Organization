; =========================================================================================
; AUTHOR:		ALEJANDRO PANTOJA-ZURITA
; COLLEGE:		DELAWARE TECHNICAL COMMUNITY COLLEGE
; COURSE:		CIS 130: COMPUTER ORGANIZATION
; INSTRUCTOR:	JIN AN
; DATE:			APRIL 12, 2026
; PROJECT:		LAB 5: ASSEMBLY CONDITIONAL PROCESSING
; NOTES:		PROGRAM CREATED TO TEST COMPETENCE WITH PROCEDURES, COMPARISONS, BRANCHING
;				AND ARRAY INDEXING IN ASSEMBLY.
; =========================================================================================


.386												; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096											; Allocates stack space (4096 bytes) for program.

.data												; Variables are declared past this point

	numbers DWORD 5, -2, 12, -7, 9, -1, 4			; Variable used to store an array of elements.
	arraySize DWORD LENGTHOF numbers 				; Variable used to store the length of the numbers array.
	positiveSum DWORD ?								; Variable used to store the sum of postive values in number array.

ExitProcess proto,dwExitCode:dword 

.code												; Instructions go past this point

main proc											; Main procedure (function) starts here.

	mov ecx, arraySize								; (used in sumIfPositive procedure) Initialize ecx as the counter for a loop with a value of the array length. ECX = 7
	mov esi, OFFSET numbers							; (used in sumIfPositive procedure) Initialize esi with the value of memory address for numbers array. EDX = numbers array address
	
	call sumIfPositive								; call sumIfPositive procedure (function).

	mov positiveSum, eax							; Move the value stored inside eax to the positiveSUm variable in memory. postiveSum = eax

	invoke ExitProcess,0							; Tell Operating System to terminate the program.

main endp											; Main procedure (function) ends here.







; --------------------------------------------------------------------------------------------------------------------------------------------------
sumIfPositive proc									; sumIfPositive procedure (function) starts here.
;
; Calculates the sum of the positive elements in an array. (32 bit integer - 4 bytes per element is hardcoded into loop used to calculate sum)
; Recieves: ECX (number of elements), ESI (array base address)
; Returns: EAX =  sum of the positive elements in an array.
; Requires: ECX & ESI to be initialized before procedure is called to function properly.
; --------------------------------------------------------------------------------------------------------------------------------------------------

mov	eax, 0											; Initialize eax with the value of 0 to keep track of the total number of warm days. EAX = 0
mov ebx, 0											; Initialize ebx with the value of 0 to increment through the array while inside the loop. EBX = 0

L1:													; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.
	
	mov edi, [esi + ebx * 4]						; Add the value stored in numbers[index value] to edi. (edi = eax + numbers[index])
	cmp edi, 0										; Compare the value stored in edx to the value in edi. if (EDI (array value) == EDX (60))

	jle lessThanOrEqualTo							; Jump to "lessThanOrEqualTo" if EDI < EDX.

	add eax, edi									; Increment the value of eax whenever value of EDI > EDX.

lessThanOrEqualTo:									; Jump to this point in code if EDI < EDX.

	inc ebx											; Increment the value of esi to cycle through array. (esi++)

loop L1												; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.

	ret												; return to main procedure (function).

sumIfPositive endp									; sumArray procedure (function) ends here.








end main											; Code for "linker", lets program know the entry point is the main procedure (function)