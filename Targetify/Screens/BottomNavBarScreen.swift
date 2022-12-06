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
            
            Group {
                switch viewModel.page {
                case .dashboard:
                    MainScreen(viewModel: mainScreenViewModel)
                case .news:
                    NewsScreen(viewModel: newsViewModel)
                case .testing:
                    ABTestingScreen(viewModel: abTestingScreenViewModel)
                }
            }
            .padding(.bottom, 60)
            
            BottomNavBar(page: $viewModel.page)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .task {
            do {
                
                let flaskService = FlaskService()
                
                let versions = try await flaskService.fetchPagesVersions()
                
                let uniquePages = versions.map({ $0.pageName }).unique()
                
                DispatchQueue.main.async {
                    var containers_: [PageContainer] = []
                    
                    for page in uniquePages {
                        let versionsForSinglePage = versions.filter({ $0.pageName == page })
                        let container = PageContainer(pageName: page, versions: versionsForSinglePage)
                        containers_.append(container)
                    }
                    
                }
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
}

final class BottomNavBarScreenViewModel: ObservableObject {
    
    @Published var page: BottomNavBarPage = .dashboard
    
    init() {
        print("INIT")
    }
}
