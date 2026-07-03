@echo off
REM ============================================================================
REM  Core\Engine.bat  -  Generic, data-driven category menu + execution engine
REM
REM  Usage:  call "%VIZKIT_CORE%\Engine.bat" "<DataFile>" "<Category Title>"
REM
REM  Every category menu (System, Network, Storage, ...) is just a plain text
REM  file in Data\*.dat. This single engine renders it, paginates it, runs
REM  entries, logs them, and manages Favorites/Recent - so no menu-specific
REM  code is duplicated anywhere in VizKit.
REM
REM  Data file line format (fields separated by ~):
REM     Name~Description~Command~Confirm(Y/N)~AdminRequired(Y/N)
REM  Lines beginning with ; are comments and are skipped.
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

set "ENGINE_FILE=%~1"
set "ENGINE_TITLE=%~2"
if "%ENGINE_TITLE%"=="" set "ENGINE_TITLE=%~n1"

if not exist "%ENGINE_FILE%" (
    call "%VIZKIT_CORE%\Common.bat" :ErrorBox "Data file not found: %ENGINE_FILE%"
    call "%VIZKIT_CORE%\Common.bat" :Pause
    endlocal
    exit /b 1
)

REM --- Load entries from the data file into indexed variables ----------------
set "TOTAL=0"
for /f "usebackq eol=; tokens=1-5 delims=~" %%A in ("%ENGINE_FILE%") do (
    if not "%%A"=="" (
        set /a TOTAL+=1
        set "NAME_!TOTAL!=%%A"
        set "DESC_!TOTAL!=%%B"
        set "CMD_!TOTAL!=%%C"
        set "CONF_!TOTAL!=%%D"
        set "ADM_!TOTAL!=%%E"
    )
)

if "%TOTAL%"=="0" (
    call "%VIZKIT_CORE%\Common.bat" :ErrorBox "This category has no commands defined yet."
    call "%VIZKIT_CORE%\Common.bat" :Pause
    endlocal
    exit /b 0
)

set "PAGESIZE=%CFG_PAGESIZE%"
if "%PAGESIZE%"=="" set "PAGESIZE=14"
set "PAGE=1"
set /a "PAGES=(TOTAL+PAGESIZE-1)/PAGESIZE"
if %PAGES% LSS 1 set "PAGES=1"

:PageLoop
set /a "START=(PAGE-1)*PAGESIZE+1"
set /a "END=START+PAGESIZE-1"
if %END% GTR %TOTAL% set "END=%TOTAL%"

call "%VIZKIT_CORE%\Common.bat" :Header "%ENGINE_TITLE%" "Main Menu > %ENGINE_TITLE%"

for /l %%i in (%START%,1,%END%) do (
    set "PADNUM=  %%i"
    set "PADNUM=!PADNUM:~-3!"
    echo(  !PADNUM!. !NAME_%%i!  -  !DESC_%%i!
)

echo(
echo(   Page %PAGE% of %PAGES%   ^(%TOTAL% commands total^)
call "%VIZKIT_CORE%\Common.bat" :Footer
echo(   [N]ext page  [P]rev page  [Fn] Favorite item n  ^(e.g. F3^)
set /p "CHOICE=   Select an item, or a command above: "

REM  Exit code 99 is VizKit's convention for "user requested full program
REM  exit" - every menu that calls Engine.bat propagates it upward instead
REM  of looping, so choosing 0 from any depth cleanly closes the whole app.
if /i "%CHOICE%"=="0" (
    endlocal
    exit /b 99
)
if /i "%CHOICE%"=="B" goto :EngineExit
if /i "%CHOICE%"=="H" (
    call "%VIZKIT_CORE%\Help.bat"
    goto :PageLoop
)
if /i "%CHOICE%"=="S" (
    call "%VIZKIT_CORE%\Search.bat"
    if errorlevel 99 (endlocal & exit /b 99)
    goto :PageLoop
)
if /i "%CHOICE%"=="R" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\recent.dat" "Recent Commands"
    if errorlevel 99 (endlocal & exit /b 99)
    goto :PageLoop
)
if /i "%CHOICE%"=="F" (
    call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\favorites.dat" "Favorites"
    if errorlevel 99 (endlocal & exit /b 99)
    goto :PageLoop
)
if /i "%CHOICE%"=="N" (
    if %PAGE% LSS %PAGES% set /a "PAGE+=1"
    goto :PageLoop
)
if /i "%CHOICE%"=="P" (
    if %PAGE% GTR 1 set /a "PAGE-=1"
    goto :PageLoop
)

REM --- "Fn" adds entry n to favorites ----------------------------------------
set "FIRSTCHAR=%CHOICE:~0,1%"
if /i "%FIRSTCHAR%"=="F" (
    set "FAVNUM=%CHOICE:~1%"
    call :ValidateNum "!FAVNUM!"
    if "!VALID!"=="1" (
        call :AddFavorite "!FAVNUM!"
    ) else (
        call "%VIZKIT_CORE%\Common.bat" :ErrorBox "Invalid item number for Favorites."
        call "%VIZKIT_CORE%\Common.bat" :Pause
    )
    goto :PageLoop
)

REM --- Otherwise, treat input as a numeric selection --------------------------
call :ValidateNum "%CHOICE%"
if "%VALID%"=="0" (
    call "%VIZKIT_CORE%\Common.bat" :ErrorBox "'%CHOICE%' is not a valid option."
    call "%VIZKIT_CORE%\Common.bat" :Pause
    goto :PageLoop
)

call :RunEntry %CHOICE%
goto :PageLoop

:EngineExit
endlocal
exit /b 0

REM ============================================================================
REM  :ValidateNum "<n>"   -> sets VALID=1 if n is a number within 1..TOTAL
REM ============================================================================
:ValidateNum
set "VALID=0"
set "CANDIDATE=%~1"
if "%CANDIDATE%"=="" exit /b 0
for /f "delims=0123456789" %%z in ("%CANDIDATE%") do exit /b 0
if %CANDIDATE% GEQ 1 if %CANDIDATE% LEQ %TOTAL% set "VALID=1"
exit /b 0

REM ============================================================================
REM  :AddFavorite <n>   Appends entry n to favorites.dat
REM  Kept as its own subroutine (rather than inline in a parenthesized block)
REM  so %~1 is resolved fresh at call time - mixing freshly-set block-local
REM  variables with percent-expansion in the same block is a classic batch
REM  bug (stale values), so indirect array lookups like NAME_<n> always
REM  happen on their own standalone lines here, exactly like :RunEntry does.
REM ============================================================================
:AddFavorite
set "FN=%~1"
>> "%VIZKIT_DATA%\favorites.dat" echo(!NAME_%FN%!~!DESC_%FN%!~!CMD_%FN%!~!CONF_%FN%!~!ADM_%FN%!
call "%VIZKIT_CORE%\Common.bat" :InfoBox "Added '!NAME_%FN%!' to Favorites."
call "%VIZKIT_CORE%\Common.bat" :Pause
exit /b 0

REM ============================================================================
REM  :RunEntry <n>   Executes entry n with confirmation/admin/error handling
REM ============================================================================
:RunEntry
set "N=%~1"
set "RNAME=!NAME_%N%!"
set "RDESC=!DESC_%N%!"
set "RCMD=!CMD_%N%!"
set "RCONF=!CONF_%N%!"
set "RADM=!ADM_%N%!"

cls
call "%VIZKIT_CORE%\Common.bat" :Header "%RNAME%" "%ENGINE_TITLE% > %RNAME%"
echo(   %RDESC%
echo(

if /i "%RADM%"=="Y" if not "%VIZKIT_ISADMIN%"=="1" (
    echo(   [!] This command normally requires Administrator privileges.
    echo(       VizKit is currently running as a standard user, so it may fail
    echo(       or show partial results. Consider re-launching VizKit as admin.
    echo(
)

if "%CFG_CONFIRMSENSITIVE%"=="1" if /i "%RCONF%"=="Y" (
    echo(   [!] This action can change system state.
    call "%VIZKIT_CORE%\Common.bat" :Confirm "Run '%RNAME%' now?"
    if not "!CONFIRM_RESULT!"=="YES" (
        call "%VIZKIT_CORE%\Common.bat" :InfoBox "Cancelled - no changes made."
        call "%VIZKIT_CORE%\Log.bat" WRITE "INFO" "User cancelled: %RNAME%"
        call "%VIZKIT_CORE%\Common.bat" :Pause
        exit /b 0
    )
)

call "%VIZKIT_CORE%\Log.bat" WRITE "CMD" "Running: %RNAME% [%RCMD%]"

REM --- Track in Recent (keep newest 20, avoid unbounded growth) --------------
>> "%VIZKIT_DATA%\recent.dat" echo(%RNAME%~%RDESC%~%RCMD%~%RCONF%~%RADM%
call :TrimRecent

echo(   ----------------------------------------------------------------------
cmd /c %RCMD%
set "RC=%errorlevel%"
echo(   ----------------------------------------------------------------------
echo(

if not "%RC%"=="0" (
    echo(   [!] Command finished with exit code %RC% ^(this may be normal for
    echo(       some diagnostic tools, or may indicate insufficient permissions^).
    call "%VIZKIT_CORE%\Log.bat" WRITE "WARN" "Non-zero exit (%RC%): %RNAME%"
) else (
    echo(   [OK] Command completed successfully.
    call "%VIZKIT_CORE%\Log.bat" WRITE "INFO" "Completed OK: %RNAME%"
)

call "%VIZKIT_CORE%\Common.bat" :Pause
exit /b 0

REM ============================================================================
REM  :TrimRecent   Keeps recent.dat capped at the last 20 entries
REM ============================================================================
:TrimRecent
set "RCOUNT=0"
for /f %%x in ('type "%VIZKIT_DATA%\recent.dat" 2^>nul ^| find /c /v ""') do set "RCOUNT=%%x"
if %RCOUNT% GTR 20 (
    for /f "skip=1 delims=" %%L in ('type "%VIZKIT_DATA%\recent.dat"') do echo(%%L>> "%VIZKIT_DATA%\recent_tmp.dat"
    move /y "%VIZKIT_DATA%\recent_tmp.dat" "%VIZKIT_DATA%\recent.dat" >nul
)
exit /b 0
