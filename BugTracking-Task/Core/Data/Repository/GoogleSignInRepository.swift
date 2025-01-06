//
//  GoogleSignInRepository.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

final class GoogleSignInRepository: GoogleSignInRepositoryProtocol {
    private let signInService: GoogleSignInServiceProtocol

    init(signInService: GoogleSignInServiceProtocol) {
        self.signInService = signInService
    }

    func signInUser() async throws -> GoogleUserEntity {
        try await signInService.signIn()
    }
}
