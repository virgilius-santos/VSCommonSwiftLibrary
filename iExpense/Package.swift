// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iExpense",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(
            name: "iExpense",
            targets: ["iExpense"]
        ),
    ],
    dependencies: [
        .package(
            name: "SnapshotTesting",
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            .upToNextMajor(from: "1.8.1")
        ),
        .package(
            name: "swift-composable-architecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            .upToNextMajor(from: "0.19.0")
        ),
        .package(path: "../VSLibrary")
    ],
    targets: [
        .target(
            name: "iExpense",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "Styles", package: "VSLibrary"),
                .product(name: "LocalStorage", package: "VSLibrary")
            ]
        ),
        .testTarget(
            name: "iExpenseTests",
            dependencies: [
                "iExpense",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                "SnapshotTesting"
            ]
        ),
    ]
)
