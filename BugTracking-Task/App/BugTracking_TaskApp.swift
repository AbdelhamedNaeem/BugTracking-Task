//
//  BugTracking_TaskApp.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 05/01/2025.
//

import SwiftUI

@main
struct BugTracking_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            DependencyManager.createGoogleSignInView()
        }
    }
}
