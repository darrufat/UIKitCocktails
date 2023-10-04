import Common
import Foundation
import RealmSwift

public protocol DBClient {
    func persist(recipes: [RecipeEntity]) async throws
    func fetch(with query: String) async throws -> [RecipeEntity]
}

final class RealmDBClient: DBClient {

    init() {}

    @MainActor
    func persist(recipes: [RecipeEntity]) async throws {
        let realm = try await Realm()
        let dbos = recipes.map {
            RecipeDBO(id: $0.id,
                      name: $0.name,
                      instructions: $0.instructions,
                      tags: $0.tags?.joined(separator: ","),
                      thumbnailUrl: $0.thumbnailUrl,
                      imageUrl: $0.imageUrl,
                      videoUrl: $0.videoUrl,
                      ingredients: $0.ingredients?.joined(separator: ","))
        }

        try realm.write {
            for dbo in dbos {
                realm.add(dbo, update: .modified)
            }
        }
    }

    @MainActor
    func fetch(with query: String) async throws -> [RecipeEntity] {
        let realm = try await Realm()
        let recipes = realm.objects(RecipeDBO.self)
        let filtered = recipes.filter("name CONTAINS %@", query)
        return filtered.map {
            RecipeEntity(id: $0.id,
                         name: $0.name,
                         instructions: $0.instructions,
                         tags: $0.tags?.components(separatedBy: ","),
                         thumbnailUrl: $0.thumbnailUrl,
                         imageUrl: $0.imageUrl,
                         videoUrl: $0.videoUrl,
                         ingredients: $0.ingredients?.components(separatedBy: ","))
        }
    }
}
