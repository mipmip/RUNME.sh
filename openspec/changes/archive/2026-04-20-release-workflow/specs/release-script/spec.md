## ADDED Requirements

### Requirement: release.sh accepts semver bump type
The `release.sh` script SHALL accept exactly one argument: `major`, `minor`, or `patch`.

#### Scenario: Valid argument
- **WHEN** `./release.sh minor` is run
- **THEN** the version is bumped according to semver minor rules

#### Scenario: No argument
- **WHEN** `./release.sh` is run without arguments
- **THEN** the script exits with an error and prints usage

#### Scenario: Invalid argument
- **WHEN** `./release.sh foo` is run
- **THEN** the script exits with an error and prints usage

### Requirement: Version is derived from latest git tag
The script SHALL read the current version from the latest `vX.Y.Z` git tag.

#### Scenario: Tag exists
- **WHEN** the latest tag is `v1.1.0` and bump type is `patch`
- **THEN** the new version is `v1.1.1`

### Requirement: Changelog is updated on release
The script SHALL replace `## [Unreleased]` with `## [X.Y.Z] - YYYY-MM-DD` and add a fresh empty `## [Unreleased]` section above it.

#### Scenario: Release updates changelog
- **WHEN** `./release.sh minor` is run
- **THEN** the `[Unreleased]` content moves under the new version heading
- **THEN** a new empty `## [Unreleased]` section appears at the top

### Requirement: Empty unreleased section prevents release
The script SHALL exit with an error if the `[Unreleased]` section contains no entries.

#### Scenario: No changes to release
- **WHEN** `./release.sh minor` is run and `[Unreleased]` has no entries
- **THEN** the script exits with error: "No unreleased changes to release"

### Requirement: Comparison links are updated
The script SHALL update the comparison links at the bottom of CHANGELOG.md to include the new version.

#### Scenario: Links updated
- **WHEN** a release is made for `v1.2.0`
- **THEN** the `[Unreleased]` link compares `v1.2.0...HEAD`
- **THEN** a new link for `[1.2.0]` compares the previous tag to `v1.2.0`

### Requirement: Git commit and tag are created
The script SHALL create a git commit with message `Release vX.Y.Z` and a git tag `vX.Y.Z`.

#### Scenario: Commit and tag
- **WHEN** `./release.sh minor` bumps to `v1.2.0`
- **THEN** a commit is created with message `Release v1.2.0`
- **THEN** a tag `v1.2.0` is created pointing to that commit

### Requirement: Script pushes with tags
The script SHALL push the commit and tag to the remote.

#### Scenario: After commit and tag
- **WHEN** the commit and tag are created
- **THEN** the script runs `git push && git push --tags`

### Requirement: GitHub Release is created
The script SHALL create a GitHub Release using `gh release create` with the new version's changelog section as the release body.

#### Scenario: Release created
- **WHEN** `./release.sh minor` bumps to `v1.2.0`
- **THEN** a GitHub Release is created for tag `v1.2.0`
- **THEN** the release body contains the changelog entries for that version
