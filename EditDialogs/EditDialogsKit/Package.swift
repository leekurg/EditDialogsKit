// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EditDialogsKit",
    platforms: [.iOS(.v16), .macOS(.v10_15)],
    products: [
        .library(
            name: "EditDialogsKit",
            targets: ["EditDialogsKit"]
        ),
    ],
    targets: [
        .target(
            name: "EditDialogsKit"
        ),
        .testTarget(
            name: "EditDialogsKitTests",
            dependencies: ["EditDialogsKit"]
        ),
    ]
)
