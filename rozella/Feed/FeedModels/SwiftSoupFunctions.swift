
import SwiftUI
import SwiftSoup
import OSLog

    @ViewBuilder
    func renderDocument(_ document: Document?) -> some View {
        if let body = document?.body() {
        renderTag(body)
        } else {
            EmptyView()
        }
    }



    
    func renderTag(_ element: Elements.Element) -> some View {
    
        var elementText: String?
    
        let childrenCount: Int = element.children().count
    
        if childrenCount == 0 {
        
            do {
                elementText = try element.text()
            } catch {
            Logger.view.error("Could not parse this element text.")
            }
        
            return if let text = elementText {
                AnyView (
                    Text(text)
                        .style(element.tagName())
                )
            } else {
                AnyView(
                    EmptyView()
                )
            }
        
        } else {
        
            return AnyView (
                ForEach(element.children(), id: \.self) { child in
                    renderTag(child)
                }
            )
        
        }
    }
