//
//  DataPoint.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/29/22.
//

import Foundation

struct DataPoint: Decodable, Identifiable {

    let id: UUID = UUID()
    
    let x: CGFloat?
    
    let y: CGFloat?
    
    var yUnwrapped: CGFloat {
        y!
    }
    
    let label: String?
    
    let group: String?
    
    var date: Date? {
        
//        guard let label = label else { return nil }
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        return formatter.date(from: label)
        
        guard let seconds = x else { return nil }
        let date = Date(timeIntervalSince1970: seconds)
        print(date, seconds)
        return date
    }
    
    var month: String? {
        guard let date = date else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
    
    var week: Int? {
        guard let date = date else { return nil }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: date)
        return components.weekOfYear
    }
}
