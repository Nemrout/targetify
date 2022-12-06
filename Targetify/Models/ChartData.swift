//
//  ChartData.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/29/22.
//

import Foundation

struct ChartData: Decodable, Equatable {
    
    private enum ChartaDataCodingKeys: String, CodingKey {
        case page
        case chartType = "chart_type"
        case yName = "y_name"
        case xName = "x_name"
        case dataPoints = "data_points"
    }
    
    let page: String
    
    let yName: String
    
    let xName: String
    
    let dataPoints: [DataPoint]
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: ChartaDataCodingKeys.self)
        
        self.page = try container
            .decode(String.self, forKey: .page)
        
        self.yName = try container
            .decode(String.self, forKey: .yName)
        
        self.xName = try container
            .decode(String.self, forKey: .xName)
        
        self.dataPoints = try container
            .decode([DataPoint].self, forKey: .dataPoints)
            .filter({ $0.y != nil })
    }
    
    static func ==(lhs: ChartData, rhs: ChartData) -> Bool {
        lhs.page == rhs.page
    }
    
    var dataRange: ClosedRange<Float> {
        _dataRange()
    }
    
    private func _dataRange() -> ClosedRange<Float> {
        let points = dataPoints.compactMap { Float($0.yUnwrapped) }

        
        guard let min = points.min(),
              let max = points.max()
        else { return 0...0 }
        
        let padding = (max - min) / 10
        
        return ((min - padding)...(max + padding))
    }
    
}
