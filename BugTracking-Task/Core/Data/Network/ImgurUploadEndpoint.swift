//
//  ImgurUploadEndpoint.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

// MARK: - Imgur Upload Endpoint
struct ImgurUploadEndpoint: EndPoint {
    let clientID: String
    
    var path: String {
        return URLEndpoints.imgurUrl
    }
    
    var method: RequestMethod {
        return .post
    }
    
    var header: [String: String]? {
        return [
            "Authorization": "Client-ID \(clientID)",
            "Content-Type": "multipart/form-data"
        ]
    }
    
    var body: [String: Any]? {
        return nil
    }
}
