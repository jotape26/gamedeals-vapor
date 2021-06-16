import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    
    app.databases.use(.sqlite(.memory), as: .sqlite)
    app.migrations.add(GameDeal(), to: .sqlite)
    try app.autoMigrate().wait()
    
    try XboxDataBusiness().populateDatabase(fromApp: app)
}
