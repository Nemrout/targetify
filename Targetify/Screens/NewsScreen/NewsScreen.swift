//
//  NewsScreen.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI

struct NewsScreen: View {
    
    @StateObject var viewModel: NewsScreenViewModel = NewsScreenViewModel()
    
    var body: some View {
        
        VStack {
            ScrollView {
                
                if !viewModel.finishedDownloadingNews {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: geo.size.width)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: geo.size.width * CGFloat(viewModel.progress) / 100, alignment: .leading)
                                .cornerRadius(5)
                        }
                        .animation(.spring(), value: viewModel.progress)
                    }
                    .frame(height: 10)
                    .padding(.horizontal, 10)
                    .transition(.move(edge: .top).animation(.spring()))
                    .animation(.spring(), value: viewModel.finishedDownloadingNews)
                }
                
                LazyVStack {
                    ForEach(viewModel.articles) { article in
                        ArticleView(article: article)
                            .transition(.opacity.combined(with: .move(edge: .bottom)).animation(.spring()))
                    }
                    
                    ButtonRounded(text: "Load more articles") {
                        viewModel.loadArticles()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Marketing news")
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
