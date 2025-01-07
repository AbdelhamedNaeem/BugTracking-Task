//
//  HttpClient.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol HttpClient{
    func performRequest<T: Decodable>(
        endPoint: EndPoint
    ) async throws -> T
    
    func performMultipartFormDataRequest<T: Decodable>(
        endPoint: EndPoint,
        boundary: String,
        body: Data
    ) async throws -> T
}

extension HttpClient{
    
    func urlComponentBuilder(endpoint: EndPoint) async -> URLComponents{
        let urlComponents = URLComponents(string: endpoint.path) ?? .init()
        print("url ==> \(urlComponents)")
        return urlComponents
    }
    
    func urlRequestBuilder(url: URL,
                           endPoint: EndPoint) async -> URLRequest?{
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        if let body = endPoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        return request
    }
    
    func performRequest<T: Decodable>(
        endPoint: EndPoint) async throws -> T{
            guard let url = await urlComponentBuilder(endpoint: endPoint).url else {
                throw RequestError.invalidURL
            }
            guard let request = await urlRequestBuilder(url: url, endPoint: endPoint) else {
                throw RequestError.badRequest
            }
            return try await withCheckedThrowingContinuation { continuation in
                URLSession.shared.dataTask(
                    with: request,
                    completionHandler: { (data, response, error) in
                        
                        guard let response = response as? HTTPURLResponse else {
                            return continuation.resume(throwing: RequestError.noResponse)
                        }
                        guard let data = data else { return }

                        do {
                            switch response.statusCode {
                            case 200...299:
                                let decodedData = try JSONDecoder().decode(T.self, from: data)
                                continuation.resume(returning: decodedData)
                            case 401:
                                continuation.resume(throwing: RequestError.unauthorized)
                            case 400:
                                continuation.resume(throwing: RequestError.badRequest)
                            default:
                                debugPrint(response.statusCode)
                                continuation.resume(throwing: RequestError.unexpectedStatusCode)
                            }
                        }
                        catch let decodingError {
                            debugPrint(decodingError)
                            continuation.resume(throwing: RequestError.decode)
                        }
                    })
                .resume()
            }
        }
}

extension HttpClient {
    
    func performMultipartFormDataRequest<T: Decodable>(
        endPoint: EndPoint,
        boundary: String,
        body: Data
    ) async throws -> T {
        guard let url = await urlComponentBuilder(endpoint: endPoint).url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(
                with: request,
                completionHandler: { (data, response, error) in
                    
                    guard let response = response as? HTTPURLResponse else {
                        return continuation.resume(throwing: RequestError.noResponse)
                    }
                    
                    guard let data = data else {
                        return continuation.resume(throwing: RequestError.noData)
                    }
                    
                    do {
                        switch response.statusCode {
                        case 200...299:
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            continuation.resume(returning: decodedData)
                        case 401:
                            continuation.resume(throwing: RequestError.unauthorized)
                        case 400:
                            continuation.resume(throwing: RequestError.badRequest)
                        default:
                            debugPrint(response.statusCode)
                            continuation.resume(throwing: RequestError.unexpectedStatusCode)
                        }
                    } catch let decodingError {
                        debugPrint(decodingError)
                        continuation.resume(throwing: RequestError.decode)
                    }
                })
            .resume()
        }
    }
}
