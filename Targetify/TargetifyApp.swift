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
    
    @StateObject var viewModel: RootViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                BottomNavBarScreen()
                    .sheet(isPresented: $viewModel.showsAddNewTestingModal, content: {
                        AddNewTestingModal()
                            .presentationDetents([.height(600)])
                    })
                    .animation(.spring(), value: viewModel.showsAddNewTestingModal)
                    .environmentObject(viewModel)
            }
        }
    }
}
