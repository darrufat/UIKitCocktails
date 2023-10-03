import Factory
import Foundation
import HTTPClient

protocol RecipesNetworkDataSource {
    func fetchRecipes(query: String) async throws -> [RecipeDTO]
}

struct DefaultRecipesNetworkDataSource: RecipesNetworkDataSource {
    @Injected(\.httpClient) private var httpClient
    // TODO: Move base url to proper place
    private let baseURL: URL? = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")

    func fetchRecipes(query: String) async throws -> [RecipeDTO] {
        guard let url = baseURL?.appendingPathComponent("search.php?s=\(query)") else { 
            throw NSError(domain: "Invalid URL", code: 500)
        }
        let data = try await httpClient.get(url: url)

        let recipes = try JSONDecoder().decode([RecipeDTO].self, from: data)

        return recipes
    }
}
