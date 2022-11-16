//
//  TargetifyError.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/13/22.
//

import SwiftUI
import UIKit
import Foundation

struct TargetifyError: Error {
    
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
        
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        DispatchQueue.main.async {
            keyWindow.rootViewController?.present(alert, animated: true)
        }
    }
}
