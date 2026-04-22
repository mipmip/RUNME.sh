# changelog Specification

## Purpose
TBD - created by archiving change release-workflow. Update Purpose after archive.
## Requirements
### Requirement: CHANGELOG.md follows Keep a Changelog format
The project SHALL have a `CHANGELOG.md` at the repository root following the [Keep a Changelog](https://keepachangelog.com/) format with sections: Added, Changed, Deprecated, Removed, Fixed, Security.

#### Scenario: New changelog exists
- **WHEN** the repository is checked out
- **THEN** a `CHANGELOG.md` file exists at the root

### Requirement: Unreleased section always present
The CHANGELOG.md SHALL always contain an `## [Unreleased]` section at the top (below the title) where new changes are collected before a release.

#### Scenario: After a release
- **WHEN** a release is made
- **THEN** CHANGELOG.md still contains an empty `## [Unreleased]` section above the new version heading

#### Scenario: Between releases
- **WHEN** changes are made to the project
- **THEN** they are added under the `## [Unreleased]` section manually

### Requirement: Comparison links at bottom
The CHANGELOG.md SHALL include GitHub comparison links at the bottom for each version and for Unreleased.

#### Scenario: Links present
- **WHEN** CHANGELOG.md is viewed
- **THEN** each version heading has a corresponding comparison link at the bottom of the file

