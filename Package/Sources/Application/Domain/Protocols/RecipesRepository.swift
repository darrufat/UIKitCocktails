public protocol RecipesRepository {
    func searchRecipes(query: String) async throws -> [RecipeEntity]
}
