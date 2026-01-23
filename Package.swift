// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MoinUI",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "MoinUI",
            targets: ["MoinUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Splash", from: "0.16.0")
    ],
    targets: [
        .target(
            name: "MoinUI",
            path: "Sources/MoinUI",
            resources: [
                .process("Localization/Locales")
            ]
        ),
        .executableTarget(
            name: "MoinUIDemo",
            dependencies: ["MoinUI", "Splash"],
            path: "Sources/Demo",
            resources: [
                .process("Resources"),
                .copy("Locales")
            ]
        ),
        .testTarget(
            name: "MoinTests",
            dependencies: [
                "MoinUI"
            ],
            path: "Tests/MoinTests"
        ),
    ]
)
