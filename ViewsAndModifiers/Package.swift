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
    dependencies: [
        .package(path: "../VSLibrary"),
    ],
    targets: [
        .target(
            name: "ViewsAndModifiers",
            dependencies: [
                .product(name: "Styles", package: "VSLibrary"),
            ]
        ),
        .testTarget(
            name: "ViewsAndModifiersTests",
            dependencies: ["ViewsAndModifiers"]
        ),
    ]
)
