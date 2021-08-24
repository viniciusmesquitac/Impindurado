//
//  DottedTextView.swift
//  Impindurado
//
//  Created by Vinicius Mesquita on 14/08/21.
//

import UIKit

class DottedTextView: UIView {

    private var labels: [UILabel] = []
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
        
        self.isAccessibilityElement = true
//        self.configureAccessibility()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAccessibility() {
        shouldGroupAccessibilityChildren = true
        let numberOfLetters = numberOfSlots
        var accessibilityLabel: [String] = []
        
        for position in 0...(numberOfLetters - 1) {
//            labels[position].isAccessibilityElement = true
//            labels[position].accessibilityLabel = "\(labels[position].text ?? "espaço")"
            
            accessibilityLabel.append(labels[position].text ?? "espaço")
        }
    }

    public func configure(numberOfSlots: Int) {
        self.numberOfSlots = numberOfSlots
        stackView = createTextFieldStackView(with: numberOfSlots)
    }
    
    public func insertLetter(at index: Int, letter: Character) {
        let selectedLabel = labels[index]
        selectedLabel.text = String(letter)
        
        // MARK:- Verificar acessibilidade nessa view!
//        selectedLabel.isAccessibilityElement = true
//        selectedLabel.accessibilityLabel = "Letra \(letter), na posição \(index + 1)"
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

        for _ in 1...count {
            let (view, label) = createContentView()
            stackView.addArrangedSubview(view)
            labels.append(label)
        }

        stackView.isAccessibilityElement = true

        return stackView
    }

    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = R.font.pacificoRegular(size: 16)
        label.textColor = .white
        
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Letra A"

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

        contentView.isAccessibilityElement = true

        
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
}
