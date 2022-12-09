//
//  Main.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import UIKit
import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 25) {
                ForEach(viewModel.configurations) { configuration in
                    let chartData = viewModel.charts[configuration]
                    GenericChart(configuration: configuration, chartData: chartData, configurable: true)
                        .id(configuration.id)
                }
            }
            .padding()
            
        }
        .navigationTitle("Dashboard")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    ForEach(0..<viewModel.pages.count, id: \.self) { i in
                        let page = viewModel.pages[i]
                        let pageFormatted = viewModel.pagesFormatted[i]
                            
                        Button {
                            viewModel.selectedPage = pageFormatted
                            
                            viewModel.configurations.forEach {
                                viewModel.fetchPage(name: page, frequency: $0.frequency, configuration: $0)
                            }
                        } label: {
                            Text(page)
                        }

                        
                    }
                } label: {
                    
                    let selectedPage = String(viewModel.selectedPage
                        .split(separator: ".")
                        .first?
                        .split(separator: "_")
                        .last ?? "page")
                    
                    Text(selectedPage)
                }
                .fixedSize()

            }
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(viewModel: .init())
    }
}


fileprivate struct DummyChart: View {
    
    var body: some View {
        Rectangle()
            .fill([Color.blue, Color.red, Color.orange].randomElement()!)
            .cornerRadius(15, antialiased: true)
            .padding(.top)
            .aspectRatio(332/174, contentMode: .fit)
    }
}
