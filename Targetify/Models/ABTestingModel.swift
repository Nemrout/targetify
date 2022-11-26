//
//  ABTestingModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import Foundation

struct ABTestingModel: Identifiable {
    
    let id: UUID = UUID()
    
    let title: String
    
    let data: [[CGFloat]]
    
    var isLive: Bool
    
}
