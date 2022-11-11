//
//  LineChartView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Charts
import SwiftUI

struct LineChartView: View {
    
    let page: Page
    
    var body: some View {
        GroupBox {
            Chart {
                ForEach(0..<page.data.clicks.count, id: \.self) { i in
                    LineMark(
                        x: .value("count", i),
                        y: .value("clicks", page.data.clicks[i])
                    )
                }
            }
        }
    }
}

//struct LineChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        LineChartView()
//    }
//}
