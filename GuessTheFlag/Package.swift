// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GuessTheFlag",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "GuessTheFlag",
            type: .dynamic,
            targets: ["GuessTheFlag"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GuessTheFlag",
            dependencies: [],
            resources: [.copy("Assets")]
        ),
        .testTarget(
            name: "GuessTheFlagTests",
            dependencies: ["GuessTheFlag"]
        ),
    ]
)
