import Vapor
//import Fluent
//import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    
//    var configuration = PostgresConfiguration(url: Environment.get("DATABASE_URL")!)
//    configuration!.tlsConfiguration?.certificateVerification = .fullVerification
//    try app.databases.use(.postgres(configuration: configuration!), as: .psql)
//
//    app.migrations.add(Game(), to: .psql)
//    try app.autoMigrate().wait()
    try XboxDataBusiness().getGameDeals(completion: { Session.current.updateActiveDeals($0) })
}


class Session {
    
    static var current : Session = Session()
    
    private var operationSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    private(set) var activeDeals : [Game] = []
    
    func updateActiveDeals(_ newDeals: [Game]) {
        operationSemaphore.wait()
        activeDeals.append(contentsOf: newDeals)
        operationSemaphore.signal()
    }
    
}
