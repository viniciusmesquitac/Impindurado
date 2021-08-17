//
//  
//  GameViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//
//

import UIKit

class GameViewController: UIViewController {

    let mainView = GameView()
    var viewModel: GameViewModel?
    var coordinator: GameCoordinator?
    let model = WordsModel()

    init(viewModel: GameViewModel, coordinator: GameCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.keyboardView.delegate = self
        mainView.livesView.delegate = self
        mainView.backButton.addTarget(self, action: #selector(didSelectBackButton), for: .touchUpInside)
        
        model.setNewWord()
        mainView.dottedTextView.configure(numberOfSlots: model.getWordNumberOfLetters())
    }

    @objc func didSelectBackButton() {
        self.dismiss(animated: true)
    }
}

extension GameViewController: KeyboardDelegate {

    func didSelectKey(key: String) {
        
        let positions = model.positionsForThis(letter: key)
        if positions.isEmpty {
            // Example of how to remove the life.
            mainView.livesView.removeOneLive()
        }

        for position in positions {
            mainView.dottedTextView.insertLetter(at: position, letter: key)
        }
        
        let labels = mainView.dottedTextView.labels.filter {$0.text?.isEmpty == false }
        let texts = labels.map { String(($0.text!.first!)) }

        if model.isWordComplete(with: texts) {
            if model.isUserWin() {
               
            } else {
                // Player has finished the first word stage.
                // TODO: Coordinate to another
            }
        }
    }
}


extension GameViewController: LivesViewDelegate {
    func didLoseAllLives() {
        // Example of game over
        print("you Lost!")
    }
    
}


extension GameViewController: AlertDelegate {
    func didTapConfirmButton(type: TypeAlert?) {
        // Confirm button from alert
    }
    
    func didTapCancelButton(type: TypeAlert?) {
        // Confirm button from alert
    }
 
}
