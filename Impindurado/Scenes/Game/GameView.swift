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
        button.tintColor = .white
        return button
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_back(), for: .normal)
        button.tintColor = .white
        return button
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "SCORE"
        label.font = R.font.adventureSubtitles(size: 24)
        label.textColor = .white
        return label
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.game_background()
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Categoria"
        label.font = R.font.pacificoRegular(size: 18)
        label.textColor = .white
        return label
    }()
    
    let dottedTextView: DottedTextView = {
        let textView = DottedTextView(numberOfSlots: 10)
        return textView
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
        addSubview(backgroundImage)
        addSubview(backButton)
        addSubview(microfoneButton)
        addSubview(scoreLabel)
        addSubview(livesView)
        addSubview(categoryLabel)
        addSubview(dottedTextView)
        addSubview(keyboardView)
    }

    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(24)
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

        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(keyboardView.snp.top).offset(-8)
        }
        
        dottedTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(categoryLabel.snp.top).offset(-8)
        }
    }

}
