// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iExpense",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "iExpense",
            targets: ["iExpense"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "iExpense",
            dependencies: []
        ),
        .testTarget(
            name: "iExpenseTests",
            dependencies: ["iExpense"]
        ),
    ]
)
