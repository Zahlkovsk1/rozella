
import SwiftUI
import FeedKit

struct ArticleView: View {
    let feed: RSSFeed
    @State private var articles: [Article] = []
    @State private var selectedArticle: Article? = nil
    @State private var showSummarySheet: Bool = false
    @State private var summary: String = "Summary will appear here"
    @State private var isSummarizing: Bool = false

    var body: some View {
        NavigationStack {
            List(articles) { article in
                HStack {
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        Text(article.title)
                    }
                    Spacer()
                    Menu {
                        Button(action: {
                            selectedArticle = article
                            Task {
                                isSummarizing = true
                                await getSummary(for: article)
                                isSummarizing = false
                                showSummarySheet = true
                            }
                        }) {
                            Text("Get Summary")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .padding()
                    }
                }
            }
            .navigationTitle(feed.title )
            .onAppear {
                fetchArticles(from: feed) { fetchedArticles in
                    articles = fetchedArticles
                }
            }
            .sheet(isPresented: $showSummarySheet) {
                if selectedArticle != nil {
                    SummaryView(summary: summary)
                }
            }
        }
    }

    func getSummary(for article: Article) async {
        guard let document = article.document else { return }
        let scrapedContent = (try? document.text()) ?? ""
        guard !scrapedContent.isEmpty else { return }
        await sendToOpenAI(messageText: scrapedContent) { response in
            DispatchQueue.main.async {
                self.summary = response
            }
        }
    }

    func sendToOpenAI(messageText: String, completion: @escaping (String) -> Void) async {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OpenAI_API_Key") as? String else {
            print("Error: Could not find OpenAI API key in Info.plist")
            return
        }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "system", "content": "Summarize the following article content."],
                ["role": "user", "content": messageText]
            ],
            "max_tokens": 300
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Unexpected response code \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }

            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let choices = jsonResponse?["choices"] as? [[String: Any]],
                  let firstChoice = choices.first,
                  let message = firstChoice["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                print("Error parsing OpenAI API response")
                return
            }

            completion(content)
        } catch {
            print("Error creating JSON body for OpenAI API request:", error)
        }
    }
}



