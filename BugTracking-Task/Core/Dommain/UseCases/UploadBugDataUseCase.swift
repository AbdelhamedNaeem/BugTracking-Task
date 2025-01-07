//
//  UploadBugDataUseCase.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

class UploadBugDataUseCase: UseCaseProtocol {
    
    typealias Input = (sheetId: String, values: [[String]])
    typealias Item = Void // No return value, so use `Void`
    
    private let repository: GoogleSheetsRepositoryProtocol
    
    private var tabName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        return dateFormatter.string(from: Date())
    }
    
    init(repository: GoogleSheetsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ input: (sheetId: String, values: [[String]])) async throws -> Item? {
        let (sheetId, values) = input
        
        // Step 1: Check if the tab exists
        let sheetDetails = try await repository.fetchSheetDetails(sheetId: sheetId)
        let tabExists = sheetDetails.sheets.contains { $0.properties.title == tabName }
        
        // Step 2: Create a new tab if it doesn't exist
        if !tabExists {
            try await repository.createNewTab(sheetId: sheetId, tabName: tabName)
        }
        
        // Step 3: Append data to the tab
        try await repository.appendData(sheetId: sheetId, tabName: tabName, values: values)
        
        print("Bug data uploaded successfully!")
        return nil
    }
}
