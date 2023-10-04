import Common
import Domain
import UIKit

struct RecipeDetailBuilder: RecipeDetailModuleBuilder {
    func build(with entity: RecipeEntity) -> UIViewController {
        let vc = RecipeDetailViewController()
        vc.updateState(with: .loaded(.init(name: entity.name,
                                instructions: entity.instructions,
                                tags: entity.tags,
                                thumbnailUrl: entity.thumbnailUrl,
                                imageUrl: entity.imageUrl,
                                videoUrl: entity.videoUrl,
                                ingredients: entity.ingredients)))
        return vc
    }
}
