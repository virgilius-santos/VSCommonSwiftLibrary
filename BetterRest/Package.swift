// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BetterRest",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "BetterRest",
            targets: ["BetterRest"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BetterRest",
            dependencies: [],
            exclude: ["SleepCalculator.mlmodel"],
            resources: [.copy("SleepCalculator.mlmodelc")]
        ),
        .testTarget(
            name: "BetterRestTests",
            dependencies: ["BetterRest"]
        ),
    ]
)
