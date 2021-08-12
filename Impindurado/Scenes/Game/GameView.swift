//
//  
//  GameView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//
//

import UIKit

class GameView: UIView {

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
        addSubview(keyboardView)
    }

    func setupConstraints() {
        keyboardView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}
