//
//  GoogleSheetsRepositoryProtocol.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol GoogleSheetsRepositoryProtocol {
    func fetchSheetDetails(sheetId: String) async throws -> SheetsResponse
    func createNewTab(sheetId: String, tabName: String) async throws
    func appendData(sheetId: String, tabName: String, values: [[String]]) async throws
}
