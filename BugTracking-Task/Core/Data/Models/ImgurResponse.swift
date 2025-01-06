//
//  ImgurResponse.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

struct ImgurResponse: Codable {
    let data: ImgurImageData
}

struct ImgurImageData: Codable {
    let link: String
}
