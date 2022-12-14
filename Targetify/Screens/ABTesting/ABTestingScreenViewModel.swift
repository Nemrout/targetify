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
    
    var didLoad: Bool = false
    
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
    
    func deleteTestingServer(id: Int) {
        Task {
            do {
                let success = try await flaskService.deleteABTesting(id: id)
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
            
        }
    }
    
    func fetchActiveTestings() {
        
        guard !didLoad else { return }
        
        Task {
            do {
                let testings = try await flaskService.fetchActiveTestings()
                testings.forEach { model in
                    fetchDataForTesting(page: model.page, groups: String(model.groups))
                }
                didLoad = true
            } catch {
                TargetifyError(error: error)
                    .handle()
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
                    showArea: false,
                    multipleGroups: true
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
    
    
    func fetchActiveTestings1() {
        
        guard !didLoad else { return }
        
        Task {
            do {
                let testings = try await flaskService.fetchActiveTestings()
                for model in testings {
                    let pageName = "pagelite_\(model.page).csv"
                    do {
                        let chartData = try await self.flaskService.fetchChartData(
                            page: pageName,
                            frequency: Frequency.M1.rawValue,
                            column: "clicks",
                            chartType: .line,
                            group: String(model.groups)
                        )
                        
                        let configuration = ChartConfiguration(
                            pageTitle: "",
                            column: "clicks",
                            chartType: .line,
                            frequency: .M1,
                            showArea: false,
                            multipleGroups: true
                        )
                        
                        let newModel = ABTestingModel(
                            title: model.title,
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
                didLoad = true
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
            
        }
    }
}
