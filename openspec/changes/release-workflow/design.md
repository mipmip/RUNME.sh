## Context

RUNME.sh has a single `v1.0` tag and no formal release process. The project is small (a bash boilerplate + build system) and the release workflow should match that simplicity.

## Goals / Non-Goals

**Goals:**
- CHANGELOG.md with `[Unreleased]` section that collects changes as they happen
- `release.sh` that automates version bump, changelog update, git tag, and GitHub Release
- Semver versioning
- GitHub Release created via `gh release create` with changelog section as body

**Non-Goals:**
- CI/CD integration
- Automated changelog generation from commit messages

## Decisions

### CHANGELOG.md format

Use [Keep a Changelog](https://keepachangelog.com/) format. Sections: Added, Changed, Deprecated, Removed, Fixed, Security.

The `[Unreleased]` heading always exists at the top. When `release.sh` runs, it replaces `[Unreleased]` with `[X.Y.Z] - YYYY-MM-DD` and adds a fresh empty `[Unreleased]` above it.

### release.sh interface

```bash
./release.sh <major|minor|patch>
```

Steps:
1. Read current version from latest git tag (e.g. `v1.1.0` → `1.1.0`)
2. Bump according to argument (major/minor/patch)
3. Replace `## [Unreleased]` with `## [X.Y.Z] - YYYY-MM-DD` in CHANGELOG.md
4. Add a new empty `## [Unreleased]` section at the top
5. Update comparison links at the bottom of CHANGELOG.md
6. Git commit: `Release vX.Y.Z`
7. Git tag: `vX.Y.Z`

8. Git push with tags
9. Create GitHub Release via `gh release create vX.Y.Z` with the version's changelog section as the release body

### Starting version

Current tag is `v1.0`. Treat as `v1.0.0`. First new release will be `v1.1.0` (minor, since features have been added).

### Comparison links

CHANGELOG.md includes comparison links at the bottom per Keep a Changelog convention:

```markdown
[Unreleased]: https://github.com/mipmip/RUNME.sh/compare/vX.Y.Z...HEAD
[X.Y.Z]: https://github.com/mipmip/RUNME.sh/compare/vX.Y-1.Z...vX.Y.Z
```

## Risks / Trade-offs

- [No validation of Unreleased content] → Script checks that `[Unreleased]` has entries before releasing; exits with error if empty
- [Manual changelog entries] → Keeps it simple and intentional; automated generation can come later
