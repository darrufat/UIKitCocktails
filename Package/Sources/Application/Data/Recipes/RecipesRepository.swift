import Common
import Domain
import Factory

struct DefaultRecipesRepository: RecipesRepository {
    @Injected(\.recipesNetworkDataSource) private var networkDataSource
    @Injected(\.recipesLocalDataSource) private var localDataSource

    func searchRecipes(query: String) async throws -> [RecipeEntity] {
        do {
            let recipesDTO = try await networkDataSource.fetchRecipes(query: query)
            let entities = recipesDTO.map {
                RecipeEntity(id: $0.idDrink,
                             name: $0.strDrink,
                             instructions: $0.strInstructions,
                             tags: $0.strTags?.components(separatedBy: ","),
                             thumbnailUrl: $0.strDrinkThumb,
                             imageUrl: $0.strImageSource,
                             videoUrl: $0.strVideo,
                             ingredients: $0.ingredients)
            }

            try await localDataSource.persist(recipes: entities)

            return entities
        } catch { // Fallback
            return try await localDataSource.fetchRecipes(query: query)
        }
    }
}
