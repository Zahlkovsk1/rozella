import SwiftUI
import YouTubeKit

struct YoutubeSearchView: View {
    private var YTM = YouTubeModel()
    @State private var text: String = ""
    @State private var searchResults: [SearchResponse] = []

    var body: some View {
        
            VStack {
                TextField("Search", text: $text)

                Button {
                    Task {
                        do {
                            let searchResponse = try await SearchResponse.sendRequest(youtubeModel: YTM, data: [.query: text])
                            print(searchResponse)
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Search")
                }
                 
            }
        }
    }


#Preview {
    YoutubeSearchView()
}
