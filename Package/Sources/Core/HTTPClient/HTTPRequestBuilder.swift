import Foundation

protocol HTTPRequestBuilder {
    func build(url: URL, method: HTTPRequestMethod) -> HTTPRequest
    func build(_ request: HTTPRequest) -> URLRequest
}
