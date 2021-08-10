//
//  AppButton.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//

import UIKit

class AppButton: UIButton {

    init(style: AppButtonStyle) {
        super.init(frame: .zero)
        setup(with: style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with style: AppButtonStyle) {
        self.backgroundColor  = style.backgroundColor
        self.titleLabel?.font = style.font
        self.clipsToBounds    = style.clipToBounds
    }
}

