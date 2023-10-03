// TODO: review @PublicInit macro
public struct RecipeEntity {
    let name: String
    let instructions: String

    public init(name: String, instructions: String) {
        self.name = name
        self.instructions = instructions
    }
}
