// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2025",
    platforms: [
        .macOS(.v15)
    ],
    targets: [
        .executableTarget(
            name: "aoc2025",
            dependencies: ["day1", "day2", "day3", "day4", "day5", "day6"]
        ),

        .target(
            name: "day1",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "day2",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "day3",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "day4",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "day5",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "day6",
            dependencies: ["helpers"],
            exclude: ["input", "test_input"],
        ),
        .target(
            name: "helpers",
            dependencies: [],
        ),
    ],
    swiftLanguageModes: [.v5],
)
