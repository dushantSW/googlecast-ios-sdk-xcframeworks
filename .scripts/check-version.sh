#!/bin/bash
set -e

# Define the API URL (consider removing the 'ref' parameter if it's problematic)
SPECS_URL="https://api.github.com/repos/CocoaPods/Specs/contents/Specs/8/1/2/google-cast-sdk?ref=b9d7978571f5a5333954cd5ea820fa7bad13ba27"

# Fetch the JSON response
VERSIONS_JSON=$(curl -s -H "Accept: application/vnd.github.v3+json" "$SPECS_URL")

# Debug: print the JSON response to help troubleshoot
echo "DEBUG: JSON response:"
echo "$VERSIONS_JSON"

# Extract version names using jq (more reliable than grep)
LATEST_VERSION=$(echo "$VERSIONS_JSON" | jq -r '.[].name' | sort -V | tail -n 1)

if [ -z "$LATEST_VERSION" ]; then
    echo "Failed to find version number"
    exit 1
fi

# Check if we already have this version
if [ -f "latest_version.txt" ] && [ "$(cat latest_version.txt)" == "$LATEST_VERSION" ]; then
    echo "has_new_version=false" >> "${GITHUB_OUTPUT:-/dev/stdout}"
    exit 0
fi

# New version found, update the version file and GitHub output
echo "$LATEST_VERSION" > latest_version.txt
echo "has_new_version=true" >> "${GITHUB_OUTPUT:-/dev/stdout}"
echo "version=$LATEST_VERSION" >> "${GITHUB_OUTPUT:-/dev/stdout}"