; ZACK GABRIEL J. VALENZUELA
; CINEMA TICKET RESERVATION SYSTEM
; NASM 32-bit Linux application using int 0x80 system calls
; TN24

%macro PRINT_TEXT 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro PRINT_NUMBER 0
    call print_uint
%endmacro

section .data

app_title                   db 10, '==============================================', 10, '       STARLIGHT CINEMA TICKET SYSTEM', 10, '==============================================', 10
app_title_len               equ $ - app_title
menu_text                   db 10, '--------------- MAIN MENU ----------------', 10, '1. Display available movies and schedules', 10, '2. Create a ticket reservation', 10, '3. View saved reservation summaries', 10, '4. Exit', 10, 'Choose an option: '
menu_text_len               equ $ - menu_text
art_text                    db 10, '       .---------------------------------.', 10, '       |  .---------------------------.  |', 10, '       |  |   STARLIGHT CINEMA HOUSE  |  |', 10, '       |  |  *  *  *  *  *  *  *  *   |  |', 10, '       |  |  SCREENING TONIGHT       |  |', 10, '       |  |   ________________       |  |', 10, '       |  |  |                |      |  |', 10, '       |  |  |   MOVIE TIME   |      |  |', 10, '       |  |  |________________|      |  |', 10, '       |  |    o          o          |  |', 10, '       |  |  __|__________|__        |  |', 10, '       |  | |  TICKETS  TICKETS |    |  |', 10, '       |  | |___________________|    |  |', 10, "       |  '---------------------------'  |", 10, "       '---------------------------------'", 10, 10
art_text_len                equ $ - art_text
movie_heading               db 'AVAILABLE MOVIES', 10
movie_heading_len           equ $ - movie_heading
movie_1_text                db '1. Starlight Journey  - Sci-Fi Adventure - PHP 250 per ticket', 10, "               *   .   *", 10, "                  /\\", 10, "                 /  \\", 10, "                /____\\", 10, "               | STAR |", 10, "               | SHIP |", 10, "               |______|", 10, "                 ||||", 10, "                /_||_\\", 10
movie_1_len                 equ $ - movie_1_text
movie_2_text                db '2. Midnight Chase    - Action Thriller - PHP 220 per ticket', 10, "          MIDNIGHT CHASE", 10, "     ________________________", 10, "      ___/|_|_|_|_|_|_|___", 10, "     |   ACTION THRILLER   |", 10, "   O==|___________________|==O", 10, "      O                 O", 10, "  ================================", 10
movie_2_len                 equ $ - movie_2_text
movie_3_text                db '3. Ocean of Dreams    - Family Fantasy - PHP 200 per ticket', 10, "       o        o        o", 10, "       ><(((o>    <o)))>", 10, "    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~", 10, "       +------------------+", 10, "       | OCEAN OF DREAMS |", 10, "       +------------------+", 10, "    ~~~~~~~~~~~~~~~~~~~~~~~~~", 10
movie_3_len                 equ $ - movie_3_text
schedule_heading            db 10, 'AVAILABLE SCHEDULES', 10
schedule_heading_len        equ $ - schedule_heading
schedule_1_text             db '1. 10:00 AM', 10
schedule_1_len              equ $ - schedule_1_text
schedule_2_text             db '2. 1:30 PM', 10
schedule_2_len              equ $ - schedule_2_text
schedule_3_text             db '3. 6:00 PM', 10
schedule_3_len              equ $ - schedule_3_text
prompt_movie                db 'Enter movie number (1-3): '
prompt_movie_len            equ $ - prompt_movie
prompt_schedule             db 'Enter schedule number (1-3): '
prompt_schedule_len         equ $ - prompt_schedule
prompt_quantity             db 'Enter ticket quantity (1-10): '
prompt_quantity_len         equ $ - prompt_quantity
prompt_customer             db 'Enter customer name: '
prompt_customer_len         equ $ - prompt_customer
invalid_number              db 'Please enter digits only.', 10
invalid_number_len          equ $ - invalid_number
invalid_menu                db 'Invalid menu option. Choose a number from 1 to 4.', 10
invalid_menu_len            equ $ - invalid_menu
invalid_movie               db 'Invalid movie number. Choose 1, 2, or 3.', 10
invalid_movie_len           equ $ - invalid_movie
invalid_schedule            db 'Invalid schedule number. Choose 1, 2, or 3.', 10
invalid_schedule_len        equ $ - invalid_schedule
invalid_quantity            db 'Quantity must be from 1 through 10.', 10
invalid_quantity_len        equ $ - invalid_quantity
empty_customer              db 'Customer name cannot be empty.', 10
empty_customer_len          equ $ - empty_customer
reservation_summary         db 10, '----------- RESERVATION SUMMARY -----------', 10, 0
reservation_summary_len     equ $ - reservation_summary - 1
label_customer              db 'Customer: ', 0
label_customer_len          equ $ - label_customer - 1
label_movie                 db 'Movie: ', 0
label_movie_len             equ $ - label_movie - 1
label_schedule              db 'Schedule: ', 0
label_schedule_len          equ $ - label_schedule - 1
label_quantity              db 'Tickets: ', 0
label_quantity_len          equ $ - label_quantity - 1
label_price                 db 'Price per ticket: PHP ', 0
label_price_len             equ $ - label_price - 1
label_total                 db 'Total amount: PHP ', 0
label_total_len             equ $ - label_total - 1
label_id                    db 'Reservation ID: ', 0
label_id_len                equ $ - label_id - 1
summary_file_heading        db '=========== RESERVATION SUMMARY ===========', 10, 0
summary_file_separator      db '--------------------------------------------', 10, 10, 0
confirm_save                db 10, 'Reservation summary saved to reservations.txt.', 10
confirm_save_len            equ $ - confirm_save
save_error                  db 10, 'Could not open a record file. Check folder permissions.', 10
save_error_len              equ $ - save_error
cancel_text                 db 'Reservation cancelled.', 10
cancel_text_len             equ $ - cancel_text
reservation_file            db 'reservations.txt', 0
reservation_view_title      db 10, '========== SAVED RESERVATION SUMMARIES ==========', 10
reservation_view_title_len  equ $ - reservation_view_title
no_records_text             db 'No saved reservation summaries found yet.', 10
no_records_len              equ $ - no_records_text
file_read_error             db 'Unable to read this record file.', 10
file_read_error_len         equ $ - file_read_error
newline_text                db 10, 0
newline_len                 equ $ - newline_text - 1
exit_text                   db 10, 'Thank you for using Starlight Cinema.', 10
exit_text_len               equ $ - exit_text
movie_name_1                db 'Starlight Journey', 0
movie_name_2                db 'Midnight Chase', 0
movie_name_3                db 'Ocean of Dreams', 0
schedule_name_1             db '10:00 AM', 0
schedule_name_2             db '1:30 PM', 0
schedule_name_3             db '6:00 PM', 0
movie_name_ptrs             dd movie_name_1, movie_name_2, movie_name_3
schedule_name_ptrs          dd schedule_name_1, schedule_name_2, schedule_name_3

section .bss
input_buffer                resb 129             ; 128 input bytes plus a safe terminator
number_buffer               resb 12              ; up to ten digits, terminator, spare byte
file_buffer                 resb 512             ; reusable block while displaying a file
file_descriptor             resd 1               ; active descriptor for record file I/O
number_length               resd 1               ; byte count produced by uint_to_buffer
menu_choice                 resd 1               ; chosen main menu number
movie_choice                resd 1               ; selected movie, numbered 1 through 3
schedule_choice             resd 1               ; selected time, numbered 1 through 3
quantity_value              resd 1               ; number of tickets requested
price_value                 resd 1               ; price for one ticket
total_value                 resd 1               ; quantity multiplied by ticket price
reservation_id              resd 1               ; increments after a successful save
movie_pointer               resd 1               ; address of selected movie name
schedule_pointer            resd 1               ; address of selected schedule name
file_found_data             resd 1               ; flag used when viewing a file
section .text

global _start
_start:
    mov dword [reservation_id], 1
    PRINT_TEXT app_title, app_title_len
main_menu:
    PRINT_TEXT menu_text, menu_text_len
    call read_integer
    cmp edx, 2
    je exit_program
    cmp edx, 1
    jne main_menu
    mov [menu_choice], eax
    cmp eax, 1
    je menu_display_movies
    cmp eax, 2
    je menu_create_reservation
    cmp eax, 3
    je menu_show_reservations
    cmp eax, 4
    je exit_program
    PRINT_TEXT invalid_menu, invalid_menu_len
    jmp main_menu
menu_display_movies:
    call display_movies
    jmp main_menu
menu_create_reservation:
    call create_reservation
    jmp main_menu
menu_show_reservations:
    call show_reservations
    jmp main_menu
exit_program:
    PRINT_TEXT exit_text, exit_text_len
    mov eax, 1
    xor ebx, ebx
    int 0x80

; display_movies
display_movies:
    push eax
    push ebx
    push ecx
    push edx
    PRINT_TEXT art_text, art_text_len
    PRINT_TEXT movie_heading, movie_heading_len
    PRINT_TEXT movie_1_text, movie_1_len
    PRINT_TEXT movie_2_text, movie_2_len
    PRINT_TEXT movie_3_text, movie_3_len
    PRINT_TEXT schedule_heading, schedule_heading_len
    PRINT_TEXT schedule_1_text, schedule_1_len
    PRINT_TEXT schedule_2_text, schedule_2_len
    PRINT_TEXT schedule_3_text, schedule_3_len
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; create_reservation
create_reservation:
    call display_movies

movie_input_loop:
    PRINT_TEXT prompt_movie, prompt_movie_len
    call read_integer
    cmp edx, 2
    je reservation_cancelled
    cmp edx, 1
    jne movie_input_loop
    cmp eax, 1
    jb movie_bad_input
    cmp eax, 3
    ja movie_bad_input
    mov [movie_choice], eax
    dec eax
    mov ebx, [movie_name_ptrs + eax * 4]
    mov [movie_pointer], ebx
    mov eax, [movie_choice]
    cmp eax, 1
    je set_movie_one_price
    cmp eax, 2
    je set_movie_two_price
    mov dword [price_value], 200
    jmp schedule_input_loop
set_movie_one_price: mov dword [price_value], 250
    jmp schedule_input_loop
set_movie_two_price: mov dword [price_value], 220
    jmp schedule_input_loop
movie_bad_input: PRINT_TEXT invalid_movie, invalid_movie_len
    jmp movie_input_loop

schedule_input_loop:
    PRINT_TEXT prompt_schedule, prompt_schedule_len
    call read_integer
    cmp edx, 2
    je reservation_cancelled
    cmp edx, 1
    jne schedule_input_loop
    cmp eax, 1
    jb schedule_bad_input
    cmp eax, 3
    ja schedule_bad_input
    mov [schedule_choice], eax
    dec eax
    mov ebx, [schedule_name_ptrs + eax * 4]
    mov [schedule_pointer], ebx
    jmp quantity_input_loop
schedule_bad_input: PRINT_TEXT invalid_schedule, invalid_schedule_len
    jmp schedule_input_loop

quantity_input_loop:
    PRINT_TEXT prompt_quantity, prompt_quantity_len
    call read_integer
    cmp edx, 2
    je reservation_cancelled
    cmp edx, 1
    jne quantity_input_loop
    cmp eax, 1
    jb quantity_bad_input
    cmp eax, 10
    ja quantity_bad_input
    mov [quantity_value], eax
    mov ebx, [price_value]
    mul ebx
    mov [total_value], eax
    jmp customer_input_loop
quantity_bad_input: PRINT_TEXT invalid_quantity, invalid_quantity_len
    jmp quantity_input_loop

customer_input_loop:
    PRINT_TEXT prompt_customer, prompt_customer_len
    call read_line
    cmp eax, 0
    je reservation_cancelled
    call sanitize_customer_name
    cmp eax, 0
    je customer_empty_name
    jmp show_reservation_summary
customer_empty_name: PRINT_TEXT empty_customer, empty_customer_len
    jmp customer_input_loop

show_reservation_summary:
    call display_reservation_summary
    call save_reservation_record
    cmp edx, 1
    jne reservation_save_failed
    ; The ID is unique during the current program run.
    PRINT_TEXT confirm_save, confirm_save_len
    inc dword [reservation_id]
    ret
reservation_save_failed: PRINT_TEXT save_error, save_error_len
    ret
reservation_cancelled: PRINT_TEXT cancel_text, cancel_text_len
    ret

; display_reservation_summary
display_reservation_summary:
    push eax
    push ebx
    push ecx
    push edx
    PRINT_TEXT reservation_summary, reservation_summary_len
    PRINT_TEXT label_id, label_id_len
    mov eax, [reservation_id]
    PRINT_NUMBER
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_customer, label_customer_len
    mov esi, input_buffer
    call print_c_string
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_movie, label_movie_len
    mov esi, [movie_pointer]
    call print_c_string
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_schedule, label_schedule_len
    mov esi, [schedule_pointer]
    call print_c_string
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_quantity, label_quantity_len
    mov eax, [quantity_value]
    PRINT_NUMBER
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_price, label_price_len
    mov eax, [price_value]
    PRINT_NUMBER
    PRINT_TEXT newline_text, newline_len
    PRINT_TEXT label_total, label_total_len
    mov eax, [total_value]
    PRINT_NUMBER
    PRINT_TEXT newline_text, newline_len
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; save_reservation_record
; Appends one readable reservation summary to reservations.txt.
save_reservation_record:
    mov eax, 5
    mov ebx, reservation_file
    mov ecx, 1089
    mov edx, 420
    int 0x80
    test eax, eax
    js reservation_open_failed
    mov [file_descriptor], eax
    mov esi, summary_file_heading
    call write_c_string_file
    mov esi, label_id
    call write_c_string_file
    mov eax, [reservation_id]
    call write_uint_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_customer
    call write_c_string_file
    mov esi, input_buffer
    call write_c_string_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_movie
    call write_c_string_file
    mov esi, [movie_pointer]
    call write_c_string_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_schedule
    call write_c_string_file
    mov esi, [schedule_pointer]
    call write_c_string_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_quantity
    call write_c_string_file
    mov eax, [quantity_value]
    call write_uint_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_price
    call write_c_string_file
    mov eax, [price_value]
    call write_uint_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, label_total
    call write_c_string_file
    mov eax, [total_value]
    call write_uint_file
    mov esi, newline_text
    call write_c_string_file
    mov esi, summary_file_separator
    call write_c_string_file
    mov eax, 6
    mov ebx, [file_descriptor]
    int 0x80
    mov edx, 1
    ret

reservation_open_failed:
    xor edx, edx
    ret

; show_reservations
show_reservations:
    push eax
    push ebx
    push ecx
    push edx
    PRINT_TEXT reservation_view_title, reservation_view_title_len
    mov ebx, reservation_file
    call display_record_file
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; display_record_file
display_record_file:
    mov eax, 5
    mov ecx, 0
    int 0x80
    test eax, eax
    js display_file_missing
    mov [file_descriptor], eax
    mov dword [file_found_data], 0
display_file_read_loop: mov eax, 3
    mov ebx, [file_descriptor]
    mov ecx, file_buffer
    mov edx, 512
    int 0x80
    cmp eax, 0
    je display_file_finished
    js display_file_read_failed
    mov dword [file_found_data], 1
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, file_buffer
    int 0x80
    jmp display_file_read_loop
display_file_finished: mov eax, 6
    mov ebx, [file_descriptor]
    int 0x80
    ; Empty files are valid but receive a helpful message.
    cmp dword [file_found_data], 0
    jne display_file_done
    PRINT_TEXT no_records_text, no_records_len
display_file_done: ret
display_file_missing: PRINT_TEXT no_records_text, no_records_len
    ret
display_file_read_failed: mov eax, 6
    mov ebx, [file_descriptor]
    int 0x80
    PRINT_TEXT file_read_error, file_read_error_len
    ret

; read_line
read_line:
    mov eax, 3
    xor ebx, ebx
    mov ecx, input_buffer
    mov edx, 128
    int 0x80
    cmp eax, 0
    jle read_line_no_input
    ; The buffer has 129 bytes, so a terminator fits after 128 input bytes.
    mov byte [input_buffer + eax], 0
    mov ecx, eax
    dec ecx
    cmp byte [input_buffer + ecx], 10
    jne read_line_check_carriage_return
    mov byte [input_buffer + ecx], 0
    dec ecx
read_line_check_carriage_return: cmp ecx, 0
    jl read_line_success
    cmp byte [input_buffer + ecx], 13
    jne read_line_success
    mov byte [input_buffer + ecx], 0
read_line_success: mov eax, 1
    ret
read_line_no_input: xor eax, eax
    ret

; read_integer
; Returns EAX=value and EDX=1 for success, EDX=0 for invalid input,
; or EDX=2 when input has ended.
read_integer:
    call read_line
    test eax, eax
    jz read_integer_eof
    call parse_uint
    cmp edx, 1
    je read_integer_valid
    PRINT_TEXT invalid_number, invalid_number_len
    xor eax, eax
    xor edx, edx
    ret
read_integer_valid: mov edx, 1
    ret
read_integer_eof: xor eax, eax
    mov edx, 2
    ret

; parse_uint
; Accepts digits only; blank input and other characters are invalid.
parse_uint:
    push ebx
    push ecx
    mov esi, input_buffer
    xor eax, eax
    xor ecx, ecx
parse_uint_loop: mov bl, [esi]
    test bl, bl
    jz parse_uint_finished
    cmp bl, '0'
    jb parse_uint_invalid
    cmp bl, '9'
    ja parse_uint_invalid
    ; Reject decimal values that would overflow a 32-bit unsigned result.
    cmp eax, 429496729
    ja parse_uint_invalid
    jne parse_uint_accumulate
    cmp bl, '5'
    ja parse_uint_invalid
parse_uint_accumulate: imul eax, eax, 10
    movzx ebx, bl
    sub ebx, '0'
    add eax, ebx
    inc esi
    inc ecx
    jmp parse_uint_loop
parse_uint_finished: cmp ecx, 0
    je parse_uint_invalid
    mov edx, 1
    jmp parse_uint_return
parse_uint_invalid: xor eax, eax
    xor edx, edx
parse_uint_return: pop ecx
    pop ebx
    ret

; sanitize_customer_name
; Replaces pipe characters with slashes to keep text summaries readable.
; Returns EAX=1 when the customer name is nonempty.
sanitize_customer_name:
    mov esi, input_buffer
    xor ecx, ecx
sanitize_name_loop: mov al, [esi]
    test al, al
    jz sanitize_name_finished
    cmp al, '|'
    jne sanitize_name_next
    mov byte [esi], '/'
sanitize_name_next: cmp byte [esi], ' '
    jne sanitize_name_has_character
    inc esi
    jmp sanitize_name_loop
sanitize_name_has_character: inc ecx
    inc esi
    jmp sanitize_name_loop
sanitize_name_finished: test ecx, ecx
    jz sanitize_name_empty
    mov eax, 1
    ret
sanitize_name_empty: xor eax, eax
    ret

; print_c_string
print_c_string:
    push eax
    push ebx
    push ecx
    push edx
    push edi
    mov edi, esi
    xor edx, edx

print_c_string_count: cmp byte [edi + edx], 0
    je print_c_string_write
    inc edx
    jmp print_c_string_count

print_c_string_write: mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 0x80
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; uint_to_buffer
; Converts unsigned EAX into number_buffer, setting number_length and ESI.
uint_to_buffer:
    push ebx
    push ecx
    push edx
    push edi
    mov edi, number_buffer + 11
    mov byte [edi], 0
    xor ecx, ecx
    mov ebx, 10

uint_to_buffer_loop: xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx
    test eax, eax
    jnz uint_to_buffer_loop
    mov esi, edi
    mov [number_length], ecx
    pop edi
    pop edx
    pop ecx
    pop ebx
    ret

; print_uint
print_uint:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    call uint_to_buffer
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, [number_length]
    int 0x80
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; write_c_string_file
write_c_string_file:
    push eax
    push ebx
    push ecx
    push edx
    push edi
    mov edi, esi
    xor edx, edx

write_c_string_count: cmp byte [edi + edx], 0
    je write_c_string_call
    inc edx
    jmp write_c_string_count

write_c_string_call: mov eax, 4
    mov ebx, [file_descriptor]
    mov ecx, esi
    int 0x80
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; write_uint_file
; Converts the unsigned integer in EAX and appends the digits to the open file.
write_uint_file:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    call uint_to_buffer
    mov eax, 4
    mov ebx, [file_descriptor]
    mov ecx, esi
    mov edx, [number_length]
    int 0x80
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret