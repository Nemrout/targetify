//
//  NewsScreenViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Combine
import Foundation

final class NewsScreenViewModel: ObservableObject {
    
    private let newsService: NewsService = NewsService()
    
    @Published var articles: [Article] = []
    
    @Published var progress: Int = 0
    
    @Published var finishedDownloadingNews: Bool = false
    
    var bag: Set<AnyCancellable> = .init()
    
    var page: Int = 0

    private var articlesLoaded: [Article] = []
    
    init() {
        
        Task {
            let articles = try await newsService.fetchNews()
            
            DispatchQueue.main.async {
                self.articlesLoaded = articles
                self.loadArticles()
            }
        }
        
        newsService.progressPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] progress in
                self?.progress = progress
                if progress == 100 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self?.finishedDownloadingNews = true
                    }
                }
            })
            .store(in: &bag)
    }
    
    func loadArticles() {
        self.articles = Array(articlesLoaded.prefix(upTo: 20 * (page + 1)))
        self.page += 1
    }
}
