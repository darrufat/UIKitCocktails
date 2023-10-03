import Foundation

public protocol HTTPClient {
    func get(url: URL) async throws -> Data
}

struct URLSessionHTTPClient: HTTPClient {
    func get(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
