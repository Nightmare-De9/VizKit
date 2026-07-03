@echo off
REM ============================================================================
REM  Core\Theme.bat  -  Applies a console color theme
REM  Usage: call Theme.bat "<ThemeName>"
REM  Supported: Classic, Matrix, Cyber, Blue, Light
REM  Batch consoles only support one background/foreground color pair via the
REM  COLOR command, so "theme" here means: base palette + accent character
REM  used to draw headers/dividers, which keeps every screen visually distinct.
REM ============================================================================

set "THEME_NAME=%~1"
if "%THEME_NAME%"=="" set "THEME_NAME=Classic"

if /i "%THEME_NAME%"=="Matrix" (
    color 0A
    set "VIZKIT_ACCENT=#"
    set "VIZKIT_THEME_LABEL=Matrix"
    goto :ThemeDone
)

if /i "%THEME_NAME%"=="Cyber" (
    color 0D
    set "VIZKIT_ACCENT=~"
    set "VIZKIT_THEME_LABEL=Cyber"
    goto :ThemeDone
)

if /i "%THEME_NAME%"=="Blue" (
    color 1F
    set "VIZKIT_ACCENT=="
    set "VIZKIT_THEME_LABEL=Blue"
    goto :ThemeDone
)

if /i "%THEME_NAME%"=="Light" (
    color F0
    set "VIZKIT_ACCENT=-"
    set "VIZKIT_THEME_LABEL=Light"
    goto :ThemeDone
)

REM --- Default: Classic ---------------------------------------------------
color 07
set "VIZKIT_ACCENT=-"
set "VIZKIT_THEME_LABEL=Classic"

:ThemeDone
exit /b 0
