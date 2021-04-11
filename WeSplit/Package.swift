// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "WeSplit",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "WeSplit",
            targets: ["WeSplit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WeSplit",
            dependencies: []
        ),
        .testTarget(
            name: "WeSplitTests",
            dependencies: ["WeSplit"]
        ),
    ]
)
