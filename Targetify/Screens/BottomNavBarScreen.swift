//
//  BottomNavBarScreen.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Foundation

struct BottomNavBarScreen: View {
    
    @StateObject var viewModel: BottomNavBarScreenViewModel = .init()
    
    var body: some View {
        
        ZStack {
            
            switch viewModel.page {
            case .dashboard:
                MainScreen()
            case .news:
                NewsScreen()
            case .testing:
                ABTestingScreen()
            }
            
            BottomNavBar(page: $viewModel.page)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

final class BottomNavBarScreenViewModel: ObservableObject {
    
    @Published var page: BottomNavBarPage = .dashboard
    
    init() {
        print("INIT")
    }
}
