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
    
    func dataRange() -> ClosedRange<Float> {
        let points = chartData.dataPoints.compactMap { Float($0.y) }

        
        guard let min = points.min(),
              let max = points.max()
        else { return 0...0 }
        
        let padding = (max - min) / 10
        
        return ((min - padding)...(max + padding))
    }
    
    var xValues: [String] {
        switch configuration.frequency.period {
        case .month:
            return chartData.dataPoints.compactMap { $0.label }
        default:
            return []
        }
        
    }
    
    let yValues = stride(from: 11, to: 16, by: 0.5).map { $0 } // << here !!
    
    var body: some View {
        
        let curGradient = LinearGradient(
                gradient: Gradient (
                    colors: [
                        TargetifyColors.primary,
                        TargetifyColors.primary.opacity(0.05),
                        TargetifyColors.primary.opacity(0.05),
                        TargetifyColors.primary.opacity(0.05)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        ZStack(alignment: .topLeading) {

            Chart(chartData.dataPoints) {
                        
                LineMark(
                    x: .value("", $0.label ?? ""),
                    y: .value("", Float($0.y))
                )
                .foregroundStyle(by: .value("Group", $0.group ?? ""))
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(TargetifyColors.primary)
                
                if configuration.showArea {
                    AreaMark(
                        x: .value("", $0.label ?? ""),
                        y: .value("", Float($0.y))
                    )
                    .clipShape(Rectangle())
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(curGradient)
                }
            }
            .chartYScale(domain: dataRange())
            .chartXAxis {
                AxisMarks(values: chartData.dataPoints.compactMap { $0.label })
            }
            .padding()
            
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(10)
                .fontWeight(.semibold)
        }
        .background(TargetifyColors.chartBackground)
        .cornerRadius(20)
    }
}

//struct LineChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        LineChartView(data: dataPoints, title: "Page views")
//            .frame(width: 300, height: 230, alignment: .center)
////            .previewDevice(nil)
////            .previewLayout(.fixed(width: 300, height: 300))
//    }
//}
