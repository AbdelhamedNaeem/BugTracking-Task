//
//  GoogleSignInServiceProtocol.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol GoogleSignInRepositoryProtocol {
    func signInUser() async throws -> GoogleUserEntity
}
