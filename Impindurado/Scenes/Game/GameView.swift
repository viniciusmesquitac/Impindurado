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
        
        view.isAccessibilityElement = true
        view.accessibilityLabel = "Restam 6 vidas"
        // "Restam 6 vidas" ou "Você tem 6 de 6 vidas"?
        return view
    }()

    let microfoneButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_microfone(), for: .normal)
        button.tintColor = .white
        
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Ditado"
        button.accessibilityHint = "Fale o nome da letra que você quer verificar"

        return button
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_back(), for: .normal)
        button.tintColor = .white
        
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Voltar ao menu inicial"
        return button
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "SCORE"
        label.font = R.font.adventureSubtitles(size: 24)
        label.textColor = .white
        
       label.isAccessibilityElement = true
       label.accessibilityHint = "A pontuação atual é 50"
        return label
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.background_gradient()
        return imageView
    }()
    
    let groundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.ground()
        return imageView
    }()
    
    let treeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.tree()
        return imageView
    }()

    let ropeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.rope()
        return imageView
    }()

    let stickmanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.stickman6()
        
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Ainda não há membros desenhados!"
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Categoria"
        label.font = R.font.pacificoRegular(size: 18)
        label.textColor = .white
        
        label.isAccessibilityElement = true
        label.accessibilityHint = "A categoria da palavra é \(label.text ?? "Objetos")"
        return label
    }()
    
    let dottedTextView: DottedTextView = {
        let textView = DottedTextView(numberOfSlots: 10)
        
        textView.isAccessibilityElement = true
        textView.accessibilityLabel = "Essa palavra possui \(textView.numberOfSlots) letras"
//        textView.accessibilityHint = "O número de letras é \(textView.numberOfSlots)"
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
        addSubview(treeImage)
        addSubview(ropeImage)
        addSubview(stickmanImage)
        addSubview(groundImage)
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

        groundImage.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2.5)
        }

        treeImage.snp.makeConstraints { make in
            make.bottom.equalTo(groundImage.snp.top).offset(64)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(UIScreen.main.bounds.height/2.5 + 24)
            make.width.equalTo(UIScreen.main.bounds.width/4)
        }

        ropeImage.snp.makeConstraints { make in
            make.leading.equalTo(treeImage.snp.trailing).offset(-32)
            make.top.equalTo(treeImage.snp.top).offset((UIScreen.main.bounds.height/8 + 12))
            make.height.equalTo(32)
            make.width.equalTo(16)
        }

        stickmanImage.snp.makeConstraints { make in
            make.centerX.equalTo(ropeImage).offset(4)
            make.top.equalTo(ropeImage.snp.bottom)
            make.height.equalTo(64)
            make.width.equalTo(32)
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
            make.bottom.equalTo(snp.bottomMargin).inset(24)
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
