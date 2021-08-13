//
//  JSONDataModel.swift
//  Impindurado
//
//  Created by Ronaldo Gomes on 11/08/21.
//

import Foundation

protocol JSONModel {
    func getRandomWord() -> Word
}

class JSONDataModel: JSONModel {
    private lazy var words: [Word] = readAllWords()
    
    internal func readAllWords(for jsonFile: String = "jsonFile") -> [Word] {
        let pathUrl = Bundle.main.url(forResource: jsonFile, withExtension: "json")!
        let jsonData = try? Data(contentsOf: pathUrl)
        guard let data = jsonData else {
            fatalError("Json could not be read")
        }
        
        let words: [Word]
        do {
            words = try JSONDecoder().decode([Word].self, from: data)
        } catch {
            fatalError("Json could not parsed")
        }
        return words
    }
    
    func getRandomWord() -> Word {
        guard let randomWord = words.randomElement() else {
            fatalError("Words is empty")
        }
        return randomWord
    }
}
