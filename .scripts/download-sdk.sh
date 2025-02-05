#!/bin/bash
set -e

VERSION=$(cat latest_version.txt)
DOWNLOAD_URL="https://dl.google.com/dl/chromecast/sdk/ios/GoogleCastSDK-ios-${VERSION}_dynamic.zip"

# Download SDK
curl -L "$DOWNLOAD_URL" -o sdk.zip

# Unzip and prepare XCFramework
unzip -q sdk.zip
rm sdk.zip

# Package XCFramework
zip -r GoogleCast.xcframework.zip GoogleCast.xcframework

# Cleanup
rm -rf GoogleCast.xcframework
