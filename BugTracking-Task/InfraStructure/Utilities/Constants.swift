//
//  Constants.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

enum UserDefaultKeys: String {
    case userEmail = "userEmail"
    case isSignedIn = "isSignedIn"
    
//    TODO: must saved in keychain -
    case accessToken = "accessToken"
}


enum URLEndpoints {
    static let imgurUrl = "https://api.imgur.com/3/image"
}
