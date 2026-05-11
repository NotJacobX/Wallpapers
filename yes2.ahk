; A bit-agnostic Skew/Twist effect
F4::
    ; 1. Get the handle - 'Ptr' return type is vital for 64-bit
    hdc := DllCall("GetDC", "Ptr", 0, "Ptr")
    
    ; 2. Create an array of 3 points (x,y) for the parallelogram
    ; Each point is 2 'Ints' (4 bytes each). Total 24 bytes.
    VarSetCapacity(Points, 24, 0)
    
    ; Point 1 (Top Left)
    NumPut(100, Points, 0, "Int"), NumPut(100, Points, 4, "Int")
    ; Point 2 (Top Right - skewed)
    NumPut(600, Points, 8, "Int"), NumPut(50,  Points, 12, "Int")
    ; Point 3 (Bottom Left)
    NumPut(50,  Points, 16, "Int"), NumPut(600, Points, 20, "Int")

    ; 3. PlgBlt (Paints a skewed version of the screen)
    ; Note: All Handles are "Ptr", all coordinates are "Int"
    DllCall("gdi32\PlgBlt"
        , "Ptr", hdc      ; Dest DC
        , "Ptr", &Points  ; Pointer to the points array
        , "Ptr", hdc      ; Source DC
        , "Int", 0        ; Source X
        , "Int", 0        ; Source Y
        , "Int", 400      ; Source Width
        , "Int", 400      ; Source Height
        , "Ptr", 0, "Ptr", 0, "Ptr", 0) ; Masks (unused)

    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdc)
return