@echo off
setlocal

:: -----------------------------------------------------------------------
:: Session Coach — build + deploy script
::
:: Requires tools\paths.local.bat (copy from paths.example.bat).
:: Double-click from Windows Explorer or run from any directory.
:: -----------------------------------------------------------------------

set REPO=%~dp0..

if not exist "%~dp0paths.local.bat" (
    echo.
    echo [ERROR] tools\paths.local.bat not found.
    echo Copy tools\paths.example.bat to tools\paths.local.bat and set your paths.
    echo.
    pause
    exit /b 1
)
call "%~dp0paths.local.bat"

set COMPILER=%CK%\Papyrus Compiler\PapyrusCompiler.exe
set FLAGS=%CK%\Data\Scripts\Source\Base\Institute_Papyrus_Flags.flg
set STUBS=%REPO%\stubs
set GAME_USER=%GAME%\Data\Scripts\Source\User
set GAME_SRC=%GAME%\Data\Scripts\Source
set OUT=%REPO%\dist\Data\Scripts

echo.
echo [Session Coach] Compiling src\SessionCoach.psc ...
echo.

:: Import path order:
::   1. stubs\          — our Hydra:Events stub (shadows the real one)
::   2. game Source\User — all other Hydra sources + any base game User scripts
::   3. game Source\    — base game scripts (Actor, Game, Debug, etc.)

"%COMPILER%" "%REPO%\src\SessionCoach.psc" ^
    -f="%FLAGS%" ^
    -i="%STUBS%;%GAME_USER%;%GAME_SRC%" ^
    -o="%OUT%"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Compilation failed — see above.
    echo.
    pause
    exit /b 1
)

echo.
echo [Session Coach] Deploying to game folder...
echo.

xcopy /s /y "%REPO%\dist\Data\*" "%GAME%\Data\" >nul

echo [OK] Deployed:
echo      %GAME%\Data\Scripts\SessionCoach.pex
echo      %GAME%\Data\Hydra\ScriptFunctions\SessionCoach.json
echo.
echo To test: launch via f4se_loader.exe, load a save.
echo Console: cgf "SessionCoach.WriteSnapshot"
echo.
pause
