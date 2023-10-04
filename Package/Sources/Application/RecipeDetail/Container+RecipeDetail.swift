import Common
import Factory

extension Container {
    public var recipeDetailBuilder: Factory<RecipeDetailModuleBuilder?> {
        self { RecipeDetailBuilder() }
    }

    public func registerDetailDependencies() {
        recipeDetailBuilder.register { RecipeDetailBuilder() }
    }
}
