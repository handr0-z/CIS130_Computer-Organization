;   TITLE Integer operation             (Exam4.asm)
;-----------------------------------------------------------------------------------------------------------
;   CIS130- Computer Organization Exam4
;   Student Name: Alejandro Pantoja-Zurita
;-----------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------
; 	This program will use an array in memory. you are asked to implements several procedures in assembly 
;   language to work with these numbers to produce the result as specified in the requirements for the 
;   particular procedures and displays the results to user
;
;   Grading Policy:
;
;	Use the correct registers for in your program		10 points
;	Use the correct movement statements				    10 points
;	Use the correct addition statements				    10 points
;	Use the correct multiplication statements			10 points
;	Use the correct label and loop statements			10 points
;	Use the correct comparison and jump statements	    10 points
;	Your program correct compile and run				10 points
;	You have the correct results					    10 points
;	Good comments									    10 points
;   Pseudocode conversions                              10 points

; 	TO DO:
; 	Write code to implement the requirements for procedures : ArrayMultiplicationDivision   ----- [DONE]
;   Write code to implement the requirements for procedures : ArrayAverage                  ----- [DONE]
; 	Write code to implement the requirements for procedure: ArraySumEven                    ----- [DONE]
;   You also need to translate these three method to pseudocode, java, or C++ code          ----- [DONE]
;   Make sure you can compile and run your code.                                            ----- [DONE]
;   You have to document your code with comments.                                           ----- [DONE]
;-----------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------
.386
.model flat,stdcall
.stack 4096

    INTEGER_COUNT = 6

.data
    array DWORD  99, 75, 5, 2, 3, 6
    divider DWORD 2
    sum DWORD ?                         ; Variable created for testing/ visual clairfy.
    result DWORD ?                      ; Variable created for testing/ visual clairfy.
    average DWORD ?                     ; Variable created for testing/ visual clairfy.
    sumIfEven DWORD ?                   ; Variable created for testing/ visual clairfy.
    ExitProcess proto,dwExitCode:dword

.code 

;-----------------------------------------------------------------------------------------------------------
; You do not need to change any code in the main procedure
;-----------------------------------------------------------------------------------------------------------

main PROC
    mov    esi,OFFSET array             ; initialize esi to start at beginning of array.
    mov    ecx,INTEGER_COUNT            ; initialize ecx with total number of elements in array.
    call   ArraySum

    mov    sum, eax                     ; store sum of array into sum variable (for visual clarity)

    mov    esi,OFFSET array             ; re-initialize esi to start at beginning of array.
    mov    ecx,INTEGER_COUNT            ; re-initialize ecx with total number of elements in array.
    call   ArrayMultiplicationDivision  

    mov    result, eax                  ; store result in variable (for visual clarity)

    mov    esi,OFFSET array             ; re-initialize esi to start at beginning of array.
    mov    ecx,INTEGER_COUNT            ; re-initialize ecx with total number of elements in array.           
    call   ArrayAverage                 

    mov    average, eax                 ; store average value of array in variable (for visual clarity)

    mov    esi,OFFSET array             ; re-initialize esi to start at beginning of array.
    mov    ecx,INTEGER_COUNT            ; re-initialize ecx with total number of elements in array.     
    call   ArraySumEven                 

    mov    sumIfEven, eax               ; store sum of even element in array in variable (for visual clarity)

	invoke ExitProcess,0
main ENDP


;-----------------------------------------------------------------------------------------------------------
ArraySum PROC USES esi ecx
;
; Calculates the sum of an array of 32-bit integers.
;
; Receives: ESI points to the array, ECX = array size
; Returns:  EAX = sum of the array elements
;-----------------------------------------------------------------------------------------------------------
    
    mov 	eax,0        			    ; set the sum to zero
L1: add    	eax,[esi]        		    ; add each integer to sum
    add   	esi,TYPE DWORD    		    ; point to next integer
    loop    L1            			    ; repeat for array size
    ret          
    ; sum is in EAX
ArraySum ENDP


;-----------------------------------------------------------------------------------------------------------
ArrayMultiplicationDivision PROC USES esi ecx
;
; Calculate the multiplications for an array of 32-bit integers
;
; You need to implement the code in this procedure to calculate products of all the numbers in the array
;   and then divided the result by the number of elements in the array.
; For example: if user enters 1, 2, 3, 4, 5, 6.  
; The final result should be like the eax = (1 * 2 * 3 * 4 * 5 * 6)/ 6 (INTERGER_COUNT, which is the number
;   of elements in the array)
; Your program should still work if you changed the INTERGER_COUNT 
; Please document your code with comments
;
; Receives: ESI points to the array, ECX = array size
; Returns:  EAX = result of the calculation
;-----------------------------------------------------------------------------------------------------------
    mov     eax, 1                      ; set eax to 1 to ensure multiplication for any values.
    mov     edx, ecx                    ; make a copy of total number of elements in array.
    push    edx                         ; store value of ecx in stack for future use in stack.
    mov     edx, 0                      ; clear contents of edx (in case edx is needed)

L1: 
    push    edx                         ; store value in edx for future use in stack. (Assume carryover)
    mov     ebx, [esi]                  ; move element of array into ebx.
    mul     ebx                         ; multiply eax by element stored in ebx.
                                        ; result of initial multiplication is is stored in EDX:EAX (64-bits)
    
    mov     edi, eax                    ; move data in eax (low value) to edi.
    mov     ebp, edx                    ; move data in edx (carry value) to ebp.
                                        ; result of initial multiplication is now stored in EBP:EDI

    pop     eax                         ; get original value stored in edx from stack and place in eax.
    mul     ebx                         ; multiply eax by element stored in ebx.
                                        ; result of 2nd multiplication (carry value) is is stored in EDX:EAX
                                        ; value stored in EDX is now irrelevant since we only need 64-bits
                                        ;   for division.

    add     eax, ebp                    ; add data in ebp (carry value) to eax. EAX = EAX + EBP
    mov     edx, eax                    ; move value of eax (carry value) to edx. EDX = EAX
    mov     eax, edi                    ; move value of edi (low value) to eax. EAX = EDX
                                        ; final result of multiplication is EDX:EAX

    add     esi, TYPE DWORD             ; increment esi by 4 to jump to next element in DWORD array.
    loop    L1                          ; jump L1 in ArrayMultiplicationDivision procedure if ECX != 0.

    pop     ecx                         ; move total number of element back into ecx.
    div     ecx                         ; divide EDX:EAX by value stored in ecx.

	ret
    ; result is in EAX
ArrayMultiplicationDivision ENDP


;-----------------------------------------------------------------------------------------------------------
; Provide the corresponding pseudocode, Java, or c++ equivalent to implement the same calculations. 
; NOTE: this pseudo code will not be compiled by the assembler, but to use it as documentation 
; and showing your understanding between assembly language and high level computer language. 
; Your high language pseudo code should be this in this comments section.
;-----------------------------------------------------------------------------------------------------------
;-- Your pseudocode for ArrayMultiplicationDivision procedure ----------------------------------------------
; int result = 1;
; for (int i = 0; i < array.length; i++){result = result * array[i];}
; result = result / array.length;
; System.out.println("Result of multiplaction then division by number of items: " + result);
;-----------------------------------------------------------------------------------------------------------


;-----------------------------------------------------------------------------------------------------------
ArrayAverage PROC USES esi ecx
;
; Calculate the average for an array of 32-bit integers
;
; You need to implement the code in this procedure to calculate avarge of the array entered by the user
; For example: if user enters 1, 2, 3, 4, 5, 6  
; The final result should be = (1 + 2 +3 + 4 + 5 + 6) / 6
; Your program should still work if you changed the INTERGER_COUNT 
; Please document your steps
;
; Receives: ESI points to the array, ECX = array size
; Returns:  EAX = result of the calculation
;-----------------------------------------------------------------------------------------------------------
    mov     eax, 0                      ; set eax to 0 for the initial average value.
    mov     edx, ecx                    ; make a copy of total number of elements in array.
    push    edx                         ; store value of ecx in stack for future use in stack.
    mov     edx, 0                      ; clear contents of edx

L1: 
    add     eax, [esi]                  ; move element of array into eax.
    add     esi, TYPE DWORD             ; increment esi by 4 to jump to next element in DWORD array.
    loop    L1                          ; jump to L1 in ArrayAverage procedure if ECX != 0.

    pop     ecx                         ; move total number of element back into ecx.
    div     ecx                         ; divide EDX:EAX by value stored in ecx.

	ret
ArrayAverage ENDP


;-----------------------------------------------------------------------------------------------------------
; Provide the corresponding pseudocode, Java, or c++ equivalent to implement the same calculations. 
; NOTE: this pseudo code will not be compiled by the assembler, but to use it as documentation 
; and showing your understanding between assembly language and high level computer language. 
; Your high language pseudo code should be this in this comments section.
;-----------------------------------------------------------------------------------------------------------
;-- Your pseudocode for ArrayAverage procedure -------------------------------------------------------------
; int average = 0;
; for (int i = 0; i < array.length; i++){average = average + array[i];}
; average = average / array.length;
; System.out.println("Average of numbers inside array: " + average);
;-----------------------------------------------------------------------------------------------------------


;-----------------------------------------------------------------------------------------------------------
ArraySumEven PROC USES esi ecx
;
; Calculate the sum of the array, only summarize the even numbers
;
; You need to implement the code in this procedure to add up only the even numbers in this array
; For example, if user enter number 3, 5, 6, 2, 11, 10, the result = 6 + 2 + 10, ignore 3, 5, and 11
; Your program should still work if you changed the INTERGER_COUNT 
; Please document your steps
;
; Receives: ESI points to the array, ECX = array size
; Returns:  EAX = result of the calculation
;-----------------------------------------------------------------------------------------------------------
    mov     eax, 0                      ; set eax with to 0 for initial sum value.

L1: 
    mov     ebx, [esi]                  ; move element of array into ebx.
    test    ebx, 1                      ; Test if value in ebx is even or odd.

    jnz notEven                         ; if not even. ZF == 0.
    add     eax, ebx                    ; add ebx into eax. EAX = EAX + EBX.

    notEven:                            ; skip adding current element in ebx into eax.
    add     esi, TYPE DWORD             ; increment esi by 4 to jump to next element in DWORD array.
    loop    L1                          ; jump to L1 in ArrayAverage procedure if ECX != 0.
    ret
ArraySumEven ENDP


;-----------------------------------------------------------------------------------------------------------
; Provide the corresponding pseudocode, Java, or c++ equivalent to implement the same calculations. 
; NOTE: this pseudo code will not be compiled by the assembler, but to use it as documentation 
; and showing your understanding between assembly language and high level computer language. 
; Your high language pseudo code should be this in this comments section.
;-----------------------------------------------------------------------------------------------------------
;-- Your pseudocode for ArraySumEven procedure -------------------------------------------------------------
; int sum = 0;
; for (int i = 0; i < array.length; i++)
; {
;   if (array[i] % 2 == 0){sum = sum + array[i];}
; }
; System.out.println("Sum of Even Numbers: " + sum);
;-----------------------------------------------------------------------------------------------------------

END main