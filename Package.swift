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
            dependencies: [.target(name: "_GoogleCastBinaryTarget")],
            path: "Sources/GoogleCast",
            publicHeadersPath: ".",
            cSettings: [.headerSearchPath(".")]
        ),
        .binaryTarget(
            name: "_GoogleCastBinaryTarget",
            url: "https://github.com/dushantSW/googlecast-ios-sdk-xcframeworks/releases/download/4.8.3/_GoogleCast.xcframework.zip",
            checksum: "562d22e99d56b3faf98b8bf8514a66606d896bb4a4f52507da3c869c436a5871"
        )
    ]
)
