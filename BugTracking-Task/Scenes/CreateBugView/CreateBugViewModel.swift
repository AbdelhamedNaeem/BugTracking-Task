//
//  CreateBugViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class CreateBugViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isUploadSuccessful: Bool = false // Track success
    @Published var errorMessage: String? = nil // Track errors

    let uploadImageUseCase: UploadImageUseCase
    let uploadBugDataUseCase: UploadBugDataUseCase
        
    init(uploadImageUseCase: UploadImageUseCase,
         uploadBugDataUseCase: UploadBugDataUseCase) {
        self.uploadImageUseCase = uploadImageUseCase
        self.uploadBugDataUseCase = uploadBugDataUseCase
    }
    
    func uploadBugImage(image: UIImage) async throws -> String? {
        let imageUrl = try await self.uploadImageUseCase.execute(image)
        return imageUrl
    }
    
    func uploadBugData(image: UIImage, description: String) {
        Task {
            await MainActor.run {
                isLoading = true
            }
            do {
                let imageUrl = try await self.uploadBugImage(image: image)
                let createdBug = UploadBugEntity(bugDescription: description, bugImage: imageUrl ?? "")
                try await uploadBugDataUseCase.execute(createdBug)
                await MainActor.run {
                    isUploadSuccessful = true
                }
            } catch let error {
                await MainActor.run {
                    errorMessage = error.localizedDescription 
                }
                print("Error: \(error.localizedDescription)")
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
