//
//  AddNewTestingModalViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/26/22.
//

import Combine
import Foundation

final class AddNewTestingModalViewModel: ObservableObject {
    
    @Published var pageContainers: [PageContainer] = []
    
    @Published var selectedPageContainer: PageContainer?
    
    @Published var selectedPageVersions: [PageVersion] = []
    
    @Published var title: String = ""
    
    private let flaskService: FlaskService = FlaskService()
    
    private var bag: Set<AnyCancellable> = .init()
    
    init() {
        self.fetchPagesVersions()
        
        self.$selectedPageContainer
            .sink { [weak self] _ in
                self?.selectedPageVersions = []
            }
            .store(in: &bag)
    }
    
    private func fetchPagesVersions() {
        Task {
            do {
                let versions = try await flaskService.fetchPagesVersions()
                
                let uniquePages = versions.map({ $0.pageName }).unique()
                
                DispatchQueue.main.async {
                    var containers_: [PageContainer] = []
                    
                    for page in uniquePages {
                        let versionsForSinglePage = versions.filter({ $0.pageName == page })
                        let container = PageContainer(pageName: page, versions: versionsForSinglePage)
                        containers_.append(container)
                    }
                    
                    self.pageContainers = containers_
                    
                    
                }
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
        }
    }
    
    func submit() {
        print(selectedPageVersions)
        guard let page = selectedPageContainer?.pageName else { return }
        
        let groups = selectedPageVersions
            .compactMap({ $0.code.last })
            .map { String($0) }
            .reduce("", +)
        
        self.fetchDataForTesting(page: page, groups: groups)
        
        self.submitToServer(page: page, groups: groups)
        
    }
    
    private func submitToServer(page: String, groups: String) {
        Task {
            guard let groups = Int(String(groups.reversed())) else {
                TargetifyError(message: "Couldn't decode groups. Internal Error.")
                    .handle()
                return
            }
            let requestModel = BFFAbTestingModel(title: title, groups: groups, page: page)
            
            do {
                try await flaskService.createABTesting(requestModel: requestModel)
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
                    pageTitle: title,
                    column: "clicks",
                    chartType: .line,
                    frequency: .M1,
                    showArea: false,
                    multipleGroups: true
                )
                
                let newModel = ABTestingModel(
                    title: title,
                    data: chartData,
                    configuraiton: configuration,
                    isLive: false
                )
                
                newModel.groups = groups
                
                DispatchQueue.main.async {
                    ABTestingScreenViewModel.subject.send(newModel)
                }
            } catch {
                TargetifyError(error: error)
                    .handle()
            }
            
        }
    }
}
