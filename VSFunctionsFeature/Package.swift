// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "VSFunctionsFeature",
  products: [
    .library(
      name: "VSFunctionsFeature",
      targets: ["VSFunctionsFeature"]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "VSFunctionsFeature",
      dependencies: []),
    .testTarget(
      name: "VSFunctionsFeatureTests",
      dependencies: ["VSFunctionsFeature"]),
  ]
)
