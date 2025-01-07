//
//  GoogleSheetsRepository.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

struct GoogleSheetsRepository: GoogleSheetsRepositoryProtocol, HttpClient {
    
    func fetchSheetDetails(sheetId: String) async throws -> SheetsResponse {
        let endPoint = GoogleSheetsEndPoint.fetchSheetDetails(sheetId: sheetId)
        let sheetResponse: SheetsResponse = try await performRequest(endPoint: endPoint)
     print("sheetResponse: \(sheetResponse)")
        return sheetResponse
    }
    
    func createNewTab(sheetId: String, tabName: String) async throws {
        let endPoint = GoogleSheetsEndPoint.createNewTab(sheetId: sheetId, tabName: tabName)
        let _: NoResponse = try await performRequest(endPoint: endPoint)
        print("New Tab Created: \(tabName)")
    }
    
    func appendData(sheetId: String, tabName: String, values: [[String]]) async throws {
        let endPoint = GoogleSheetsEndPoint.appendData(sheetId: sheetId, tabName: tabName, values: values)
        let _: NoResponse = try await performRequest(endPoint: endPoint)
    }
}
