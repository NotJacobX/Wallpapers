DllCall("SetProcessDPIAware")
#NoTrayIcon
#Persistent
#NoEnv
SetBatchLines, -1
ListLines, Off
SendMode Input
SetWorkingDir %A_ScriptDir%

; keyboard scrambler shit
global arr := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

; start the keybind with OFF
Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % "" 
{
    Hotkey, *%A_LoopField%, Snd, Off
}

return ; auto-execute end
; escape mechanism, reload Ctrl+Esc
Ins::ExitApp
F1::
    
    SetTimer, WindowShakeTask, 1
    SetTimer, ScreenMeltTask, 1
    SetTimer, FlashTask, 12

    ; enable scrambler!!
    Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % ""
        Hotkey, *%A_LoopField%, On
return

WindowShakeTask: ; Coronavirus.exe
    WinGet, id, List,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        WinGetClass, class, ahk_id %this_id%
        
        if (title != "" || class = "Shell_TrayWnd" || class = "Shell_SecondaryTrayWnd")
        {
            WinGetPos, X, Y, , , ahk_id %this_id%
            Random, mX, -30, 30
            Random, mY, -30, 30
            ; 64-bit safe DllCall
            DllCall("SetWindowPos", "Ptr", this_id, "Ptr", 0, "Int", X+mX, "Int", Y+mY, "Int", 0, "Int", 0, "UInt", 0x0001 | 0x0004)
        }
    }
return

; GDI
ScreenMeltTask: ; ScreenMelter.exe
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    Random, x, 0, A_ScreenWidth
    Random, w, 50, 200
    Random, h, 100, 500
    DllCall("gdi32\BitBlt", "Ptr", hdc, "Int", x, "Int", 15, "Int", w, "Int", h, "Ptr", hdc, "Int", x, "Int", 0, "UInt", 0x00CC0020)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return
FlashTask: ; MEMZ.exe (maybe.)
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    ; PatBlt inverts the screen colors
    DllCall("gdi32\PatBlt", "Ptr", hdc, "Int", 0, "Int", 0, "Int", A_ScreenWidth, "Int", A_ScreenHeight, "UInt", 0x00550009)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
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