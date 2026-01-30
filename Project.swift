import ProjectDescription

let project = Project(
    name: "RBSOdometer",
    organizationName: "RbBtSn0w",
    options: .options(
        automaticSchemesOptions: .enabled(
            targetSchemesGrouping: .byNameSuffix,
            codeCoverageEnabled: true,
            testingOptions: [.parallelizable, .randomExecutionOrdering]
        ),
        disableBundleAccessors: false,
        disableSynthesizedResourceAccessors: true
    ),
    packages: [],
    settings: .settings(
        base: [
            "MARKETING_VERSION": "0.2.0",
            "CURRENT_PROJECT_VERSION": "1",
            "IPHONEOS_DEPLOYMENT_TARGET": "11.0"
        ],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        Target(
            name: "RBSOdometer",
            platform: .iOS,
            product: .framework,
            bundleId: "com.rbbtsnow.RBSOdometer",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["RBSOdometer/Classes/**"],
            resources: [],
            dependencies: [
                .external(name: "RBSReuseQueue")
            ],
            settings: .settings(
                base: [
                    "ENABLE_TESTABILITY": "YES",
                    "DEFINES_MODULE": "YES"
                ]
            )
        ),
        Target(
            name: "RBSOdometerExample",
            platform: .iOS,
            product: .app,
            bundleId: "com.rbbtsnow.RBSOdometer.Example",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone, .ipad]),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UIMainStoryboardFile": "Main",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                        "UIInterfaceOrientationLandscapeLeft",
                        "UIInterfaceOrientationLandscapeRight"
                    ],
                    "UISupportedInterfaceOrientations~ipad": [
                        "UIInterfaceOrientationPortrait",
                        "UIInterfaceOrientationPortraitUpsideDown",
                        "UIInterfaceOrientationLandscapeLeft",
                        "UIInterfaceOrientationLandscapeRight"
                    ]
                ]
            ),
            sources: ["Example/RBSOdometer/**"],
            resources: ["Example/RBSOdometer/**/*.{storyboard,xib,xcassets}"],
            dependencies: [
                .target(name: "RBSOdometer")
            ]
        ),
        Target(
            name: "RBSOdometerTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.rbbtsnow.RBSOdometer.Tests",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["Example/Tests/**"],
            dependencies: [
                .target(name: "RBSOdometer")
            ]
        )
    ]
)
