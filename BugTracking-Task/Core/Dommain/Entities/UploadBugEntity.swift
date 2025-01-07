//
//  UploadBugEntity.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 07/01/2025.
//

import Foundation
import UIKit.UIDevice

class UploadBugEntity {
    var bugId: String
    var bugDescription: String
    var bugReporter: String
    var bugImage: String
    var sheetId: String
    
    private var userDefaultsManager: UserDefaultsManaging = UserDefaultsManager()
    
    private static func generateBugID(userDefaultsManager: UserDefaultsManaging) -> String {
        let deviceUUID = UIDevice.current.identifierForVendor?.uuidString ?? "unknownDevice"
        let lastBugID = userDefaultsManager.incrementLastBugID()
        return "\(deviceUUID)_\(lastBugID)"
    }

    init(bugDescription: String, bugImage: String) {
        self.bugId = UploadBugEntity.generateBugID(userDefaultsManager: userDefaultsManager)
        self.bugDescription = bugDescription
        self.bugReporter = (userDefaultsManager.loadUser()?.name ?? "") + " / " + (userDefaultsManager.loadUser()?.email ?? "")
        self.bugImage = bugImage
        self.sheetId = "11Hu4FtZfXzoEqLt6rtlDQx-7ndE5du-doeuMtPStWkc"
    }
    
    func createBugData() -> [[String]]{
        let bugData = [
            ["Bug ID", "Reporter", "Description", "Image URL"], // Header row
            [bugId, bugReporter, bugDescription, bugImage]      // Bug data row
        ]
        return bugData
    }
}
