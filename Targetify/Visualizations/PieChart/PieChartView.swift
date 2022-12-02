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
        ZStack {
         
            PieChart(
                title: title,
                data: data,
                separatorColor: separatorColor,
                accentColors: accentColors)
            .padding(15)
            
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .fontWeight(.semibold)
                .padding(10)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(TargetifyColors.chartBackground)
        )
        .aspectRatio(332/174, contentMode: .fit)
        
    }
}
