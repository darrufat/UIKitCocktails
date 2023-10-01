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
        .library(
            name: "RecipeDetail",
            targets: ["RecipeDetail"]),

        // MARK: - Domain Layer
        .library(
            name: "Domain",
            targets: ["Domain"]),

        // MARK: - Data Layer
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", 
                 from: "1.13.0"),
        .package(url:  "https://github.com/Quick/Nimble.git", from: "12.0.0"),
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
            dependencies: ["RecipesSearcher", "Nimble"],
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
            name: "RecipeDetail",
            dependencies: ["Domain"],
            path: "Sources/Application/RecipeDetail"
        ),
        .testTarget(
            name: "RecipeDetailTests",
            dependencies: ["RecipeDetail", "Nimble"],
            path: "Tests/Unit/RecipeDetailTests"
        ),
        .testTarget(
            name: "RecipeDetailSnapshotTests",
            dependencies: ["RecipeDetail",
                           .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "Tests/Snapshot/RecipeDetailSnapshotTests",
            exclude: ["__Snapshots__"]
        ),
        .target(
            name: "Domain",
            dependencies: ["Assembly"],
            path: "Sources/Application/Domain"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "Nimble"],
            path: "Tests/Unit/DomainTests"
        ),
        .target(
            name: "Data",
            dependencies: ["Assembly", "Nimble"],
            path: "Sources/Application/Data"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Nimble"],
            path: "Tests/Unit/DataTests"
        ),

        // MARK: - Core
        .target(
            name: "Assembly",
            path: "Sources/Core/Assembly"
        ),
        .testTarget(
            name: "AssemblyTests",
            dependencies: ["Assembly", "Nimble"],
            path: "Tests/Unit/AssemblyTests"
        ),
    ]
)
