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
    
    let configurable: Bool
    
    @State private var isConfiguring: Bool = false
    
    var body: some View {
        
        Group {
            
            VStack {
                
                HStack {
                    HStack {
                        Text(configuration.pageTitle)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    if configurable && configuration.chartType != .pie {
                        FrequencyPicker(frequency: $configuration.frequency)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 44)
                
                Group {
                    if let chartData = chartData {
                        
                        ZStack {
                            
                            switch configuration.chartType {
                            case .line:
                                LineChartView(chartData: chartData, configuration: configuration)
                            case .bar:
                                BarChartView(chartData: chartData, configuration: configuration)
                            case .pie:
                                PieChartView(title: "Country", data: chartData, accentColors: pieColors)
                            }
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
                .frame(height: chartHeight)
            }
        }
        .animation(.spring(), value: chartData)
        
    }
}

public let chartHeight: CGFloat = 224
