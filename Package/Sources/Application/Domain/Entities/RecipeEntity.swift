// TODO: review @PublicInit macro
public struct RecipeEntity {
    public let name: String
    public let instructions: String

    public init(name: String, instructions: String) {
        self.name = name
        self.instructions = instructions
    }
}
