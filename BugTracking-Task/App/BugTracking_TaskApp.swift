//
//  BugTracking_TaskApp.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 05/01/2025.
//

import SwiftUI

@main
struct BugTracking_TaskApp: App {
    let userDefaultManager: UserDefaultsManaging = UserDefaultsManager()
    var body: some Scene {
        WindowGroup {
            if userDefaultManager.isUserSignedIn() {
                DependencyManager.createBugView()
            }else {
                DependencyManager.createGoogleSignInView()
            }
        }
    }
}
