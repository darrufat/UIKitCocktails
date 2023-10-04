import Domain
import Factory

extension Container {
    var recipesNetworkDataSource: Factory<RecipesNetworkDataSource> {
        self { DefaultRecipesNetworkDataSource() }
    }

    var recipesLocalDataSource: Factory<RecipesLocalDataSource> {
        self { DefaultRecipesLocalDataSource() }
    }

    public var recipesRepository: Factory<RecipesRepository?> {
        self { DefaultRecipesRepository() }
    }

    public func registerDataDependencies() {
        recipesRepository.register { DefaultRecipesRepository() }
    }
}
