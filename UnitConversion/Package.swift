// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "UnitConversion",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "UnitConversion",
            targets: ["UnitConversion"]
        ),
    ],
    dependencies: [
        .package(path: "../VSLibrary"),
        .package(
          name: "SnapshotTesting",
          url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
          from: "1.8.1"
        ),
    ],
    targets: [
        .target(
            name: "UnitConversion",
            dependencies: [
                .product(name: "Functions", package: "VSLibrary")
            ]
        ),
        .testTarget(
            name: "UnitConversionTests",
            dependencies: ["UnitConversion", "SnapshotTesting"],
            exclude: ["__Snapshots__"]
        ),
    ]
)
