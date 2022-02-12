// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Animations",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "Animations",
            targets: ["Animations"]
        ),
    ],
    dependencies: [
        .package(path: "../VSLibrary"),
    ],
    targets: [
        .target(
            name: "Animations",
            dependencies: [.product(name: "Styles", package: "VSLibrary"),]
        ),
        .testTarget(
            name: "AnimationsTests",
            dependencies: ["Animations"]
        ),
    ]
)
