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
F5::
	SetTimer, DrawIcons, 1
return






DrawIcons:
hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    Random, x, 0, A_ScreenWidth
    Random, y, 0, A_ScreenHeight
    Random, IconType, 32513, 32515
    
    hIcon := DllCall("LoadIcon", "Ptr", 0, "Ptr", IconType, "Ptr")
    DllCall("user32\DrawIcon", "Ptr", hdc, "Int", x, "Int", y, "Ptr", hIcon)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return

; --- OTHER UTILITIES ---
^Esc::Reload ; Emergency Stop/Reset screen