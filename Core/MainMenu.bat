@echo off
REM ============================================================================
REM  Core\MainMenu.bat  -  Top-level category menu
REM  Every category listed here is just a data file handed to Engine.bat,
REM  except for Plugins/Search/Reports (thin wrappers) and the hidden
REM  Developer menu (DevMenu.bat), which is intentionally NOT listed below.
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

if "%CFG_SHOWBANNER%"=="0" goto :SkipBanner
cls
call "%VIZKIT_CORE%\Common.bat" :Header "Main Menu" "Main Menu"
echo(   Welcome to VizKit. Type H at any time for help, or 0 to exit.
echo(
call "%VIZKIT_CORE%\Common.bat" :Pause
:SkipBanner

:MainLoop
call "%VIZKIT_CORE%\Common.bat" :Header "Main Menu" "Main Menu"

echo(    1. System            - Hardware, OS, BIOS, environment, uptime
echo(    2. Network            - IP config, adapters, DNS, Wi-Fi, firewall
echo(    3. Storage            - Disks, volumes, CHKDSK, BitLocker, cleanup
echo(    4. Windows Security   - Defender, Firewall, accounts, groups
echo(    5. Diagnostics        - Event logs, drivers, services, processes
echo(    6. Recovery           - Restore points, SFC, DISM, Advanced Startup
echo(    7. Development        - Terminal, Registry, Event Viewer, Dev Mgmt
echo(    8. Reports            - Generate timestamped system reports
echo(    9. Plugins            - Community / custom plugin commands
echo(
call "%VIZKIT_CORE%\Common.bat" :Footer
set /p "MCHOICE=   Select a category: "

if /i "%MCHOICE%"=="0" goto :DoExit
if /i "%MCHOICE%"=="B" goto :DoExit
if /i "%MCHOICE%"=="H" (
    call "%VIZKIT_CORE%\Help.bat"
    goto :MainLoop
)
if /i "%MCHOICE%"=="S" (
    call "%VIZKIT_CORE%\Search.bat"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if /i "%MCHOICE%"=="F" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\favorites.dat" "Favorites"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if /i "%MCHOICE%"=="R" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\recent.dat" "Recent Commands"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)

REM --- Hidden developer menu: not shown in the list above on purpose --------
if /i "%MCHOICE%"=="dev" (
    call "%VIZKIT_CORE%\DevMenu.bat"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if /i "%MCHOICE%"=="devmenu" (
    call "%VIZKIT_CORE%\DevMenu.bat"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)

if "%MCHOICE%"=="1" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\System.dat" "System"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="2" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Network.dat" "Network"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="3" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Storage.dat" "Storage"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="4" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Security.dat" "Windows Security"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="5" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Diagnostics.dat" "Diagnostics"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="6" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Recovery.dat" "Recovery"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="7" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Development.dat" "Development"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="8" (
    call "%VIZKIT_CORE%\Reports.bat"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)
if "%MCHOICE%"=="9" (
    call "%VIZKIT_CORE%\Plugins.bat"
    if errorlevel 99 goto :DoExit
    goto :MainLoop
)

call "%VIZKIT_CORE%\Common.bat" :ErrorBox "'%MCHOICE%' is not a valid option. Press H for help."
call "%VIZKIT_CORE%\Common.bat" :Pause
goto :MainLoop

:DoExit
cls
echo(
echo(   Thanks for using VizKit. Session log saved to:
echo(     %VIZKIT_LOGFILE%
echo(
endlocal
exit /b 0
