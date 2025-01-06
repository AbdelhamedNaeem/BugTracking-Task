//
//  CreateBugViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class CreateBugViewModel: ObservableObject {
    
    let uploadImageUseCase: UploadImageUseCase
    
    init(uploadImageUseCase: UploadImageUseCase) {
        self.uploadImageUseCase = uploadImageUseCase
    }
    
    func uploadBugImage(image: UIImage) async throws -> String? {
        let imageUrl = try await self.uploadImageUseCase.execute(image)
        print("imageUrl -> \(imageUrl ?? "")")
        return imageUrl
    }
}
