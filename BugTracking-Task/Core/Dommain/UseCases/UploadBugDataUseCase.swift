//
//  UploadBugDataUseCase.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

class UploadBugDataUseCase: UseCaseProtocol {
    
    typealias Input = UploadBugEntity
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
    
    func execute(_ input: UploadBugEntity) async throws -> Item? {
        // Step 1: Check if the tab exists
        let sheetDetails = try await repository.fetchSheetDetails(sheetId: input.sheetId)
        let tabExists = sheetDetails.sheets.contains { $0.properties.title == tabName }
        
        // Step 2: Create a new tab if it doesn't exist
        if !tabExists {
            try await repository.createNewTab(sheetId: input.sheetId, tabName: tabName)
        }
        
        // Step 3: Append data to the tab
        try await repository.appendData(sheetId: input.sheetId, tabName: tabName, values: input.createBugData())
        
        print("Bug data uploaded successfully!")
        return nil
    }
}
