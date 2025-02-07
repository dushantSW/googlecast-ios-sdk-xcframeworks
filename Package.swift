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
            checksum: "8b87dd28d221f049b756ffd4d7d4471f81070742a678620f7a12e869ba291d6f"
        )
    ]
)