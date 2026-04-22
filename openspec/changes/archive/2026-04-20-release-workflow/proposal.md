## Why

The project has no changelog, no version bumping, and no release process. The only version marker is a single `v1.0` git tag. As features are added (RUNME.d/ support, build system, etc.) there's no way to communicate what changed between releases.

## What Changes

- Add a `CHANGELOG.md` following Keep a Changelog format with an `[Unreleased]` section
- Add a `release.sh` script that bumps the semver version, moves `[Unreleased]` entries to a new version heading, tags the commit, and updates comparison links
- Establish semver versioning starting from the current `v1.0` as `v1.0.0`

## Capabilities

### New Capabilities
- `changelog`: CHANGELOG.md with Unreleased placeholder, Keep a Changelog format
- `release-script`: Script to bump version, update changelog, create git tag

### Modified Capabilities

## Impact

- New files: `CHANGELOG.md`, `release.sh`
- Existing `v1.0` tag remains as-is; new releases start from `v1.1.0`
