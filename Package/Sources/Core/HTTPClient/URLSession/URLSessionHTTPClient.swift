import Combine
import Foundation

final class URLSessionHTTPClient: HTTPClient {

    private let baseUrl: URLMetadata
    private let requestBuilder: HTTPRequestBuilder
    private let urlSession: URLSession

    init(baseUrl: URLMetadata, requestBuilder: HTTPRequestBuilder, urlSession: URLSession) {
        self.baseUrl = baseUrl
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }

    func get(_ path: String) throws -> HTTPRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = baseUrl.scheme.rawValue
        urlComponents.host = baseUrl.host
        urlComponents.path = path
        guard let url = urlComponents.url else {
            throw HTTPClientError.invalidURL
        }
        return requestBuilder.build(url: url, method: .GET)
    }

    func execute(_ request: HTTPRequest) -> AnyPublisher<HTTPResponse, HTTPClientError> {
        urlSession.dataTaskPublisher(for: requestBuilder.build(request))
        .print("HTTPCLient")
        .retry(3)
        .tryMap { (data, response) -> HTTPResponse in
            guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode else {
                    throw HTTPClientError.failure
            }
            return HTTPResponse(data: data, response: response)
        }
        .mapError { error in
            if let httpClientError = error as? HTTPClientError {
                return httpClientError
            } else {
                return .unknown(error)
            }
        }
        .eraseToAnyPublisher()
    }
}
