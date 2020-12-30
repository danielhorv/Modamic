// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modamic",
    products: [
        .library(
            name: "Modamic",
            targets: ["Modamic"]
        )
    ],
    targets: [
        .target(
            name: "Modamic",
            dependencies: [],
            path: "Sources/Modamic"
        ),
        .testTarget(
            name: "ModamicTests",
            dependencies: ["Modamic"],
            path: "Tests"
        )
    ]
)
