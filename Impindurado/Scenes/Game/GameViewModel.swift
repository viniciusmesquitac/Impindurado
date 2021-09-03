//
//  
//  GameViewModel.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//
//

import Foundation
import UIKit

struct GameViewModel: ViewModel {
    let wordsModel = WordsModel()
    var score: Float = 0.0
    
    init() {
        startGame()
    }
    
    private func startGame() {
        wordsModel.setNewWord()
    }
    
    func numberOfLetters() -> Int {
        return wordsModel.getWordNumberOfLetters()
    }
    
    func indexsOf(letter: String) -> [Int]? {
        let indexs = wordsModel.positionsForThis(letter: letter.lowercased())
        return indexs.isEmpty ? nil : indexs
    }
    
    func isCompletedWord(with label: [UILabel]) -> Bool {
        let labels = label.filter { $0.text?.isEmpty == false }
        let texts = labels.compactMap { String($0.text!.first!) }
        
        // Verifica se todas as letras anteriores da palavra ja foram acertadas
        if texts.count != label.count {
            return false
        }
        
        return wordsModel.isWordComplete(with: texts)
    }
    
    func isUserWin() -> Bool {
        return wordsModel.isUserWin()
    }
}
