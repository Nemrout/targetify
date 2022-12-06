//
//  ABTestingCardSummary.swift
//  Targetify
//
//  Created by Петрос Тепоян on 12/6/22.
//

import SwiftUI

struct ABTestingCardSummary: View {
    
    let pairs: [ABTestingPair]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Difference in average clicks")
                .font(.title2)
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                ForEach(pairs) { pair in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(pair.group1Description)
                                .bold()
                            
                            Text("vs.")
                            
                            Text(pair.group2Description)
                                .bold()
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Effect size")
                            
                            Spacer()
                            
                            Text("\(pair.effectSize.format)")
                        }
                        
                        HStack {
                            Text("Power size")
                            
                            Spacer()
                            
                            Text("\(pair.powerSize.format)")
                        }
                        
                        HStack {
                            Text("Difference:")
                            Text("\(pair.meanDifference.format)")
                            
                            Spacer()
                            
                            Group {
                                if pair.reject {
                                    Text(pair.meanDifference < 0 ? pair.group1Description : pair.group2Description)
                                        .bold() +
                                    Text(" is better")
                                } else {
                                    Text("No difference")
                                        .bold()
                                }
                                
                            }
                            .padding(.horizontal, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(pair.pValue < 0.05 ? Color.green : Color.red)
                            )
                        }
                        
                        Divider()
                    }
                }
            }
        }
    }
}

//struct ABTestingCardSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ABTestingCardSummary()
//            .previewLayout(SwiftUI.PreviewLayout.fixed(width: 280, height: 240))
//            .previewDevice(nil)
//            .padding()
//    }
//}

struct ABTestingPair: Identifiable, Codable {
    
    let id: UUID = UUID()
    
    let group1Description: String
    
    let group2Description: String
    
    // Group2 - Group1
    let meanDifference: Double
    
    let pValue: Double
    
    let reject: Bool
    
    let effectSize: Double
    
    let powerSize: Double

}

//let pair = ABTestingPair(
//    group1: "0",
//    group1Description: "original",
//    group2: "1",
//    group2Description: "another",
//    meanDifference: -11.32,
//    lower: -10.9,
//    upper: -7.7,
//    pValue: 0.001,
//    reject: true
//)
//
//
//let pair1 = ABTestingPair(
//    group1: "0",
//    group1Description: "original",
//    group2: "1",
//    group2Description: "another",
//    meanDifference: 9.32,
//    lower: 7.7,
//    upper: 10.9,
//    pValue: 0.001,
//    reject: true
//)

struct TestingStatistic {
    
    var lower: Double
    
    var mean: Double
    
    var upper: Double
    
    mutating func divide(by: Double) {
        lower = lower / by
        mean = mean / by
        upper = upper / by
    }
    
    mutating func subtract(_ x: Double) {
        lower = lower - x
        mean = mean - x
        upper = upper - x
    }
    
    mutating func reverse() {
        let x = lower
        lower = upper
        upper = x
    }
}

/*
var body: some View {
    VStack {
        ZStack {
            GeometryReader { geometry in
                
                let width = geometry.size.width
                
                let startX = pair.normalize().lower * width
                let endX = pair.normalize().upper * width
                let meanX = pair.normalize().mean * width
                
                VStack {
                    GeometryReader { geometry2 in
                        
                        let centerY = geometry2.size.height / 2
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 2.5)
                                .fill(Color.black)
                                .frame(height: 5)
                            
                            RoundedRectangle(cornerRadius: 2.5)
                                .fill(Color.red)
                                .frame(width: 5, height: 14)
                                .position(x: startX, y: centerY)
                            
                            RoundedRectangle(cornerRadius: 2.5)
                                .fill(Color.red)
                                .frame(width: 5, height: 14)
                                .position(x: endX, y: centerY)
                        }
                        
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 14)
                                .position(x: meanX, y: centerY)
                        }
                    }
                    
                    
                    GeometryReader { geometry3 in
                        
                        let centerY = geometry3.size.height / 2
                        
                        ZStack {
                            Text("\(pair.lower.formatted(.number))")
                                .position(x: startX, y: centerY)
                            
                            Text("\(pair.upper.formatted(.number))")
                                .position(x: endX, y: centerY)
                            
                            Text("\(pair.meanDifference.formatted(.number))")
                                .position(x: meanX, y: centerY)
                        }
                    }
                }
            }
            .frame(height: 44)
        }
        
//            Text(String("\(pair.normalize().lower)"))
//            Text(String("\(pair.normalize().mean)"))
//            Text(String("\(pair.normalize().upper)"))
    }
}

*/

extension Double {
    var format: String {
        String(format: "%.2f", self)
    }
}
