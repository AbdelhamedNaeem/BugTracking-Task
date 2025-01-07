//
//  GoogleSheetsModels.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

/// Represents the properties of a Google Sheet tab.
struct SheetProperties: Codable {
    let title: String
}

/// Represents a Google Sheet.
struct Sheet: Codable {
    let properties: SheetProperties
}

/// Represents the response from the Google Sheets API when fetching sheet details.
struct SheetsResponse: Codable {
    let sheets: [Sheet]
}

/// Represents the request body for creating a new tab.
struct AddSheetRequest: Codable {
    let requests: [AddSheetRequestBody]
}

/// Represents the body of a request to add a new tab.
struct AddSheetRequestBody: Codable {
    let addSheet: AddSheetProperties
}

/// Represents the properties of a new tab to be added.
struct AddSheetProperties: Codable {
    let properties: SheetProperties
}

/// Represents the request body for appending data to a tab.
struct AppendDataRequest: Codable {
    let values: [[String]]
}

struct NoResponse: Decodable {}
