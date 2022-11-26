//
//  TargetifyError.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/13/22.
//

import SwiftUI
import UIKit
import Foundation

final class TargetifyError: Error {
    
    let message: String
    
    static func `default`(_ message: String) -> TargetifyError {
        TargetifyError(message: message)
    }
    
    init(message: String) {
        self.message = message
    }
    
    init(error: Error) {
        self.message = error.localizedDescription
    }
    
    func handle() {
        
        let alert = UIAlertController(
            title: "Error occurred",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow else { return }
            keyWindow.rootViewController?.present(alert, animated: true)
        }
    }
}
