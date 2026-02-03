#!/bin/bash
set -e

NEW_VERSION="$1"

if [ -z "$NEW_VERSION" ]; then
  echo "Error: No version supplied."
  exit 1
fi

echo "Bumping version to $NEW_VERSION in Project.swift"

perl -pi -e "s/\"MARKETING_VERSION\": \".*\"/\"MARKETING_VERSION\": \"$NEW_VERSION\"/" Project.swift

echo "Updated Project.swift"
