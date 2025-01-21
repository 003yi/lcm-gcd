INCLUDE Irvine32.inc
.data
sPrompt BYTE "Please enter two integers: ",0
sLCM BYTE "The LCM is ",0
sGCD BYTE "The GCD is ",0
sstr BYTE "Cannot find LCM!",0
sstring BYTE "----",0
x SDWORD ?
y SDWORD ?
result SDWORD ?
sum BYTE ?
.code
main PROC
    L1: 
        mov  edx,OFFSET sPrompt
        call WriteString
        call crlf
 
        call ReadInt   ;輸入x
        mov x,eax
        mov ecx,eax   
 
        call ReadInt   ;輸入y
        mov y,eax
        mov ebx,eax   ;y存至ebx

        mov eax,ecx   ;x存至eax
        mov sum,0
 
        call GCD
        cmp sum,0
        je L2
        push edx
        mov  edx,OFFSET sstr
        call WriteString
        call crlf
        mov  edx,OFFSET sGCD
        call WriteString
        pop edx
        mov eax,edx
        call WriteDec
        call crlf
        mov  edx,OFFSET sstring
        call WriteString
        call crlf
        jmp L1
    L2: 
        call LCM
        mov  edx,OFFSET sstring
        call WriteString
        call crlf
        jmp L1
        exit
main ENDP
;---------------------------------------------------------
GCD PROC 
    cmp eax,0
    jge L2
    add sum,1
    neg eax
L2:
    cmp ebx,0
    jge L1
    add sum,1
    neg ebx
L1: cdq
    idiv ebx
    mov eax,ebx 
    mov ebx,edx 
    cmp ebx,0
    jg L1
    mov edx,eax ;將算出的GCD值存至edx
    ret
GCD ENDP
;--------------------------------------------------
LCM PROC
    mov eax,x
	mov result,edx
	mov edx,0
	imul y    ;edx:eax=product
	cdq
	idiv result
	mov edx,OFFSET sLCM
	call WriteString
	call WriteDec;印出商
	call crlf
	ret
LCM ENDP


END main