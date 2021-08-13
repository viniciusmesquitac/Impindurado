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

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
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
        mainView.backButton.addTarget(self, action: #selector(didSelectBackButton), for: .touchUpInside)
    }

    @objc func didSelectBackButton() {
        self.dismiss(animated: true)
    }
}

extension GameViewController: KeyboardDelegate {
    func didSelectKey(key: String) {
        print(key)
        mainView.livesView.removeOneLive()
    }
}

extension GameViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: 0.33, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: 0.33, animationType: .dismiss)
    }

}
