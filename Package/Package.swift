// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        // MARK: - App Features
        .library(
            name: "RecipesSearcher",
            targets: ["RecipesSearcher"]),

        // MARK: - Domain Layer
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", 
                 from: "1.13.0")
    ],
    targets: [
        // MARK: - Application
        .target(
            name: "RecipesSearcher",
            dependencies: ["Domain"],
            path: "Sources/Application/RecipesSearcher"
        ),
        .testTarget(
            name: "RecipesSearcherTests",
            dependencies: ["RecipesSearcher"], // ADD NIMBLE
            path: "Tests/Unit/RecipesSearcherTests"
        ),
        .testTarget(
            name: "RecipesSearcherSnapshotTests",
            dependencies: [
                "RecipesSearcher",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "Tests/Snapshot/RecipesSearcherSnapshotTests",
            exclude: ["__Snapshots__"]
        ),
        .target(
            name: "Domain",
            dependencies: ["Assembly"],
            path: "Sources/Application/Domain"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"], // ADD NIMBLE
            path: "Tests/Unit/DomainTests"
        ),

        // MARK: - Core
        .target(
            name: "Assembly",
            path: "Sources/Core/Assembly"
        ),
        .testTarget(
            name: "AssemblyTests",
            dependencies: ["Assembly"], // ADD NIMBLE
            path: "Tests/Unit/AssemblyTests"
        ),
    ]
)
