import Common
import Domain
import Factory
import UIKit

protocol RecipeDetailRouting: AnyObject {
    func routeToBrowser(with url: URL)
}

final class RecipeDetailRouter: RecipeDetailRouting {
    func routeToBrowser(with url: URL) {
        UIApplication.shared.open(url)
    }
}
