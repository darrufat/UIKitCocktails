import Common
import Domain
import UIKit

struct RecipeDetailBuilder: RecipeDetailModuleBuilder {
    func build(with entity: RecipeEntity) -> UIViewController {
        let vc = RecipeDetailViewController()
        let router = RecipeDetailRouter()
        vc.presenter.view = vc
        vc.presenter.router = router
        vc.presenter.loadDetail(with: entity)
        return vc
    }
}
