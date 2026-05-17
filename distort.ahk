DllCall("SetProcessDPIAware")
#NoTrayIcon
#Persistent
#NoEnv
SetBatchLines, -1
ListLines, Off
SendMode Input
SetWorkingDir %A_ScriptDir%

return ; auto-execute end

; escape mechanism, reload Ctrl+Esc
Ins::ExitApp

F1::
    ; Prevent stacking if F1 is pressed multiple times
    if (AlreadyRunning)
        return
    AlreadyRunning := true

    SetTimer, Distort, 25        ; The new MEMZ-style tunnel effect
return
Distort: ; MEMZ.exe tunnel, again.
; 1. Grab the desktop device context
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    
    ; 2. Generate a small, uniform offset shift direction
    ; Changing these numbers changes how fast/far the screen "drifts"
    Random, offsetX, -1, 1
    Random, offsetY, -1, 1
    
    ; 3. Use SRCPAINT to blend the ENTIRE screen onto itself at the offset
    DllCall("gdi32\BitBlt"
        , "Ptr", hdc
        , "Int", offsetX, "Int", offsetY      ; Shifted destination coordinates
        , "Int", A_ScreenWidth                ; Full screen width
        , "Int", A_ScreenHeight               ; Full screen height
        , "Ptr", hdc
        , "Int", 0, "Int", 0                  ; Source coordinates (original screen position)
        , "UInt", 0x008800C6)                 ; SRCPAINT (0x00EE0086) RasterOp ; Change to SRCAND (0x008800C6) for darker effect
        
    ; 4. Free up the context handle
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return

; --- OTHER UTILITIES ---
^Esc::Reload ; Emergency Stop/Reset screen