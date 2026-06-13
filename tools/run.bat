@echo off
setlocal

if not exist "%~dp0paths.local.bat" (
    echo [ERROR] tools\paths.local.bat not found.
    exit /b 1
)
call "%~dp0paths.local.bat"

start "" "%GAME%\f4se_loader.exe"
