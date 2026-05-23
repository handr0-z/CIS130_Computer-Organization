; =========================================================================================
; AUTHOR:		ALEJANDRO PANTOJA-ZURITA
; COLLEGE:		DELAWARE TECHNICAL COMMUNITY COLLEGE
; COURSE:		CIS 130: COMPUTER ORGANIZATION
; INSTRUCTOR:	JIN AN
; DATE:			APRIL 12, 2026
; PROJECT:		ASSIGNMENT 6: ASSEMBLY PROGRAM 2
; NOTES:		PROGRAM CREATED TO TEST COMPETENCE WITH PROCEDURES, COMPARISONS, BRANCHING
;				AND ARRAY INDEXING IN ASSEMBLY.
; =========================================================================================


.386												; Target CPU (32-bit CPU)

.model flat,stdcall

.stack 4096											; Allocates stack space (4096 bytes) for program.

.data												; Variables are declared past this point

	temps DWORD 42, 62, 58, 71, 39, 66, 74			; Variable used to store an array of elements.
	arraySize DWORD LENGTHOF temps					; Variable used to store the length of the temps array.
	threshold DWORD 60								; Variable used to store comparison value.
	warmDayCount DWORD ?							; Variable used to store the amount of days that are warm based on temps.

ExitProcess proto,dwExitCode:dword 

.code												; Instructions go past this point

main proc											; Main procedure (function) starts here.

	mov ecx, arraySize								; (used in countWarmDay procedure) Initialize ecx as the counter for a loop with a value of the array length. ECX = 7
	mov edx, threshold								; (used in countWarmDay procedure) Initialize edx with the value stores inside threshold. EDX = 60
	mov esi, OFFSET temps							; (used in countWarmDay procedure) Initialize esi with the value of memory address for numbers array. EDX = numbers array address
	
	call countWarmDays								; call countWarmDays procedure (function).

	mov warmDayCount, eax							; Move the value stored inside eax to the warmDayCount variable in memory. warmDayCount = eax (total # of warm days)

	invoke ExitProcess,0							; Tell Operating System to terminate the program.

main endp											; Main procedure (function) ends here.







; --------------------------------------------------------------------------------------------------------------------------------------------------
countWarmDays proc									; countWarmDays procedure (function) starts here.
;
; Calculates the total number of warm days from an array. (32 bit integer - 4 bytes per element is hardcoded into loop used to calculate sum)
; Recieves: ECX (number of elements), EDX (threshold), ESI (array base address)
; Returns: EAX =  # of warm days.
; Requires: ECX, EDX, & ESI to be initialized before procedure is called to function properly.
; --------------------------------------------------------------------------------------------------------------------------------------------------

mov	eax, 0											; Initialize eax with the value of 0 to keep track of the total number of warm days. EAX = 0
mov ebx, 0											; Initialize ebx with the value of 0 to increment through the array while inside the loop. EBX = 0

L1:													; Loop created to get sum of array. L1 acts as the label to let program know where loop starts.
	
	mov edi, [esi + ebx * 4]						; Add the value stored in numbers[index value] to edi. (edi = eax + numbers[index])
	cmp edi, edx									; Compare the value stored in edx to the value in edi. if (EDI (array value) == EDX (60))

	jle lessThanOrEqualTo							; Jump to "lessThanOrEqualTo" if EDI < EDX.

	inc eax											; Increment the value of eax whenever value of EDI > EDX.

lessThanOrEqualTo:									; Jump to this point in code if EDI < EDX.

	inc ebx											; Increment the value of esi to cycle through array. (esi++)

loop L1												; Let program know to repeat loop again until ecx = 0. ecx automatically decrements each loop.

	ret												; return to main procedure (function).

countWarmDays endp									; sumArray procedure (function) ends here.








end main											; Code for "linker", lets program know the entry point is the main procedure (function)