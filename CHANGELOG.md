# Changelog

All notable changes to VizKit are documented in this file.

## [1.0.0] - 2026-07-03

### Added
- Initial public release.
- Data-driven command engine (`Core\Engine.bat`) reading `Data\*.dat` files.
- 200 built-in commands across 8 categories: System (33), Network (30),
  Storage (25), Windows Security (28), Diagnostics (29), Recovery (21),
  Development (24), Reports (10).
- Global search across command names, descriptions, and underlying commands,
  ranked with name-matches first.
- Favorites and Recent Commands (last 20), available from any menu depth.
- Plugin system: auto-discovers `.bat`/`.cmd` files in `Plugins\`, with an
  optional `REM VIZKIT:` metadata convention.
- Timestamped session logging to `Logs\`.
- Timestamped report generation to `Reports\` via the Reports category.
- `config.ini` for theme, banner, logging, page size, and confirmation
  behavior.
- Five built-in console themes: Classic, Matrix, Cyber, Blue, Light.
- Confirmation prompts for state-changing commands, and non-blocking
  elevation warnings for admin-flagged commands.
- Hidden Developer Menu (`dev` at the Main Menu) with environment variable
  dump, log tail, config reload, data-file validation, and per-category
  entry counts.
- Full documentation set: README, CONTRIBUTING, DeveloperGuide, PluginGuide.
