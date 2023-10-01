import Assembly
import Foundation

extension Assembly {

    public func getHTTPClient(baseUrl: URLMetadata) -> HTTPClient {
        return URLSessionHTTPClient(baseUrl: baseUrl, requestBuilder: getRequestBuilder(), urlSession: URLSession.shared)
    }

    private func getRequestBuilder() -> HTTPRequestBuilder {
        return URLSessionHTTPRequestBuilder()
    }

}
