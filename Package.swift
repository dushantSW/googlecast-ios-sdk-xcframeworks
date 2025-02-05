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
            url: "https://github.com/dushantSW/googlecast-ios-sdk-xcframeworks/releases/download/4.8.3/GoogleCast.xcframework.zip",
            checksum: "be52337c798b014214e53c4e536c6f8b8b41316492dc44edb6ddf168e7bc9a62"
        )
    ]
)
