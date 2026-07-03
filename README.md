# VizKit

A portable, dependency-free Windows administration toolkit built entirely in
native Batch, with **200 built-in commands** across System, Network, Storage,
Windows Security, Diagnostics, Recovery, Development, and Reports — plus a
plugin system, favorites, recent commands, search, logging, and themeable UI.

VizKit runs on Windows 10 and Windows 11 (64-bit and ARM64), requires no
installation, no admin rights to launch, and no third-party software.

## Quick Start

1. Copy the `VizKit` folder anywhere — a local drive, a USB stick, a network
   share.
2. Double-click `VizKit.bat`.
3. Use the number keys to browse categories, or press `S` to search all 200
   commands at once.

Some commands (marked with an admin warning when selected) work best when
VizKit itself is run as Administrator. Right-click `VizKit.bat` and choose
**Run as administrator** if you plan to use those.

## Why Batch, and why data-driven?

Every command in VizKit lives as one line in a plain-text file under `Data\`
(e.g. `Data\Network.dat`), in the format:

```
Name~Description~Command~Confirm(Y/N)~AdminRequired(Y/N)
```

A single reusable engine (`Core\Engine.bat`) reads these files to build every
menu, run commands, log activity, and manage Favorites/Recent. This means:

- No duplicated menu-handling code across 200 commands.
- Adding a new command is a one-line edit to a `.dat` file — no batch
  scripting required.
- The whole toolkit stays auditable: you can read every command VizKit will
  ever run just by opening the `Data\*.dat` files in Notepad.

## Features

- **200 built-in commands** across 8 categories (System, Network, Storage,
  Windows Security, Diagnostics, Recovery, Development, Reports)
- **Search** across every command's name, description, and underlying command
- **Favorites** and **Recent Commands** (last 20), available from any menu
- **Plugin system** — drop a `.bat`/`.cmd` file into `Plugins\` and it shows
  up automatically, with optional metadata (name/description/author/version)
- **Session logging** — every launch writes a timestamped log to `Logs\`
- **Report generation** — timestamped inventories saved to `Reports\`
- **5 built-in themes** — Classic, Matrix, Cyber, Blue, Light
- **Confirmation prompts** for any command that changes system state
- **Admin-awareness** — VizKit tells you up front if a command usually needs
  elevation, without forcing a relaunch
- **Hidden developer menu** (type `dev` at the Main Menu) for validating data
  files, inspecting environment variables, and tailing the session log

## Folder Structure

```
VizKit/
├── VizKit.bat            Entry point — keep this tiny, don't edit logic here
├── config.ini             Your settings: theme, page size, logging, etc.
├── Core/                  The engine — menu system, theming, logging, search
├── Data/                  One .dat file per category = the 200 commands
├── Plugins/               Drop your own .bat/.cmd files here
├── Logs/                  Auto-created, timestamped session logs
├── Reports/               Auto-created, timestamped generated reports
└── docs/                  Developer & plugin documentation
```

## Configuration

Edit `config.ini` (plain text) to change:

- `Theme` — Classic, Matrix, Cyber, Blue, or Light
- `ShowBanner` — show the welcome banner on startup
- `LoggingEnabled` — turn session logging on/off
- `PageSize` — how many commands are shown per page before pagination
- `ConfirmSensitive` — require typed confirmation for state-changing commands

## Safety Model

VizKit does not run anything silently. Every command:

- Shows its full description before running
- Prints live output directly in the console — nothing is hidden
- Asks for typed `YES` confirmation if it's flagged as changing system state
- Warns (but doesn't block) if it likely needs Administrator rights
- Reports its exit code and logs the result

Nothing in the default command set formats a drive, deletes system files, or
makes irreversible changes without an explicit confirmation prompt naming
exactly what will happen.

## Extending VizKit

- **Add a command**: open the relevant `Data\*.dat` file and add one line.
  See `docs/DeveloperGuide.md`.
- **Add a plugin**: drop a `.bat`/`.cmd` file into `Plugins\`. See
  `docs/PluginGuide.md`.

## Contributing

See `CONTRIBUTING.md`.

## License

See `LICENSE` (MIT).
