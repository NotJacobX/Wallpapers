Esc::
; Loop from 1 to 5000 (or higher!)
Run, notepad.exe
Loop, 50000 
{
    ; Chr() converts the number (Unicode decimal) directly into its actual character
    CurrentCharacter := Chr(A_Index)
    
    ; Send the character natively
    Send, {Text}%CurrentCharacter%
	MouseMove, 0, 0
}
return
Ins::ExitApp
Alt::0
F4::0