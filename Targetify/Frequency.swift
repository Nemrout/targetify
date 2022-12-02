//
//  Frequency.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import Foundation

struct Frequency {
    
    enum Period: String {
        case hour = "H"
        case day = "D"
        case week = "W"
        case month = "M"
    }
    
    let period: Period
    
    let count: Int
    
    var rawValue: String {
        "\(count)\(period.rawValue)"
    }
    
    init(_ period: Period, _ count: Int) {
        self.period = period
        self.count = count
    }
    
    static var H1: Frequency = Frequency(.hour, 1)
    
    static var M1: Frequency = Frequency(.month, 1)
}
