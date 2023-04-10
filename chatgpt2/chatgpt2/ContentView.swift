//
//  ContentView.swift
//  chatgpt2
//
//  Created by user232369 on 4/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var chattyViewModel = ChattyViewModel()
    @State var text1 = ""
    @State var text2 = ""
    @State var text3 = ""
    @State var messages = [String]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(messages, id: \.self) { string in
                Text(string)
            }
            
            //THIS IS HOW TO DISPLAY AN IMAGE
            //AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"))

            Spacer()
            VStack(alignment: .leading){
                HStack {
                    TextField("Start sentence...", text: $text1)
                    Button("Finish Sentence"){
                        send()
                    }
                }
                HStack{
                    TextField("Make a statement...", text: $text2)
                    Button("Find Sentiment"){
                        analyzeSentiment()
                    }
                }
                HStack{
                    TextField("Describe an image...", text: $text3)
                    Button("Build Image"){
                        makePhoto()
                    }
                }

                .padding()
                .task {
                    chattyViewModel.initialize()
                }
            }
        }
    }
        
        func send(){
            guard !text1.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            messages.append("Me: \n\(text1) \n")
            let textToSend = self.text1
            self.text1 = ""
            chattyViewModel.send(text1: textToSend) { response in
                DispatchQueue.main.async {
                    self.messages.append("ChatGPT: " + response + "\n")
                }
            }
        }
        
        func analyzeSentiment(){
            guard !text2.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            messages.append("Me: \n\(text2) \n")
            let textToAnalyze = self.text2
            self.text2 = ""
            chattyViewModel.analyzeSentiment(text2: textToAnalyze) { response in
                DispatchQueue.main.async {
                    self.messages.append("ChatGPT: " + response + "\n")
                }
            }
        }
    
        func makePhoto(){
            guard !text3.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            messages.append("Me: \n\(text3) \n")
            let textToAnalyze = self.text3
            self.text3 = ""
            chattyViewModel.makePhoto(text3: textToAnalyze) { response in
                DispatchQueue.main.async {
                    self.messages.append("ChatGPT: " + response + "\n")
                }
            }
        }

    }
    
