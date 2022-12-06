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
//                    withAnimation(.easeIn) {
                        self.pairs = pairs
//                    }
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
            
            Group {
                if !pairs.isEmpty {
                    ABTestingCardSummary(pairs: pairs)
                        .opacity(self.pairs.isEmpty ? 0 : 1)
                        .animation(.easeIn, value: self.pairs.isEmpty)
                } else {
                    HStack {
                        SwiftUI.ProgressView()
                            .progressViewStyle(.circular)
                            .padding()
                        
                        Text("Computing statistics...")
                    }
                    .opacity(self.pairs.isEmpty ? 1 : 0)
                    .animation(.easeIn, value: self.pairs.isEmpty)
                }
            }

        }
        .onAppear {
//            model.data.page
//            model.data.dataPoints.map { $0.group }
            model.configuraiton.multipleGroups = true
            fetchPairs(page: model.data.page, groups: model.groups)
        }
    }
}

//struct ABTestingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ABTestingCardView()
//    }
//}
