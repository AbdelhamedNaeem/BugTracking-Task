//
//  GoogleSignInService.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation
import GoogleSignIn

protocol GoogleSignInServiceProtocol {
    func signIn() async throws -> GoogleUserEntity
}

final class GoogleSignInService: GoogleSignInServiceProtocol {
    private let presentationProvider: PresentationProvider

    init(presentationProvider: PresentationProvider) {
        self.presentationProvider = presentationProvider
    }
    
    func signIn() async throws -> GoogleUserEntity {
        guard let rootViewController = await presentationProvider.getPresentingViewController() else {
            throw NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "No root view controller found"])
        }
        
        // Use Task { @MainActor in } to ensure the code runs on the main thread
        return try await Task { @MainActor in
            try await withCheckedThrowingContinuation { continuation in
                GIDSignIn.sharedInstance.signIn(
                    withPresenting: rootViewController,
                    hint: nil,
                    additionalScopes: ["https://www.googleapis.com/auth/spreadsheets"]
                ) { signInResult, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    if let user = signInResult?.user {
                        let userEntity = GoogleUserEntity(
                            id: user.userID ?? "",
                            name: user.profile?.name ?? "",
                            email: user.profile?.email ?? ""
                        )
                        continuation.resume(returning: userEntity)
                    } else {
                        continuation.resume(throwing: NSError(
                            domain: "GoogleSignIn",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "No user found"]
                        ))
                    }
                }
            }
        }.value
    }
}
