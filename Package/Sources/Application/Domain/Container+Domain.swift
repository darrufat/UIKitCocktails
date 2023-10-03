import Factory

extension Container {
    public var recipesRepository: Factory<RecipesRepository?> { self { nil } }
    public var searchRecipesUseCase: Factory<SearchRecipesUseCase> {
        self { SearchRecipes() }
    }
}
