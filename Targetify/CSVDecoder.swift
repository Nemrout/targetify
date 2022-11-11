//
//  CSVDecoder.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation
import SwiftCSV

struct CSVDecoder {
    
    init() {
        
    }
    
    enum DecodingError: Error {
        case curruptedData
    }
    
    func decode(from data: Data) throws -> NamedCSV {
        guard let string = String(data: data, encoding: .utf8) else {
            throw DecodingError.curruptedData
        }
        
        let csv = try NamedCSV(string: string, delimiter: .comma)
        
        return csv
    }
}
