//
//  ArticleView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        if let articleURL = article.articleURL {
            Link(destination: articleURL) {
                VStack(alignment: .leading) {
                    VStack {
                        
                        HStack {
                            AsyncImage(url: article.imageURL, scale: 1.0) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                SwiftUI.ProgressView()
                            }
                            .frame(width: 120, alignment: .center)
                            .cornerRadius(15)
                            
                            Spacer()
                            
                            Text(article.title)
                                .font(.headline)
                                .truncationMode(.tail)
                                .lineLimit(3)
                        }
                        .frame(height: 80)
                        
                        Text(article.description)
                            .font(.subheadline)
                    }
                    .padding(8)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(Color.cyan, lineWidth: 2)
                )
            }
        }
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView()
//    }
//}
