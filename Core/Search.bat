@echo off
REM ============================================================================
REM  Core\Search.bat  -  Searches command Name/Description/Command fields
REM  across every category data file, ranks Name-matches above Description/
REM  alias matches, then hands the combined result list to Engine.bat so it
REM  can be browsed and launched exactly like a normal category menu.
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

call "%VIZKIT_CORE%\Common.bat" :Header "Search" "Main Menu > Search"
set /p "TERM=   Enter a search term (command name, keyword, or description): "

if "%TERM%"=="" (
    endlocal
    exit /b 0
)

set "TMP_A=%TEMP%\vizkit_search_name.tmp"
set "TMP_B=%TEMP%\vizkit_search_other.tmp"
set "RESULTS=%VIZKIT_DATA%\_search_results.dat"

if exist "%TMP_A%" del /q "%TMP_A%" >nul 2>&1
if exist "%TMP_B%" del /q "%TMP_B%" >nul 2>&1
if exist "%RESULTS%" del /q "%RESULTS%" >nul 2>&1

for %%F in (System Network Storage Security Diagnostics Recovery Development) do (
    if exist "%VIZKIT_DATA%\%%F.dat" (
        for /f "usebackq eol=; delims=" %%L in ("%VIZKIT_DATA%\%%F.dat") do (
            call :CheckLine "%%L"
        )
    )
)

REM --- Rank: Name matches first, then Description/Command matches -----------
if exist "%TMP_A%" type "%TMP_A%" >> "%RESULTS%"
if exist "%TMP_B%" type "%TMP_B%" >> "%RESULTS%"

if not exist "%RESULTS%" (
    call "%VIZKIT_CORE%\Common.bat" :ErrorBox "No commands matched '%TERM%'."
    call "%VIZKIT_CORE%\Common.bat" :Pause
    endlocal
    exit /b 0
)

call "%VIZKIT_CORE%\Engine.bat" "%RESULTS%" "Search Results: %TERM%"
set "SEARCH_RC=%errorlevel%"

del /q "%TMP_A%" >nul 2>&1
del /q "%TMP_B%" >nul 2>&1
del /q "%RESULTS%" >nul 2>&1

endlocal
exit /b %SEARCH_RC%

REM ============================================================================
REM  :CheckLine "<full data line>"
REM ============================================================================
:CheckLine
set "LINE=%~1"
if "%LINE%"=="" exit /b 0

for /f "tokens=1 delims=~" %%n in ("%LINE%") do set "LNAME=%%n"

echo(%LNAME%| findstr /i /c:"%TERM%" >nul 2>&1
if %errorlevel%==0 (
    echo(%LINE%>> "%TMP_A%"
    exit /b 0
)

echo(%LINE%| findstr /i /c:"%TERM%" >nul 2>&1
if %errorlevel%==0 (
    echo(%LINE%>> "%TMP_B%"
)
exit /b 0
