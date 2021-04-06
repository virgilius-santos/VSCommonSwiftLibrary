// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSFoundationExtensions",
  platforms: [.iOS(.v12), .macOS(.v10_12)],
  products: [
    .library(
      name: "VSFoundationExtensions",
      targets: ["VSFoundationExtensions"]
    ),
  ],
  dependencies: [
    .package(path: "./VSFunctionsFeature"),
  ],
  targets: [
    .target(
      name: "VSFoundationExtensions",
      dependencies: ["VSFunctionsFeature"]
    ),
    .testTarget(
      name: "VSFoundationExtensionsTests",
      dependencies: ["VSFoundationExtensions"]
    ),
  ]
)
