//
//  LivesView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import UIKit

class LivesView: UIView {

    // Views
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    // Variables
    private var totalNumberOfLives: Int = 0
    private var currentLives: Int = 0

    init(totalNumberOfLives: Int) {
        self.totalNumberOfLives = totalNumberOfLives
        self.currentLives = totalNumberOfLives
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        setupLives()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupLives() {
        for _ in 1...totalNumberOfLives {
            let imageView = UIImageView()
            imageView.image = .checkmark
            stackView.addArrangedSubview(imageView)
        }
    }
    
    public func removeOneLive() {
        guard stackView.arrangedSubviews.indices.contains(currentLives - 1) else {
            print("You don't have any lives")
            return
        }
        let lastLive = stackView.arrangedSubviews[currentLives - 1]
        currentLives -= 1
        if let imageView = lastLive as? UIImageView { imageView.image = .remove}
    }
}

extension LivesView: ViewCode {
    func setupViewHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
