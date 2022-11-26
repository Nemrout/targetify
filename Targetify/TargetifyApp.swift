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
                    .overlay(alignment: .center) {
                        if viewModel.showsAddNewTestingModal {
                            ZStack {
                                Rectangle()
                                    .fill(Color.white.opacity(0.5))
                                    .contentShape(Rectangle())
                                    .blur(radius: viewModel.showsAddNewTestingModal ? 10 : 0)
                                    .animation(.spring(), value: viewModel.showsAddNewTestingModal)
                                    .onTapGesture {
                                        viewModel.showsAddNewTestingModal = false
                                    }
                                
                                AddNewTestingModal()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                                    
                            }
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .ignoresSafeArea(.all, edges: .all)
                        }
                        
                    }
                    .animation(.spring(), value: viewModel.showsAddNewTestingModal)
                    .environmentObject(viewModel)
            }
        }
    }
}
