import ProjectDescription

let project = Project(
    name: "RBSOdometer",
    organizationName: "RbBtSn0w",
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
        .target(
            name: "RBSOdometer",
            destinations: [.iPhone, .iPad],
            product: .framework,
            bundleId: "com.rbbtsnow.RBSOdometer",
            deploymentTargets: .iOS("11.0"),
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
        .target(
            name: "RBSOdometerExample",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "com.rbbtsnow.RBSOdometer.Example",
            deploymentTargets: .iOS("11.0"),
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
            sources: ["Example/RBSOdometer/**/*.{h,m}"],
            resources: [
                "Example/RBSOdometer/Base.lproj/**",
                "Example/RBSOdometer/en.lproj/**",
                "Example/RBSOdometer/Images.xcassets"
            ],
            dependencies: [
                .target(name: "RBSOdometer")
            ]
        ),
        .target(
            name: "RBSOdometerTests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "com.rbbtsnow.RBSOdometer.Tests",
            deploymentTargets: .iOS("11.0"),
            infoPlist: .default,
            sources: ["Example/Tests/**/*.{h,m}"],
            dependencies: [
                .target(name: "RBSOdometer")
            ]
        )
    ]
)
