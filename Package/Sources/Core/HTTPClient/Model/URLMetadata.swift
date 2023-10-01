public enum URLScheme: String {
    case https
}

public struct URLMetadata {

    let scheme: URLScheme
    let host: String
    var url: String {
        "\(scheme.rawValue)://\(host)"
    }

    public init(scheme: URLScheme, host: String) {
        self.scheme = scheme
        self.host = host
    }
}
