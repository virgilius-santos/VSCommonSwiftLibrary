// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MQTTLibrary",
  platforms: [.iOS("15.0"), .macOS("12.1")],
  products: [
    .library(
      name: "MQTTLibrary",
      targets: ["MQTTLibrary"]
    ),
    .library(
      name: "MQTTLibraryLive",
      targets: ["MQTTLibraryLive"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/emqx/CocoaMQTT", .branch("master")),
    .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.1.0")),
  ],
  targets: [
    .target(
      name: "MQTTLibrary",
      dependencies: [.product(name: "RxSwift", package: "RxSwift")]
    ),
    .testTarget(
      name: "MQTTLibraryTests",
      dependencies: ["MQTTLibrary"]
    ),
    .target(
      name: "MQTTLibraryLive",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "CocoaMQTT", package: "CocoaMQTT"),
        
      ]
    ),
    .testTarget(
      name: "MQTTLibraryLiveTests",
      dependencies: ["MQTTLibraryLive"]
    ),
  ]
)
