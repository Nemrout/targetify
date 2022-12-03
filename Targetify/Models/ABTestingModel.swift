//
//  ABTestingModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import Foundation

struct ABTestingModel: Identifiable, Equatable {
    
    let id: UUID = UUID()
    
    let title: String
    
    let data: ChartData
    
    let configuraiton: ChartConfiguration
    
    var isLive: Bool
    
}

struct BFFAbTestingModel: Codable {
    
    let title: String
    
    // 01234
    let groups: Int
    
    let page: String
}
