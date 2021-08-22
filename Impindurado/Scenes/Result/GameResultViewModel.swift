//
//  
//  GameResultViewModel.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 21/08/21.
//
//

import Foundation

struct GameResultViewModel: ViewModel {

    var result: GameResult
    var score: Float

    init(result: GameResult, score: Float) {
        self.result = result
        self.score = score
    }
}

enum GameResult {
    case won
    case lose
}
