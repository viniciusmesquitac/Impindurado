//
//  AppLabel.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 22/08/21.
//

import UIKit

class AppLabel: UILabel {

    init(style: AppLabelStyle = .normal) {
        super.init(frame: .zero)
        setup(with: style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with style: AppLabelStyle) {
        self.layer.shadowColor   = style.shadowColor?.cgColor
        self.layer.shadowRadius  = style.shadowRadius
        self.layer.shadowOpacity = style.shadowOpacity
        self.layer.masksToBounds = style.masksToBounds
    }
}
