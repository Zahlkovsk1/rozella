//
//  ArticleView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI
import FeedKit

struct ArticleView: View {
    
    let feed: RSSFeed
    
    @State private var articles: [Article] = []
    
    var body: some View {
        VStack {
            List(articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article)) {                    
                    Text(article.title)
                }
            }
            .navigationTitle(feed.title)
            .onAppear {
                fetchArticles(from: feed) { fetchedArticles in
                    articles = fetchedArticles
                }
            }
        }
    }
}

//#Preview {
//    ArticleView(feed: nil)
//}
