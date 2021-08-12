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

    let skView: SKView = {
        let skView = SKView()
        return skView
    }()

    let keyboardView: KeyboardView = {
        let view = KeyboardView()
        return view
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

extension GameView: ViewCode {

    func setupViewHierarchy() {
        addSubview(skView)
        addSubview(keyboardView)
    }

    func setupConstraints() {
    
        skView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2)
        }

        keyboardView.snp.makeConstraints { make in
            make.top.equalTo(skView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

}
