// swift-tools-version: 5.9
import PackageDescription

#if TUIST
  import ProjectDescription

  let packageSettings = PackageSettings(
    productTypes: [
      "RBSReuseQueue": .framework
    ]
  )
#endif

let package = Package(
  name: "RBSOdometer",
  defaultLocalization: "en",
  platforms: [

    .iOS(.v11)
  ],
  products: [
    .library(
      name: "RBSOdometer",
      targets: ["RBSOdometer"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/RbBtSn0w/RBSReuseQueue.git", from: "0.1.0")
  ],
  targets: [
    .target(
      name: "RBSOdometer",
      dependencies: ["RBSReuseQueue"],
      path: "RBSOdometer/Classes",
      publicHeadersPath: "."
    ),
    .testTarget(
      name: "RBSOdometerTests",
      dependencies: ["RBSOdometer"],
      path: "Example/Tests",
      exclude: ["Tests-Info.plist", "Tests-Prefix.pch"],
      sources: ["Tests.m"]
    ),
  ]
)
