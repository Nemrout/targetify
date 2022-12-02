//
//  NewsPiece.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation

struct Article: Decodable, Identifiable {
    
    private enum ArticleCodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    struct Source: Decodable {
        
        let name: String
        
    }
    
    var id: UUID = UUID()
    
    let source: Source
    
    let author: String?
    
    let title: String
    
    let description: String
    
    let url: String
    
    let urlToImage: String?
    
    let publishedAt: String
    
    let content: String
    
    var articleURL: URL? {
        URL(string: url)
    }
    
    var imageURL: URL? {
        URL(string: urlToImage ?? "")
    }
    
    var publishedAtDate: Date {
        .now
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: ArticleCodingKeys.self)
        
        self.source = try container
            .decode(Article.Source.self, forKey: .source)
        
        self.author = try container
            .decodeIfPresent(String.self, forKey: .author)
        
        self.title = try container
            .decode(String.self, forKey: .title)
        
        self.description = try container
            .decode(String.self, forKey: .description)
        
        self.url = try container
            .decode(String.self, forKey: .url)
        
        self.urlToImage = try container
            .decodeIfPresent(String.self, forKey: .urlToImage)
        
        self.publishedAt = try container
            .decode(String.self, forKey: .publishedAt)
        
        self.content = try container
            .decode(String.self, forKey: .content)
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
