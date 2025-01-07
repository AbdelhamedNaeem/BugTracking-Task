//
//  CreateBugViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import UIKit.UIImage

class CreateBugViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false

    let uploadImageUseCase: UploadImageUseCase
    let uploadBugDataUseCase: UploadBugDataUseCase
    
    private var userName: String {
        let userdefaultManager: UserDefaultsManaging = UserDefaultsManager()
        return userdefaultManager.loadUser()?.name ?? ""
    }
    
    private var sheetId: String {
        return "11Hu4FtZfXzoEqLt6rtlDQx-7ndE5du-doeuMtPStWkc"
    }

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
                let imageUrl = try await uploadBugImage(image: image)
                
                let bugData = [
                    ["Bug ID", "Reporter", "Description", "Image URL"],
                    ["12312313", userName, description, imageUrl ?? ""]
                ]
                
                try await uploadBugDataUseCase.execute((sheetId: sheetId, values: bugData))
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
