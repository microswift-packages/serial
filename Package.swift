// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "serial",
    products: [
        .library(
            name: "serial",
            targets: ["serial"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microswift-packages/hal", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "serial",
            dependencies: [],
            path: ".",
            sources: ["serial.swift"]),
    ]
)
