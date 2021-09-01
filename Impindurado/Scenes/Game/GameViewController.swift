//
//  
//  GameViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    let mainView = GameView()
    var viewModel: GameViewModel?
    var coordinator: GameCoordinator?
    private var keySelected: String?

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
        
        guard let viewModel = viewModel else { return }
        configureAccessibility(numberOfLetters: viewModel.numberOfLetters(), category: "Objeto")
    }

    @objc func didSelectBackButton() {
        self.dismiss(animated: true)
    }
}

extension GameViewController: KeyboardDelegate {

    func didSelectKey(key: String) {
        coordinator?.showAlert(title: R.string.alert.checkLetter() + " \(key)?", type: .confirmLetter)
        readingOrderChangedKeyboard()
//        keySelected = key
        
//        coordinator?.result(.won, score: 0.0)
//        guard let key = keySelected else { return }
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
        switch type {
        case .confirmLetter:
            dismiss(animated: true, completion: nil)
        case .tutorial:
            dismiss(animated: true, completion: nil)
        case .none:
            print("Type Alert invalid")

        }
    }
    
    func didTapCancelButton(type: TypeAlert?) {
        // Confirm button from alert
    }
}

extension GameViewController {
    func configureAccessibility(numberOfLetters: Int, category: String) {
        mainView.dottedTextView.accessibilityLabel = "Essa palavra possui \(numberOfLetters) letras"
        mainView.categoryLabel.accessibilityLabel = "A categoria é \(category)"
    }
    
    func speechInfoWord(text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
    }
    
    func readingOrderChangedKeyboard() {
        mainView.accessibilityElements = [
            mainView.backButton,
            mainView.scoreLabel,
            mainView.microfoneButton,
            mainView.livesView,
            mainView.stickmanImage,
            mainView.dottedTextView,
            mainView.categoryLabel,
            mainView.keyboardView
        ]
        UIAccessibility.post(notification: .layoutChanged, argument: mainView.keyboardView)
    }
    
    func seeSlots(textView: DottedTextView) {
        let letters = textView.getLabelsText()
        
        mainView.dottedTextView.accessibilityLabel = letters
    }
    
    func updateScoreAccessibility(score: Int) {
        mainView.scoreLabel.accessibilityLabel = "A pontuação atual é \(score)"
    }
    
    func updateImageAccessibility(imageLabel: String) {
        mainView.stickmanImage.accessibilityLabel = imageLabel
    }
}
