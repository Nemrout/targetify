//
//  ABTestingCardSummary.swift
//  Targetify
//
//  Created by Петрос Тепоян on 12/6/22.
//

import SwiftUI

struct ABTestingCardSummary: View {
    
    let pairs: [ABTestingPair]
    
    var body: some View {
        Group {
            if pairs.isEmpty {
                HStack {
                    SwiftUI.ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                    
                    Text("Computing statistics...")
                }
                .opacity(self.pairs.isEmpty ? 1 : 0)
                .animation(.easeIn, value: self.pairs.isEmpty)
            } else {
                VStack(alignment: .leading) {
                    
                    Text("Difference in average clicks")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 10) {
                        ForEach(pairs) { pair in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(pair.group1Description)
                                        .bold()
                                    
                                    Text("vs.")
                                    
                                    Text(pair.group2Description)
                                        .bold()
                                }
                                .padding(.bottom)
                                
                                HStack {
                                    Text("Effect size")
                                    
                                    Spacer()
                                    
                                    Text("\(pair.effectSize.format)")
                                }
                                
                                HStack {
                                    Text("Power size")
                                    
                                    Spacer()
                                    
                                    Text("\(pair.powerSize.format)")
                                }
                                
                                HStack {
                                    Text("Difference:")
                                    Text("\(pair.meanDifference.format)")
                                    
                                    Spacer()
                                    
                                    Group {
                                        if pair.reject {
                                            Text(pair.meanDifference < 0 ? pair.group1Description : pair.group2Description)
                                                .bold() +
                                            Text(" is better")
                                        } else {
                                            Text("No difference")
                                                .bold()
                                        }
                                        
                                    }
                                    .padding(.horizontal, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(pair.pValue < 0.05 ? Color.green : Color.red)
                                    )
                                }
                                
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ABTestingPair: Identifiable, Codable {
    
    let id: UUID = UUID()
    
    let group1Description: String
    
    let group2Description: String
    
    // Group2 - Group1
    let meanDifference: Double
    
    let pValue: Double
    
    let reject: Bool
    
    let effectSize: Double
    
    let powerSize: Double

}

struct TestingStatistic {
    
    var lower: Double
    
    var mean: Double
    
    var upper: Double
    
    mutating func divide(by: Double) {
        lower = lower / by
        mean = mean / by
        upper = upper / by
    }
    
    mutating func subtract(_ x: Double) {
        lower = lower - x
        mean = mean - x
        upper = upper - x
    }
    
    mutating func reverse() {
        let x = lower
        lower = upper
        upper = x
    }
}


extension Double {
    var format: String {
        String(format: "%.2f", self)
    }
}
