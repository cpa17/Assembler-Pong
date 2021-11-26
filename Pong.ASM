          .model small
          .486
;Konstanten
          esc_Code = 1Bh
          enter_code = 0Dh
;Variablen
          .data

          paddle1_X dw 7
          paddle1_Y dw 80
          paddle2_X dw 307
          paddle2_Y dw 80
          paddle_Size dw 5
          paddle1_Length dw 45
          paddle2_Length dw 45

          ball_Size dw 4

          ball_X dw 160
          ball_Y dw 100

          x_Speed dw 2
          y_Speed dw 1

          score1 db 0
          score2 db 0

          player1 db "Spieler 1 gewinnt!",'$'
          player2 db "Spieler 2 gewinnt!", '$'

          oldIOFF	dw ?
          oldISeg dw ?
          counter dw 1

          menu_Screen  db " Pong von Christoph Pascal Ahlner ",'$'
          menu_Start   db " Starten ",'$'
          menu_Ende    db " Beenden ",'$'

          number dw 0
;Code Beginn
          .code

          include PongProc.ASM

;Interrupt Routine
ISR:
          push ds                                  ; sichern ds
          push ax                                  ; sichern ax
          mov ax, @DATA                            ; sichern von data in ax
          mov ds, ax                               ; ax in ds sichern
          dec counter                              ; counter - 1
          pop ax                                   ; ax wiederherstellen
          pop ds                                   ; ds wiederherstellen
          iret

Beginn:
          mov ax, @DATA                             ; sichern von data in ax
          mov ds, ax                                ; ax in ds sichern
                                                    ; Lesen alter VT Eintrag
          mov al, 1Ch                               ; interrupt number
	        mov ah, 35h                               ; Get Interrupt Vector
      		int 21h                                   ; DOS Function Dispatcher
                                                    ; es:bx Adresse alte ISR
                                                    ; Sichern
          mov oldIOFF, bx
      		mov oldISeg, es
		                                                ; Eintragen neue ISR
          push ds                                   ; sichern ds
          push cs
          pop ds	                                  ; ds <- cs
          mov dx, OFFSET ISR                        ; Adresse in ds:dx
          mov al, 1Ch	                              ; <vn>
          mov ah, 25h                               ; set Interrupt Vector
          int 21h                                   ; DOS Function Dispatcher
          pop ds	                                  ; Wiederherstellen ds

menu:


          mov ah, 00h                               ; Video mode
          mov al, 13h                               ; 320x200 256 color graphics (VGA)
          int 10h                                   ; Video BIOS Services

          call print_Menu

          mov ax, 7                                 ; Set Mouse Horizontal Min/Max Position
          mov cx, 0                                 ; min pos
          mov dx, 635                               ; max pos
          int 33h                                   ; Mouse Function Calls

          mov ax, 8                                 ; Set Mouse Vertical Min/Max Position
          mov cx,0                                  ; min pos
          mov dx, 195                               ; max pos
          int 33h                                   ; Mouse Function Calls

          mov ax, 4                                 ; Set Mouse Cursor Position
          mov cx, 300                               ; horizontal position
          mov dx, 130                               ; vertical position
          int 33h                                   ; Mouse Function Calls

          mov ax, 1                                 ; Show Mouse Cursor
          int 33h                                   ; Mouse Function Calls

          start_Click:

                    call check_Position_Start

          end_Click:

                    call check_Position_End

          start_Game:

                    mov ah, 00h                     ; Video mode
                    mov al, 13h                     ; 320x200 256 color graphics (VGA)
                    int 10h                         ; Video BIOS Services
                    mov ax, 2                       ; Hide Mouse Cursor
                    int 33h                         ; Mouse Function Calls
                    jmp endlLoop

          end_Game:

                    jmp ende

endlLoop:

          mov ah, 1                                 ; Get keystroke status
          int 16h                                   ; Keyboard BIOS Services
          jz gameLoop
          xor ah,ah
          cmp al, esc_Code
          je ende

gameLoop:
          mov bx, counter
          cmp bx, 0
          jg end_if
          call print_scores
          call move_ball
          call draw_ball
          call move_paddle
          call draw_paddle1
          call draw_paddle2
          mov bx, 1
          mov counter, bx
end_if:
          jmp endlLoop
ende:
          mov dx, oldIOFF
          mov ax, oldISeg
          mov ds, ax
          mov al, 1Ch                           ; interrupt number
          mov ah, 25h                           ; set Interrupt Vector
          int 21h                               ; DOS Function Dispatcher
          mov ax, 3                             ; Löschen Bildschirm, Zeichenbildschirm
          int 10h                               ; Video BIOS Services
          mov ah, 4ch                           ; Terminate Process With Return Code
          int 21h                               ; DOS Function Dispatcher
          .stack 100h
          end Beginn
