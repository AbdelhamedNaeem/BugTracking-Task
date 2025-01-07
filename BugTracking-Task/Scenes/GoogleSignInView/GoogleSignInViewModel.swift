//
//  GoogleSignInViewModel.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

enum NavigationState {
    case none
    case createBug
}

class GoogleSignInViewModel: ObservableObject {
    
    @Published var navigationState: NavigationState = .none
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
            let user = try await self.googleSignInUseCase.execute(0)
            print("Signed in user: \(user?.email ?? "")")
            print("Signed in user token: \(user?.accessToken ?? "")")
            navigationState = .createBug
            await MainActor.run {
                isLoading = false
            }
        }catch let error{
            await MainActor.run {
                isLoading = false
            }
            print("error: \(error)")
        }
    }
}
