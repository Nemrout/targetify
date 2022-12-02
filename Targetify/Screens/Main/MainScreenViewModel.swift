//
//  MainScreenViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI
import Combine
import Foundation

final class MainScreenViewModel: ObservableObject {
    
    private let networkService: FlaskService = FlaskService()
    
    @Published var pages: [String] = []
    
    @Published var charts: [ChartConfiguration : ChartData] = [:]
    
    var configurations: [ChartConfiguration] = [
        .init(pageTitle: "Number of clicks", column: "clicks", chartType: .line, frequency: .M1),
        .init(pageTitle: "Lifetime", column: "lifetime", chartType: .bar, frequency: .M1),
        .init(pageTitle: "Country", column: "country", chartType: .pie, frequency: .M1)
    ]
    
    var bag: Set<AnyCancellable> = .init()
    
    /// Displaying charts:
    /// 1. Fetch page names
    /// 2. Fetch page data
    /// Take a random one
    /// 3. Request
    init() {
        self.fetchPages()

//        $pages
//            .sink { [weak self] pages in
//                pages.forEach { self?.fetchPage(name: $0) }
//            }
//            .store(in: &bag)
    }
    
    func fetchPages() {
        Task {
            do {
                let pages = try await networkService.fetchPages()
                
                DispatchQueue.main.async {
                    self.pages = pages
                }
                
                guard let randomPage = pages.randomElement() else { return }
                print("REQUESTING", randomPage)
                self.configurations.forEach {
                    self.fetchPage(name: randomPage, frequency: .M1, configuration: $0)
                }
                
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
    
    func fetchPage(name: String, frequency: Frequency = .M1, configuration: ChartConfiguration) {
        let task = Task {
            
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
                        self.charts[configuration] = chartData
                    }
                }
                
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
}
