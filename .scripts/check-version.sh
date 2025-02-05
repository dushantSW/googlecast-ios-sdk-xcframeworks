#!/bin/bash
set -e

# Fetch the latest version from CocoaPods Specs
SPECS_URL="https://api.github.com/repos/CocoaPods/Specs/contents/Specs/8/1/2/google-cast-sdk"
VERSIONS_JSON=$(curl -s "$SPECS_URL")

# Extract and sort version numbers, then get the latest
LATEST_VERSION=$(echo "$VERSIONS_JSON" | grep '"name":' | grep -o '"[0-9][0-9.]*"' | tr -d '"' | sort -V | tail -n 1)

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to find version number"
    exit 1
fi

# Check if we already have this version
if [ -f "latest_version.txt" ] && [ "$(cat latest_version.txt)" == "$LATEST_VERSION" ]; then
    echo "has_new_version=false" >> $GITHUB_OUTPUT
    exit 0
fi

# New version found
echo "$LATEST_VERSION" > latest_version.txt
echo "has_new_version=true" >> $GITHUB_OUTPUT
echo "version=$LATEST_VERSION" >> $GITHUB_OUTPUT
