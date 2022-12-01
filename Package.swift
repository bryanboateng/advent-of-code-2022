// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
		platforms: [
			.macOS(.v13)
		],
    products: [
        .executable(
            name: "AdventOfCode2022",
            targets: ["AdventOfCode2022"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode2022",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            resources: [
                .process("Inputs")
            ]),
    ]
)
