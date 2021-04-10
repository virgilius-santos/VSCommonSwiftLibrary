// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "ResourcesFeature",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "ResourcesFeature",
      targets: ["ResourcesFeature"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "ResourcesFeature",
      dependencies: [],
      resources: [.process("Assets")]
    ),
    .testTarget(
      name: "ResourcesFeatureTests",
      dependencies: ["ResourcesFeature"]
    ),
  ]
)
