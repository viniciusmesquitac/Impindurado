//
//  AppButtonStyle.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 10/08/21.
//

import UIKit

enum AppButtonStyle {
    case normal
    case large

    var height: CGFloat {
        switch self {
        case .normal: return 64.0
        default: return 48.0
        }
    }

    var highlightedColor: UIColor {
        switch self {
        case .normal: return .lightBrown
        default: return .blue
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal: return .customBrown
        default: return .blue
        }
    }

    var borderColor: CGColor {
        switch self {
        case .normal: return UIColor.lightBrown.cgColor
        default: return UIColor.blue.cgColor
        }
    }

    var borderWidth: CGFloat {
        switch self {
        case .normal: return 6.0
        default: return 0.0
        }
    }

    var cornerRadious: CGFloat {
        switch self {
        case .normal: return 12.0
        default: return 0.0
        }
    }

    var alpha: CGFloat {
        switch self {
        case .normal: return 0.8
        default: return 1
        }
    }

    var font: UIFont? {
        switch self {
        case .normal: return R.font.nes2(size: 32)
        default: return UIFont.boldSystemFont(ofSize: 24)
        }
    }

    var clipToBounds: Bool {
        return true
    }
}
