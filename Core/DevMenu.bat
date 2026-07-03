@echo off
REM ============================================================================
REM  Core\DevMenu.bat  -  Hidden developer/debug menu
REM  Reached only by typing "dev" or "devmenu" at the Main Menu prompt - it is
REM  intentionally absent from the visible numbered list. Useful for anyone
REM  extending VizKit or diagnosing the toolkit itself (not the OS).
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

:DevLoop
call "%VIZKIT_CORE%\Common.bat" :Header "Developer Menu" "Main Menu > Developer (hidden)"
echo(    1. Dump active VizKit environment variables
echo(    2. Show current session log (tail)
echo(    3. Reload config.ini without restarting
echo(    4. Validate all Data\*.dat files for formatting errors
echo(    5. Count entries per category
echo(    6. Open Logs folder    7. Open Reports folder    8. Open Data folder
echo(    0. Back to Main Menu
echo(
set /p "DCHOICE=   Select an option: "

if "%DCHOICE%"=="0" goto :DevExit
if /i "%DCHOICE%"=="B" goto :DevExit

if "%DCHOICE%"=="1" (
    cls
    echo(   VIZKIT_ROOT      = %VIZKIT_ROOT%
    echo(   VIZKIT_CORE      = %VIZKIT_CORE%
    echo(   VIZKIT_DATA      = %VIZKIT_DATA%
    echo(   VIZKIT_PLUGINS   = %VIZKIT_PLUGINS%
    echo(   VIZKIT_LOGS      = %VIZKIT_LOGS%
    echo(   VIZKIT_REPORTS   = %VIZKIT_REPORTS%
    echo(   VIZKIT_VERSION   = %VIZKIT_VERSION%
    echo(   VIZKIT_ISADMIN   = %VIZKIT_ISADMIN%
    echo(   WIN_FRIENDLY     = %WIN_FRIENDLY%
    echo(   WIN_BUILD        = %WIN_BUILD%
    echo(   WIN_DISPLAYVER   = %WIN_DISPLAYVER%
    echo(   WIN_ARCH         = %WIN_ARCH%
    echo(   CFG_THEME        = %CFG_THEME%
    echo(   CFG_PAGESIZE     = %CFG_PAGESIZE%
    echo(   VIZKIT_LOGFILE   = %VIZKIT_LOGFILE%
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :DevLoop
)

if "%DCHOICE%"=="2" (
    cls
    echo(   --- Last 25 lines of current session log ---
    echo(
    if exist "%VIZKIT_LOGFILE%" (
        powershell -NoProfile -Command "Get-Content -Path '%VIZKIT_LOGFILE%' -Tail 25"
    ) else (
        echo(   No log file yet this session.
    )
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :DevLoop
)

if "%DCHOICE%"=="3" (
    call "%VIZKIT_CORE%\Init.bat"
    call "%VIZKIT_CORE%\Common.bat" :InfoBox "config.ini reloaded."
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :DevLoop
)

if "%DCHOICE%"=="4" (
    call :ValidateData
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :DevLoop
)

if "%DCHOICE%"=="5" (
    cls
    echo(   Entries per category:
    echo(
    for %%F in (System Network Storage Security Diagnostics Recovery Development Reports) do (
        if exist "%VIZKIT_DATA%\%%F.dat" (
            for /f %%c in ('type "%VIZKIT_DATA%\%%F.dat" 2^>nul ^| findstr /v /r "^;" ^| findstr /v /r "^$" ^| find /c /v ""') do (
                echo(     %%F : %%c
            )
        )
    )
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :DevLoop
)

if "%DCHOICE%"=="6" (start "" "%VIZKIT_LOGS%" & goto :DevLoop)
if "%DCHOICE%"=="7" (start "" "%VIZKIT_REPORTS%" & goto :DevLoop)
if "%DCHOICE%"=="8" (start "" "%VIZKIT_DATA%" & goto :DevLoop)

call "%VIZKIT_CORE%\Common.bat" :ErrorBox "'%DCHOICE%' is not a valid option."
call "%VIZKIT_CORE%\Common.bat" :Pause
goto :DevLoop

:DevExit
endlocal
exit /b 0

REM ============================================================================
REM  :ValidateData   Basic sanity check: every non-comment line must have
REM  exactly 5 fields (Name~Desc~Command~Confirm~Admin).
REM ============================================================================
:ValidateData
cls
echo(   Validating Data\*.dat files...
echo(
set "ERRCOUNT=0"
for %%F in (System Network Storage Security Diagnostics Recovery Development Reports) do (
    if exist "%VIZKIT_DATA%\%%F.dat" (
        set "LN=0"
        for /f "usebackq eol=; delims=" %%L in ("%VIZKIT_DATA%\%%F.dat") do (
            set /a LN+=1
            set "TESTLINE=%%L"
            if not "!TESTLINE!"=="" (
                set "FIELDCOUNT=0"
                for /f "tokens=1-5 delims=~" %%a in ("!TESTLINE!") do (
                    if not "%%a"=="" set /a FIELDCOUNT+=1
                    if not "%%b"=="" set /a FIELDCOUNT+=1
                    if not "%%c"=="" set /a FIELDCOUNT+=1
                    if not "%%d"=="" set /a FIELDCOUNT+=1
                    if not "%%e"=="" set /a FIELDCOUNT+=1
                )
                if !FIELDCOUNT! LSS 5 (
                    echo(   [!] %%F.dat line !LN!: expected 5 fields, found !FIELDCOUNT!
                    set /a ERRCOUNT+=1
                )
            )
        )
    ) else (
        echo(   [!] %%F.dat is missing
        set /a ERRCOUNT+=1
    )
)
echo(
if "%ERRCOUNT%"=="0" (
    echo(   All data files passed validation.
) else (
    echo(   %ERRCOUNT% issue(s) found.
)
exit /b 0
