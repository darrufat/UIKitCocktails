import Common
import Domain
import Dispatch
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
                await MainActor.run {
                    guard !self.recipes.isEmpty else {
                        self.view?.updateState(with: .empty)
                        return
                    }
                    let models = self.recipes.map { RecipeCellModel(name: $0.name,
                                                                    instructions: $0.instructions,
                                                                    thumbnailUrl: $0.thumbnailUrl) }
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
