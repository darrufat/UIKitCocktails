import Data
import Factory
import RecipeDetail

extension Container: AutoRegistering {
    public func autoRegister() {
        registerDataDependencies()
        registerDetailDependencies()
    }
}
