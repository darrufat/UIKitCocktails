public enum HTTPClientError: Error {
    case response(HTTPResponse)
    case failure
    case invalidURL
    case unknown(Error)
}
