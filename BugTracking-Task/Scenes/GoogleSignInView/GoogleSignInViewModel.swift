//
//  GoogleSignInViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

class GoogleSignInViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    private let googleSignInUseCase: GoogleSignInUseCase
    
    init(googleSignInUseCase: GoogleSignInUseCase) {
        self.googleSignInUseCase = googleSignInUseCase
    }
    
    func signIn() async {
        await MainActor.run {
            isLoading = true
        }
        do{
            let user = try await self.googleSignInUseCase.execute(nil)
            print("Signed in user: \(user?.email ?? "")")
            await MainActor.run {
                isLoading = false
            }
        }catch let error{
            print("error: \(error)")
        }
    }
}