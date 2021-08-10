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

    init(viewModel: MenuViewModel) {
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
        // TODO: Send to GameScene
    }

    @objc func didSelectLeaderboardButton() {
        // TODO: Send to LeaderBoard
    }
}
