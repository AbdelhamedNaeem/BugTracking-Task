//
//  GoogleSheetsEndPoint.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

enum GoogleSheetsEndPoint {
    case fetchSheetDetails(sheetId: String)
    case createNewTab(sheetId: String, tabName: String)
    case appendData(sheetId: String, tabName: String, values: [[String]])
}

extension GoogleSheetsEndPoint: EndPoint {
    
    var baseUrl: String {
        return URLEndpoints.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchSheetDetails(let sheetId):
            return "\(baseUrl)/\(sheetId)"
        case .createNewTab(let sheetId, _):
            return "\(baseUrl)/\(sheetId):batchUpdate"
        case .appendData(let sheetId, let tabName, _):
            return "\(baseUrl)/\(sheetId)/values/\(tabName)!A1:append?valueInputOption=USER_ENTERED"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchSheetDetails:
            return .get
        case .createNewTab, .appendData:
            return .post
        }
    }
    
    var header: [String: String]? {
        var accessToken: String {
            return UserDefaultsManager().loadUser()?.accessToken ?? ""
        }
        switch self {
        case .fetchSheetDetails, .createNewTab, .appendData:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .fetchSheetDetails:
            return nil
        case .createNewTab(_, let tabName):
            let requestBody = AddSheetRequest(requests: [
                AddSheetRequestBody(addSheet: AddSheetProperties(properties: SheetProperties(title: tabName)))
            ])
            return requestBody.asDictionary
        case .appendData(_, _, let values):
            let requestBody = AppendDataRequest(values: values)
            return requestBody.asDictionary
        }
    }
}
