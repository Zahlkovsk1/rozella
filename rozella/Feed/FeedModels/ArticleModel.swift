
import SwiftUI
import FeedKit
import SwiftSoup
import OSLog

struct Article: Identifiable {
    
    let id = UUID()
    let link: URL
    var title: String
    var description: String
    var document: Document? = nil
    var image: RSSFeedImage? = nil
    
    init(
        link: URL,
        title: String? = nil,
        description: String? = nil,
        contentEncoded: String? = nil,
        image: RSSFeedImage? = nil
    ) {
        self.link = link
        self.title = title ?? "Untitled"
        self.description = description ?? ""
        self.image = image
        
        if let contentEncoded = contentEncoded {
            do {
                self.document = try Parser.parse(contentEncoded, link.absoluteString)
            } catch {
                Logger.parser.error("\(String(describing: error))")
            }
        }
    }
    
}
