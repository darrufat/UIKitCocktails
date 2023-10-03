import Common
import Factory
import Foundation

public protocol SearchRecipesUseCase {
    func callAsFunction(query: String) async throws  -> [RecipeEntity]
}

struct SearchRecipes: SearchRecipesUseCase {
    @Injected(\.recipesRepository) private var repository

    func callAsFunction(query: String) async throws -> [RecipeEntity] {
        guard let repository else { throw NSError(domain: "Dependency missing", code: 1001) }
        return try await repository.searchRecipes(query: query)
    }
}
