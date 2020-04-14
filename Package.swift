// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConsoleIO",
    products: [
        .library(
            name: "ConsoleIO",
            targets: ["ConsoleIO"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wendyliga/SwiftKit.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "ConsoleIO",
            dependencies: ["SwiftKit"]),
        .testTarget(
            name: "ConsoleIOTests",
            dependencies: ["ConsoleIO"]),
    ]
)
