//
//  ABTestingScreenViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Combine
import Foundation

final class ABTestingScreenViewModel: ObservableObject {
    
    @Published var testingModels: [ABTestingModel] = []
    
    static let subject: PassthroughSubject<ABTestingModel, Never> = .init()
    
    let flaskService: FlaskService = .init()
    
    var bag: Set<AnyCancellable> = .init()
    
    init() {
        print(#file, "INIT")
        ABTestingScreenViewModel.subject
            .sink { [weak self] model in
                withAnimation(.spring()) {
                    self?.testingModels.append(model)
                }
            }
            .store(in: &bag)
    }
    
    func fetchActiveTestings() {
        Task {
            let testings = try await flaskService.fetchActiveTestings()
            testings.forEach { page_groups in
                let page_groups_split = page_groups.split(separator: "_").map({ $0 })
//                let page: String = String(page_groups_split[0])
//                let groups: String = String(page_groups_split[1])
                
//                self.fetchDataForTesting(page: page, groups: groups)
            }
        }
    }
    
    private func fetchDataForTesting(page: String, groups: String) {
        Task {
            
            let pageName = "pagelite_\(page).csv"
            do {
                let chartData = try await self.flaskService.fetchChartData(
                    page: pageName,
                    frequency: Frequency.M1.rawValue,
                    column: "clicks",
                    chartType: .line,
                    group: groups
                )
                
                let configuration = ChartConfiguration(
                    pageTitle: "",
                    column: "clicks",
                    chartType: .line,
                    frequency: .M1,
                    showArea: false
                )
                
                let newModel = ABTestingModel(
                    title: "",
                    data: chartData,
                    configuraiton: configuration,
                    isLive: false
                )
                
                DispatchQueue.main.async {
                    self.testingModels.append(newModel)
                }
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
            
        }
    }
}
