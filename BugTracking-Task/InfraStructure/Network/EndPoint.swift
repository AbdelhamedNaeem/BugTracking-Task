//
//  EndPoint.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol EndPoint{
    var path: String { get }
    var method: RequestMethod { get }
    var body: [String: Any]? { get }
    var header: [String: String]? { get }
    
}

extension EndPoint{
    
    var header: [String: String]?{
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var body: [String: Any]?{
        return nil
    }
}
