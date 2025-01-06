//
//  GoogleSignInUseCase.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

final class GoogleSignInUseCase: UseCaseProtocol {
    
    typealias Input = Int
    typealias Item = GoogleUserEntity

    private let repository: GoogleSignInRepositoryProtocol

    init(repository: GoogleSignInRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ input: Int) async throws -> GoogleUserEntity? {
        try await repository.signInUser()
    }
}

