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
        self.snp.makeConstraints { $0.height.equalTo(style.height) }
        self.backgroundColor    = style.backgroundColor
        self.titleLabel?.font   = style.font
        self.alpha              = style.alpha
        self.clipsToBounds      = style.clipToBounds
        self.layer.borderWidth  = style.borderWidth
        self.layer.borderColor  = style.borderColor
        self.layer.cornerRadius = style.cornerRadious

        self.setBackgroundColor(style.backgroundColor, for: .normal)
        self.setBackgroundColor(style.highlightedColor, for: .highlighted)
    }
}

extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}

