# Contributing to VizKit

Thanks for considering a contribution. VizKit is intentionally simple to
extend — most contributions don't require touching the engine at all.

## Ways to Contribute

### 1. Add a command (easiest, most welcome)

Open the relevant `Data\*.dat` file and add one line:

```
Name~Description~Command~Confirm(Y/N)~AdminRequired(Y/N)
```

Guidelines for new commands:

- Prefer native Windows commands or `powershell -NoProfile -Command "..."`
  one-liners over anything requiring a third-party download.
- Mark `Confirm=Y` for anything that changes system state (registry writes,
  service changes, deletions, restarts, formatting, etc.) — when in doubt,
  mark it `Y`.
- Mark `AdminRequired=Y` if the command typically needs elevation to show
  full results.
- Test the command directly in a real `cmd.exe`/PowerShell window before
  adding it — VizKit just runs your literal command string, so accuracy
  here matters.
- Run VizKit, type `dev` at the Main Menu, and use **Validate all
  Data\*.dat files** before submitting.

### 2. Write a plugin

See `docs/PluginGuide.md`. Plugins are a good fit for anything that doesn't
belong as a core, always-available command — experimental tools,
org-specific scripts, or anything with external dependencies.

### 3. Improve the core engine

Changes to `Core\*.bat` should:

- Preserve portability — never hardcode drive letters or absolute paths;
  use the `%VIZKIT_*%` variables set up in `Init.bat`.
- Preserve the "never run silently" safety model — no new code path should
  execute a state-changing command without visible confirmation.
- Be tested on both Windows 10 and Windows 11 where possible.
- Avoid introducing third-party dependencies. VizKit's core promise is
  "works on a stock Windows install, no downloads required."

### 4. Documentation and themes

Docs (`README.md`, `docs/*.md`) and new themes (`Core\Theme.bat`) are always
welcome. A new theme just needs a `COLOR` code pair and an accent character —
see the existing entries in `Theme.bat` for the pattern.

## Submitting Changes

1. Fork the repository.
2. Make your change on a feature branch.
3. Run the Developer Menu's data validation (`dev` → option 4) if you
   touched any `Data\*.dat` file.
4. Manually test the affected menu path end-to-end in a real Windows
   console.
5. Open a pull request describing what changed and why, and which category
   the change fits into.

## Reporting Issues

When reporting a broken or inaccurate command, please include:

- The exact category and command name from the menu.
- Your Windows version/build (visible in VizKit's header, or via
  **System > Detailed Build Info**).
- Whether VizKit was running elevated or not.
- The actual output/error you saw.

## Code of Conduct

Be respectful, be constructive, and remember that VizKit runs commands that
can affect real systems — accuracy and safety review matter more than speed
for any change that touches `Data\*.dat` or `Core\*.bat`.
