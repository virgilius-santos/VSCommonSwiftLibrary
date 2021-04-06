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
    .package(path: "./VSFunctionsFeature")
  ],
  targets: [
    .target(
      name: "VSUIKitExtensions",
      dependencies: ["VSFunctionsFeature"]
    ),
    .testTarget(
      name: "VSUIKitExtensionsTests",
      dependencies: ["VSUIKitExtensions"]
    ),
  ]
)
