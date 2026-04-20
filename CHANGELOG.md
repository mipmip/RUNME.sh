# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [2.0.0] - 2026-04-20

### Added

- RUNME.d/ support — split commands into separate files
- `build.sh` — builds RUNME.sh from source with minification
- `test.sh` — syntax, functional, and equivalence tests
- `src/minify.sh` — bash minifier for the framework
- Examples directory with inline and RUNME.d/ usage
- CHANGELOG.md and release workflow

### Changed

- Copyright years updated to 2019-2026

### Removed

- `make-minified-runme.sh` (replaced by `build.sh`)
- `RUNME.unminified.sh` (redundant with `src/RUNME.inc.sh`)
- `src/RUNME.inc.minified.sh` (now generated at build time)

## [1.0.0] - 2019-12-01

### Added

- Initial release of RUNME.sh boilerplate
- `make_command` function for registering commands
- Auto-generated usage banners
- Single-file minified boilerplate

[Unreleased]: https://github.com/mipmip/RUNME.sh/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/mipmip/RUNME.sh/compare/v1.0...v2.0.0
[1.0.0]: https://github.com/mipmip/RUNME.sh/releases/tag/v1.0
