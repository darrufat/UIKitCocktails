# UIKitCocktails

**UIKitCocktails** is a demo app to search for cocktail recipes. It even allows you to view previously searched recipes when there's no internet connection available.

## Overview

This app displays a search page where you can look for cocktail recipes. When you select one, its details will be displayed on a new screen.

## Configure and Run the Application

The UIKitCocktails app was developed in Xcode 15 to take advantage of the #Preview macro for UIKit views. I also attempted to use SwiftData for offline mode, but encountered crashes.

There are several dependencies integrated with SPM:

### App:

* [Factory](https://github.com/hmlongco/Factory.git): A compile-time safe dependency injection library.
* [Snapkit](https://github.com/SnapKit/SnapKit.git): A UI library that simplifies setting view constraints.
* [Kingfisher](https://github.com/onevcat/Kingfisher.git): An image downloading library that also handles caching.
* [Realm](https://github.com/realm/realm-swift.git): A library for persisting data on your device.

### Tests:

* [Snapshot-Testing](https://github.com/pointfreeco/swift-snapshot-testing.git): A library for creating snapshot tests with different configurations.
* [Nimble](https://github.com/Quick/Nimble.git): A library for writing more readable unit tests and offering helpful expectations.

## Architecture

To avoid adding excessive boilerplate, I developed the app using the MVP architecture for the presentation layer. It's similar to VIPER as I also incorporated Routers to abstract navigation logic.

Following clean architecture principles, I also have a domain layer with use cases, and a Data layer consisting of repositories and data sources.

## Workspace Structure

I understand that one can work directly on a project with SPM. However, I prefer having a Workspace to compartmentalize the application into Packages, even delineating each feature or screen.

I choose this approach because, in the future, if you want to create an App Clip (or a watchOS, macOS, tvOS App...), you can simply incorporate the features you need. Unfortunately, with it being implemented in UIKit, we are limited to iOS and iPadOS in terms of UI.

The main modules include:

- **Data**: This encompasses the repositories and data sources.
- **Domain**: Primarily, the search use case and the repository protocol.
- **RecipesSearcher**: This is the search screen with the view module utilizing the MVP structure and a builder to consolidate the classes, returning a fully set up UIViewController.
- **RecipeDetail**: The detail screen follows a similar architecture.
- **Common**: Shared protocols and entities between layers, free of dependencies.
- **DBClient**: A wrapper for persistent storage. While I started with SwiftData and faced issues, transitioning the two functions to Realm was straightforward, thanks to the level of abstraction.
- **HTTPClient**: A simple URLSession wrapper for requests, which can be replaced by Alamofire or another library if necessary.

Dependencies between 3rd party libraries and packages are established in SPM and registered with Factory, with Container extensions created in each module.

## Testing

Regrettably, I didn't have time to implement tests. Ideally, I'd like to at least establish a snapshot test of cells under different scales, in both dark and light modes, and so on.

Unit tests are crucial for all logic to ensure consistent app behavior and to prevent issues across releases. I usually mock dependency protocols with tools like Sourcery, Cuckoo, Mockolo, etc., but perhaps Swift macros might offer similar capabilities.

In my experience, UI Tests tend to be unstable and slow. I prioritize covering code with the aforementioned test types and occasionally some integration tests, from Presenter to HTTPClient, using real dependencies but mocking HTTP responses.