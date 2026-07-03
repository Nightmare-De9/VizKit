@echo off
REM ============================================================================
REM  Core\Log.bat  -  Central logging routine
REM  Usage: call "%VIZKIT_CORE%\Log.bat" WRITE "<LEVEL>" "<message>"
REM  LEVEL is a free-form tag: INFO, WARN, ERROR, CMD, PLUGIN, REPORT
REM  Writing is a no-op if logging is disabled in config.ini, so callers never
REM  need to check CFG_LOGGING themselves.
REM ============================================================================

if /i not "%~1"=="WRITE" exit /b 1
if "%CFG_LOGGING%"=="0" exit /b 0
if not defined VIZKIT_LOGFILE exit /b 0

set "LOG_LEVEL=%~2"
set "LOG_MSG=%~3"

>> "%VIZKIT_LOGFILE%" echo [%date% %time%] [%LOG_LEVEL%] %LOG_MSG%
exit /b 0
