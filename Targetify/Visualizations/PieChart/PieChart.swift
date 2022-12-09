//
//  PieChart.swift
//  MyPieChart
//
//  Created by BLCKBIRDS on 07.06.21.
//

import SwiftUI

struct PieChart: View {

    var title: String
    var data: ChartData
    var separatorColor: Color = Color(UIColor.systemBackground)
    var accentColors: [Color] = pieColors

    @State private var currentValue = ""
    @State private var currentLabel = ""
    @State private var touchLocation: CGPoint = .init(x: -1, y: -1)

    var pieSlices: [PieSlice] {
        var slices = [PieSlice]()
        data.dataPoints.enumerated().forEach {(index, _) in
            let value = normalizedValue(index: index, data: self.data)
            if slices.isEmpty    {
                slices.append((.init(startDegree: 0, endDegree: value * 360)))
            } else {
                slices.append(.init(startDegree: slices.last!.endDegree, endDegree: (value * 360 + slices.last!.endDegree)))
            }
        }
        return slices
    }

    var body: some View {
        HStack {
            ZStack {
                GeometryReader { geometry in
                    ZStack  {
                        ForEach(0..<self.data.dataPoints.count){ i in
                            PieChartSlice(center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in:  .local).midY), radius: geometry.frame(in: .local).width/2, startDegree: pieSlices[i].startDegree, endDegree: pieSlices[i].endDegree, isTouched: sliceIsTouched(index: i, inPie: geometry.frame(in:  .local)), accentColor: getColor(for: i), separatorColor: separatorColor)
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ position in
                            let pieSize = geometry.frame(in: .local)
                            touchLocation   =   position.location
                            updateCurrentValue(inPie: pieSize)
                        })
                            .onEnded({ _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    resetValues()
                                }
                            })
                    )
                }
                .frame(height: chartHeight)
                VStack  {
                    if !currentLabel.isEmpty   {
                        Text(currentLabel)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.black)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                    }

                    if !currentValue.isEmpty {
                        Text("\(currentValue)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.black)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                    }
                }
                .padding()
            }

            VStack(alignment: .leading, spacing: 0)  {
                ForEach(0..<data.dataPoints.count)  {    i in
                    HStack {
                        Circle()
                            .fill(getColor(for: i))
                            .frame(width: 10, height: 10)

                        Text(data.dataPoints[i].label ?? "")
                            .font(.caption)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
    }


    func updateCurrentValue(inPie   pieSize:    CGRect)  {
        guard let angle = angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation)    else    {return}
        let currentIndex = pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) ?? -1
        
        if data.dataPoints.indices.contains(currentIndex), let label = data.dataPoints[currentIndex].label {
            currentLabel = label
        }
        
        currentValue = "\(data.dataPoints[currentIndex].y ?? 100)"
    }

    func resetValues() {
        currentValue = ""
        currentLabel = ""
        touchLocation = .init(x: -1, y: -1)
    }

    func sliceIsTouched(index: Int, inPie pieSize: CGRect) -> Bool {
        guard let angle =   angleAtTouchLocation(inPie: pieSize, touchLocation: touchLocation) else { return false }
        return pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) == index
    }
    
    func getColor(for index: Int) -> Color {
        let i = index % accentColors.count
        return accentColors[i]
    }

}
