//
//  LineChartView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Charts
import SwiftUI

struct LineChartView: View {
    
    let data: [DataPoint]
    
    let title: String
    
    @State var touch: CGPoint?
    
    func dataRange() -> ClosedRange<CGFloat> {
        let points = data.compactMap { $0.value }
        
        guard let min = points.min(),
              let max = points.max()
        else { return 0...0 }
        
        return ((min - 10)...(max + 10))
        
    }
    
    let yValues = stride(from: 900, to: 1600, by: 200).map { $0 } // << here !!
    
    var body: some View {
        
        
//        .background(TargetifyColors.chartBackground)
//        .cornerRadius(20, antialiased: true)
        
        ZStack(alignment: .topLeading) {

            Chart(data) {

                LineMark(
                    x: .value("Month", $0.label),
                    y: .value("Hours of Sunshine", Float($0.value))
                )
                .foregroundStyle(by: .value("Group", $0.group ?? ""))
//                .annotation(position: .automatic, alignment: .center, spacing: 0) {
//                    Text("Annota")
//                        .position(x: touch?.x ?? 0, y: touch?.y ?? 0)
//                        .animation(.spring(), value: touch)
//                }
            }
            .chartLegend(position: .top, alignment: .topTrailing, spacing: 0)
            .chartYScale(domain: 900...1600)
//            .chartYScale(range: .plotDimension(padding: 20))
            .chartYAxis{
                AxisMarks(position: .leading, values: yValues)  // << here !!
            }
//            .chartYScale(range: .plotDimension(padding: 5))
            .chartOverlay { proxy in
                ZStack {
                    GeometryReader { geometry in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        self.touch = value.location
                                    }
                                    .onEnded { value in
                                        self.touch = value.location
                                        self.touch = nil
                                    }
                            )
                    }
                }

                Circle()
                    .fill(Color.red)
                    .opacity(touch == nil ? 0 : 1)
                    .position(x: (touch?.x ?? 0) - proxy.plotAreaSize.width / 2,
                              y: (touch?.y ?? 0) - proxy.plotAreaSize.height / 2)
                    .animation(.spring(), value: touch)
                    .frame(width: 15, height: 15, alignment: .center)
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

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(data: dataPoints, title: "Page views")
            .frame(width: 300, height: 230, alignment: .center)
//            .previewDevice(nil)
//            .previewLayout(.fixed(width: 300, height: 300))
    }
}

struct DataPoint: Identifiable {
    
    let id: UUID = UUID()
    
    let label: String
    
    let value: CGFloat
    
    let group: String?
}

let dataPoints: [DataPoint] = [
    .init(label: "Aug", value: 1140, group: "A"),
    .init(label: "Aug", value: 998, group: "B"),
    .init(label: "Sep", value: 1340, group: "A"),
    .init(label: "Sep", value: 1050, group: "B"),
    .init(label: "Oct", value: 1440, group: "A"),
    .init(label: "Oct", value: 1200, group: "B"),
    .init(label: "Nov", value: 1370, group: "A"),
    .init(label: "Nov", value: 1094, group: "B"),
    .init(label: "Dec", value: 1500, group: "A"),
    .init(label: "Dec", value: 1300, group: "B"),
]
