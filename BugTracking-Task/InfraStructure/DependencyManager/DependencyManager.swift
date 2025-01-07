//
//  DependencyManager.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation
import SwiftUI

enum DependencyManager {
    
    static func createGoogleSignInView() -> some View{
        let presentationProvider: PresentationProvider = UIKitPresentationProvider()

        let signinService = GoogleSignInService(presentationProvider: presentationProvider)
        let signInRepository = GoogleSignInRepository(signInService: signinService)
        let signInUseCase = GoogleSignInUseCase(repository: signInRepository)
        let signinViewModel = GoogleSignInViewModel(googleSignInUseCase: signInUseCase)
        
        return GoogleSignInView(viewModel: signinViewModel)
    }
    
    static func createBugView() -> some View{
        let imgurRepository = ImgurRepository()
        let googleSheetsRepository = GoogleSheetsRepository()
        let uploadImageUseCase = UploadImageUseCase(imageRepository: imgurRepository)
        let uploadBugUseCase = UploadBugDataUseCase(repository: googleSheetsRepository)
        let createBugViewModel = CreateBugViewModel(uploadImageUseCase: uploadImageUseCase,
                                                    uploadBugDataUseCase: uploadBugUseCase)
        
        return CreateBugView(viewModel: createBugViewModel)
    }
    
    
}
