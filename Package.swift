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
            targets: ["GoogleCastTarget"]
        )
    ],
    targets: [
        .target(
            name: "GoogleCastTarget",
            dependencies: ["_GoogleCastBinaryTarget"],
            path: "Sources/GoogleCast"
        ),
        .binaryTarget(
            name: "_GoogleCastBinaryTarget",
            url: "https://github.com/dushantSW/googlecast-ios-sdk-xcframeworks/releases/download//4.8.3//_GoogleCast.xcframework.zip",
            checksum: ""
        )
    ]
)