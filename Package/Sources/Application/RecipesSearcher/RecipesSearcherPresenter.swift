import Common
import Domain
import Factory

protocol RecipesSearcherPresentable {
    var view: RecipesSearcherView? { get set }
    var router: RecipesSearcherRouting? { get set }
    func searchRecipes(for query: String)
    func recipeSelected(at index: Int)
}

final class RecipesSearcherPresenter: RecipesSearcherPresentable {

    weak var view: RecipesSearcherView?
    var router: RecipesSearcherRouting?
    @Injected(\.searchRecipesUseCase) private var searchUseCase
    private var searchTask: Task<Void, Never>?
    private var recipes: [RecipeEntity] = []

    func searchRecipes(for query: String) {
        searchTask?.cancel()

        let task = Task { [weak self] in
            guard let self else { return }
            do {
                self.recipes = try await self.searchUseCase(with: query)
                let models = self.recipes.map {
                    let name = $0.name
                    let instructions = $0.instructions
                    let thumbnailUrl = $0.thumbnailUrl
                    return RecipeCellModel(name: name,
                                    instructions: instructions,
                                    thumbnailUrl: thumbnailUrl)
                }
                await MainActor.run {
                    guard !self.recipes.isEmpty else {
                        self.view?.updateState(with: .empty)
                        return
                    }
                    self.view?.updateState(with: .loaded(models))
                }
            } catch {
                await MainActor.run {
                    print("error: \(error)")
                    //self?.view?.updateState(with: .failed(error))
                }
            }
        }

        self.searchTask = task
    }

    func recipeSelected(at index: Int) {
        router?.routeToRecipeDetail(with: recipes[index])
    }
}
