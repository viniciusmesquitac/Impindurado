//
//  MenuViewController.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//

import UIKit

class MenuViewController: UIViewController {

    let mainView = MenuView()
    var viewModel: MenuViewModel?
    var coordinator: MenuCoordinator?

    init(viewModel: MenuViewModel, coordinator: MenuCoordinator) {
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
        setupOutput()
        setupInput()
    }
    
    func setupOutput() {
        Sound.play(file: MenuSound.background.rawValue)
    }

    func setupInput() {
        mainView.soundButton
            .addTarget(self, action: #selector(didSelectSoundButton), for: .touchUpInside)
        mainView.playButton
            .addTarget(self, action: #selector(didSelectPlayButton), for: .touchUpInside)
        mainView.leaderBoardButton
            .addTarget(self, action: #selector(didSelectLeaderboardButton), for: .touchUpInside)
    }

    @objc func didSelectSoundButton() {
        mainView.soundButton.isMuted.toggle()
        Sound.play(file: MenuSound.background.rawValue)
    }

    @objc func didSelectPlayButton() {
        coordinator?.gameScene()
    }

    @objc func didSelectLeaderboardButton() {
        // TODO: Send to LeaderBoard
    }
}
