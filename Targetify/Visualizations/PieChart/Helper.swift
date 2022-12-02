//
//  Helper.swift
//  MyPieChart
//
//  Created by BLCKBIRDS on 07.06.21.
//

import Foundation
import SwiftUI

let pieColors = [
     Color.init(hex: "#2f4b7c")!,
     Color.init(hex: "#003f5c")!,
     Color.init(hex: "#665191")!,
     Color.init(hex: "#a05195")!,
     Color.init(hex: "#d45087")!,
     Color.init(hex: "#f95d6a")!,
     Color.init(hex: "#ff7c43")!,
     Color.init(hex: "#ffa600")!
 ]

func normalizedValue(index: Int, data: ChartData) -> Double {
    
    var values = data.dataPoints.map { $0.y }
    let point = values[index]
    let total = values.reduce(0, +)
    let fraction = point / total
    
    return fraction
}

struct PieSlice {
     var startDegree: Double
     var endDegree: Double
 }


func angleAtTouchLocation(inPie pieSize: CGRect, touchLocation: CGPoint) ->  Double?  {
     let dx = touchLocation.x - pieSize.midX
     let dy = touchLocation.y - pieSize.midY
     
     let distanceToCenter = (dx * dx + dy * dy).squareRoot()
     let radius = pieSize.width/2
     guard distanceToCenter <= radius else {
         return nil
     }
     let angleAtTouchLocation = Double(atan2(dy, dx) * (180 / .pi))
     if angleAtTouchLocation < 0 {
         return (180 + angleAtTouchLocation) + 180
     } else {
         return angleAtTouchLocation
     }
 }
