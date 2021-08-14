//
//  LivesView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 12/08/21.
//

import UIKit

protocol LivesViewDelegate: AnyObject {
    func didLoseAllLives()
}

class LivesView: UIView {

    // Views
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    // Variables
    private var totalNumberOfLives: Int = 0
    private var currentLives: Int = 0
    
    weak var delegate: LivesViewDelegate?

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
            imageView.snp.makeConstraints { $0.size.equalTo(CGSize(width: 32, height: 32)) }
            imageView.image = R.image.life_remain()
            stackView.addArrangedSubview(imageView)
        }
    }
    
    public func removeOneLive() {
        guard stackView.arrangedSubviews.indices.contains(currentLives - 1) else {
            delegate?.didLoseAllLives()
            return
        }
        let lastLive = stackView.arrangedSubviews[currentLives - 1]
        currentLives -= 1
        
        if currentLives == .zero {
            delegate?.didLoseAllLives()
        }
        if let imageView = lastLive as? UIImageView { imageView.image = R.image.life_lost() }
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
