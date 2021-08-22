//
//  
//  GameResultViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 21/08/21.
//
//

import UIKit

class GameResultViewController: UIViewController {

    let mainView = GameResultView()
    var viewModel: GameResultViewModel?
    weak var coordinator: GameCoordinator?

    init(viewModel: GameResultViewModel, coordinator: GameCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        self.setupResultLayout()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backButton.addTarget(self, action: #selector(didSelectBackButton), for: .touchUpInside)
    }
    
    func setupResultLayout() {
        guard let result = viewModel?.result else { return }
        mainView.setResultLayout(result)

        let score = String(viewModel?.score ?? .zero)
        mainView.setScore(text: score)
    }
    
    @objc func didSelectBackButton() {
        self.coordinator?.returnToMenu()
    }
}
