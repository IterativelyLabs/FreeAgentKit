// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FreeAgent",
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
            dependencies: []),
        .testTarget(
            name: "FreeAgentTests",
            dependencies: ["FreeAgent"]),
    ]
)
