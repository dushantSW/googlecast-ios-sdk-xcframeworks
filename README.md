# GoogleCast iOS SDK XCFramework Distribution

A Swift Package Manager distribution of Google's Cast iOS SDK, providing XCFramework binary integration.

This repository automatically tracks and packages new releases of the [Google Cast iOS SDK](https://developers.google.com/cast/docs/ios_sender), making them available through Swift Package Manager.

## Features

- ✅ Automated SDK updates every 12 hours
- ✅ XCFramework distribution for Apple Silicon support
- ✅ Swift Package Manager integration
- ✅ iOS 14.0+ support
- ✅ Version-locked dependencies

## Installation

Add the following to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/dushantSW/googlecast-ios-sdk-xcframeworks.git", .exact("4.8.3"))
]
```

Then add `GoogleCast` to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "GoogleCast", package: "googlecast-ios-sdk-xcframeworks")
        ]
    )
]
```

## Additional Setup

1. Add the following to your `Info.plist`:

```xml
<key>NSBonjourServices</key>
<array>
    <string>_googlecast._tcp</string>
    <string>_YOUR-APP-ID._googlecast._tcp</string>
</array>

<key>NSLocalNetworkUsageDescription</key>
<string>${PRODUCT_NAME} uses the local network to discover Cast-enabled devices on your WiFi network.</string>
```

2. Add `-ObjC` to your target's "Other Linker Flags" in Build Settings

## Version Updates

The workflow checks for new SDK versions every 12 hours. When a new version is detected:
1. Downloads and packages the SDK as XCFramework
2. Creates a new GitHub release
3. Updates Package.swift with the new version

## License

This repository is available under the MIT license. See the LICENSE file for more info.
The Google Cast iOS SDK is covered by its own license terms - see [Google Cast iOS SDK Terms of Service](https://developers.google.com/cast/docs/terms).
