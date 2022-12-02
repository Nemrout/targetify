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
    
    var error: (any Error)?
    
    let message: String
    
    private var debugMessage: String?
    
    static func `default`(_ message: String) -> TargetifyError {
        TargetifyError(message: message)
    }
    
    init(message: String) {
        self.message = message
    }
    
    init(error: Error) {
        self.message = error.localizedDescription
        self.error = error
    }
    
    init(error: DecodingError) {
        self.message = error.localizedDescription
        self.debugMessage = error.errorDescription
        self.error = error
    }
    
    func handle() {
        
        print(error)
        
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
