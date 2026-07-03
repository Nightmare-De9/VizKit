@echo off
REM VIZKIT:NAME=Example Plugin
REM VIZKIT:DESC=Demonstrates the VizKit plugin metadata format and conventions
REM VIZKIT:AUTHOR=VizKit Team
REM VIZKIT:VERSION=1.0
REM ============================================================================
REM  This is a working example plugin. Copy this file as a starting point for
REM  your own plugins. Read docs\PluginGuide.md for the full specification.
REM
REM  Rules a well-behaved plugin follows:
REM    1. Never assume the current directory - always use %~dp0 for its own
REM       path if it needs to find sibling files.
REM    2. Never use "exit" (which would close the parent VizKit session);
REM       always use "exit /b" so only the plugin's own process ends.
REM    3. Handle its own errors - VizKit will show a warning if your plugin
REM       exits with a non-zero code, but it will not crash VizKit either way.
REM    4. Keep output readable in an 80-column console when possible.
REM ============================================================================

echo(
echo(   Hello from the VizKit Example Plugin!
echo(
echo(   This plugin is just a normal .bat file living in the Plugins folder.
echo(   VizKit found it automatically and read its REM VIZKIT: metadata tags
echo(   to build the menu entry you just launched.
echo(
echo(   Plugin file location: %~f0
echo(

REM Example of doing something mildly useful: show the date/time.
echo(   Current date/time: %date% %time%
echo(

exit /b 0
