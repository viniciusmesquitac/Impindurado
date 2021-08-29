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
    }

    @objc func didSelectBackButton() {
        self.dismiss(animated: true)
    }
}

extension GameViewController: KeyboardDelegate {

    func didSelectKey(key: String) {

        readingOrderChangedKeyboard()

        // Example of how to insert a letter to the textView
        let randomRange = 0...mainView.dottedTextView.numberOfSlots - 1
        mainView.dottedTextView.insertLetter(at: randomRange.randomElement() ?? 0, letter: key.first!)
        
        // Example of how to remove the life.
        mainView.livesView.removeOneLive()
        
        // Example of calling alert
        // coordinator?.showAlert(title: R.string.alert.checkLetter(), type: .confirmLetter)
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

extension GameViewController {
    func speechInfoWord(numberOfletters: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let utterance = AVSpeechUtterance(string: "A palavra possui \(numberOfletters) letras")
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
}
