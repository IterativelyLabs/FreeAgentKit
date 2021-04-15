// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FreeAgent",
    platforms: [.macOS(.v10_12),
                .iOS(.v11)],
    products: [
        .library(
            name: "FreeAgent",
            targets: ["FreeAgent"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
    ],
    targets: [
        .target(
            name: "FreeAgent",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "FreeAgentTests",
            dependencies: ["FreeAgent"]),
    ]
)
