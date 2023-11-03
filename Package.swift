// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalRepositories",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ], 
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocalRepositories",
            targets: ["LocalRepositories"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
        .package(url: "https://github.com/Matejkob/swift-spyable.git", .upToNextMajor(from: "0.1.3")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocalRepositories",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Spyable", package: "swift-spyable"),
            ]),
        .testTarget(
            name: "LocalRepositoriesTests",
            dependencies: [
                "LocalRepositories",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]),
    ]
)
