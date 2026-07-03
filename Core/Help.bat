@echo off
REM ============================================================================
REM  Core\Help.bat  -  In-app help / keyboard shortcut reference
REM ============================================================================
setlocal EnableExtensions

call "%VIZKIT_CORE%\Common.bat" :Header "Help" "Main Menu > Help"

echo(   NAVIGATION
echo(   ----------------------------------------------------------------------
echo(     [number]   Run the command with that number
echo(     N          Next page          P          Previous page
echo(     S          Search all commands by name, keyword, or description
echo(     F          Open Favorites     Fn (e.g. F3)  Add item n to Favorites
echo(     R          Open Recent Commands (last 20 you ran)
echo(     H          Show this Help screen
echo(     B          Back to the previous menu
echo(     0          Exit VizKit completely (from any menu)
echo(
echo(   ABOUT COMMAND SAFETY
echo(   ----------------------------------------------------------------------
echo(     Commands marked as sensitive will always ask you to type YES before
echo(     running. Commands that typically need elevation will warn you if
echo(     VizKit is not currently running as Administrator. No command runs
echo(     silently in the background - you always see its live output.
echo(
echo(   LOGS ^& REPORTS
echo(   ----------------------------------------------------------------------
echo(     Every session writes a timestamped log to the Logs folder.
echo(     The Reports menu (Main Menu ^> Diagnostics ^> Generate Report) builds
echo(     timestamped inventories into the Reports folder.
echo(
echo(   PLUGINS
echo(   ----------------------------------------------------------------------
echo(     Drop a .bat or .cmd file into the Plugins folder and it will appear
echo(     automatically in Main Menu ^> Plugins the next time VizKit starts.
echo(     See docs\PluginGuide.md for the full spec.
echo(
echo(   CONFIGURATION
echo(   ----------------------------------------------------------------------
echo(     Edit config.ini to change the theme, page size, banner, and logging.
echo(     Themes available: Classic, Matrix, Cyber, Blue, Light.
echo(

call "%VIZKIT_CORE%\Common.bat" :Pause
endlocal
exit /b 0
