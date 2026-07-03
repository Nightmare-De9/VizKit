@echo off
REM ============================================================================
REM  Core\Plugins.bat  -  Auto-discovers .bat/.cmd plugins and lists them
REM
REM  Plugins are just ordinary .bat/.cmd files dropped into Plugins\.
REM  Optional metadata is read from comment lines at the top of the file:
REM     REM VIZKIT:NAME=My Plugin
REM     REM VIZKIT:DESC=One line description
REM     REM VIZKIT:AUTHOR=Your Name
REM     REM VIZKIT:VERSION=1.0
REM  If metadata is missing, the filename is used as the name instead, so a
REM  plugin with zero VizKit-specific code still works out of the box.
REM
REM  Discovered plugins are converted into a temporary Engine.bat data file
REM  so they get full Favorites/Recent/Search/logging support for free.
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

set "PLUGDIR=%VIZKIT_ROOT%\%CFG_PLUGINFOLDER%"
if not exist "%PLUGDIR%" (
    call "%VIZKIT_CORE%\Common.bat" :ErrorBox "Plugin folder not found: %PLUGDIR%"
    call "%VIZKIT_CORE%\Common.bat" :Pause
    endlocal
    exit /b 0
)

set "PLUGDAT=%VIZKIT_DATA%\_plugins.dat"
if exist "%PLUGDAT%" del /q "%PLUGDAT%" >nul 2>&1

set "FOUND=0"
for %%P in ("%PLUGDIR%\*.bat" "%PLUGDIR%\*.cmd") do (
    if exist "%%~P" (
        set /a FOUND+=1
        call :ReadMeta "%%~P"
    )
)

if "%FOUND%"=="0" (
    call "%VIZKIT_CORE%\Common.bat" :Header "Plugins" "Main Menu > Plugins"
    echo(   No plugins found.
    echo(
    echo(   Drop a .bat or .cmd file into:
    echo(     %PLUGDIR%
    echo(   and it will appear here automatically next time you open this menu.
    echo(   See docs\PluginGuide.md for the metadata format.
    call "%VIZKIT_CORE%\Common.bat" :Pause
    endlocal
    exit /b 0
)

call "%VIZKIT_CORE%\Engine.bat" "%PLUGDAT%" "Plugins"
set "PRC=%errorlevel%"
del /q "%PLUGDAT%" >nul 2>&1
endlocal
exit /b %PRC%

REM ============================================================================
REM  :ReadMeta "<full path to plugin file>"
REM ============================================================================
:ReadMeta
set "PFILE=%~1"
set "PNAME="
set "PDESC="
set "LINESCANNED=0"

for /f "usebackq delims=" %%L in ("%PFILE%") do (
    set /a LINESCANNED+=1
    set "PLINE=%%L"
    echo(!PLINE!| findstr /b /i /c:"REM VIZKIT:NAME=" >nul && (
        for /f "tokens=1* delims==" %%a in ("!PLINE!") do set "PNAME=%%b"
    )
    echo(!PLINE!| findstr /b /i /c:"REM VIZKIT:DESC=" >nul && (
        for /f "tokens=1* delims==" %%a in ("!PLINE!") do set "PDESC=%%b"
    )
    if !LINESCANNED! GEQ 15 goto :MetaDone
)
:MetaDone
if not defined PNAME set "PNAME=%~n1"
if not defined PDESC set "PDESC=Custom plugin (no description provided)"

>> "%PLUGDAT%" echo(!PNAME!~!PDESC!~"%PFILE%"~N~N
exit /b 0
