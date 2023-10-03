import Factory

extension Container {
    public var httpClient: Factory<HTTPClient> {
        self { URLSessionHTTPClient() }
    }
}
