//
//  GoogleSignInViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

class GoogleSignInViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String? = nil
    
    private let googleSignInUseCase: GoogleSignInUseCase
    
    init(googleSignInUseCase: GoogleSignInUseCase) {
        self.googleSignInUseCase = googleSignInUseCase
    }
    
    func signIn() async {
        await MainActor.run {
            isLoading = true
        }
        do{
            let user = try await self.googleSignInUseCase.execute(0)
            await MainActor.run {
                isLoading = false
                isSignedIn = true
            }
        }catch let error{
            await MainActor.run {
                isLoading = false
                errorMessage = error.localizedDescription 
            }
            print("error: \(error)")
        }
    }
}
