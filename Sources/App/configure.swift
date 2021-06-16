import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    
    var configuration = PostgresConfiguration(url: Environment.get("DATABASE_URL")!)
    configuration!.tlsConfiguration?.certificateVerification = .fullVerification
    try app.databases.use(.postgres(configuration: configuration!), as: .psql)
    
    app.migrations.add(GameDeal(), to: .psql)
    try app.autoMigrate().wait()
    try XboxDataBusiness().populateDatabase(fromApp: app)
}
