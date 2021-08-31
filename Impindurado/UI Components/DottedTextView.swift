//
//  DottedTextView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 14/08/21.
//

import UIKit

class DottedTextView: UIView {

    public var labels: [UILabel] = []
    private var spacing: CGFloat
    private var height: CGFloat
    public  var numberOfSlots: Int
    
    private var stackView = UIStackView()

    init(spacing: CGFloat = 6, numberOfSlots: Int = 0, height: CGFloat = 32.0) {
        self.spacing = spacing
        self.numberOfSlots = numberOfSlots
        self.height = height
        super.init(frame: .zero)
        self.setupStackView()
        
        self.configureAccessibility()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAccessibility() {
        self.isAccessibilityElement = true
    }

    public func configure(numberOfSlots: Int) {
        self.numberOfSlots = numberOfSlots
        stackView.removeFromSuperview()
        setupStackView()
    }
    
    public func insertLetter(at index: Int, letter: String) {
        let selectedLabel = labels[index]
        selectedLabel.text = letter
    }
    
    private func setupStackView() {
        stackView = createTextFieldStackView(with: numberOfSlots)
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createTextFieldStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        labels = []

        for _ in 0..<count {
            let (view, label) = createContentView()
            stackView.addArrangedSubview(view)
            labels.append(label)
        }

        return stackView
    }

    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = R.font.pacificoRegular(size: 16)
        label.textColor = .white

        return label
    }
    
    private func createContentView() -> (UIView, UILabel) {
        let contentView = UIView()
        let label = createLabel()
        let line = UIView()
        line.backgroundColor = .white
        line.layer.cornerRadius = 2
        line.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(line)
        
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalTo(18)
            make.leading.trailing.equalToSuperview().inset(2)
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }

        return (contentView, label)
    }
    
    func getLabelsText() -> String {
        var letters = ""
        for letter in labels {
            if letter.text == nil {
                letters.append(" espaço")
            } else {
                guard let text = letter.text else { return "" }
                letters.append(" \(text)")
            }
        }
        return letters
    }
}
