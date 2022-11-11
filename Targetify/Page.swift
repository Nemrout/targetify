//
//  Page.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Foundation

struct Page: Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    
    var data: PageData
    
    init(name: String, data: PageData) {
        self.name = name
        self.data = data
    }
}
