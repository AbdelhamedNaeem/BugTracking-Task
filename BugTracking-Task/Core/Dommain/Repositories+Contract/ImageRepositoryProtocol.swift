//
//  ImageRepositoryProtocol.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

protocol ImageRepositoryProtocol {
    func uploadImage(_ image: UIImage) async throws -> String
}
