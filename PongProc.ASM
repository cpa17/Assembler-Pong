          print_Menu proc

                    mov  dl, 3                    ; column
                    mov  dh, 2                    ; row
                    mov  bh, 0                    ; page
                    mov  ah, 02h                  ; Set cursor position
                    int  10h                      ; Video BIOS Services
                                                  ; Ausgabe überschrift
                    mov ah, 09h                   ; Print String
                    lea dx, menu_Screen           ; pointer to string
                    int 21h                       ; DOS Function Dispatcher

                    mov cx, 105                   ; x coordinate
                    mov dx, 40                    ; y coordinate

                    draw_start:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 0F6h        ; color blue
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw rectangle
                              inc cx
                              mov ax, cx
                              sub ax, 105
                              cmp ax, 100         ; width
                              jng draw_start

                              mov cx, 105
                              inc dx

                              mov ax, dx
                              sub ax, 40
                              cmp ax, 40           ; height
                              jng draw_start

                    mov cx, 105
                    mov dx, 100

                    draw_end:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 0F4h        ; color green
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw rectangle
                              inc cx
                              mov ax, cx
                              sub ax, 105
                              cmp ax, 100         ; width
                              jng draw_end

                              mov cx, 105
                              inc dx

                              mov ax, dx
                              sub ax, 100
                              cmp ax, 40          ; height
                              jng draw_end

                    mov  dl, 15                   ; column
                    mov  dh, 6                    ; row
                    mov  bh, 0                    ; page
                    mov  ah, 02h                  ; Set cursor position
                    int  10h                      ; Video BIOS Services
                                                  ; Start text
                    mov ah, 09h                   ; Print String
                    lea dx, menu_Start            ; pointer to string
                    int 21h                       ; DOS Function Dispatcher

                    mov  dl, 15                   ; column
                    mov  dh, 14                   ; row
                    mov  bh, 0                    ; page
                    mov  ah, 02h                  ; Set cursor position
                    int  10h                      ; Video BIOS Services
                                                  ; Ende Text
                    mov ah, 09h                   ; Print String
                    lea dx, menu_ende             ; pointer to string
                    int 21h                       ; DOS Function Dispatcher

                    ret
          print_Menu endp

          check_Position_Start proc
                                                  ; check click on start
                    mov ax, 3                     ; Get Mouse Position and Button Status
                    int 33h                       ; Mouse Function Calls

                    cmp bx, 1                     ; check left click
                    jne end_Click

                    min_Y:                        ; sart Y position
                              cmp dx, 40
                              jg max_Y
                              jmp end_Click

                    mov ax, 3
                    int 33h
                    cmp bx, 1                      ; check left release
                    je end_Click

                    max_Y:                         ; end of Y position
                              cmp dx, 80
                              jl min_X
                              jmp end_Click

                    min_X:                         ; start X Position
                              cmp cx, 210
                              jg max_X
                              jmp end_Click

                    max_X:                         ; end X position
                              cmp cx, 410
                              jl start_Game
                              jmp end_Click

                    ret
          check_Position_Start endp

          check_Position_End proc
                                                    ; check click on end
                    mov ax, 3                       ; Get Mouse Position and Button Status
                    int 33h                         ; Mouse Function Calls

                    cmp bx, 1                       ; check left click
                    jne start_Click

                    e_min_Y:                         ; sart Y position
                              cmp dx, 100
                              jg e_max_Y
                              jmp start_Click

                    mov ax, 3                       ; Get Mouse Position and Button Status
                    int 33h                         ; Mouse Function Calls
                    cmp bx, 1                        ; check left release
                    je start_Click

                    e_max_Y:                         ; end Y position
                              cmp dx, 140
                              jl e_min_X
                              jmp start_Click

                    e_min_X:                         ; sart X position
                              cmp cx, 210
                              jg e_max_X
                              jmp start_Click

                    e_max_X:                         ; end Y position
                              cmp cx, 410
                              jl end_Game
                              jmp start_Click

                    ret
          check_Position_End endp

          print_scores proc

                    mov  dl, 170                    ; column
                    mov  dh, 45                     ; row
                    mov  bh, 0                      ; page
                    mov  ah, 02h                    ; Set cursor position
                    int  10h                        ; Video BIOS Services

                    mov al, [score1]                ; ASCII charecter from Score1
                    mov bl, 0Fh                     ; foreground pixel color
                    mov bh, 0                       ; page
                    mov ah, 0eh                     ; Write Text in Teletype Mode
                    add al, '0'                     ; translate to ASCII
                    int 10h                         ; Video BIOS Services

                    mov al, ':'                     ; ASCII charecter
                    mov bl, 0Fh                     ; foreground pixel color
                    mov bh, 0                       ; page
                    mov ah, 0eh                     ; Write Text in Teletype Mode
                    int 10h                         ; Video BIOS Services

                    mov al, [score2]                ; ASCII charecter from Score2
                    mov bl, 0Fh                     ; foreground pixel color
                    mov bh, 0                       ; page
                    mov ah, 0eh                     ; Write Text in Teletype Mode
                    add al, '0'                     ; translate to ASCII
                    int 10h                         ; Video BIOS Services

                    ret
          print_scores endp

          draw_ball proc

                    mov cx, ball_X
                    mov dx, ball_Y

                    draw_dott:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 0Fh         ; color white
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw dott
                              inc cx
                              mov ax, cx
                              sub ax, ball_X
                              cmp Ax, ball_Size
                              jng draw_dott

                              mov cx, ball_X
                              inc dx

                              mov ax, dx
                              sub ax, ball_Y
                              cmp ax, ball_Size
                              jng draw_dott

                    ret
          draw_ball endp

          delete_Ball proc

                    mov cx, ball_X
                    mov dx, ball_Y

                    delete_dott:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 00h         ; color black
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw dott
                              inc cx
                              mov ax, cx
                              sub ax, ball_X
                              cmp Ax, ball_Size
                              jng delete_dott

                              mov cx, ball_X
                              inc dx

                              mov ax, dx
                              sub ax, ball_Y
                              cmp ax, ball_Size
                              jng delete_dott

                    ret
          delete_Ball endp

          move_Ball proc

                    call delete_Ball

                                                    ; let ball move
                    mov ax, x_Speed
                    add ball_X, ax                  ; adding speed to position

                    cmp ball_X, 0
                    jl neg_X                        ; check goal left
                    cmp ball_X, 317
                    jg neg_X                        ; check goal right

                    mov ax, y_Speed
                    add ball_Y, ax                  ; adding speed to position

                    cmp ball_Y, 0
                    jl neg_Y                        ; check top bounds
                    cmp ball_Y, 197
                    jg neg_Y                        ; check bottom bounds

                    check_Right:                    ; check collusion with right paddle

                              mov ax, ball_X
                              add ax, ball_Size
                              cmp ax, paddle2_X
                              jng check_Left

                              mov ax, paddle2_X
                              add ax, paddle_Size
                              cmp ball_X, ax
                              jnl check_Left

                              mov ax, ball_Y
                              add ax, ball_Size
                              cmp ax, paddle2_Y
                              jng check_Left

                              mov ax, paddle2_Y
                              add ax, paddle2_Length
                              cmp ball_Y, ax
                              jnl check_Left

                              cmp x_Speed, 7
                              jl inc_Speed
                              dec x_Speed
                              neg X_Speed
                              ret

                    inc_speed:                    ; colussion with paddle increase speed
                              inc x_Speed
                              neg x_Speed
                              call random
                              mov ax, number
                              mov y_Speed, ax
                              ret

                    check_Left:                     ; check collusion with left paddle

                              mov ax, ball_X
                              add ax, ball_Size
                              cmp ax, paddle1_X
                              jng next

                              mov ax, paddle1_X
                              add ax, paddle_Size
                              cmp ball_X, ax
                              jnl next

                              mov ax, ball_Y
                              add ax, ball_Size
                              cmp ax, paddle1_Y
                              jng next

                              mov ax, paddle1_Y
                              add ax, paddle1_Length
                              cmp ball_Y, ax
                              jnl next

                              cmp x_Speed, -7
                              jg dec_speed
                              inc x_Speed
                              neg x_Speed
                              ret

                    dec_speed:                    ; colussion with paddle increase speed
                              dec x_Speed
                              neg x_Speed
                              call random
                              mov ax, number
                              mov y_Speed, ax
                              ret

                    neg_X:                        ; negates X_Speed increas score
                              neg x_Speed
                              cmp ball_X, 0
                              jl score_2
                              cmp ball_X, 317
                              jg score_1
                              ret

                    neg_Y:                         ; negates Y_Speed
                              neg y_Speed
                              ret

                    score_1:                      ; add score for player1 and reset ball
                              call random
                              inc score1
                              cmp score1, 9
                              je  winner1
                              call delete_paddle1
                              sub paddle1_Length, 2
                              call draw_paddle1
                              mov x_Speed, -2
                              mov ax, number
                              mov y_Speed, ax
                              mov ball_X, 160
                              mov ball_Y, 100
                              ret

                    score_2:                      ; add score for player2 and reset ball
                              call random
                              inc score2
                              cmp score2, 9
                              je  winner2
                              call delete_paddle2
                              sub paddle2_Length, 2
                              call draw_paddle2
                              mov x_Speed, 2
                              mov ax, number
                              mov y_Speed, ax
                              mov ball_X, 160
                              mov ball_Y, 100
                              ret

                    winner1:                      ; player1 wins and reset board

                              mov  dl, 11         ; Column
                              mov  dh, 10         ; row
                              mov  bh, 0          ; page
                              mov  ah, 02h        ; set Cursor
                              int  10h            ; Video BIOS Services

                              mov ah, 09h         ; Print string
                              lea dx, player1     ; pointer to string
                              int 21h             ; DOS Function Dispatcher

                              mov score1, 0
                              mov score2, 0

                              mov paddle1_Y, 80
                              mov paddle2_Y, 80
                              mov paddle1_Length, 45
                              mov paddle2_Length, 45
                              mov ball_X, 160
                              mov ball_Y, 100

                              xor ah,ah
                              int 16h
                              cmp al, enter_Code
                              je menu
                              cmp al, esc_Code
                              je ende

                              ret

                    winner2:                      ; player2 wins and reset board

                              mov  dl, 11         ; Column
                              mov  dh, 10         ; row
                              mov  bh, 0          ; page
                              mov  ah, 02h        ; set Cursor
                              int  10h            ; Video BIOS Services

                              mov ah, 09h         ; Print string
                              lea dx, player2     ; pointer to string
                              int 21h             ; DOS Function Dispatcher

                              mov score1, 0
                              mov score2, 0

                              mov paddle1_Y, 80
                              mov paddle2_Y, 80
                              mov paddle1_Length, 45
                              mov paddle2_Length, 45
                              mov ball_X, 160
                              mov ball_Y, 100

                              xor ah,ah
                              int 16h
                              cmp al, enter_code
                              je menu
                              cmp al, esc_Code
                              je ende

                              ret
          move_Ball endp

          draw_paddle1 proc

                    mov cx, paddle1_X
                    mov dx, paddle1_Y

                    paddle1:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 0Fh         ; color white
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw line

                              inc cx
                              mov ax, cx
                              sub ax, paddle1_X
                              cmp ax, paddle_Size
                              jng paddle1

                              mov cx, paddle1_X
                              inc dx

                              mov ax, dx
                              sub ax, paddle1_Y
                              cmp ax, paddle1_Length
                              jng paddle1

                    ret
          draw_paddle1 endp

          draw_paddle2 proc

                    mov cx, paddle2_X
                    mov dx, paddle2_Y

                    paddle2:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 0Fh         ; color white
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw line

                              inc cx
                              mov ax, cx
                              sub ax, paddle2_X
                              cmp Ax, paddle_Size
                              jng paddle2

                              mov cx, paddle2_X
                              inc dx

                              mov ax, dx
                              sub ax, paddle2_Y
                              cmp ax, paddle2_Length
                              jng paddle2
                    ret
          draw_paddle2 endp

          delete_paddle1 proc

                    mov cx, paddle1_X
                    mov dx, paddle1_Y

                    black_paddle1:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 00h         ; color black
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw line

                              inc cx
                              mov ax, cx
                              sub ax, paddle1_X
                              cmp ax, paddle_Size
                              jng black_paddle1

                              mov cx, paddle1_X
                              inc dx

                              mov ax, dx
                              sub ax, paddle1_Y
                              cmp ax, paddle1_Length
                              jng black_paddle1

                    ret
          delete_paddle1 endp

          delete_paddle2 proc

                    mov cx, paddle2_X
                    mov dx, paddle2_Y

                    black_paddle2:
                              mov ah, 0Ch         ; Write Graphics Pixel at Coordinate
                              mov al, 00h         ; color black
                              mov bh, 0           ; page
                              int 10h             ; Video BIOS Services
                                                  ; draw line

                              inc cx
                              mov ax, cx
                              sub ax, paddle2_X
                              cmp Ax, paddle_Size
                              jng black_paddle2

                              mov cx, paddle2_X
                              inc dx

                              mov ax, dx
                              sub ax, paddle2_Y
                              cmp ax, paddle2_Length
                              jng black_paddle2
                    ret
          delete_paddle2 endp

          move_paddle proc

                    mov ah, 1                   ; Get keystroke status
                    int 16h                     ; Keyboard BIOS Services
                    jz next

                    mov ah, 0                   ; Wait for keystroke and read
                    int 16h                     ; Keyboard BIOS Services

                    cmp al, 'W'
                    je move_up1
                    cmp al, 'w'
                    je move_up1
                    cmp al, 's'
                    je move_down1
                    cmp al, 'S'
                    je move_down1
                    cmp al, 'O'
                    je move_up2
                    cmp al, 'o'
                    je move_up2
                    cmp al, 'L'
                    je move_down2
                    cmp al, 'l'
                    je move_down2
                    ret

                    move_up1:

                            call delete_paddle1
                            cmp paddle1_Y, 1
                            jl next
                            sub paddle1_Y, 5
                            ret

                    move_down1:

                            call delete_paddle1
                            mov ax, 199
                            sub ax, paddle1_Length
                            cmp paddle1_Y, ax
                            jg next
                            add paddle1_Y, 5
                            ret

                  move_up2:

                            call delete_paddle2
                            cmp paddle2_Y, 1
                            jl next
                            sub paddle2_Y, 5
                            ret

                  move_down2:

                            call delete_paddle2
                            mov ax, 199
                            sub ax, paddle2_Length
                            cmp paddle2_Y, ax
                            jg next
                            add paddle2_Y, 5
                            ret

                    next:
                            ret
          move_paddle endp

          random proc                               ; random Number source: https://www.youtube.com/c/ARTechniques/videos

                    new:                            ; generate a random number between -3 and 3
                              call delay
                              mov ah, 0h            ; Read system clock counter
                              int 1ah               ; System and Real Time Clock BIOS Services

                              mov ax, dx            ; clock from dx in ax
                              mov dx, 0             ; clear dx
                              mov bx, 10            ; divisor for number between 0 and 9
                              div bx                ; ax / bx

                              mov number, dx

                              cmp number, 6
                              jg new

                              sub number, 3

                              ret
           random endp

           delay proc

                    mov cx, 1
                    start_Delay:
                              cmp cx, 30000
                              je end_Delay
                              inc cx
                              jmp start_Delay
                    end_Delay:
                              ret
          delay endp
