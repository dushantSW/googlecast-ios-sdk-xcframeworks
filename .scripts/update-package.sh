#!/bin/bash
set -e

# Determine the project root (assumes this script is in .scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# Read the new SDK version from latest_version.txt
VERSION=$(cat latest_version.txt)
echo "Updating Package.swift for SDK version: $VERSION"

# Compute the checksum for the packaged xcframework zip
echo "Computing checksum for _GoogleCast.xcframework.zip..."
CHECKSUM=$(swift package compute-checksum _GoogleCast.xcframework.zip)
echo "Checksum computed: $CHECKSUM"

# Generate Package.swift from the template
cp Package.swift.template Package.swift

# Update the new Package.swift with the new version and checksum
echo "Updating Package.swift with the new version and checksum..."
sed -i '' "s|/VERSION/|/$VERSION/|g" Package.swift
sed -i '' "s|CHECKSUM|$CHECKSUM|g" Package.swift

echo "Package.swift has been updated successfully."