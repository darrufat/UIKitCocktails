import Common
import Factory

extension Container {
    public var recipesSearcherBuilder: Factory<ViewModuleBuilder> {
        self { RecipesSearcherBuilder() }
    }
    public var recipeDetailBuilder: Factory<RecipeDetailModuleBuilder?> { self { nil } }
    var recipesSearcherView: Factory<RecipesSearcherView?> {
        self { RecipesSearcherViewController() }
    }
    var recipesSearcherPresenter: Factory<RecipesSearcherPresentable> {
        self { RecipesSearcherPresenter() }
    }
}
