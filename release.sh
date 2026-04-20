#!/usr/bin/env bash
#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh

set -euo pipefail
cd "$(dirname "$0")"

REPO_URL="https://github.com/mipmip/RUNME.sh"

# --- Detect VCS ---

if jj root &>/dev/null; then
  VCS="jj"
elif git rev-parse --git-dir &>/dev/null; then
  VCS="git"
else
  echo "Error: not in a git or jj repository"
  exit 1
fi

# --- 2.1 Parse and validate argument ---

usage() {
  echo "Usage: ./release.sh <major|minor|patch>"
  exit 1
}

[[ $# -ne 1 ]] && usage

BUMP_TYPE="$1"
case "$BUMP_TYPE" in
  major|minor|patch) ;;
  *) echo "Error: invalid bump type '$BUMP_TYPE'"; usage ;;
esac

# --- 2.2 Read current version from latest git tag ---

# Both jj and git use git tags under the hood
CURRENT_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
# Normalize v1.0 to v1.0.0
CURRENT_VERSION="${CURRENT_TAG#v}"
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"
MAJOR="${MAJOR:-0}"
MINOR="${MINOR:-0}"
PATCH="${PATCH:-0}"

# --- 2.3 Bump version according to semver ---

case "$BUMP_TYPE" in
  major) MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0 ;;
  minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
  patch) PATCH=$((PATCH + 1)) ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
NEW_TAG="v$NEW_VERSION"
TODAY=$(date +%Y-%m-%d)

echo "Releasing: $CURRENT_TAG → $NEW_TAG"

# --- 2.4 Validate [Unreleased] section has entries ---

CHANGELOG="CHANGELOG.md"

if ! grep -q '## \[Unreleased\]' "$CHANGELOG"; then
  echo "Error: no [Unreleased] section found in $CHANGELOG"
  exit 1
fi

# Extract content between [Unreleased] and next ## heading
UNRELEASED_CONTENT=$(sed -n '/^## \[Unreleased\]/,/^## \[/{/^## \[/!p}' "$CHANGELOG" | grep -v '^$' | grep -v '^###' || true)

if [[ -z "$UNRELEASED_CONTENT" ]]; then
  echo "Error: no unreleased changes to release"
  exit 1
fi

# --- 2.5 Replace [Unreleased] with new version heading, add fresh [Unreleased] ---

# Extract the release notes section (between [Unreleased] and next version)
RELEASE_BODY=$(sed -n '/^## \[Unreleased\]/,/^## \[/{/^## \[/!p}' "$CHANGELOG")

sed -i "s/^## \[Unreleased\]/## [$NEW_VERSION] - $TODAY/" "$CHANGELOG"

# Add fresh [Unreleased] section at the top (after the header block)
sed -i "/^## \[$NEW_VERSION\]/i\\
## [Unreleased]\\
" "$CHANGELOG"

# --- 2.6 Update comparison links ---

# Update the [Unreleased] comparison link
sed -i "s|\[Unreleased\]: .*|[Unreleased]: $REPO_URL/compare/$NEW_TAG...HEAD|" "$CHANGELOG"

# Add new version comparison link (before the oldest version link)
PREV_TAG="$CURRENT_TAG"
# Insert new version link after [Unreleased] link
sed -i "/^\[Unreleased\]: /a\\
[$NEW_VERSION]: $REPO_URL/compare/$PREV_TAG...$NEW_TAG" "$CHANGELOG"

# --- 2.7 Commit and tag ---

if [[ "$VCS" == "jj" ]]; then
  jj commit -m "Release $NEW_TAG"
  jj git export
  git tag "$NEW_TAG"
else
  git add "$CHANGELOG"
  git commit -m "Release $NEW_TAG"
  git tag "$NEW_TAG"
fi

# --- 2.8 Push to remote ---

if [[ "$VCS" == "jj" ]]; then
  jj git push --change @-
  git push --tags
else
  git push
  git push --tags
fi

# --- 2.9 Create GitHub Release ---

gh release create "$NEW_TAG" \
  --title "$NEW_TAG" \
  --notes "$RELEASE_BODY"

# --- 2.10 Print summary ---

echo ""
echo "Released $NEW_TAG"
echo "  Changelog: updated"
echo "  Tag: $NEW_TAG"
echo "  Push: done"
echo "  GitHub Release: $REPO_URL/releases/tag/$NEW_TAG"
