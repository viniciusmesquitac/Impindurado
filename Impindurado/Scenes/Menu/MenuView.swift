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
        imageView.image = R.image.logo()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var soundButton: SoundButton = {
        let button = SoundButton()
        button.tintColor = .customBrown
        
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Som"
        button.accessibilityHint = "Som desativado"
        return button
    }()

    lazy var playButton: AppButton = {
        let button = AppButton(style: .normal)
        button.setTitle(R.string.button.play(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isAccessibilityElement = true
        button.accessibilityHint = "Inicia o jogo"
        return button
    }()

    lazy var leaderBoardButton: AppButton = {
        let button = AppButton(style: .normal)
        button.setTitle(R.string.button.leaderboard(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isAccessibilityElement = true
        button.accessibilityHint = "Mostra o ranking de pontuações"
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.menu_background()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let logoSize = CGSize(width: 200, height: 200)
    
    func performAnimation() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, delay: .zero, options: [.repeat, .autoreverse]) {
            self.appImageView.snp.remakeConstraints { make in
                make.size.equalTo(self.logoSize)
                make.centerY.equalToSuperview().multipliedBy(0.62)
                make.centerX.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
}

extension MenuView: ViewCode {

    func setupViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(appImageView)
        addSubview(soundButton)
        addSubview(playButton)
        addSubview(leaderBoardButton)
    }

    func setupConstraints() {

        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        soundButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(snp.topMargin)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }

        appImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.size.equalTo(self.logoSize)
        }

        playButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
        }

        leaderBoardButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(64)
        }
    }
}
