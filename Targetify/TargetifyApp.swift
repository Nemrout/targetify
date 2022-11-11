//
//  TargetifyApp.swift
//  Targetify
//
//  Created by Петрос Тепоян on 10/3/22.
//

import SwiftUI
import Foundation

@main
struct TargetifyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainScreen()
                    .navigationTitle("Dashboard")
            }
        }
    }
}
