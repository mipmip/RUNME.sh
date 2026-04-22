## 1. Changelog

- [x] 1.1 Create `CHANGELOG.md` with `[Unreleased]` section and retroactive `v1.0.0` entry
- [x] 1.2 Add comparison links at bottom

## 2. Release Script

- [x] 2.1 Create `release.sh` — parse and validate argument (major/minor/patch)
- [x] 2.2 Read current version from latest git tag
- [x] 2.3 Bump version according to semver
- [x] 2.4 Validate `[Unreleased]` section has entries
- [x] 2.5 Replace `[Unreleased]` with new version heading, add fresh `[Unreleased]`
- [x] 2.6 Update comparison links
- [x] 2.7 Git commit and tag
- [x] 2.8 Push commit and tags to remote
- [x] 2.9 Create GitHub Release via `gh release create` with changelog section as body
- [x] 2.10 Print summary

## 3. Verify

- [x] 3.1 Test release.sh with a dry run (verify changelog output without committing)
