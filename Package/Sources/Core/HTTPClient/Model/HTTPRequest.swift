import Foundation

// TODO: add post, delete, patch...
public enum HTTPRequestMethod: String {
    case GET
}

// TODO: body, headers, params...
public struct HTTPRequest {
    let url: URL
    let method: HTTPRequestMethod

    public init(url: URL, method: HTTPRequestMethod) {
        self.url = url
        self.method = method
    }
}
