//
//  UserDefaultManager.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol UserDefaultsManaging {
    func saveUser(_ user: GoogleUserEntity)
    func removeUser()
    func isUserSignedIn() -> Bool
}

class UserDefaultsManager: UserDefaultsManaging {
    private enum UserDefaultsKeys: String {
        case googleUserEntity = "GoogleUserEntity"
    }

    func saveUser(_ user: GoogleUserEntity) {
        let userDefaults = UserDefaults.standard
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: UserDefaultsKeys.googleUserEntity.rawValue)
            userDefaults.synchronize()
        } catch {
            print("Failed to save GoogleUserEntity to UserDefaults: \(error)")
        }
    }

    func removeUser() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: UserDefaultsKeys.googleUserEntity.rawValue)
        userDefaults.synchronize()
    }

    func loadUser() -> GoogleUserEntity? {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: UserDefaultsKeys.googleUserEntity.rawValue) {
            do {
                return try JSONDecoder().decode(GoogleUserEntity.self, from: data)
            } catch {
                print("Failed to load GoogleUserEntity from UserDefaults: \(error)")
            }
        }
        return nil
    }
    
    func isUserSignedIn() -> Bool {
        guard ((loadUser()?.accessToken) != nil) else {
            return false
        }
        return true
    }
}
