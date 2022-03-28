; main.asm - Main assembly file for usage with the cisc225-project template.
;	This project links with a subset of the Irvine library written in C/C++
;	and wrapper procedures written in assembly.

; Program Random Stars 
; Date: 03.22.2021
; Author: Afham Bashir 


.386
.model flat,c
.stack 4096

include cisc225.inc


.data
	n_stars sdword 1    ;variable to contain number of stars per row 
	outerloop dword 0	;used to preserve ecx as the code uses nested loops 

.code

main PROC

call Randomize    ;set randomizer 
mov ecx,9		  ;set loop counter for top 9 rows 
mov dh,1		  ;move cursor to row 1
mov dl,40		  ;move cursor to column 40 


L1: 
	mov outerloop,ecx ;presernve ecx for ouuter loop 
	call GotoXY       ;move cursor to xy 
	mov ecx,n_stars   ;set up counter for inner loop to print stars 
L2: 
	call print_star	  ;call print funnctino to output random asterick 
	loop L2		      ;keep printing stars for that row until ecx is zero 

	add n_stars,2     ; moving down a row, there will 2 more stars
	inc dh			  ; move down a row 
	dec dl			  ; move back left a column 
	mov ecx,outerloop ;revert ecx for outer loop
	loop L1			  

mov ecx,10 		  ;set loop counter for bottom 10 rows 

L3: 
	mov outerloop,ecx ;presernve ecx for ouuter loop 
	call GotoXY       ;move cursor to xy 
	mov ecx,n_stars   ;set counter for inner loop
L4: 
	call print_star	  ;call print funnction to output random asterick 
	loop L4			  ;set up counter for inner loop to print stars 

	sub n_stars,2     ;for the bottom part of row decrement number of stars per row
	inc dh			  ; move down a row 
	inc dl			  ; move right a column 
	mov ecx,outerloop ;revert ecx for 
	loop L3			 



call ReadChar		
;hold console window open until keystroke

call EndProgram	
; Terminates the program

	ret
main ENDP


;print random background/foreground asterisk 
print_star PROC
	
	mov eax,255        ; pick random colors up to 256 
	call RandomRange   ;set EAX to a random color 
	inc eax            ; to avoid black 
	call SetTextColor  ;Set Random foreground color 
	call RandomRange   ;set EAX to random numbers 
	mov al,'*'		   ;char to be output is asterisck 
	call WriteChar     ;output asterisck 

	ret
print_star ENDP 


END