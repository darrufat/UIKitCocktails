import Domain
import Factory

extension Container {
    var recipesNetworkDataSource: Factory<RecipesNetworkDataSource> {
        self { DefaultRecipesNetworkDataSource() }
    }

    public var recipesRepository: Factory<RecipesRepository> {
        self { DefaultRecipesRepository() }
    }
}
