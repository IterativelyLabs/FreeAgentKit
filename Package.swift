// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FreeAgentKit",
    platforms: [.macOS(.v10_12),
                .iOS(.v11)],
    products: [
        .library(
            name: "FreeAgentKit",
            targets: ["FreeAgentKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
    ],
    targets: [
        .target(
            name: "FreeAgentKit",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "FreeAgentTests",
            dependencies: ["FreeAgentKit"]),
    ]
)
