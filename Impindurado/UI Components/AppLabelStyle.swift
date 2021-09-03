//
//  AppLabelStyle.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 22/08/21.
//

import UIKit

enum AppLabelStyle {
    case normal
    case neon(shadowColor: UIColor = .black)
    
    var shadowColor: UIColor? {
        switch self {
        case .neon(let color): return color
        default: return nil
        }
    }

    var shadowRadius: CGFloat {
        switch self {
        case .neon: return 6.0
        default: return .zero
        }
    }
    
    var shadowOpacity: Float {
        switch self {
        case .neon: return 1.0
        default: return 1.0
        }
    }

    var shadowOffset: CGSize {
        switch self {
        case .neon: return CGSize(width: 100, height: 100)
        default: return .zero
        }
    }

    var masksToBounds: Bool {
        switch self {
        case .neon: return false
        default: return true
        }
    }
}
