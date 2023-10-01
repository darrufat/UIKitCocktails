import Factory
import RecipesSearcher
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    @Injected(\.recipesSearcherBuilder) private var recipesSearcherBuilder
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: recipesSearcherBuilder.build())
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
