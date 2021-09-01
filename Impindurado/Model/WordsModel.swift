//
//  WordsModel.swift
//  Impindurado
//
//  Created by Ronaldo Gomes on 12/08/21.
//

import Foundation

class WordsModel {
    private var word: Word
    private var actualWord: String
    
    init() {
        let jsonModel = JSONDataModel()
        word = jsonModel.getRandomWord()
        actualWord = word.portuguese
    }
    
    //// Reinicia todo o fluxo de word
    func setNewWord() {
        let jsonModel = JSONDataModel()
        word = jsonModel.getRandomWord()
        actualWord = word.portuguese
    }
    
    //// Retorna o numero de letras da palavra atual.
    func getWordNumberOfLetters() -> Int {
        return actualWord.count
    }
    
    //// Recebe a letra que o usuario digitou no momento
    //// Retorna as posiçoes em que a letra aparece. Caso essa letra nao tenha na palavra, ele retorna vazio
    func positionsForThis(letter: String) -> [Int] {
        var indexs = [Int]()
        
        for (index, wordLetter) in actualWord.enumerated() {
            if letter.lowercased() == wordLetter.description {
                indexs.append(index)
            }
        }
        
        return indexs
    }
    
    //// Recebe as letras das palavras e retorna se com essas letras a palavra ja esta completa
    func isWordComplete(with letters: [String]) -> Bool {
        var containtsAllLetters = true
        letters.forEach { letter in
            if !actualWord.contains(letter) {
                containtsAllLetters = false
            }
        }
        
        return containtsAllLetters
    }
    
    //// Verifica se o  usuario ganhou a rodada
    func isUserWin() -> Bool {
        var userWin = true
        
        if actualWord == word.portuguese {
            userWin = false
            changeActualWord()
        }
        
        return userWin
    }
    
    private func changeActualWord() {
        actualWord = word.english
    }
}
