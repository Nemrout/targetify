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
//                    .foregroundStyle(by: .value("Group", $0.group ?? ""))
                .foregroundStyle(TargetifyColors.primary)
        }
        .padding()
//        .background(TargetifyColors.chartBackground)
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
