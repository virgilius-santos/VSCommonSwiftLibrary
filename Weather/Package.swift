// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Weather",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Weather",
            targets: ["Weather"]
        ),
    ],
    dependencies: [
        .package(path: "../VSLibrary")
    ],
    targets: [
        .target(
            name: "Weather",
            dependencies: [
                .product(name: "Functions", package: "VSLibrary"),
                .product(name: "Styles", package: "VSLibrary")
            ]
        ),
        .testTarget(
            name: "WeatherTests",
            dependencies: ["Weather"]
        ),
    ]
)
