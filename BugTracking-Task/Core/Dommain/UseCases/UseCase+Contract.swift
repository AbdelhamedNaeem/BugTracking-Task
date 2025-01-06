//
//  UseCase+Contract.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation

protocol UseCaseProtocol {
    associatedtype Input = Void
    associatedtype Item
    func execute(_ input: Input?) async throws -> Item?
}
