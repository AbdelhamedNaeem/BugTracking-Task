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
    func loadUser() -> GoogleUserEntity?
    
    // Methods for managing lastBugID
    func saveLastBugID(_ id: Int)
    func loadLastBugID() -> Int
    func incrementLastBugID() -> Int
}

class UserDefaultsManager: UserDefaultsManaging {
    private enum UserDefaultsKeys: String {
        case googleUserEntity = "GoogleUserEntity"
        case lastBugID = "lastBugID"
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
    
    // Save the lastBugID
    func saveLastBugID(_ id: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(id, forKey: UserDefaultsKeys.lastBugID.rawValue)
        userDefaults.synchronize()
    }
    
    // Load the lastBugID
    func loadLastBugID() -> Int {
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: UserDefaultsKeys.lastBugID.rawValue)
    }
    
    // Increment the lastBugID and return the new value
    func incrementLastBugID() -> Int {
        let lastBugID = loadLastBugID() + 1
        saveLastBugID(lastBugID)
        return lastBugID
    }
}
