import Common
import Domain
import Factory
import UIKit

protocol RecipesSearcherRouting: AnyObject {
    func routeToRecipeDetail(with entity: RecipeEntity)
}

final class RecipesSearcherRouter: RecipesSearcherRouting {
    weak var viewController: UIViewController?
    @Injected(\.recipeDetailBuilder) private var detailBuilder

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToRecipeDetail(with entity: RecipeEntity) {
        guard let detailVC = detailBuilder?.build(with: entity) else { return }
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
