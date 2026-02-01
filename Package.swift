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
    dependencies: [
        .package(url: "https://github.com/RbBtSn0w/RBSReuseQueue.git", from: "0.1.0")
    ]
)
