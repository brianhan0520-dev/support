@echo off
cd /d "%~dp0"
start /b powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0server.ps1"
timeout /t 2 /nobreak > nul
start "" "http://localhost:8760/contacts-viewer.html"
echo Server is running. Close this window to stop.
pause > nul
taskkill /f /im powershell.exe /fi "WINDOWTITLE eq server.ps1" > nul 2>&1
