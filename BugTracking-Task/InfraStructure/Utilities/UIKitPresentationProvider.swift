//
//  UIKitPresentationProvider.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import Foundation
import UIKit

protocol PresentationProvider {
    func getPresentingViewController() async -> UIViewController?
}

final class UIKitPresentationProvider: PresentationProvider {
    func getPresentingViewController() async -> UIViewController? {
        return await MainActor.run {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                return rootViewController
            }
            return nil
        }
    }
}
