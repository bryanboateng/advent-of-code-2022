// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    products: [
        .library(
            name: "AdventOfCode2022",
            targets: ["AdventOfCode2022"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AdventOfCode2022",
            dependencies: []),
    ]
)
