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
    targets: [
        .target(
            name: "ConsoleIO",
            dependencies: []),
        .testTarget(
            name: "ConsoleIOTests",
            dependencies: ["ConsoleIO"]),
    ]
)
