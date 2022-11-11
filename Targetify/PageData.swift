//
//  PageData.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import SwiftCSV
import Foundation

class PageData: NamedCSV {
    
    var name: String
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return formatter
    }()
    
    lazy var groups: [String] = {
        getColumn("groups")
    }()
    
    lazy var clicks: [Int] = {
        getColumn("groups")
            .compactMap { Int($0) }
    }()
    
    lazy var liftime: [Double] = {
        getColumn("lifetime")
            .compactMap { Double($0) }
    }()
    
    lazy var country: [String] = {
        getColumn("country")
    }()
    
    lazy var browser: [String] = {
        getColumn("browser")
    }()
    
    lazy var date: [Date] = {
        getColumn("groups")
            .compactMap { dateFormatter.date(from: $0) }
    }()
    
    private func getColumn(_ c: String) -> [String] {
        guard let columns = self.columns else { return [] }
        return columns[c] ?? []
    }
    
    init(name: String, data: Data) throws {
        guard let string = String(data: data, encoding: .utf8) else {
            throw CSVDecoder.DecodingError.curruptedData
        }
        
        self.name = name
        
        try super.init(string: string, delimiter: .comma)
    }
    
}
