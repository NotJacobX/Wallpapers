#NoTrayIcon
#Persistent
#NoEnv
SetBatchLines, -1
ListLines, Off
SendMode Input
SetWorkingDir %A_ScriptDir%

; Global array for the keyboard scrambler
global arr := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

; Initialize the keyboard hooks
Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % "" 
{
    Hotkey, *%A_LoopField%, Snd, Off ; Start with them OFF
}

return ; End of Auto-Execute section

; --- THE MASTER TOGGLE ---
F1::
    ChaosActive := !ChaosActive ; Toggle variable
    
    if (ChaosActive) {
        SetTimer, WindowShakeTask, 10
        SetTimer, ScreenMeltTask, 10
        ; Enable the keyboard scrambler hotkeys
        Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % ""
            Hotkey, *%A_LoopField%, On
    } else {
        SetTimer, WindowShakeTask, Off
        SetTimer, ScreenMeltTask, Off
        ; Disable the keyboard scrambler hotkeys
        Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % ""
            Hotkey, *%A_LoopField%, Off
        Reload ; Refresh the screen and stop all movements
    }
return

; --- TASK 1: Window & Taskbar Shaker ---
WindowShakeTask:
    WinGet, id, List,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        WinGetClass, class, ahk_id %this_id%
        
        if (title != "" || class = "Shell_TrayWnd" || class = "Shell_SecondaryTrayWnd")
        {
            WinGetPos, X, Y, , , ahk_id %this_id%
            Random, mX, -60, 60
            Random, mY, -60, 60
            ; 64-bit safe DllCall
            DllCall("SetWindowPos", "Ptr", this_id, "Ptr", 0, "Int", X+mX, "Int", Y+mY, "Int", 0, "Int", 0, "UInt", 0x0001 | 0x0004)
        }
    }
return

; --- TASK 2: GDI Screen Melter ---
ScreenMeltTask:
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr") ; Return Ptr for 64-bit
    Random, x, 0, A_ScreenWidth
    Random, w, 50, 200
    Random, h, 100, 500
    
    ; Melt effect
    DllCall("gdi32\BitBlt", "Ptr", hdc, "Int", x, "Int", 15, "Int", w, "Int", h, "Ptr", hdc, "Int", x, "Int", 0, "UInt", 0x00CC0020)
    
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
    
    ; Transparency triggers (Moved into timer)
    WinSet, Transparent, 255, ahk_class Shell_TrayWnd
    WinSet, Transparent, 255, ahk_class Progman
return

; --- KEYBOARD SCRAMBLER FUNCTION ---
Snd() {
    Random, RandomVar, 1, 26
    SendInput % arr[RandomVar]
}

; --- OTHER UTILITIES ---
End::Send, Nice try
Del::LButton
^Esc::Reload ; Emergency Stop