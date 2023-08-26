// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GSheetsSwift",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GSheetsSwift",
            targets: ["GSheetsSwift"]),
        .library(
            name: "GSheetsSwiftAPI",
            targets: ["GSheetsSwiftAPI", "GSheetsSwiftTypes"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GSheetsSwiftTypes"),
        .target(
            name: "GSheetsSwiftAPI",
            dependencies: ["GSheetsSwiftTypes"]),
        .target(
            name: "GSheetsSwift",
            dependencies: ["GSheetsSwiftAPI", "GSheetsSwiftTypes"]),
        .testTarget(
            name: "GSheetsSwiftTests",
            dependencies: ["GSheetsSwift"]),
    ]
)
