//
//  GenericChart.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import SwiftUI
import Foundation

struct GenericChart: View {
    
    @ObservedObject var configuration: ChartConfiguration
    
    let chartData: ChartData?
    
    @State private var isConfiguring: Bool = false
    
    var body: some View {
        
        Group {
            
            if let chartData = chartData {
                
                ZStack {
                    
                    if !isConfiguring {
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
                            
                            FrequencyPicker(frequency: $configuration.frequency)
                                .frame(maxWidth: .infinity)
                            
                        }
                        
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: { isConfiguring.toggle() }, label: { Text("Config") })
                        .buttonStyle(.borderedProminent)
                        .padding()
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
