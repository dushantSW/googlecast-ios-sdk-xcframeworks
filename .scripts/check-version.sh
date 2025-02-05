#!/bin/bash
set -e

# Fetch the download page
DOWNLOAD_PAGE=$(curl -s "https://developers.google.com/cast/docs/ios_sender")

# Extract latest version number
LATEST_VERSION=$(echo "$DOWNLOAD_PAGE" | grep -o "Cast iOS SDK [0-9.]*" | head -1 | grep -o "[0-9.]*")

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to find version number"
    exit 1
fi

# Check if we already have this version
if [ -f "latest_version.txt" ] && [ "$(cat latest_version.txt)" == "$LATEST_VERSION" ]; then
    echo "::set-output name=has_new_version::false"
    exit 0
fi

# New version found
echo "$LATEST_VERSION" > latest_version.txt
echo "::set-output name=has_new_version::true"
echo "::set-output name=version::$LATEST_VERSION"
