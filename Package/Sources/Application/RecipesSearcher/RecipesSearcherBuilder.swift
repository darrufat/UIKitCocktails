import Common
import UIKit

struct RecipesSearcherBuilder: ViewModuleBuilder {
    func build() -> UIViewController {
        let vc = RecipesSearcherViewController()
        vc.presenter.view = vc
        return vc
    }
}
