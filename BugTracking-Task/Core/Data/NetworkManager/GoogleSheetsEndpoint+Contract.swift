//
//  GoogleSheetsEndpoint+Contract.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol GoogleSheetsEndpointProtocols {
    func fetchSheetDetails(sheetId: String)
    func createNewTab(sheetId: String, tabName: String)
    func appendData(sheetId: String, tabName: String, values: [[String]])
}
