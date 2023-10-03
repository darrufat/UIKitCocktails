import Domain
import Factory

struct DefaultRecipesRepository: RecipesRepository {
    @Injected(\.recipesNetworkDataSource) private var networkDataSource

    func searchRecipes(query: String) async throws -> [RecipeEntity] {
        return try await networkDataSource.fetchRecipes(query: query).map {
            .init(name: $0.strDrink, instructions: $0.strInstructions)
        }
    }
}
