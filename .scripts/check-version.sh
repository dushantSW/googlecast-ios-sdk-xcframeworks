#!/bin/bash
set -e

# Define the API URL
SPECS_URL="https://api.github.com/repos/CocoaPods/Specs/contents/Specs/8/1/2/google-cast-sdk?ref=b9d7978571f5a5333954cd5ea820fa7bad13ba27"

# Use GITHUB_TOKEN if provided to avoid rate limits
if [ -n "$GITHUB_TOKEN" ]; then
    VERSIONS_JSON=$(curl -s -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" "$SPECS_URL")
else
    echo "Warning: GITHUB_TOKEN not set. You might hit API rate limits."
    VERSIONS_JSON=$(curl -s -H "Accept: application/vnd.github.v3+json" "$SPECS_URL")
fi

# Process JSON to extract the version number...
LATEST_VERSION=$(echo "$VERSIONS_JSON" | grep '"name":' | cut -d'"' -f4 | sort -V | tail -n 1)

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to find version number"
    exit 1
fi

# Continue with the rest of your script...
if [ -f "latest_version.txt" ] && [ "$(cat latest_version.txt)" == "$LATEST_VERSION" ]; then
    echo "has_new_version=false" >> "${GITHUB_OUTPUT:-/dev/stdout}"
    exit 0
fi

echo "$LATEST_VERSION" > latest_version.txt
echo "has_new_version=true" >> "${GITHUB_OUTPUT:-/dev/stdout}"
echo "version=$LATEST_VERSION" >> "${GITHUB_OUTPUT:-/dev/stdout}"