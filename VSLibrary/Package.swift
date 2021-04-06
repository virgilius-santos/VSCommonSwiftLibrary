// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSLibrary",
  platforms: [.iOS(.v12), .macOS(.v10_14)],
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
  ],
  dependencies: [
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
  ]
)
