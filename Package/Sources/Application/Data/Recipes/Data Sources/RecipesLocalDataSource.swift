import Common
import Factory
import Foundation
import DBClient

protocol RecipesLocalDataSource {
    func persist(recipes: [RecipeEntity]) async throws
    func fetchRecipes(query: String) async throws -> [RecipeEntity]
}

struct DefaultRecipesLocalDataSource: RecipesLocalDataSource {
    @Injected(\.dbClient) private var dbClient

    func persist(recipes: [RecipeEntity]) async throws {
        try await dbClient.persist(recipes: recipes)
    }

    func fetchRecipes(query: String) async throws -> [RecipeEntity] {
        try await dbClient.fetch(with: query)
    }
}
