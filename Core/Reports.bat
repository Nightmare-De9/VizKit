@echo off
REM ============================================================================
REM  Core\Reports.bat  -  Thin wrapper exposing Data\Reports.dat through the
REM  standard Engine, so report generation gets Favorites/Recent/logging for
REM  free, exactly like every other category.
REM ============================================================================
setlocal
call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\Reports.dat" "Reports"
set "RC=%errorlevel%"
endlocal & exit /b %RC%
