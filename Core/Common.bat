@echo off
REM ============================================================================
REM  Core\Common.bat  -  Shared UI + utility subroutines
REM  This file is never "called" directly for its own body; instead its
REM  labels are invoked with: call "%VIZKIT_CORE%\Common.bat" :LabelName args
REM  That single-file/multi-label pattern is what keeps VizKit free of
REM  duplicated UI code across every menu file.
REM ============================================================================

if "%~1"=="" exit /b 0
goto %~1

REM ----------------------------------------------------------------------------
REM  :Header  "<Title>"  "<Breadcrumb>"
REM  Clears the screen and draws the standard VizKit header block.
REM ----------------------------------------------------------------------------
:Header
setlocal
set "H_TITLE=%~2"
set "H_CRUMB=%~3"
cls
call :Line
echo(  __     ___     _  ___ _
echo(  \ \   / (_)___| |/ (_) |_
echo(   \ \ / /| |_  / ' /| | __^|
echo(    \ V / | |/ /| . \| | ^|_
echo(     \_/  |_/___|_|\_\_|\__^|
echo(
echo(   VizKit v%VIZKIT_VERSION%  ^|  %WIN_FRIENDLY% (Build %WIN_BUILD%, %WIN_ARCH%)  ^|  Theme: %VIZKIT_THEME_LABEL%
call :Line
if not "%H_TITLE%"=="" echo(   %H_TITLE%
if not "%H_CRUMB%"=="" echo(   Location: %H_CRUMB%
call :Line
echo(
endlocal
exit /b 0

REM ----------------------------------------------------------------------------
REM  :Line   Draws a divider line using the active theme's accent character
REM ----------------------------------------------------------------------------
:Line
setlocal
set "L=%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%%VIZKIT_ACCENT%"
set "L=%L%%L%%L%%L%%L%%L%%L%%L%"
set "L=%L:~0,78%"
echo(%L%
endlocal
exit /b 0

REM ----------------------------------------------------------------------------
REM  :Footer   Standard footer / status bar shown at the bottom of every menu
REM ----------------------------------------------------------------------------
:Footer
setlocal
call :Line
if "%VIZKIT_ISADMIN%"=="1" (
    set "ADMSTATE=Administrator"
) else (
    set "ADMSTATE=Standard User"
)
echo(   [S]earch  [F]avorites  [R]ecent  [H]elp  [B]ack  [0] Exit    Session: %ADMSTATE%
call :Line
endlocal
exit /b 0

REM ----------------------------------------------------------------------------
REM  :Pause   "Press any key" prompt, wrapped so callers don't repeat text
REM ----------------------------------------------------------------------------
:Pause
echo(
pause>nul
echo(
exit /b 0

REM ----------------------------------------------------------------------------
REM  :Confirm  "<question text>"    -> sets CONFIRM_RESULT=YES or NO
REM ----------------------------------------------------------------------------
:Confirm
setlocal EnableDelayedExpansion
set "Q=%~2"
set "ANSWER="
echo(
echo(   !Q!
set /p "ANSWER=   Type YES to continue, anything else to cancel: "
endlocal & if /i "%ANSWER%"=="YES" (set "CONFIRM_RESULT=YES") else (set "CONFIRM_RESULT=NO")
exit /b 0

REM ----------------------------------------------------------------------------
REM  :ErrorBox  "<message>"   Displays a consistent error message block
REM ----------------------------------------------------------------------------
:ErrorBox
setlocal
echo(
echo(   [!] %~2
echo(
endlocal
exit /b 0

REM ----------------------------------------------------------------------------
REM  :InfoBox   "<message>"
REM ----------------------------------------------------------------------------
:InfoBox
setlocal
echo(
echo(   [i] %~2
echo(
endlocal
exit /b 0
