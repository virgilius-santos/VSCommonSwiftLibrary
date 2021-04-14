// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Animations",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Animations",
            targets: ["Animations"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Animations",
            dependencies: []
        ),
        .testTarget(
            name: "AnimationsTests",
            dependencies: ["Animations"]
        ),
    ]
)
