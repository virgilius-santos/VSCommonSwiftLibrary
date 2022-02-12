// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GuessTheFlag",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "GuessTheFlag",
            type: .dynamic,
            targets: ["GuessTheFlag"]
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
            name: "GuessTheFlag",
            dependencies: [
                .product(name: "Styles", package: "VSLibrary"),
                .product(name: "Functions", package: "VSLibrary")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "GuessTheFlagTests",
            dependencies: ["GuessTheFlag", "SnapshotTesting"],
            exclude: ["__Snapshots__"]
        ),
    ]
)
