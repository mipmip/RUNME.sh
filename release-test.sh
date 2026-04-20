#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/mipmip/RUNME.sh"
BUMP_TYPE="minor"

CURRENT_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
CURRENT_VERSION="${CURRENT_TAG#v}"
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"
MAJOR="${MAJOR:-0}"; MINOR="${MINOR:-0}"; PATCH="${PATCH:-0}"

case "$BUMP_TYPE" in
  minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
NEW_TAG="v$NEW_VERSION"
TODAY=$(date +%Y-%m-%d)

echo "=== Version bump: $CURRENT_TAG → $NEW_TAG ==="

CHANGELOG="CHANGELOG.md"

UNRELEASED_CONTENT=$(sed -n '/^## \[Unreleased\]/,/^## \[/{/^## \[/!p}' "$CHANGELOG" | grep -v '^$' | grep -v '^###' || true)
if [[ -z "$UNRELEASED_CONTENT" ]]; then
  echo "Error: no unreleased changes"; exit 1
fi

RELEASE_BODY=$(sed -n '/^## \[Unreleased\]/,/^## \[/{/^## \[/!p}' "$CHANGELOG")

sed -i "s/^## \[Unreleased\]/## [$NEW_VERSION] - $TODAY/" "$CHANGELOG"
sed -i "/^## \[$NEW_VERSION\]/i\\
## [Unreleased]\\
" "$CHANGELOG"

sed -i "s|\[Unreleased\]: .*|[Unreleased]: $REPO_URL/compare/$NEW_TAG...HEAD|" "$CHANGELOG"
PREV_TAG="$CURRENT_TAG"
sed -i "/^\[Unreleased\]: /a\\
[$NEW_VERSION]: $REPO_URL/compare/$PREV_TAG...$NEW_TAG" "$CHANGELOG"

echo "=== Updated CHANGELOG.md ==="
cat "$CHANGELOG"
echo ""
echo "=== Release body for gh ==="
echo "$RELEASE_BODY"
