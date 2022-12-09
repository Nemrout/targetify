//
//  LineChartView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Charts
import SwiftUI

struct BarChartView: View {
    
    let chartData: ChartData
    
    let configuration: ChartConfiguration
    
    var title: String {
        configuration.pageTitle
    }
    
    var body: some View {
        
        Chart(chartData.dataPoints) {
                 
            BarMark(
                x: .value("", $0.label ?? ""),
                y: .value("", Float($0.yUnwrapped))
            )
            .foregroundStyle(TargetifyColors.primary)
        }
    }
}

