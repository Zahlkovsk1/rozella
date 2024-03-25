import SwiftUI
import YouTubeKit

struct YoutubeSearchView: View {
    private var YTM = YouTubeModel()
    @State private var text: String = ""
    @State private var searchResults: [SearchResponse] = []
    @State private var searchResponse: SearchResponse?
    
    var body: some View {
        
        VStack {
            
            if let validSearchResults = searchResponse?.results{
                ForEach(validSearchResults.indices, id: \.self){ index in
                    if let channel = validSearchResults[index] as? YTChannel{
                        HStack{
                            Text(channel.name ?? "N/A")
                            
                            Text(channel.subscriberCount ?? "N/A")
                            
                            Text("https://www.youtube.com/channel/\(channel.channelId)")
                            
                        }
                        //                            .onAppear(){
                        //                                print("https://www.youtube.com/channel/\(channel.channelId)")
                        //                            }
                        .onAppear(){
                            dump(channel.channelId)
                            
                            let channelId: String = channel.channelId
                            
                            Task {
                                do {
                                    let searchResponse = try await ChannelInfosResponse.sendRequest(youtubeModel: YTM, data: [.browseId: channelId])
                                    
                                    dump(searchResponse)
                                    
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                    
                }
                
                
                TextField("Search", text: $text)
                
                Button {
                    Task {
                        do {
                            searchResponse = try await SearchResponse.sendRequest(youtubeModel: YTM, data: [.query: text])
                            
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
}

#Preview {
    YoutubeSearchView()
}
