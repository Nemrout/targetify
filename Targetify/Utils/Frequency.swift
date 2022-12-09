//
//  Frequency.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import Foundation

struct Frequency: Hashable, Identifiable {
    
    enum Period: String, CaseIterable {
        case hour = "H"
        case day = "D"
        case week = "W"
        case month = "M"
        
        var long: String {
            switch self {
            case .hour: return "Hour"
            case .day: return "Day"
            case .week: return "Week"
            case .month: return "Month"
            }
        }
        
        static var longListed: [String] {
            Period.allCases.map({ $0.long })
        }
    }
    
    var id: String {
        rawValue
    }
    
    let period: Period
    
    let count: Int
    
    var rawValue: String {
        "\(count)\(period.rawValue)"
    }
    
    var description: String {
        "\(count) \(period.long)"
    }
    
    init(_ period: Period, _ count: Int) {
        self.period = period
        self.count = count
    }
    
    static var H1: Frequency = Frequency(.hour, 1)
    
    static var D1: Frequency = Frequency(.day, 1)
    
    static var W1: Frequency = Frequency(.week, 1)
    
    static var W2: Frequency = Frequency(.week, 2)
    
    static var W3: Frequency = Frequency(.week, 3)
    
    static var M1: Frequency = Frequency(.month, 1)
    
    static var common: [Frequency] = [.W1, .W2, .W3, .M1]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
