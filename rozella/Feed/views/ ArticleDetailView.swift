//
//   ArticleDetailView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//
import SwiftUI
import WebKit
import SwiftSoup
import OSLog


struct ArticleDetailView: View {
    let article: Article

    @State private var scrapedContent: String = "Loading..."
    @State private var isLoading: Bool = true

    var body: some View {
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    Text(article.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    
                    Text(scrapedContent)
                        .lineSpacing(2)
                }
                .padding()
            }
        
        .navigationBarTitleDisplayMode(.automatic)
        .task(priority: .high) {
            do {
                if let document = article.document {
                    scrapedContent = try document.text()
                }
            } catch {
                Logger.parser.error("\(String(describing: error))")
            }
        }
    }

}

//#Preview {
//    ArticleDetailView(article:)
//}
