////
////  ChaView.swift
////  rozella
////
////  Created by SHOHJAHON on 16/05/24.
////
//import SwiftUI
//import SwiftyGPTChat
//
//struct ChatView: View {
//    @State private var messages: [any SwiftyGPTChatMessage] = []
//    @State private var userInput: String = ""
//    
//    // Create a SwiftyGPTChatManager instance
//    let manager = SwiftyGPTChatManager(service: SwiftyGPTChatNetworkingService(apiKey: "YOUR_API_KEY"))
//    
//    var body: some View {
//        VStack {
//            // Display chat messages
//            ScrollView {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(messages, id: \.id) { message in
//                        Text(message.text)
//                            .padding(8)
//                            .background(message.sender == .user ? Color.blue : Color.gray)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//            }
//            
//            // Input field for user to type messages
//            HStack {
//                TextField("Type your message...", text: $userInput)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                Button("Send") {
//                    sendMessage()
//                }
//            }
//            .padding()
//        }
//        .navigationBarTitle("Chat")
//    }
//    
//    // Function to send user message and receive response
//    func sendMessage() {
//        guard !userInput.isEmpty else { return }
//        
//        // Create user message
//        let userMessage = SwiftyGPTChatUserMessage(content: userInput)
//        messages.append(userMessage)
//        
//        // Send user message and receive response
//        Task {
//            do {
//                let response = try await manager.send(messages: messages, model: .gpt3_5_turbo, frequencyPenalty: 0.5)
//                if let receivedMessage = response.choices.first?.message {
//                    messages.append(receivedMessage)
//                } else {
//                    print("Oops, there are no available choices!")
//                }
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//        
//        // Clear user input
//        userInput = ""
//    }
//}
//
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
