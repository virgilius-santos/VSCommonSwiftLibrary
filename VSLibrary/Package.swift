// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSLibrary",
  platforms: [.iOS(.v14), .macOS(.v11)],
  products: [
    .library(
      name: "UIKitExtensions",
      targets: ["UIKitExtensions"]
    ),
    .library(
      name: "FoundationExtensions",
      targets: ["FoundationExtensions"]
    ),
    .library(
      name: "Functions",
      targets: ["Functions"]
    ),
    .library(
      name: "LocalStorage",
      targets: ["LocalStorage"]
    ),
    .library(
      name: "Cache",
      targets: ["Cache"]
    ),
    .library(
      name: "Service",
      targets: ["Service"]
    ),
    .library(
      name: "BoxFeature",
      targets: ["BoxFeature"]
    ),
    .library(
      name: "Styles",
      targets: ["Styles"]
    ),
  ],
  dependencies: [
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.8.1"
    ),
    .package(
      name: "OHHTTPStubs",
      url: "https://github.com/AliSoftware/OHHTTPStubs",
      from: "9.1.0"
    ),
    .package(
      url: "https://github.com/Quick/Quick.git",
      .upToNextMajor(from: "3.0.0")
    ),
    .package(
      url: "https://github.com/Quick/Nimble.git",
      .upToNextMajor(from: "9.0.0")
    ),
  ],
  targets: [
    .target(
      name: "UIKitExtensions",
      dependencies: ["Functions", "FoundationExtensions"]
    ),
    .testTarget(
      name: "UIKitExtensionsTests",
      dependencies: ["UIKitExtensions"]
    ),
    .target(
      name: "FoundationExtensions",
      dependencies: ["Functions"]
    ),
    .testTarget(
      name: "FoundationExtensionsTests",
      dependencies: ["FoundationExtensions"]
    ),
    .target(
      name: "Functions",
      dependencies: []
    ),
    .testTarget(
      name: "FunctionsTests",
      dependencies: ["Functions"]
    ),
    .target(
      name: "LocalStorage",
      dependencies: ["FoundationExtensions"]
    ),
    .testTarget(
      name: "LocalStorageTests",
      dependencies: ["LocalStorage"]
    ),
    .target(
      name: "Cache",
      dependencies: ["FoundationExtensions"]
    ),
    .testTarget(
      name: "CacheTests",
      dependencies: ["Cache"]
    ),
    .target(
      name: "Service",
      dependencies: ["FoundationExtensions"]
    ),
    .testTarget(
      name: "ServiceTests",
      dependencies: [
        "Service",
        "SnapshotTesting", "Quick", "Nimble",
        .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs"),
        .product(name: "OHHTTPStubs", package: "OHHTTPStubs")
      ],
      exclude: ["__Snapshots__"]
    ),
    .target(
      name: "BoxFeature",
      dependencies: []
    ),
    .testTarget(
      name: "BoxFeatureTests",
      dependencies: ["BoxFeature"]
    ),
    .target(
      name: "Styles",
      dependencies: []
    ),
  ]
)
