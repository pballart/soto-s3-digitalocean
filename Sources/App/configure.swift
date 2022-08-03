import Vapor
import SotoS3

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    configureAWS(app)

    // register routes
    try routes(app)
}

private func configureAWS(_ app: Application) {
    app.aws.client = AWSClient(httpClientProvider: .shared(app.http.client.shared))
}
