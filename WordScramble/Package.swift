// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WordScramble",
    platforms: [.iOS("15.0"), .macOS("12.1")],
    products: [
        .library(
            name: "WordScramble",
            targets: ["WordScramble"]
        ),
    ],
    dependencies: [
        .package(path: "../VSLibrary"),
    ],
    targets: [
        .target(
            name: "WordScramble",
            dependencies: [
                .product(name: "FoundationExtensions", package: "VSLibrary"),
                .product(name: "Styles", package: "VSLibrary")
            ],
            resources: [.copy("start.txt")]
        ),
        .testTarget(
            name: "WordScrambleTests",
            dependencies: ["WordScramble"]
        ),
    ]
)
