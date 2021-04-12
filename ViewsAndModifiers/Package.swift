// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ViewsAndModifiers",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ViewsAndModifiers",
            targets: ["ViewsAndModifiers"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ViewsAndModifiers",
            dependencies: []
        ),
        .testTarget(
            name: "ViewsAndModifiersTests",
            dependencies: ["ViewsAndModifiers"]
        ),
    ]
)
