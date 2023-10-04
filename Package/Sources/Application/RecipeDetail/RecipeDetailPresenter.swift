import Common
import Factory
import Foundation

protocol RecipeDetailPresentable {
    var view: RecipesDetailView? { get set }
    var router: RecipeDetailRouting? { get set }
    func loadDetail(with recipe: RecipeEntity)
    func imageTapped()
}

final class RecipeDetailPresenter: RecipeDetailPresentable {
    weak var view: RecipesDetailView?
    var router: RecipeDetailRouting?
    private var recipe: RecipeEntity?

    func loadDetail(with recipe: RecipeEntity) {
        self.recipe = recipe
        view?.updateState(with: .loaded(.init(name: recipe.name,
                                              instructions: recipe.instructions,
                                              tags: recipe.tags,
                                              thumbnailUrl: recipe.thumbnailUrl,
                                              imageUrl: recipe.imageUrl,
                                              videoUrl: recipe.videoUrl,
                                              ingredients: recipe.ingredients)))
    }

    func imageTapped() {
        if let videoURL = URL(string: recipe?.videoUrl ?? "") {
            router?.routeToBrowser(with: videoURL)
        } else if let imageURL = URL(string: recipe?.imageUrl ?? "") {
            router?.routeToBrowser(with: imageURL)
        }
    }
}
