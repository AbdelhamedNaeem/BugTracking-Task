//
//  ImgurRepository.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class ImgurRepository: ImageRepositoryProtocol, HttpClient {

    private var clientID: String {
        return "e96ce0d1607462f"
    }
    
    func uploadImage(_ image: UIImage) async throws -> String {
        let boundary = "Boundary-\(UUID().uuidString)"
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageUploadError.invalidImageData
        }
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        let endpoint = ImgurUploadEndpoint(clientID: clientID)
        
        let imgurResponse: ImgurResponse = try await performMultipartFormDataRequest(
            endPoint: endpoint,
            boundary: boundary,
            body: body
        )
        
        return imgurResponse.data.link
    }
}
