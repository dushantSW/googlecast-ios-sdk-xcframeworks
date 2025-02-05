#!/bin/bash
set -e

# Read the version from latest_version.txt
VERSION=$(cat latest_version.txt)

# Construct the download URL using the version
DOWNLOAD_URL="https://dl.google.com/dl/chromecast/sdk/ios/GoogleCastSDK-ios-${VERSION}_dynamic.zip"

echo "Downloading SDK version ${VERSION} from ${DOWNLOAD_URL}..."

# Download the SDK zip file
curl -L "$DOWNLOAD_URL" -o sdk.zip

echo "Download complete. Unzipping the package..."

# Unzip the downloaded file quietly and remove the zip file afterwards
unzip -q sdk.zip
rm sdk.zip

# Expected directory name based on the file structure
SDK_DIR="GoogleCastSDK-ios-${VERSION}_dynamic_xcframework"

# Verify the expected directory exists
if [ -d "$SDK_DIR" ]; then
    echo "Found directory: ${SDK_DIR}"
    cd "$SDK_DIR"
    
    # Check if the GoogleCast.xcframework folder exists
    if [ -d "GoogleCast.xcframework" ]; then
        echo "Found GoogleCast.xcframework. Packaging it..."
        # Package the GoogleCast.xcframework into a zip file in the parent directory
        zip -r ../GoogleCast.xcframework.zip GoogleCast.xcframework
    else
        echo "Error: GoogleCast.xcframework directory not found in ${SDK_DIR}."
        exit 1
    fi
    
    # Return to the parent directory
    cd ..
else
    echo "Error: ${SDK_DIR} directory not found."
    exit 1
fi

# Cleanup the unzipped SDK directory
rm -rf "$SDK_DIR"

echo "Packaging complete. The file 'GoogleCast.xcframework.zip' is ready."