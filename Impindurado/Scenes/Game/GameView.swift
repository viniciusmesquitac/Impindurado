//
//  
//  GameView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//
//

import UIKit
import SpriteKit

class GameView: UIView {

    let livesView: LivesView = {
        let view = LivesView(totalNumberOfLives: 6)
        return view
    }()

    let microfoneButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_microfone(), for: .normal)
        return button
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_microfone(), for: .normal)
        return button
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: "
        return label
    }()

    let keyboardView: KeyboardView = {
        let view = KeyboardView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension GameView: ViewCode {

    func setupViewHierarchy() {
        addSubview(backButton)
        addSubview(microfoneButton)
        addSubview(scoreLabel)
        addSubview(livesView)
        addSubview(keyboardView)
    }

    func setupConstraints() {
    
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(scoreLabel)
            make.leading.equalToSuperview().inset(24)
        }
    
        microfoneButton.snp.makeConstraints { make in
            make.centerY.equalTo(scoreLabel)
            make.trailing.equalToSuperview().inset(24)
        }

        livesView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }

        keyboardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(64)
        }
    }

}
