#NoTrayIcon
#Persistent
#NoEnv
SetBatchLines, -1
global arr := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

Loop, Parse, % "abcdefghijklmnopqrstuvwxyz", % "" 
{
    Hotkey, *%A_LoopField%, Snd
}

; --- Toggle 1: Screen Melt ---
F1::
    SetTimer, ScreenMelt, 1 ; Run every 1ms
return

; --- Toggle 2: Window Shake ---
F2::
    SetTimer, WindowShake, 2 ; Run every 2ms
return
F3::
    SetTimer, Flash, 3 ; Run every 3ms
return
; --- THE ACTUAL EFFECTS (No Loops inside here!) ---

ScreenMelt:
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    Random, x, 0, A_ScreenWidth
    Random, w, 50, 200
    Random, h, 100, 500
    DllCall("gdi32\BitBlt", "Ptr", hdc, "Int", x, "Int", 15, "Int", w, "Int", h, "Ptr", hdc, "Int", x, "Int", 0, "UInt", 0x00CC0020)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return

WindowShake:
    WinGet, id, List,,, Program Manager
    Loop, %id% ; This small loop is okay because it finishes instantly
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        if (title = "")
            continue
        WinGetPos, X, Y, , , ahk_id %this_id%
        Random, mX, -10, 10
        Random, mY, -10, 10
        WinMove, ahk_id %this_id%,, X + mX, Y + mY
    }
return
Flash:
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    ; PatBlt inverts the screen colors
    DllCall("gdi32\PatBlt", "Ptr", hdc, "Int", 0, "Int", 0, "Int", A_ScreenWidth, "Int", A_ScreenHeight, "UInt", 0x00550009)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return