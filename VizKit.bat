@echo off
REM ============================================================================
REM  VizKit.bat  -  Single entry point for the VizKit Windows toolkit
REM
REM  This file must stay tiny and fast. All real logic lives in Core\*.bat.
REM  It only:
REM    1. Locks the working directory to its own location (portability)
REM    2. Loads the core initialization routine
REM    3. Hands off control to the Main Menu
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- Anchor all paths to this script's folder, so VizKit works from any
REM     drive or folder (USB stick, network share, etc.) without hardcoding.
set "VIZKIT_ROOT=%~dp0"
if "%VIZKIT_ROOT:~-1%"=="\" set "VIZKIT_ROOT=%VIZKIT_ROOT:~0,-1%"

set "VIZKIT_CORE=%VIZKIT_ROOT%\Core"
set "VIZKIT_DATA=%VIZKIT_ROOT%\Data"
set "VIZKIT_PLUGINS=%VIZKIT_ROOT%\Plugins"
set "VIZKIT_LOGS=%VIZKIT_ROOT%\Logs"
set "VIZKIT_REPORTS=%VIZKIT_ROOT%\Reports"
set "VIZKIT_CONFIG=%VIZKIT_ROOT%\config.ini"
set "VIZKIT_VERSION=1.0.0"

REM --- Sanity check: Core folder must exist or VizKit cannot run.
if not exist "%VIZKIT_CORE%\Init.bat" (
    echo [FATAL] Core\Init.bat not found. Your VizKit installation is incomplete.
    echo Expected at: %VIZKIT_CORE%\Init.bat
    pause
    exit /b 1
)

REM --- Title + console code page (safe UTF-8-ish box drawing) ---------------
title VizKit v%VIZKIT_VERSION%

call "%VIZKIT_CORE%\Init.bat"
if errorlevel 1 (
    echo [FATAL] VizKit failed to initialize. See Logs folder for details.
    pause
    exit /b 1
)

call "%VIZKIT_CORE%\MainMenu.bat"

REM --- Clean shutdown ---------------------------------------------------------
call "%VIZKIT_CORE%\Log.bat" WRITE "INFO" "VizKit session ended normally."
endlocal
exit /b 0
