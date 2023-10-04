import Foundation

public enum ViewState<T> {
    case empty
    case loading
    case loaded(T)
    case failed(LocalizedError)
}
