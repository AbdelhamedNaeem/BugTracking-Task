//
//  GoogleUserEntity.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

class GoogleUserEntity: Codable {
    var id: String
    var name: String
    var email: String

    private static let userDefaultsManager: UserDefaultsManaging = UserDefaultsManager()

    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        save() // Save initially on creation
    }

    private func save() {
        GoogleUserEntity.userDefaultsManager.saveUser(self)
    }
}
