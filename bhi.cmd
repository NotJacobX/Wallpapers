@echo off
set VHD_PATH=C:\z\d.vhdx

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"New-VHD -Path '%VHD_PATH%' -SizeBytes 16TB -Dynamic; ^
 Mount-VHD -Path '%VHD_PATH%'"

pause
