public struct RecipeEntity {
    public let name: String
    public let instructions: String
    public let tags: [String]?
    public let imageUrl: String?
    public let videoUrl: String?
    public let ingredients: [String]?

    public init(name: String, instructions: String, tags: [String]? = nil, imageUrl: String? = nil, videoUrl: String? = nil, ingredients: [String]? = nil) {
        self.name = name
        self.instructions = instructions
        self.tags = tags
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.ingredients = ingredients
    }
}
