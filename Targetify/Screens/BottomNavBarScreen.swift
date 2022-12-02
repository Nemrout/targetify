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
    
    @StateObject var mainScreenViewModel: MainScreenViewModel = .init()
    
    @StateObject var abTestingScreenViewModel: ABTestingScreenViewModel = .init()
    
    @StateObject var newsViewModel: NewsScreenViewModel = NewsScreenViewModel()
    
    var body: some View {
        
        ZStack {
            
            switch viewModel.page {
            case .dashboard:
                MainScreen(viewModel: mainScreenViewModel)
            case .news:
                NewsScreen(viewModel: newsViewModel)
            case .testing:
                ABTestingScreen(viewModel: abTestingScreenViewModel)
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
