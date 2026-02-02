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
    .iOS(.v12)
  ],
  products: [
    .library(
      name: "RBSOdometer",
      targets: ["RBSOdometer"]
    )
  ],
  targets: [
    .target(
        name: "RBSReuseQueue",
        path: "Vendor/RBSReuseQueue",
        publicHeadersPath: "include"
    ),
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