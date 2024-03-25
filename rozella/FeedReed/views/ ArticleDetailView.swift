//
//   ArticleDetailView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title).font(.headline)
            Text(article.description ?? "").font(.subheadline)
            // We'll add the scraped content here later!
        }
        .navigationTitle(article.title) // Optional: Set title for detail view
    }
}

//#Preview {
//    ArticleDetailView()
//}
