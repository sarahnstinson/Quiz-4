//
//  ChattyViewModel.swift
//  chatgpt2
//
//  Created by user232369 on 4/8/23.
//

import Foundation
//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
import OpenAISwift
import SwiftUI

final class ChattyViewModel: ObservableObject {
    
    init(){
        
    }
    
    private var client: OpenAISwift?
    
    func initialize(){
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text1: String, completion: @escaping (String) -> Void ) {
        let prompt1 = "Please finish the following sentence: "
        let inputText = prompt1 + text1
        client?.sendCompletion(with: inputText, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let success):
                let output = success.choices?.first?.text ?? ""
                completion(output)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func analyzeSentiment(text2: String, completion: @escaping (String) -> Void ) {
        let prompt2 = "Please tell me the sentiment of the following statement: "
        let inputText = prompt2 + text2
        client?.sendCompletion(with: inputText, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let success):
                let output = success.choices?.first?.text ?? ""
                completion(output)
            case .failure(let failure):
                print(failure.localizedDescription)
                
            }
        })
    }
    
    func makePhoto(text3: String, completion: @escaping (String) -> Void ) {
        let prompt3 = "Enhance the following string for a generative AI image prompt: "
        let inputText = prompt3 + text3
        client?.sendCompletion(with: inputText, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let success):
                print(success.data?.first?.text ?? "")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }

    //func makePhoto(text3: String, completion: @escaping (String) -> Void ) {
        //let prompt3 = "Enhance the following string for a generative AI image prompt: "
        //let inputText = prompt3 + text3
        //client?.sendImages(with: inputText, numImages: 1, size: .size1024) { result in
            //switch result {
            //case .success(let success):
                //print(success.data?.first?.url ?? "")
            //case .failure(let failure):
                //print(failure.localizedDescription)
            //}
        //}
    //}

}
                               
