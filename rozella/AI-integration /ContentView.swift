
import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var responseText: String = "Response will appear here"

    var body: some View {
        VStack {
            TextField("Type your prompt here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                Task {
                    await sendRequest()
                }
            }) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text(responseText)
                .padding()
            Spacer()
        }
        .padding()
    }

    func sendRequest() async {
        await sendToOpenAI(messageText: inputText) { response in
            DispatchQueue.main.async {
                self.responseText = response
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
            "model": "gpt-4o",
            "messages": [
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

// For preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
