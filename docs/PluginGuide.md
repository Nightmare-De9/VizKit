# VizKit Plugin Guide

Plugins let you add your own commands to VizKit without touching any core
files. A plugin is simply a `.bat` or `.cmd` file placed in the `Plugins\`
folder.

## The Minimal Plugin

This is a complete, valid plugin:

```bat
@echo off
echo Hello from my plugin!
exit /b 0
```

Save it as `Plugins\Hello.bat` and it will appear in **Main Menu > Plugins**
the next time you start VizKit, listed as "Hello" (the filename is used as
the display name when no metadata is provided).

## Adding Metadata

To control how your plugin appears, add comment lines near the top of the
file using the `REM VIZKIT:` prefix. VizKit reads the first 15 lines of every
plugin looking for these tags:

```bat
@echo off
REM VIZKIT:NAME=My Plugin
REM VIZKIT:DESC=One-line description shown in the menu
REM VIZKIT:AUTHOR=Your Name
REM VIZKIT:VERSION=1.0

echo Hello from my plugin!
exit /b 0
```

Only `NAME` and `DESC` currently affect what's displayed; `AUTHOR` and
`VERSION` are reserved for future use and safe to include for your own
documentation purposes.

## Rules Every Plugin Should Follow

1. **Never use bare `exit`** — it closes the entire console window,
   including VizKit itself. Always use `exit /b [code]` so only your
   plugin's own process ends.
2. **Don't assume the working directory.** VizKit calls your plugin with its
   full path, but if your plugin needs to find sibling files, use `%~dp0`
   (the plugin's own folder) rather than a relative path.
3. **Return a meaningful exit code.** VizKit will show "[OK] Command
   completed successfully" for exit code `0`, and a soft warning for any
   other code — it will never crash VizKit either way, so this is about
   giving the user accurate feedback, not about safety.
4. **Handle your own errors.** Wrap risky operations in your plugin the same
   way you would in any other batch script — VizKit doesn't know what your
   plugin does internally.
5. **Keep output readable.** VizKit's console assumes roughly an 80-column
   width by default.
6. **Don't fight the theme.** Avoid calling `color` yourself inside a
   plugin — let VizKit's active theme control the console colors. If you
   must change colors temporarily, restore them before your plugin exits.

## What Plugins Can Do

Anything a normal `.bat`/`.cmd` file can do: run other programs, call
PowerShell, prompt for input with `set /p` or `Read-Host`, write files, etc.
Plugins run with the same permissions as VizKit itself (elevated, if VizKit
was launched elevated).

## What Plugins Get for Free

Because VizKit converts every discovered plugin into a temporary entry for
`Core\Engine.bat`, plugins automatically get:

- A confirmation-free launch (plugins are never auto-confirmed as
  "sensitive" — if your plugin does something destructive, warn and confirm
  the user *inside* your plugin's own code)
- Automatic inclusion in **Favorites** (press `Fn` from the Plugins menu)
- Automatic inclusion in **Recent Commands**
- A session log entry each time they're run

## Testing Your Plugin

1. Drop your `.bat`/`.cmd` file into `Plugins\`.
2. Launch VizKit, go to **Main Menu > Plugins**.
3. Confirm your plugin's name/description look right, then run it.
4. Type `dev` at the Main Menu to open the hidden Developer Menu if you want
   to inspect the current session log after running your plugin.

## Example

See `Plugins\Example_Plugin.bat` in this repository for a complete, working
reference implementation.
