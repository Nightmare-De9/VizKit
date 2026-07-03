# VizKit Developer Guide

This document explains how VizKit is put together, so you can safely extend
or modify it.

## Architecture Overview

```
VizKit.bat            Anchors paths, then hands off to Core\Init.bat
  └─ Core\Init.bat     Loads config.ini, detects Windows, starts the log,
                        applies the theme, then hands off to MainMenu.bat
       └─ Core\MainMenu.bat   Top-level category list
            └─ Core\Engine.bat   Generic paginated menu + execution engine,
                                   driven entirely by Data\*.dat files
```

Supporting modules, all called via `call "%VIZKIT_CORE%\X.bat"`:

| File               | Responsibility                                          |
|---------------------|----------------------------------------------------------|
| `Common.bat`        | Shared UI: header, footer, dividers, pause, confirm boxes |
| `Theme.bat`         | Applies a console color theme                             |
| `Log.bat`           | Appends a line to the current session log                 |
| `Search.bat`        | Searches every `Data\*.dat` file, ranks, hands to Engine   |
| `Plugins.bat`       | Discovers `.bat`/`.cmd` files in `Plugins\`, hands to Engine|
| `Reports.bat`       | Thin wrapper exposing `Data\Reports.dat` via Engine        |
| `Help.bat`          | Static help / keyboard shortcut screen                    |
| `DevMenu.bat`       | Hidden developer menu (type `dev` at the Main Menu)        |

## The Data-Driven Command Format

Every command in every category is one line in a `Data\*.dat` file:

```
Name~Description~Command~Confirm(Y/N)~AdminRequired(Y/N)
```

- **Name** — shown in the menu list. Keep it short (under ~28 chars fits
  best on an 80-column console).
- **Description** — one line, shown next to the name and again before the
  command runs.
- **Command** — the literal command line VizKit will execute via `cmd /c`.
  This can be a native command, a `powershell -NoProfile -Command "..."`
  one-liner, or a chain of commands joined with `&`.
- **Confirm** — `Y` if VizKit should require the user to type `YES` before
  running it (use for anything that changes system state).
- **AdminRequired** — `Y` if the command typically needs elevation. VizKit
  will show a warning (not a hard block) if it isn't currently elevated.

Lines starting with `;` are comments and are ignored. Blank lines are
ignored.

### Adding a new command

1. Open the matching `Data\*.dat` file (or create a new category — see
   below).
2. Add one line following the format above.
3. Run VizKit, type `dev` at the Main Menu, choose **4. Validate all
   Data\*.dat files** to confirm the line parses correctly.

### A note on quoting

Because fields are split on `~`, you're free to use double quotes inside the
**Command** field for normal Windows quoting. What you should avoid:

- **`~` inside a field** — it will be mis-parsed as a field separator.
- **`!` inside a field** — `Engine.bat` runs with delayed expansion enabled,
  and a literal `!` can be misread as the start of a delayed-expansion
  variable reference. If a PowerShell command needs a literal `!`, avoid it
  or wrap the whole thing in a plugin instead (see `PluginGuide.md`).
- **Nested double quotes inside a `powershell -Command "..."` argument** —
  if you need a path with spaces inside a PowerShell command, build it with
  string concatenation and single quotes instead of escaped double quotes,
  e.g. `($env:TEMP + '\*')` rather than `"\"$env:TEMP\*\""`.

### Adding a new category

1. Create `Data\YourCategory.dat` following the same format.
2. In `Core\MainMenu.bat`, add a numbered menu line and an `if` block that
   calls `Engine.bat` against your new file, following the existing pattern
   for entries 1–9.
3. Optionally add your category to the `for %%F in (...)` loops in
   `Core\Search.bat` and `Core\DevMenu.bat`'s `:ValidateData` /  entry-count
   routines so search and validation cover it too.

## Logging

`Core\Log.bat` is called as:

```
call "%VIZKIT_CORE%\Log.bat" WRITE "<LEVEL>" "<message>"
```

`LEVEL` is a free-form tag (`INFO`, `WARN`, `ERROR`, `CMD`, ...). Logging is a
no-op automatically when `LoggingEnabled=0` in `config.ini`, so callers never
need to check the setting themselves.

## Exit-Code Convention

VizKit uses exit code `99` internally as "the user asked to exit the whole
program," so choosing `0` from any nested menu closes VizKit cleanly instead
of just returning one level up. If you add new menu wrappers around
`Engine.bat`, propagate this code:

```
call "%VIZKIT_CORE%\Engine.bat" "%VIZKIT_DATA%\YourCategory.dat" "Your Category"
if errorlevel 99 goto :DoExit
```

## Themes

`Core\Theme.bat` maps a theme name to a `COLOR` code and an accent character
used for header/divider drawing. Batch consoles can only apply one
foreground/background pair at a time, so "theme" in VizKit means: base
palette + accent character, which keeps each theme visually distinct without
needing any third-party console library.

## Coding Conventions

- All new `Core\*.bat` files should start with `@echo off` and a comment
  block describing their responsibility.
- Prefer `setlocal EnableExtensions EnableDelayedExpansion` at the top of any
  file that manipulates variables in loops.
- Use `%VIZKIT_ROOT%`, `%VIZKIT_CORE%`, `%VIZKIT_DATA%`, `%VIZKIT_LOGS%`, and
  `%VIZKIT_REPORTS%` rather than hardcoded paths — this is what makes VizKit
  portable across drives and machines.
- Never use `exit` (closes the whole console); always use `exit /b [code]`.
