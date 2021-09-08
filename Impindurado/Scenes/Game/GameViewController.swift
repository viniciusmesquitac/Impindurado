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
        
        mainView.dottedTextView.configure(numberOfSlots: viewModel?.numberOfLetters() ?? 0)
        
        guard let viewModel = viewModel else { return }
        configureAccessibility(numberOfLetters: viewModel.numberOfLetters(), category: "Geral")
    }

    @objc func didSelectBackButton() {
        coordinator?.showAlert(title: "Você deseja desistir?", type: .giveUp)
    }
    
    private func checkLetter(with key: String) {
        guard let positions = viewModel?.indexsOf(letter: key) else {
            mainView.livesView.removeOneLive()
            mainView.updateImage()
            mainView.updateImageAccessibility()
            return
        }

        for position in positions {
            viewModel?.score += 10
            mainView.scoreLabel.text = "\(viewModel?.score ?? .zero)"
            mainView.dottedTextView.insertLetter(at: position, letter: key)
            updateScoreAccessibility(score: viewModel!.score)
        }

        if viewModel?.isCompletedWord(with: mainView.dottedTextView.labels) == true {
            if viewModel?.isUserWin() ?? false {
                coordinator?.result(.won, score: viewModel?.score ?? .zero)
            } else {
                if let viewModel = viewModel {
                    coordinator?.nextLevel(viewModel: viewModel)
                }
            }
            
        }
        
        seeSlots(textView: mainView.dottedTextView)
    }
}

extension GameViewController: KeyboardDelegate {

    func didSelectKey(key: String) {
        coordinator?.showAlert(title: R.string.alert.checkLetter() + " \(key)?", type: .confirmLetter(key: key))
        readingOrderChangedKeyboard()
    }
}


extension GameViewController: LivesViewDelegate {
    func didLoseAllLives() {
        coordinator?.result(.lose, score: viewModel?.score ?? .zero)
    }
    
}


extension GameViewController: AlertDelegate {
    func didTapConfirmButton(type: TypeAlert?) {
        // Confirm button from alert
        switch type {
        case .confirmLetter(let key):
            checkLetter(with: key)
        case .tutorial:
            dismiss(animated: true, completion: nil)
        case .giveUp:
            giveUp()
        default:
            print("Returning to `GameViewController`")

        }
    }
    
    func didTapCancelButton(type: TypeAlert?) {
        switch type {
        case .confirmLetter( _):
            mainView.keyboardView.showSelectedButton()
        case .tutorial:
            dismiss(animated: true, completion: nil)
        default:
            print("Returning to `GameViewController`")

        }
    }
    
    func giveUp() {
        if viewModel?.wordsModel.actualWord == viewModel?.wordsModel.word.portuguese {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                self.dismiss(animated: true)
            }
        } else {
            coordinator?.returnToMenu()
        }
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
    
    func updateScoreAccessibility(score: Float) {
        mainView.scoreLabel.accessibilityLabel = "A pontuação atual é \(score)"
    }

}
