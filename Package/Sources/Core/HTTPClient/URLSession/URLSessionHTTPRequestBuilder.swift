import Foundation

struct URLSessionHTTPRequestBuilder: HTTPRequestBuilder {

    public func build(url: URL, method: HTTPRequestMethod) -> HTTPRequest {
        return HTTPRequest(url: url, method: method)
    }

    public func build(_ request: HTTPRequest) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
}
