import Common
import Factory

extension Container {
    public var recipesSearcherBuilder: Factory<ViewModuleBuilder> {
        self { RecipesSearcherBuilder() }
    }
}
