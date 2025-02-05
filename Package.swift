// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "GoogleCast",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "GoogleCast",
            targets: ["GoogleCast"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "GoogleCast",
            url: "https://github.com/dushantSW/googlecast-ios-sdk-xcframeworks/releases/download/VERSION/GoogleCast.xcframework.zip",
            checksum: "CHECKSUM"
        )
    ]
)
