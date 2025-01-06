//
//  UploadImageUseCase.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class UploadImageUseCase: UseCaseProtocol {
    
    typealias Input = UIImage
    typealias Item = String
    
    private let imageRepository: ImageRepositoryProtocol
    
    init(imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
    }
    
    func execute(_ input: UIImage) async throws -> String? {
        return try await imageRepository.uploadImage(input)
    }
}
