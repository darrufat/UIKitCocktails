import RealmSwift

class RecipeDBO: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var instructions: String
    @Persisted var tags: String?
    @Persisted var thumbnailUrl: String?
    @Persisted var imageUrl: String?
    @Persisted var videoUrl: String?
    @Persisted var ingredients: String?

    convenience init(id: String, name: String, instructions: String, tags: String? = nil, thumbnailUrl: String? = nil, imageUrl: String? = nil, videoUrl: String? = nil, ingredients: String? = nil) {
        self.init()
        self.id = id
        self.name = name
        self.instructions = instructions
        self.tags = tags
        self.thumbnailUrl = thumbnailUrl
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.ingredients = ingredients
    }
}
