@echo off
REM ============================================================================
REM  Core\Init.bat  -  One-time startup initialization
REM  Loads config.ini, detects the Windows environment, starts the session
REM  log, and loads the selected theme. Called once by VizKit.bat.
REM ============================================================================

REM --- Defaults (used if config.ini is missing a key) -----------------------
set "CFG_THEME=Classic"
set "CFG_SHOWBANNER=1"
set "CFG_DEFAULTPAGE=MainMenu"
set "CFG_LOGGING=1"
set "CFG_PLUGINFOLDER=Plugins"
set "CFG_PAGESIZE=14"
set "CFG_CONFIRMSENSITIVE=1"

REM --- Parse config.ini (simple KEY=VALUE INI parser) ------------------------
if exist "%VIZKIT_CONFIG%" (
    for /f "usebackq eol=; tokens=1,* delims==" %%K in ("%VIZKIT_CONFIG%") do (
        set "_key=%%K"
        set "_val=%%L"
        if /i "!_key!"=="Theme"            set "CFG_THEME=!_val!"
        if /i "!_key!"=="ShowBanner"       set "CFG_SHOWBANNER=!_val!"
        if /i "!_key!"=="DefaultPage"      set "CFG_DEFAULTPAGE=!_val!"
        if /i "!_key!"=="LoggingEnabled"   set "CFG_LOGGING=!_val!"
        if /i "!_key!"=="PluginFolder"     set "CFG_PLUGINFOLDER=!_val!"
        if /i "!_key!"=="PageSize"         set "CFG_PAGESIZE=!_val!"
        if /i "!_key!"=="ConfirmSensitive" set "CFG_CONFIRMSENSITIVE=!_val!"
    )
) else (
    echo [WARN] config.ini not found - using built-in defaults.
)

REM --- Detect Windows environment --------------------------------------------
REM  Uses "ver" (always available, no dependency) plus systeminfo/PowerShell
REM  fallbacks for edition/build strings. Kept fast: no heavy WMI calls here.
for /f "tokens=4-5 delims=. " %%A in ('ver') do (
    set "WIN_VER_RAW=%%A.%%B"
)

set "WIN_ARCH=%PROCESSOR_ARCHITECTURE%"
if /i "%WIN_ARCH%"=="AMD64" set "WIN_ARCH=64-bit"
if /i "%WIN_ARCH%"=="x86"   set "WIN_ARCH=32-bit"
if /i "%WIN_ARCH%"=="ARM64" set "WIN_ARCH=ARM64"

REM  Build number and product name via registry (fast, no external process)
for /f "tokens=3*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul ^| findstr /i "CurrentBuild"') do set "WIN_BUILD=%%A"
for /f "tokens=3*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul ^| findstr /i "ProductName"') do set "WIN_EDITION=%%A %%B"
for /f "tokens=3*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^>nul ^| findstr /i "DisplayVersion"') do set "WIN_DISPLAYVER=%%A"

if not defined WIN_BUILD set "WIN_BUILD=0"
if not defined WIN_EDITION set "WIN_EDITION=Windows (edition unknown)"
if not defined WIN_DISPLAYVER set "WIN_DISPLAYVER=n/a"

REM  Windows 11 reports as build >= 22000 even though "ver" says 10.0
set "WIN_FRIENDLY=Windows 10"
if %WIN_BUILD% GEQ 22000 set "WIN_FRIENDLY=Windows 11"

REM --- Detect admin (elevation) state -----------------------------------------
net session >nul 2>&1
if %errorlevel%==0 (
    set "VIZKIT_ISADMIN=1"
) else (
    set "VIZKIT_ISADMIN=0"
)

REM --- Start session log -------------------------------------------------------
REM  One timestamped log per launch, reused for the whole session. PowerShell's
REM  fixed-format Get-Date avoids locale-dependent date/time parsing issues
REM  (wmic is deprecated on newer Windows 11 builds, so we don't rely on it).
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "VIZKIT_STAMP=%%T"
if not defined VIZKIT_STAMP set "VIZKIT_STAMP=00000000_000000"
set "VIZKIT_LOGFILE=%VIZKIT_LOGS%\VizKit_%VIZKIT_STAMP%.log"

if not exist "%VIZKIT_LOGS%" mkdir "%VIZKIT_LOGS%" >nul 2>&1
if not exist "%VIZKIT_REPORTS%" mkdir "%VIZKIT_REPORTS%" >nul 2>&1
if not exist "%VIZKIT_ROOT%\%CFG_PLUGINFOLDER%" mkdir "%VIZKIT_ROOT%\%CFG_PLUGINFOLDER%" >nul 2>&1

if "%CFG_LOGGING%"=="1" (
    echo ==================================================================== > "%VIZKIT_LOGFILE%"
    echo VizKit Session Log >> "%VIZKIT_LOGFILE%"
    echo Started : %date% %time% >> "%VIZKIT_LOGFILE%"
    echo Version : %VIZKIT_VERSION% >> "%VIZKIT_LOGFILE%"
    echo Windows : %WIN_FRIENDLY% ^(build %WIN_BUILD%, %WIN_DISPLAYVER%^) %WIN_ARCH% >> "%VIZKIT_LOGFILE%"
    echo Admin   : %VIZKIT_ISADMIN% >> "%VIZKIT_LOGFILE%"
    echo ==================================================================== >> "%VIZKIT_LOGFILE%"
)

REM --- Load theme colors -------------------------------------------------------
call "%VIZKIT_CORE%\Theme.bat" "%CFG_THEME%"

REM --- Recent / favorites data files must exist --------------------------------
if not exist "%VIZKIT_DATA%\favorites.dat" type nul > "%VIZKIT_DATA%\favorites.dat"
if not exist "%VIZKIT_DATA%\recent.dat" type nul > "%VIZKIT_DATA%\recent.dat"

exit /b 0
