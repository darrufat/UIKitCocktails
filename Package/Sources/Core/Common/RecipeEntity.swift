public struct RecipeEntity {
    public let id: String
    public let name: String
    public let instructions: String
    public let tags: [String]?
    public let thumbnailUrl: String?
    public let imageUrl: String?
    public let videoUrl: String?
    public let ingredients: [String]?

    public init(id: String, name: String, instructions: String, tags: [String]? = nil, thumbnailUrl: String? = nil, imageUrl: String? = nil, videoUrl: String? = nil, ingredients: [String]? = nil) {
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
