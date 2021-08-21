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
        
        viewModel?.startGame()
        mainView.dottedTextView.configure(numberOfSlots: viewModel?.numberOfLetters() ?? 0)
    }

    @objc func didSelectBackButton() {
        self.dismiss(animated: true)
    }
}

extension GameViewController: KeyboardDelegate {

    func didSelectKey(key: String) {
        guard let positions = viewModel?.indexsOf(letter: key) else {
            mainView.livesView.removeOneLive()
            return
        }

        for position in positions {
            mainView.dottedTextView.insertLetter(at: position, letter: key)
        }

        if viewModel?.isCompletedWord(with: mainView.dottedTextView.labels) == true {
            if viewModel?.isUserWin() == true {
               print("Ganhou!!!")
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
