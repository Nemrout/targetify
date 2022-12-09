//
//  PieChartView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 10/3/22.
//

import Charts
import SwiftUI

struct PieChartView: View {
    
    var title: String
    var data: ChartData
    var separatorColor: Color = Color(UIColor.systemBackground)
    var accentColors: [Color] = pieColors
    
    var body: some View {
        PieChart(
            title: title,
            data: data,
            separatorColor: separatorColor,
            accentColors: accentColors)
        .frame(maxWidth: .infinity)
        .frame(height: chartHeight)
        
    }
}
