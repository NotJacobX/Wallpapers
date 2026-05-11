#Persistent
#NoEnv
SetBatchLines, -1

; --- Emergency Kill Switch ---
^Esc::Reload ; Reloading clears the GDI paint and stops the script

F1::
Loop
{
    ; 1. Get the Device Context for the Desktop (0)
    hdc := DllCall("GetDC", "Ptr", 0)
    
    ; 2. Pick a random X coordinate and a random width
    Random, x, 0, A_ScreenWidth
    Random, w, 50, 200
    Random, h, 100, 500
    
    ; 3. BitBlt (Bit Block Transfer) 
    ; This copies a piece of the screen and pastes it 2 pixels lower
    ; Parameters: DestDC, DestX, DestY, Width, Height, SourceDC, SourceX, SourceY, RasterOp (0x00CC0020 is SRCCOPY)
    DllCall("gdi32\BitBlt", "Ptr", hdc, "Int", x, "Int", 2, "Int", w, "Int", h, "Ptr", hdc, "Int", x, "Int", 0, "UInt", 0x00CC0020)
    
    ; 4. Release the DC to prevent memory leaks
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
    
    Sleep, 10
}
return