
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
            VStack(alignment: .leading) {
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
        case "h2":
            content
                .bold()
        default:
            content
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
