import UIKit

public protocol ViewModuleBuilder {
    func build() -> UIViewController
}

public protocol RecipeDetailModuleBuilder {
    func build(with entity: RecipeEntity) -> UIViewController
}
