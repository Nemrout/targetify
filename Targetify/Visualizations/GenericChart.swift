//
//  GenericChart.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import SwiftUI
import Foundation

struct GenericChart: View {
    
    let configuration: ChartConfiguration
    
    let chartData: ChartData?
    
    var body: some View {
        
        Group {
            
            if let chartData = chartData {
                
                switch configuration.chartType {
                case .line:
                    LineChartView(chartData: chartData, configuration: configuration)
                case .bar:
                    BarChartView(chartData: chartData, configuration: configuration)
                case .pie:
                    PieChartView(title: "Country", data: chartData, accentColors: pieColors)
                }
                
            } else {
                ZStack {
                    TargetifyColors.chartBackground
                        .background(TargetifyColors.chartBackground)
                        .cornerRadius(20)
                    
                    HStack {
                        SwiftUI.ProgressView()
                            .padding()
                        
                        Text("Loading data...")
                            .foregroundColor(.secondary)
                    }
                    
                }
            }
        }
        .animation(.spring(), value: chartData)
        .aspectRatio(332/174, contentMode: .fit)
        
    }
}
