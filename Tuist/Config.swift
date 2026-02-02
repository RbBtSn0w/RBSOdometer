import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .all,
    swiftVersion: nil,
    generationOptions: .options(
        resolveDependenciesWithSystemScm: false,
        disablePackageVersionLocking: false
    )
)
