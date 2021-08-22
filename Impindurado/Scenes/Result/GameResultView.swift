//
//  
//  GameResultView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 21/08/21.
//
//

import UIKit

class GameResultView: UIView {

    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.ic_back(), for: .normal)
        button.tintColor = .white
        return button
    }()

    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = -1
        label.font = R.font.nes2(size: 64.0)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.nes2(size: 24.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setResultLayout(_ result: GameResult) {
        switch result {
        case .won:
            setupWonLayout()
        case .lose:
            setupLoseLayout()
        }
    }

    func setScore(text: String) {
        self.scoreLabel.text = R.string.results.score() + text
    }

    private func setupWonLayout() {
        resultLabel.text = R.string.results.won().replacingOccurrences(of: " ", with: "\n")
        resultLabel.textColor = .lightGreen
        backgroundImage.image = R.image.win_background()
    }

    private func setupLoseLayout() {
        resultLabel.text = R.string.results.lose().replacingOccurrences(of: " ", with: "\n")
        resultLabel.textColor = .lightPink
        backgroundImage.image = R.image.lose_background()
    }
}

extension GameResultView: ViewCode {

    func setupViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(backButton)
        addSubview(resultLabel)
        addSubview(scoreLabel)
    }

    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(Spacing.normal.rawValue)
            make.leading.equalToSuperview().inset(Spacing.normal.rawValue)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).offset(Spacing.extra.rawValue)
            make.centerX.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(Spacing.normal.rawValue)
            make.centerX.equalToSuperview()
        }
    }

}
