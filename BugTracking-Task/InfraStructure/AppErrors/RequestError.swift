//
//  RequestError.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badRequest    
    case noData
}

enum ImageUploadError: Error {
    case invalidImageData
    case uploadFailed
    case invalidResponse
}

enum GoogleSheetsError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case tabCreationFailed
    case dataAppendingFailed
    case networkError(Error)
}
