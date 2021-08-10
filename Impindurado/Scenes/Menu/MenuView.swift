//
//  
//  MenuView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 09/08/21.
//
//

import UIKit

class MenuView: UIView {

    lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var soundButton: SoundButton = {
        let button = SoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var playButton: AppButton = {
        let button = AppButton(style: .normal)
        button.setTitle(R.string.button.play(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var leaderBoardButton: AppButton = {
        let button = AppButton(style: .normal)
        button.setTitle(R.string.button.leaderboard(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension MenuView: ViewCode {

    func setupViewHierarchy() {
        addSubview(appImageView)
        addSubview(soundButton)
        addSubview(playButton)
        addSubview(leaderBoardButton)
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            soundButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            soundButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])

        NSLayoutConstraint.activate([
            appImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            appImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            playButton.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 24)
        ])

        NSLayoutConstraint.activate([
            leaderBoardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            leaderBoardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            leaderBoardButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 24)
        ])
    }
}
