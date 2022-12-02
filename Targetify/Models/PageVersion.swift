//
//  PageVersion.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/30/22.
//

import Foundation

class PageVersion: Decodable, Identifiable, Equatable, ObservableObject {
    
    private enum PageVersionCodingKeys: String, CodingKey {
        case pageName = "page_name"
        case description
        case code
    }
    
    var id: UUID = UUID()
    
    let pageName: String
    
    let code: String
    
    let description: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: PageVersionCodingKeys.self)
        
        self.pageName = try container
            .decode(String.self, forKey: .pageName)
        
        self.description = try container
            .decode(String.self, forKey: .description)
        
        self.code = try container
            .decode(String.self, forKey: .code)
    }
    
    static func == (lhs: PageVersion, rhs: PageVersion) -> Bool {
        lhs.id == rhs.id
    }
}

struct PageContainer: Identifiable {
    
    var id: UUID = UUID()
    
    let pageName: String
    
    let versions: [PageVersion]
}
