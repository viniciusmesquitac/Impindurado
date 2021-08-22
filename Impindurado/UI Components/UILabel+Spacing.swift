//
//  UILabel + extensions.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 21/08/21.
//

import UIKit

extension UILabel {
    func setSpacing(text: String, spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value:paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
