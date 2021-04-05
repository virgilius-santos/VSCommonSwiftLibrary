// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSFoundationExtensions",
  products: [
    .library(
      name: "VSFoundationExtensions",
      targets: ["VSFoundationExtensions"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "VSFoundationExtensions",
      dependencies: []),
    .testTarget(
      name: "VSFoundationExtensionsTests",
      dependencies: ["VSFoundationExtensions"]),
  ]
)
