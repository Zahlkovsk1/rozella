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
                        .padding(.bottom, 5)
    
                    renderDocument(article.document)
                    
                    
                }
                .padding()
            }
        
        .navigationBarTitleDisplayMode(.automatic)
        .task(priority: .high) {
            do {
                if let document = article.document {
                    scrapedContent = try document.text()
//                    let headSection = try document.head() // <head> tags
                    let body = try document.body() // <body> tags
//                               let pageTitle = try document.title() // <title> tag
//                               print(bodySection)
//                               print(pageTitle)
                }
            } catch {
                Logger.parser.error("\(String(describing: error))")
            }
        }
    }
    

    


}




struct TagStyle: ViewModifier {
    
    var tag: String
    
    func body(content: Content) -> some View {
        switch tag {
            case "h1":
                content
                .font(.largeTitle)
            default:
                content
                .foregroundColor(.red)
        }
    }
    
}

extension View {
    
    func style(_ tag: String) -> some View {
        modifier(TagStyle(tag: tag))
    }
    
}

//#Preview {
//    ArticleDetailView(article:)
//}
