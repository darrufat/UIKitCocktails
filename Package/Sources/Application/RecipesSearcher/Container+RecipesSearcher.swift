import Common
import Factory

extension Container {
    public var recipesSearcherBuilder: Factory<ViewModuleBuilder> {
        self { RecipesSearcherBuilder() }
    }
    var recipesSearcherView: Factory<RecipesSearcherView?> {
        self { RecipesSearcherViewController() }
    }
    var recipesSearcherPresenter: Factory<RecipesSearcherPresentable> {
        self { RecipesSearcherPresenter() }
    }
}
