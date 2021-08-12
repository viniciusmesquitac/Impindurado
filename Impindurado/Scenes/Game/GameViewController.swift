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
    var scene: GameScene?

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
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
        setupScene()
    }
    
    func setupScene() {
        scene = GameScene(size: CGSize(width: 100, height: 100))
        mainView.skView.presentScene(scene)
    }
}

extension GameViewController: KeyboardDelegate {
    func didSelectKey(key: String) {
        print(key)
    }
}
