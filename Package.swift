// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GSheetsSwift",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
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
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
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
