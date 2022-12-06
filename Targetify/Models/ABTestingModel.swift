//
//  ABTestingModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import Foundation

final class ABTestingModel: Identifiable, Equatable {
    
    let id: UUID = UUID()
    
    let title: String
    
    let data: ChartData
    
    let configuraiton: ChartConfiguration
    
    var isLive: Bool

    var groups: String = ""
    
    init(title: String, data: ChartData, configuraiton: ChartConfiguration, isLive: Bool) {
        self.title = title
        self.data = data
        self.configuraiton = configuraiton
        self.isLive = isLive
    }
    
    static func == (lhs: ABTestingModel, rhs: ABTestingModel) -> Bool {
        lhs.id == rhs.id
    }
}

struct BFFAbTestingModel: Codable {
    
    let title: String
    
    // 01234
    let groups: Int
    
    let page: String
}
