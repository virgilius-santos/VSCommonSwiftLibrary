// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSUIKitExtensions",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "VSUIKitExtensions",
      targets: ["VSUIKitExtensions"]),
  ],
  dependencies: [
    .package(path: "./VSFunctionsFeature"),
    .package(path: "./VSFoundationExtensions"),
  ],
  targets: [
    .target(
      name: "VSUIKitExtensions",
      dependencies: [
        "VSFunctionsFeature",
        "VSFoundationExtensions"
      ]
    ),
    .testTarget(
      name: "VSUIKitExtensionsTests",
      dependencies: ["VSUIKitExtensions"]
    ),
  ]
)
