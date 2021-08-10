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

    var backgroundColor: UIColor {
        switch self {
        case .normal: return .red
        default: return .blue
        }
    }

    var font: UIFont {
        switch self {
        case .normal: return UIFont.boldSystemFont(ofSize: 24)
        default: return UIFont.boldSystemFont(ofSize: 24)
        }
    }

    var clipToBounds: Bool {
        return true
    }
}
