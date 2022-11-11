//
//  NewsPiece.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation

struct Article: Decodable, Identifiable {
    
    struct Source: Decodable {
        
        let id: String?
        
        let name: String
        
    }
    
    let id: UUID = UUID()
    
    let source: Source
    
    let author: String?
    
    let title: String
    
    let description: String
    
    let url: String
    
    let urlToImage: String
    
    let publishedAt: String
    
    let content: String
    
    var articleURL: URL? {
        URL(string: url)
    }
    
    var imageURL: URL? {
        URL(string: urlToImage)
    }
    
    var publishedAtDate: Date {
        .now
    }
    
    
}

struct NewsRequestError: Decodable {
    
    let status: String
    
    let code: String
    
    let message: String
}

struct NewsRequestResponse: Decodable {
    
    let status: String
    
    let totalResults: Int
    
    let articles: [Article]
}
