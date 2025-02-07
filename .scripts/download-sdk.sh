#!/bin/bash
set -e

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Assume the project root is one level above the script directory
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change to the project root so that all relative paths work as expected
cd "$PROJECT_ROOT"

# Read the version from latest_version.txt
VERSION=$(cat latest_version.txt)

# Construct the download URL using the version
DOWNLOAD_URL="https://dl.google.com/dl/chromecast/sdk/ios/GoogleCastSDK-ios-${VERSION}_dynamic.zip"

echo "Downloading SDK version ${VERSION} from ${DOWNLOAD_URL}..."

# Download the SDK zip file
curl -L "$DOWNLOAD_URL" -o sdk.zip

echo "Download complete. Unzipping the package..."

# Unzip the downloaded file quietly and remove the zip file afterward
unzip -q sdk.zip
rm sdk.zip

# Expected directory name based on the file structure
SDK_DIR="GoogleCastSDK-ios-${VERSION}_dynamic_xcframework"

# Verify the expected directory exists
if [ -d "$SDK_DIR" ]; then
    echo "Found directory: ${SDK_DIR}"
    cd "$SDK_DIR"
    
    # First, check if GoogleCast.xcframework exists and package it
    if [ -d "GoogleCast.xcframework" ]; then
        echo "Found GoogleCast.xcframework. Packaging it..."
        # Package the GoogleCast.xcframework into a zip file (with an underscore prefix) in the project root
        zip -r ../_GoogleCast.xcframework.zip GoogleCast.xcframework
    else
        echo "Error: GoogleCast.xcframework directory not found in ${SDK_DIR}."
        exit 1
    fi

    # Now, move header files and module maps to the proper folder
    DEST_DIR="../Sources/GoogleCast"
    mkdir -p "$DEST_DIR"

    echo "Moving header files and module maps..."
    find . -name "*.h" -exec mv {} "$DEST_DIR/" \;
    find . -name "*.modulemap" -exec mv {} "$DEST_DIR/" \;
    
    # Return to the project root
    cd "$PROJECT_ROOT"
else
    echo "Error: ${SDK_DIR} directory not found."
    exit 1
fi

# Cleanup the unzipped SDK directory
rm -rf "$SDK_DIR"

echo "Packaging complete. The file '_GoogleCast.xcframework.zip' is ready."