import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(
                url: "https://github.com/RbBtSn0w/RBSReuseQueue.git",
                requirement: .upToNextMinor(from: "0.1.0")
            )
        ],
        productTypes: [
            "RBSReuseQueue": .framework
        ]
    ),
    platforms: [.iOS]
)
