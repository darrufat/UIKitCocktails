import Domain
import Dispatch
import Factory

protocol RecipesSearcherPresentable {
    var view: RecipesSearcherView? { get set }
    func searchRecipes(for query: String)
}

final class RecipesSearcherPresenter: RecipesSearcherPresentable {

    weak var view: RecipesSearcherView?
    @Injected(\.searchRecipesUseCase) private var searchUseCase
    private var searchTask: Task<Void, Never>?

    func searchRecipes(for query: String) {
        searchTask?.cancel()

        let task = Task { [weak self] in
            guard let self else { return }
            do {
                let recipes = try await self.searchUseCase(with: query)
                    .map { RecipeViewModel(name: $0.name, instructions: $0.instructions) }
                await MainActor.run {
                    guard !recipes.isEmpty else {
                        self.view?.updateState(with: .empty)
                        return
                    }
                    self.view?.updateState(with: .loaded(recipes))
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
}
