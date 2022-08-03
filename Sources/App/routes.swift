import Vapor
import SotoS3

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("deleteImage") { req async throws -> String in
        try await removeImageFromS3(fileName: "image.jpg", client: req.aws.client)
        return "Hello, world!"
    }
}

let spaceBaseUrl = "https://fra1.digitaloceanspaces.com"
let bucketName = "testBucket"

func uploadImageToS3(fileName: String, data: Data, client: AWSClient) async throws {
    let s3 = S3(client: client, endpoint: spaceBaseUrl).with(middlewares: [AWSLoggingMiddleware()])
    let putObjectRequest = S3.PutObjectRequest(
        acl: .publicRead,
        body: .data(data),
        bucket: bucketName,
        contentType: "image/jpg",
        key: fileName
    )
    _ = try await s3.putObject(putObjectRequest)
}

func removeImageFromS3(fileName: String, client: AWSClient) async throws {
    let s3 = S3(client: client, endpoint: spaceBaseUrl).with(middlewares: [AWSLoggingMiddleware()])
    let deleteObjectRequest = S3.DeleteObjectRequest(
        bucket: bucketName,
        key: fileName
    )
    _ = try await s3.deleteObject(deleteObjectRequest)
}
