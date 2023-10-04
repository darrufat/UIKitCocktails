import Common
import Foundation
import SwiftData

public protocol DBClient {
    func persist(recipes: [RecipeEntity]) async throws
    func fetch(with query: String) async throws -> [RecipeEntity]
}

final class SwiftDataClient: DBClient {
    var container: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            container = try ModelContainer(for: RecipeEntity.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }

    func persist(recipes: [RecipeEntity]) async throws {
        guard let context else { throw NSError(domain: "Context needed", code: 1002) }
        recipes.forEach {
            context.insert($0)
        }
        try context.save()
    }

    func fetch(with query: String) async throws -> [RecipeEntity] {
        let descriptor = FetchDescriptor<RecipeEntity>(predicate: #Predicate { recipe in
            recipe.name.contains(query) // lowercase needed?
        })
        let recipes = try context?.fetch(descriptor)
        return recipes ?? []
    }
}
