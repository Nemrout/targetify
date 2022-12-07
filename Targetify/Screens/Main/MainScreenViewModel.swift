//
//  MainScreenViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI
import Combine
import Foundation

final class MainScreenViewModel: ObservableObject, FrequencyChangedProtocol {
    
    private let networkService: FlaskService = FlaskService()
    
    @Published var pages: [String] = []
    
    @Published var charts: [ChartConfiguration : ChartData] = [:]
    
    @Published var selectedPage: String = "Loading pages..."
    
    var pagesFormatted: [String] {
        pages.map {
            String($0
                .split(separator: ".")
                .first?
                .split(separator: "_")
                .last ?? "page")
        }
        
    }
    
    var configurations: [ChartConfiguration] = [
        .init(pageTitle: "Number of clicks", column: "clicks", chartType: .line, frequency: .M1),
        .init(pageTitle: "Lifetime", column: "lifetime", chartType: .bar, frequency: .M1),
        .init(pageTitle: "Views by country", column: "country", chartType: .pie, frequency: .M1)
    ]
    
    var bag: Set<AnyCancellable> = .init()
    
    init() {
        self.fetchPages()
        
        configurations.forEach { $0.delegate = self }
    }
    
    func frequencyChanged(_ chartConfiguration: ChartConfiguration, frequency: Frequency) {
        guard let chartData = charts[chartConfiguration] else { return }
        let page = chartData.page
        self.fetchPage(name: page, frequency: frequency, configuration: chartConfiguration)
    }
    
    func fetchPages() {
        Task {
            do {
                let pages = try await networkService.fetchPages()
                
                guard let firstPage = pages.first else { return }
                
                DispatchQueue.main.async {
                    self.pages = pages
                    self.selectedPage = firstPage
                }
                
                self.configurations.forEach {
                    self.fetchPage(name: firstPage, frequency: .M1, configuration: $0)
                }
                
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
    
    func fetchPage(name: String, frequency: Frequency, configuration: ChartConfiguration) {
        Task {
            
            do {
                let chartData = try await networkService.fetchChartData(
                    page: name,
                    frequency: frequency.rawValue,
                    column: configuration.column,
                    chartType: configuration.chartType,
                    group: nil
                )
                
                
//                sleep(1)
                DispatchQueue.main.async {
                    withAnimation(.spring()) {
                        configuration.id = UUID()
                        self.charts.updateValue(chartData, forKey: configuration)
                        print(chartData)
                        
                    }
                }
                
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
}
