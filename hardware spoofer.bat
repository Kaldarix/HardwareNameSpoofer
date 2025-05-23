@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo [!] This script requires admin privileges.
    echo [i] Attempting to relaunch as Administrator...
	timeout /t 3 >nul
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

title Hardware Spoofer
color 0A

:MENU
cls
echo ===================================
echo      HARDWARE SPOOFER v1.0
echo ===================================
echo.
echo 1. Spoof CPU Name
echo 2. Exit
echo.
set /p choice=Enter your choice [1-2]: 

if "%choice%"=="1" goto CPU
if "%choice%"=="2" exit

:CPU
cls
set /p newname=Enter new CPU name: 
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v "ProcessorNameString" /t REG_SZ /d "%newname%" /f
echo [✔] Successfully spoofed CPU name to: %newname%
pause
goto MENU
