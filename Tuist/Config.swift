import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["15.0"],
    swiftVersion: nil,
    generationOptions: .options(
        resolveDependenciesWithSystemScm: false,
        disablePackageVersionLocking: false
    )
)
