//
//  LineChartView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Charts
import SwiftUI

struct LineChartView: View {
    
    let chartData: ChartData
    
    let configuration: ChartConfiguration
    
    var title: String {
        configuration.pageTitle
    }
    
    var xValues: [String] {
        switch configuration.frequency.period {
        case .month:
            return chartData.dataPoints.compactMap { $0.label }
        default:
            
            let len = chartData.dataPoints.count
            let step = len / 10
            
            let sequence = Set(stride(from: 0, through: len, by: step))
            let labels = chartData.dataPoints
                .enumerated()
                .filter({ sequence.contains($0.offset) })
                .compactMap({ $0.element.label })
            return labels
        }
        
    }
    
    var body: some View {
        
        let curGradient = LinearGradient(
                gradient: Gradient (
                    colors: [
                        TargetifyColors.primary,
                        TargetifyColors.primary.opacity(0.05)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        Chart(chartData.dataPoints) {
            
            if configuration.multipleGroups {
                
                LineMark(x: .value("Date", $0.date ?? .now, unit: .month),
                         y: .value("", Float($0.yUnwrapped)))
                .foregroundStyle(by: .value("Group", $0.group ?? ""))
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .interpolationMethod(.catmullRom)
            } else {
                LineMark(
                    x: .value("", $0.label ?? ""),
                    y: .value("", Float($0.yUnwrapped))
                )
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(TargetifyColors.primary)
            }
            
            
            if configuration.showArea {
                AreaMark(
                    x: .value("", $0.label ?? ""),
                    yStart: .value("", chartData.dataRange.lowerBound),
                    yEnd: .value("", Float($0.yUnwrapped))
                )
                .clipShape(Rectangle())
                .interpolationMethod(.catmullRom)
                .foregroundStyle(curGradient)
            }
        }
        .chartYScale(domain: chartData.dataRange)
        .chartXAxis {
            AxisMarks(values: xValues)
        }
    }
}
