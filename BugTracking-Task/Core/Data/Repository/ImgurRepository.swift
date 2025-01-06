//
//  ImgurRepository.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class ImgurRepository: ImageRepositoryProtocol, HttpClient {

    // MARK: - Properties
    private let clientID = "e96ce0d1607462f"
    
    // MARK: - Image Upload Method
    func uploadImage(_ image: UIImage) async throws -> String {
        let boundary = generateBoundary()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageUploadError.invalidImageData
        }
        
        let body = createRequestBody(boundary: boundary, imageData: imageData)
        let endpoint = ImgurUploadEndpoint(clientID: clientID)
        
        let imgurResponse: ImgurResponse = try await performMultipartFormDataRequest(
            endPoint: endpoint,
            boundary: boundary,
            body: body
        )
        
        return imgurResponse.data.link
    }

    // MARK: - Helper Methods
    private func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }

    private func createRequestBody(boundary: String, imageData: Data) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

// MARK: - Extensions
private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
