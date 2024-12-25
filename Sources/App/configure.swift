import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // database configuration
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost",
                username: "postgres",
                password: "",
                database: "postgres",
                tls: .disable
            )
        ),
        as: .psql
    )

    // register migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryCategoryTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())

    // register controllers
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())

    app.jwt.signers.use(.hs256(key: "SECRETKEY"))

    // register routes
    try routes(app)
}
