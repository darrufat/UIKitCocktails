import Domain
import Factory

struct DefaultRecipesRepository: RecipesRepository {
    @Injected(\.recipesNetworkDataSource) private var networkDataSource

    func searchRecipes(query: String) async throws -> [RecipeEntity] {
        try await networkDataSource.fetchRecipes(query: query)
            .map {
                .init(name: $0.strDrink,
                      instructions: $0.strInstructions,
                      tags: $0.strTags?.components(separatedBy: ","),
                      imageUrl: $0.strImageSource,
                      videoUrl: $0.strVideo,
                      ingredients: $0.ingredients)
            }
    }
}
