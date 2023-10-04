import Factory

extension Container {
    public var dbClient: Factory<DBClient> {
        self { SwiftDataClient() }
    }
}
