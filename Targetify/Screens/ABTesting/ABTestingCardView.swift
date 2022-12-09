//
//  ABTestingCardView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI

struct ABTestingCardView: View {
    
    @State var pairs: [ABTestingPair] = []
    
    let flaskService = FlaskService()
    
    func fetchPairs(page: String, groups: String) {
        Task {
            do {
                let pairs = try await flaskService.fetchPairs(page: page, groups: groups)
                DispatchQueue.main.async {
                    self.pairs = pairs
                }
            } catch {
                print(error)
                TargetifyError(error: error)
                    .handle()
            }
            
        }
    }
    
    let model: ABTestingModel
    
    var body: some View {
        VStack(spacing: 20) {
            GenericChart(configuration: model.configuraiton, chartData: model.data, configurable: false)
            
            ABTestingCardSummary(pairs: pairs)
        }
        .onAppear {
            model.configuraiton.multipleGroups = true
            if !model.groups.isEmpty {
                fetchPairs(page: model.data.page, groups: model.groups)
            }
        }
    }
}
