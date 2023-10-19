// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Application", targets: [ "Application" ])
    ],
    dependencies: [
        .package(
            url: "https://github.com/KindKit/KindKit.git",
            from: "0.6.0"
        )
    ],
    targets: [
        .target(
            name: "Application",
            dependencies: [
                .product(name: "KindKit", package: "KindKit"),
            ],
            path: "Source"
        )
    ]
)
