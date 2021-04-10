// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "PalindromeFeature",
  platforms: [.iOS(.v12)],
  products: [
    .library(
      name: "PalindromeFeature",
      targets: ["PalindromeFeature"]
    ),
    .library(
      name: "PalindromeFeatureLive",
      targets: ["PalindromeFeatureLive"]
    ),
  ],
  dependencies: [
    .package(path: "../VSLibrary/VSLibrary"),
    .package(path: "./ResourcesFeature"),
    .package(path: "./WordDataSource"),
  ],
  targets: [
    .target(
      name: "PalindromeFeature",
      dependencies: [
        .product(name: "UIKitExtensions", package: "VSLibrary"),
        .product(name: "FoundationExtensions", package: "VSLibrary"),
        .product(name: "Functions", package: "VSLibrary"),
        .product(name: "BoxFeature", package: "VSLibrary"),
        "ResourcesFeature",
        "WordDataSource",
      ]
    ),
    .target(
      name: "PalindromeFeatureLive",
      dependencies: ["PalindromeFeature"]
    ),
    .testTarget(
      name: "PalindromeFeatureTests",
      dependencies: ["PalindromeFeatureLive"]
    ),
  ]
)
