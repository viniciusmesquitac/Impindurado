//
//  UILabel + extensions.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 21/08/21.
//

import UIKit

extension UILabel {

    func spaced(with spacing: CGFloat, attributedString: NSMutableAttributedString) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 1.0
        paragraphStyle.lineHeightMultiple = spacing
        paragraphStyle.alignment = textAlignment
    
        let range = NSMakeRange(.zero, attributedString.length)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attributedText = attributedString
    }

    func outilined(oulineColor: UIColor, foregroundColor: UIColor, strokeWidth: NSNumber = -4.0) {
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : oulineColor,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.strokeWidth : strokeWidth,
            NSAttributedString.Key.font : font ?? UIFont.systemFontSize,
        ] as [NSAttributedString.Key : Any]
        attributedText = NSMutableAttributedString(string: text ?? "", attributes: strokeTextAttributes)
    }

    func underline() {
        let attributedString = NSMutableAttributedString(string: text ?? "")
        let attribute = NSAttributedString.Key.underlineStyle
        let value = NSUnderlineStyle.single.rawValue
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(attribute, value: value, range: range)
        attributedText = attributedString
    }

}
