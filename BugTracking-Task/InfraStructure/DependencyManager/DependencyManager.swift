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
        let uploadImageUseCase = UploadImageUseCase(imageRepository: imgurRepository)
        let createBugViewModel = CreateBugViewModel(uploadImageUseCase: uploadImageUseCase)
        
        return CreateBugView(viewModel: createBugViewModel)
    }
    
    
}
