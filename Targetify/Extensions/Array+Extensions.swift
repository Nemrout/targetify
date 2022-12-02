//
//  Array+Extensions.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import Foundation

extension Array where Element: Hashable {
    
    func unique() -> Self {
        let set = Set(self)
        return Array(set)
    }
    
}
