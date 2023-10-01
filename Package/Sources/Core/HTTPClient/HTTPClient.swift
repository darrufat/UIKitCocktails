import Combine

/// - Tag: HTTPClient
public protocol HTTPClient {
    func get(_ path: String) throws -> HTTPRequest
    func execute(_ request: HTTPRequest) -> AnyPublisher<HTTPResponse, HTTPClientError>
}
