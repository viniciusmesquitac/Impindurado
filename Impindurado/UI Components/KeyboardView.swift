//
//  KeyboardView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import UIKit
import SnapKit

enum Alphabet: String, CaseIterable {
    case A, B, C, D, E, F, G, H,
         I, J, K, L, M, N, O, P,
         Q, R, S, T, U, V, X, Z
    
    static func fromHash(hashValue: Int) -> Alphabet? {
        return Alphabet.allCases.filter( { $0.hashValue == hashValue }).first
    }
}

protocol KeyboardDelegate: AnyObject {
    func didSelectKey(key: String)
}

class KeyboardView: UIView {

    weak var delegate: KeyboardDelegate?
    var key: String?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
        var keyLineStackView = UIStackView()
        keyLineStackView.distribution = .fillProportionally
        for key in Alphabet.allCases {
            stackView.addArrangedSubview(keyLineStackView)
            if key == .I || key == .Q {
                keyLineStackView = UIStackView()
                keyLineStackView.distribution = .fillProportionally
                stackView.addArrangedSubview(keyLineStackView)
            }
            let button = UIButton()
            button.addTarget(self, action: #selector(didSelectKey), for: .touchUpInside)
            button.tag = key.hashValue
            button.setTitle(key.rawValue, for: .normal)
            button.titleLabel?.font = R.font.adventureSubtitles(size: 16)
            keyLineStackView.addArrangedSubview(button)
        }
    }

    @objc func didSelectKey(_ target: UIButton) {
        if let key = Alphabet.fromHash(hashValue: target.tag) {
            delegate?.didSelectKey(key: key.rawValue)
        }
    }
}
