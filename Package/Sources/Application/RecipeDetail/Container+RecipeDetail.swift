import Common
import Factory

extension Container {
    public var recipeDetailBuilder: Factory<RecipeDetailModuleBuilder?> {
        self { RecipeDetailBuilder() }
    }

    var recipeDetailPresenter: Factory<RecipeDetailPresentable> {
        self { RecipeDetailPresenter() }
    }

    public func registerDetailDependencies() {
        recipeDetailBuilder.register { RecipeDetailBuilder() }
    }
}
