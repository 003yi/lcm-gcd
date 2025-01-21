INCLUDE Irvine32.inc
.data
sPrompt BYTE "Please enter two integers: ",0
sLCM BYTE "The LCM is ",0
sGCD BYTE "The GCD is ",0
sstr BYTE "Cannot find LCM!",0
sstring BYTE "----",0
x SDWORD ?
y SDWORD ?
z SDWORD ?
result SDWORD ?
LCM_xy SDWORD ?
gcd_xyz SDWORD ?
sum BYTE ?
.code
main PROC
    L1: 
        mov  edx,OFFSET sPrompt
        call WriteString
        call crlf
 
        call ReadInt ;輸入x
        mov x,eax
        mov ecx,eax
 
        call ReadInt ;輸入y
        mov y,eax
        mov ebx,eax  ;y存至ebx

        call ReadInt ;輸入z
        mov z,eax
        mov edx,eax

        mov eax,ecx  ;x存至eax
        mov ecx,edx  ;z存至ecx
        mov sum,0

        call GCDxy
        cmp sum,0
        je L2
        call LCMxy
        call GCDxyz
        cmp sum,0
        je L2
    L3: push edx
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
        call LCMxy
        call GCDxyz
        cmp sum,0
        jne L3
        call LCMxyz
        mov  edx,OFFSET sstring
        call WriteString
        call crlf
        jmp L1
        exit
main ENDP
;---------------------------------------------------------
GCDxy PROC 
    cmp eax,0
    jge L2
    add sum,1
    neg eax
    mov x,eax
L2:
    cmp ebx,0
    jge L1
    add sum,1
    neg ebx
    mov y,ebx
L1: cdq
    idiv ebx
    mov eax,ebx 
    mov ebx,edx 
    cmp ebx,0
    jg L1
    mov edx,eax ;將算出的GCD值存至edx
    ret
GCDxy ENDP
;--------------------------------------------------
GCDxyz PROC 
    mov eax,ecx
    mov ebx,LCM_xy
    cmp eax,0
    jge L1
    add sum,1
    neg eax
L1: cdq
    idiv ebx
    mov eax,ebx 
    mov ebx,edx 
    cmp ebx,0
    jg L1
    mov edx,eax ;將算出的GCD值存至edx
    ret
GCDxyz ENDP
;--------------------------------------------------
LCMxy PROC
    mov eax,x
	mov result,edx ;把GCD(x,y)存至result
	mov edx,0
	imul y    ;edx:eax=product
	cdq
	idiv result
    mov LCM_xy,eax
	ret
LCMxy ENDP
;--------------------------------------------------
LCMxyz PROC
    mov eax,LCM_xy
	mov gcd_xyz,edx
	mov edx,0
	imul z    ;edx:eax=product
	cdq
	idiv gcd_xyz
	mov edx,OFFSET sLCM
	call WriteString
	call WriteDec;印出商
	call crlf
	ret
LCMxyz ENDP
END main