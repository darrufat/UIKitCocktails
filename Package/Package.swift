// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [
        .iOS("16.0")
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

        // MARK: - Core
        .library(
            name: "Common",
            targets: ["Common"]
        ),
        
        // MARK: - Libraries
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]
        ),
        .library(
            name: "DBClient",
            targets: ["DBClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.3.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.9.1"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.43.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.13.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
    ],
    targets: [
        // MARK: - Application
        .target(
            name: "RecipesSearcher",
            dependencies: ["Common", "Kingfisher", "SnapKit", "Domain"],
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
            dependencies: ["Kingfisher", "Domain"],
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
            dependencies: ["Factory"],
            path: "Sources/Application/Domain"
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "Nimble"],
            path: "Tests/Unit/DomainTests"
        ),
        .target(
            name: "Data",
            dependencies: ["Common", "Domain", "Factory", "HTTPClient", "DBClient"],
            path: "Sources/Application/Data"
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Nimble"],
            path: "Tests/Unit/DataTests"
        ),

        // MARK: - Core
        .target(
            name: "Common",
            path: "Sources/Core/Common"
        ),

        // MARK: - Libraries
        .target(
            name: "HTTPClient",
            dependencies: ["Factory"],
            path: "Sources/HTTPClient"
        ),
        .testTarget(
            name: "HTTPClientTests",
            dependencies: ["HTTPClient"],
            path: "Tests/Unit/HTTPClientTests"
        ),
        .target(
            name: "DBClient",
            dependencies: ["Factory", .product(name: "RealmSwift", package: "realm-swift")],
            path: "Sources/DBClient"
        ),
        .testTarget(
            name: "DBClientTests",
            dependencies: ["DBClient"],
            path: "Tests/Unit/DBClientTests"
        ),
    ]
)
