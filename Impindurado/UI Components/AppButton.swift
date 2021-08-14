//
//  AppButton.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//

import UIKit

class AppButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if oldValue == false && isHighlighted {
                self.backgroundColor = highlightedColor
            }
            else if oldValue == true && !isHighlighted {
                self.backgroundColor = defaultColor
            }
        }
    }
    var highlightedColor: UIColor = .clear
    var defaultColor: UIColor = .clear

    init(style: AppButtonStyle) {
        super.init(frame: .zero)
        setup(with: style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with style: AppButtonStyle) {
        self.snp.makeConstraints { $0.height.equalTo(style.height) }
        self.backgroundColor    = style.backgroundColor
        self.titleLabel?.font   = style.font
        self.alpha              = style.alpha
        self.clipsToBounds      = style.clipToBounds
        self.layer.borderWidth  = style.borderWidth
        self.layer.borderColor  = style.borderColor
        self.layer.cornerRadius = style.cornerRadious
        self.defaultColor       = style.backgroundColor
        self.highlightedColor   = style.highlightedColor
    }
}

