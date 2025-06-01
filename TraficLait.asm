.386
.model flat, stdcall
option casemap:none

INCLUDE Irvine32.inc

.data
    red_timer    BYTE 5
    yellow_timer BYTE 3
    green_timer  BYTE 4
    current_time BYTE 0
    timer_state  BYTE 0        ; 0=Red, 1=Yellow, 2=Green

    msg1         BYTE "Enter Red Light Time (1-9): ", 0
    msg2         BYTE "Enter Yellow Light Time (1-9): ", 0
    msg3         BYTE "Enter Green Light Time (1-9): ", 0
    msg_done     BYTE "Press any key to start...", 0

    phase_red    BYTE "RED PHASE", 0
    phase_yellow BYTE "YELLOW PHASE", 0
    phase_green  BYTE "GREEN PHASE", 0

    light_char   BYTE 219
    bar_char     BYTE 178

    ascii_top    BYTE "******************************", 0
    ascii_side   BYTE "*", 0
    ascii_bottom BYTE "******************************", 0

.code
main PROC
    call Clrscr
    call GetTimeInput

    mov edx, OFFSET msg_done
    call WriteString
    call WaitMsg
    call Clrscr

MainLoop:
    cmp timer_state, 0
    je RedPhase
    cmp timer_state, 1
    je YellowPhase
    cmp timer_state, 2
    je GreenPhase

RedPhase:
    mov al, red_timer
    mov current_time, al
    call Clrscr
    mov eax, red
    call ShowLightFrame
    mov edx, OFFSET phase_red
    mov eax, red
    call ShowPhaseName
    mov eax, red
    call ShowLight
    mov timer_state, 1
    jmp MainLoop

YellowPhase:
    mov al, yellow_timer
    mov current_time, al
    call Clrscr
    mov eax, yellow
    call ShowLightFrame
    mov edx, OFFSET phase_yellow
    mov eax, yellow
    call ShowPhaseName
    mov eax, yellow
    call ShowLight
    mov timer_state, 2
    jmp MainLoop

GreenPhase:
    mov al, green_timer
    mov current_time, al
    call Clrscr
    mov eax, green
    call ShowLightFrame
    mov edx, OFFSET phase_green
    mov eax, green
    call ShowPhaseName
    mov eax, green
    call ShowLight
    mov timer_state, 0
    jmp MainLoop

    invoke ExitProcess, 0
main ENDP

;-----------------------------------------
ShowLight PROC
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, eax

LightLoop:
    ; Light block
    mov dh, 7
    mov dl, 40
    call Gotoxy
    mov eax, ebx
    call SetTextColor
    mov al, light_char
    call WriteChar

    ; Countdown
    mov dh, 15
    mov dl, 38
    call Gotoxy
    mov eax, white
    call SetTextColor
    movzx eax, current_time
    call WriteInt

    ; Progress Bar (max 20)
    mov dh, 17
    mov dl, 30
    call Gotoxy
    movzx ecx, current_time
    cmp ecx, 20
    jbe BarOk
    mov ecx, 20
BarOk:
    mov eax, lightGray
    call SetTextColor
BarLoop:
    mov al, bar_char
    call WriteChar
    loop BarLoop

    ; Check key
    call ReadKey
    jz NoKeyPressed
    invoke ExitProcess, 0

NoKeyPressed:
    ; Delay 1s
    mov eax, 1000
    call Delay

    dec current_time
    jnz LightLoop

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ShowLight ENDP

;-----------------------------------------
ShowLightFrame PROC
    push eax
    push ecx
    push edx

    mov eax, white
    call SetTextColor

    mov dh, 5
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET ascii_top
    call WriteString

    mov ecx, 6
DrawSides:
    mov dh, cl
    add dh, 5
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET ascii_side
    call WriteString
    loop DrawSides

    mov dh, 13
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET ascii_bottom
    call WriteString

    pop edx
    pop ecx
    pop eax
    ret
ShowLightFrame ENDP

;-----------------------------------------
ShowPhaseName PROC
    push eax
    push edx

    mov dh, 3
    mov dl, 35
    call Gotoxy
    call SetTextColor
    call WriteString

    pop edx
    pop eax
    ret
ShowPhaseName ENDP

;-----------------------------------------
GetTimeInput PROC
    mov edx, OFFSET msg1
    call WriteString
    call ReadInt
    cmp eax, 1
    jb InvalidRed
    cmp eax, 9
    ja InvalidRed
    mov red_timer, al
    jmp NextYellow
InvalidRed:
    mov red_timer, 5

NextYellow:
    mov edx, OFFSET msg2
    call WriteString
    call ReadInt
    cmp eax, 1
    jb InvalidYellow
    cmp eax, 9
    ja InvalidYellow
    mov yellow_timer, al
    jmp NextGreen
InvalidYellow:
    mov yellow_timer, 3

NextGreen:
    mov edx, OFFSET msg3
    call WriteString
    call ReadInt
    cmp eax, 1
    jb InvalidGreen
    cmp eax, 9
    ja InvalidGreen
    mov green_timer, al
    ret
InvalidGreen:
    mov green_timer, 4
    ret
GetTimeInput ENDP

END main
