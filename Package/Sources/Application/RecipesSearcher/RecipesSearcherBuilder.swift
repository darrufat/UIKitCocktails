import Common
import Factory
import UIKit

struct RecipesSearcherBuilder: ViewModuleBuilder {
    func build() -> UIViewController {
        let vc = RecipesSearcherViewController()
        let router = RecipesSearcherRouter(viewController: vc)
        vc.presenter.view = vc
        vc.presenter.router = router
        return vc
    }
}
