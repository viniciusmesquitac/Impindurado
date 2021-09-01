//
//  KeyboardView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import UIKit
import SnapKit

enum Alphabet: String, CaseIterable {
    case Q, W, E, R, T, Y, U, I, O, P,
         A, S, D, F, G, H, J, K, L,
         Z, X, C, V, B, N, M
    
    static func fromHash(hashValue: Int) -> Alphabet? {
        return Alphabet.allCases.filter( { $0.hashValue == hashValue }).first
    }
}

// Returns which letter the user tapped.
protocol KeyboardDelegate: AnyObject {
    func didSelectKey(key: String)
}

class KeyboardView: UIView {

    weak var delegate: KeyboardDelegate?
    var key: String?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        setupKeys()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension KeyboardView: ViewCode {
    func setupViewHierarchy() {
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupKeys() {
        var keyLineStackView = createStackView()
        for key in Alphabet.allCases {
            stackView.addArrangedSubview(keyLineStackView)
            if key == .A || key == .Z {
                keyLineStackView = createStackView()
                stackView.addArrangedSubview(keyLineStackView)
            }
            let button = createButton(key)

            configureAccessibility(object: button, key: key)
            configureAccessibilityElementsOrder(object: button)
            
            keyLineStackView.addArrangedSubview(button)
        }
    }

    @objc func didSelectKey(_ target: UIButton) {
        if let key = Alphabet.fromHash(hashValue: target.tag) {
            target.isUserInteractionEnabled = false
            target.alpha = 0
            delegate?.didSelectKey(key: key.rawValue)
        }
    }

    private func createButton(_ key: Alphabet) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(didSelectKey), for: .touchUpInside)
        button.tag = key.hashValue
        button.setBackgroundColor(.lightBrown, for: .normal)
        button.layer.cornerRadius = 4
        button.setTitle(key.rawValue, for: .normal)
        let titleSizeBazed: CGFloat = UIDevice.is4InchDevice ? 18 : 22
        button.titleLabel?.font = R.font.adventureSubtitles(size: titleSizeBazed)
        button.setBackgroundColor(.customBrown, for: .highlighted)
        let buttonSizeBased = UIDevice.is4InchDevice ? CGSize(width: 18, height: 36) : CGSize(width: 24, height: 48)
        button.snp.makeConstraints { $0.size.equalTo(buttonSizeBased)}
        return button
    }

    private func createStackView() -> UIStackView {
        let keyLineStackView = UIStackView()
        keyLineStackView.distribution = .fillProportionally
        keyLineStackView.spacing = 4
        return keyLineStackView
    }
}

extension KeyboardView {

    func configureAccessibility(object: NSObject, key: Alphabet) {
        object.isAccessibilityElement = true
        object.accessibilityLabel = "Letra \(key)"
    }
    
    func configureAccessibilityElementsOrder(object: NSObject) {
        accessibilityElements?.append(object)
    }

}
